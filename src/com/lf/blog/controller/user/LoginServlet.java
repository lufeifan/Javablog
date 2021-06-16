package com.lf.blog.controller.user;

import com.lf.blog.dao.daoimpl.RoleDaoImpl;
import com.lf.blog.dao.daoimpl.UserDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Boolean login = new UserDaoImpl().isLogin(request.getParameter("username"), request.getParameter("password"));
        if (login){
//            登录成功将用户名储存到session
            request.getSession().setAttribute("username",request.getParameter("username"));
//            是否是管理员
            boolean isadmin = new RoleDaoImpl().isAdmin(request.getParameter("username"));
            if (isadmin){
                response.sendRedirect("admin.jsp");
                return;
            }
            response.sendRedirect("index.jsp");
        }else {
            response.sendRedirect("login.jsp");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("username");
        response.sendRedirect("/login.jsp");
    }
}
