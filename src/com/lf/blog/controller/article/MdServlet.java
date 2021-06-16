package com.lf.blog.controller.article;

import com.alibaba.fastjson.JSON;
import com.lf.blog.dao.daoimpl.ArticleDaoImpl;
import com.lf.blog.pojo.Article;
import com.lf.blog.utils.ReqBody;
import com.lf.blog.vo.ArticleMSg;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/article")
public class MdServlet extends HttpServlet {

    //    保存一篇文章
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String body = new ReqBody().getBody(request);
        ArticleMSg articleMSg = JSON.parseObject(body, ArticleMSg.class);
        articleMSg.setAuthor((String) request.getSession().getAttribute("username"));
        List<Integer> list = new ArrayList<>();
        for (Object o : articleMSg.getTagName()) {
            list.add(Integer.valueOf(o.toString()));
        }
        articleMSg.setTagName(list);
        boolean save = new ArticleDaoImpl().save(articleMSg);
        response.getWriter().print(save);
    }

    //    获取一篇文章。通过id 获取
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ArticleMSg article = new ArticleDaoImpl().one(Integer.parseInt(req.getParameter("id")));
        resp.getWriter().print(JSON.toJSONString(article));
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        boolean del = new ArticleDaoImpl().changStatus(Integer.parseInt(req.getParameter("id")));
//        resp.getWriter().print(del);
    }

    //    更新文章
    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String body = new ReqBody().getBody(req);
        Article article = JSON.parseObject(body, Article.class);
        boolean update = new ArticleDaoImpl().update(article);
        resp.getWriter().print(update);
    }
}
