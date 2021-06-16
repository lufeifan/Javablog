package com.lf.blog.controller.category;

import com.alibaba.fastjson.JSON;
import com.lf.blog.dao.daoimpl.CategoryDaoImpl;
import com.lf.blog.pojo.Category;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/CategoryServlet")
public class CategoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> list = new CategoryDaoImpl().list();
        response.getWriter().print(JSON.toJSONString(list));
    }
}
