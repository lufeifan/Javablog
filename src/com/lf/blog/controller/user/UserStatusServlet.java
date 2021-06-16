package com.lf.blog.controller.user;

import com.lf.blog.dao.daoimpl.UserDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UserStatusServlet")
public class UserStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String sex = request.getParameter("sex");
        boolean changSex = new UserDaoImpl().changSex(id, sex);
        response.getWriter().print(changSex);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int status = Integer.parseInt(request.getParameter("status"));
        boolean frozenUser = new UserDaoImpl().frozenUser(id, status);
        response.getWriter().print(frozenUser);
    }
}
