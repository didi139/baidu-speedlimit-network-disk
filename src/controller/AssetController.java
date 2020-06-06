package controller;

import dao.Asset;
import dao.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ac")
public class AssetController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = utils.Cookie.getCookieValue(req, "username");
        String password = utils.Cookie.getCookieValue(req, "username");
        String filename = req.getParameter("filename");
        String type = req.getParameter("type");
        type = type == null ? "create" : type;
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
                resp.setHeader("Content-disposition", "attachment;filename=" + filename);
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
        String filename = req.getParameter("filename");

        try {
            int userId = User.getId(username, password);
            if (filename == null || filename.equals("")) {
                throw new NullPointerException();
            }
            Asset.create(userId, filename, "create".getBytes());
            resp.sendRedirect("./disk/home.jsp");
        } catch (SQLException | ClassNotFoundException e) {
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
        }
    }
}
