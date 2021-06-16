package com.lf.blog.controller.user;

import com.alibaba.fastjson.JSON;
import com.lf.blog.dao.daoimpl.UserDaoImpl;
import com.lf.blog.pojo.User;
import com.lf.blog.utils.ReqBody;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/UserMsgServlet")
public class UserMsgServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = new UserDaoImpl().getUserMsg(request.getParameter("username"));
        response.getWriter().print(JSON.toJSONString(user));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String params = new ReqBody().getBody(request);
        User user = JSON.parseObject(params, User.class);
        Boolean i = new UserDaoImpl().updateUserMsg(user);
        response.getWriter().print(i);
    }
}
