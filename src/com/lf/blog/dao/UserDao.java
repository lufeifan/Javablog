package com.lf.blog.dao;

import com.lf.blog.pojo.User;

import java.util.List;

public interface UserDao {

    // 是否登录
    boolean isLogin(String username, String password);

    //获取用户信息
    User getUserMsg(String username);

    //   修改用户信息
    boolean updateUserMsg(User user);

    //   冻结或解封用户
    boolean frozenUser(int id, int status);

    //    更改用户状态
    boolean register(User user);

//    获取非管理员
    List<User> userList();

    boolean changSex(int id,String sex);
}
