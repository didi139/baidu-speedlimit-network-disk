package controller;

import bean.UserBean;
import dao.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(UserController.URL_PATH)
public class UserController extends HttpServlet {
    static final String URL_PATH = "/uc";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        boolean exit = req.getParameter("exit") != null;
        if (exit) {
            for (Cookie cookie : req.getCookies()) {
                if (cookie.getName().equals("username") || cookie.getName().equals("password")) {
                    cookie.setMaxAge(0);
                    resp.addCookie(cookie);
                }
            }
            req.getSession().setAttribute("user", new UserBean());
            resp.sendRedirect("./index.jsp");
        } else {
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            if (username == null || username.equals("")) {
                username = utils.Cookie.getCookieValue(req, "username");
                password = utils.Cookie.getCookieValue(req, "password");
            }
            try {
                if (username != null && password != null) {
                    User.check(username, password);
                    resp.addCookie(new Cookie("username", username));
                    resp.addCookie(new Cookie("password", password));
                    UserBean userBean = new UserBean();
                    userBean.setId(User.getId(username, password));
                    userBean.setName(username);
                    req.getSession().setAttribute("user", userBean);
                }
                resp.sendRedirect("./index.jsp");
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                resp.sendError(500);
            } catch (User.InvalidPasswordException | User.InvalidUsernameException e) {
                resp.setContentType("text/html;charset=utf-8");
                resp.getWriter().write("无效的用户名或密码！请重新<a href=\"./user/login.jsp\">登录</a>！");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            User.create(req.getParameter("username"), req.getParameter("password"));
            doGet(req, resp);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            resp.sendError(500);
        } catch (User.UsernameExistException e) {
            resp.setContentType("text/html;charset=utf-8");
            resp.getWriter().write("用户名已存在！请尝试新的用户名！<a href=\"./user/signup.jsp\">返回</a>");
        }
    }
}
