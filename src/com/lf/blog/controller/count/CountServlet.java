package com.lf.blog.controller.count;

import com.lf.blog.dao.daoimpl.CountDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CountServlet")
public class CountServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer count = new CountDaoImpl().count();
        response.getWriter().print(count);
    }
}
