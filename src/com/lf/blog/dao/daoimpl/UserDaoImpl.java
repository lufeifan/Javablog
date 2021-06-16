package com.lf.blog.dao.daoimpl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.lf.blog.utils.DBUtils;
import com.lf.blog.dao.UserDao;
import com.lf.blog.pojo.User;
import com.lf.blog.utils.MD5Util;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao {

    @Override
    public boolean isLogin(String username, String password) {
        password = MD5Util.getMD5Str(password);
        boolean b = false;
        Connection connection = new DBUtils().getConnection();
        String sql = "select * from user where username = ? and password = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                b = true;
            }
            connection.close();

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return b;
    }

    @Override
    public User getUserMsg(String username) {
        Connection connection = new DBUtils().getConnection();
        String sql = "select * from user where username = ?";
        User user = new User();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);

            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();
            String data = new DBUtils().getData(resultSet, User.class);
            user = JSON.parseObject(data, User.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public boolean updateUserMsg(User user) {
        Connection connection = new DBUtils().getConnection();
        System.out.println(user.getPhoneNum());
        int resultSet = 0;
        String sql = "update user set address = ? , age = ?,phoneNum = ?,email = ? where id = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user.getAddress());
            preparedStatement.setString(2, user.getAge());
            preparedStatement.setString(3, user.getPhoneNum());
            preparedStatement.setString(4, user.getEmail());
            preparedStatement.setInt(5, (int) user.getId());
            resultSet = preparedStatement.executeUpdate();

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        if (resultSet == 1){
            return true;
        }
        return false;
    }

    @Override
    public boolean frozenUser(int id, int status) {
        Connection connection = new DBUtils().getConnection();
        String sql = "update user set status = ? where id = ?";
        int i = 0;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1,status);
            preparedStatement.setInt(2,id);
            i = preparedStatement.executeUpdate();
        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
        if (i ==1){
            return true;
        }
        return false;
    }

//    注册
    @Override
    public boolean register(User user) {
        Connection connection = new DBUtils().getConnection();
        String sql = "INSERT INTO user (username,email,password) VALUES (?,?,?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1,user.getUsername());
            preparedStatement.setString(2,user.getEmail());
            preparedStatement.setString(3,user.getPassword());
            int save = preparedStatement.executeUpdate();
            if (save == 1){
                return true;
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return false;
    }

    @Override
    public List<User> userList() {
        Connection connection = new DBUtils().getConnection();
        String sql = "SELECT * FROM user WHERE id NOT IN (SELECT user_id FROM role WHERE role = 'admin')";
        List<User> users = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet resultSet = preparedStatement.executeQuery();

            int rowCount = 0;
            resultSet.last();
            rowCount = resultSet.getRow();
            resultSet.beforeFirst();

            String data = new DBUtils().getData(resultSet, User.class);
            if (rowCount>1){
                users = JSONArray.parseArray(data, User.class);
            }if (rowCount==1){
                users.add(JSON.parseObject(data,User.class));
            }

        } catch (Exception throwables) {
            throwables.printStackTrace();
        }

        return users;
    }

    @Override
    public boolean changSex(int id, String sex) {
        Connection connection = new DBUtils().getConnection();
        String sql = "update user set sex = ? where id = ?";
        int i = 0;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1,sex);
            preparedStatement.setInt(2,id);
            i = preparedStatement.executeUpdate();
        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
        if (i ==1){
            return true;
        }
        return false;
    }


}
