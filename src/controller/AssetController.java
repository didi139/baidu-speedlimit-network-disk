package controller;

import dao.Asset;
import dao.User;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

@WebServlet("/ac")
public class AssetController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = utils.Cookie.getCookieValue(req, "username");
        String password = utils.Cookie.getCookieValue(req, "username");
        String filename = req.getParameter("filename");
        String type = req.getParameter("type");
        type = type == null ? "" : type;
        try {
            int userId = User.getId(username, password);
            if (type.equals("update")) {
                Asset.update(userId, filename, "update".getBytes());
                resp.sendRedirect("./disk/home.jsp");
            } else if (type.equals("delete")) {
                Asset.delete(userId, filename);
                resp.sendRedirect("./disk/home.jsp");
            } else {
                if (!Asset.exist(userId, filename)) {
                    throw new Asset.FileNoExistException();
                }
                if (!type.equals("doNotDownload")) {
                    resp.setHeader("Content-disposition", "attachment;filename=" + filename);
                }
                Asset.outputFile(userId, filename, resp.getOutputStream());
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            resp.sendError(500);
        } catch (User.InvalidUsernameException | User.InvalidPasswordException | Asset.FileNoExistException e) {
            resp.setContentType("text/html;charset=utf-8");
            resp.getWriter().write("请检查您的用户名、密码或者文件名是否正确！");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = utils.Cookie.getCookieValue(req, "username");
        String password = utils.Cookie.getCookieValue(req, "username");

        try {
            int userId = User.getId(username, password);
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(5 * 1024 * 1024);
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setSizeMax(5 * 1024 * 1024);
            List<FileItem> items = upload.parseRequest(req);
            FileItem item = null;
            for (Iterator<FileItem> iter = items.iterator(); iter.hasNext(); ) {
                item = iter.next();
                if (item.isFormField()) {
                    if (!item.isInMemory()) {
                        throw new IncompleteFileException();
                    }
                    break;
                }
            }
            if (item != null) {
                Asset.create(userId, item.getName(), item.get());
            }
            resp.sendRedirect("./disk/home.jsp");
        } catch (SQLException | ClassNotFoundException | FileUploadException e) {
            e.printStackTrace();
            resp.sendError(500);
        } catch (User.InvalidUsernameException | User.InvalidPasswordException e) {
            resp.setContentType("text/html;charset=utf-8");
            resp.getWriter().write("请检查您的用户名、密码是否正确！");
        } catch (Asset.FileExistException e) {
            resp.setContentType("text/html;charset=utf-8");
            resp.getWriter().write("该文件已存在！");
        } catch (NullPointerException e) {
            resp.setContentType("text/html;charset=utf-8");
            resp.getWriter().write("试图上传空文件！");
        } catch (IncompleteFileException e) {
            resp.setContentType("text/html;charset=utf-8");
            resp.getWriter().write("文件过大，无法处理！");
        }
    }

    private static class IncompleteFileException extends Exception {
    }
}
