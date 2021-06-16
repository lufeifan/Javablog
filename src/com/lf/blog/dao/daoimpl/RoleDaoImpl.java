package com.lf.blog.dao.daoimpl;

import com.lf.blog.dao.RoleDap;
import com.lf.blog.pojo.User;
import com.lf.blog.utils.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RoleDaoImpl implements RoleDap {

    @Override
    public boolean isAdmin(String username) {
//        通过用户名查取用户id
        User user = new UserDaoImpl().getUserMsg(username);
        Long id = user.getId();
        Connection connection = new DBUtils().getConnection();
        String sql = "select * from role where user_id = ? and role = 'admin'";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, Math.toIntExact(id));
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                return true;
            }
        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
        return false;
    }
}
