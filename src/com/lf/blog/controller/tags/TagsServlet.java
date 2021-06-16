package com.lf.blog.controller.tags;

import com.alibaba.fastjson.JSON;
import com.lf.blog.dao.daoimpl.TagsDaoImpl;
import com.lf.blog.pojo.Tags;
import com.lf.blog.vo.ArticleMSg;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/TagsServlet")
public class TagsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ArticleMSg> list = new TagsDaoImpl().aArticleMSgList(Integer.valueOf(request.getParameter("id")));
        response.getWriter().print(JSON.toJSONString(list));
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Tags> list = new TagsDaoImpl().list();
//        request.getSession().setAttribute("tags",list);
        response.getWriter().print(JSON.toJSONString(list));
    }
}
