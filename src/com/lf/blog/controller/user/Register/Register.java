package com.lf.blog.controller.user.Register;

import com.alibaba.fastjson.JSON;
import com.lf.blog.dao.daoimpl.UserDaoImpl;
import com.lf.blog.pojo.User;
import com.lf.blog.utils.MD5Util;
import com.lf.blog.utils.ReqBody;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Register")
public class Register extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String body = new ReqBody().getBody(request);
        User user = JSON.parseObject(body, User.class);
        String password = MD5Util.getMD5Str(user.getPassword());
        user.setPassword(password);
        boolean register = new UserDaoImpl().register(user);
        response.getWriter().print(register);
    }
}
