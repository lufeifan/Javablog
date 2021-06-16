package com.lf.blog.controller.article;

import com.lf.blog.dao.daoimpl.ArticleDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/articlestatus")
public class ChangStatus extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        System.out.println(req.getParameter("id"));
        boolean status = new ArticleDaoImpl().changStatus(Integer.parseInt(req.getParameter("id")),Integer.parseInt(req.getParameter("status")));
        resp.getWriter().print(status);
    }
}
