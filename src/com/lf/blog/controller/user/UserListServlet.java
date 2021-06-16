package com.lf.blog.controller.user;

import com.alibaba.fastjson.JSON;
import com.lf.blog.dao.daoimpl.UserDaoImpl;
import com.lf.blog.pojo.User;

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

@WebServlet("/UserListServlet")
public class UserListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer limit = Integer.valueOf(request.getParameter("limit"));
        Integer page = Integer.valueOf(request.getParameter("page"));
        List<User> list = new UserDaoImpl().userList();
        Integer startIndex = (page-1)*limit;
        Integer endIndex = startIndex + limit;
        List<User> list1 = new ArrayList<>();
        if (endIndex<list.size()){
            for (int i = startIndex; i < endIndex; i++) {
                User user = list.get(i);
                list1.add(user);
            }
        }else {
            for (int i = startIndex; i < list.size(); i++) {
                User user = list.get(i);
                list1.add(user);
            }
        }
        Map<String,Object> map = new HashMap<>();
        map.put("code",0);
        map.put("count",list.size());
        map.put("data",list1);
        response.getWriter().print(JSON.toJSONString(map));
    }
}
