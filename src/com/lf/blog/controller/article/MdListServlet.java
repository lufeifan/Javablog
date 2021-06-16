package com.lf.blog.controller.article;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lf.blog.dao.daoimpl.ArticleDaoImpl;
import com.lf.blog.dao.daoimpl.CategoryDaoImpl;
import com.lf.blog.pojo.Article;
import com.lf.blog.vo.ArticleMSg;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/articlelist")
public class MdListServlet extends HttpServlet {

//    获取全部文章
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Article> list = new ArticleDaoImpl().list();
        request.getSession().setAttribute("articlelist",list);
        response.getWriter().print(JSON.toJSONString(list));
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ArticleMSg> articleMSgList = new CategoryDaoImpl().ArticleByCategoryId(Integer.valueOf(req.getParameter("id")));
        resp.getWriter().print(JSON.toJSONString(articleMSgList));
    }
}
