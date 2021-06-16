package com.lf.blog.dao.daoimpl;

import com.lf.blog.dao.CountDao;
import com.lf.blog.utils.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class CountDaoImpl implements CountDao {

    @Override
    public Integer count() {
        Connection connection = new DBUtils().getConnection();
        String sql = "select * from count ";
        Integer count = 0;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet resultSet = preparedStatement.executeQuery();
           resultSet.first();
            count = Integer.valueOf(resultSet.getString("count")) +1;

        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
        return count;
    }

    @Override
    public boolean insert() {
        Connection connection = new DBUtils().getConnection();
        String sql = "UPDATE  count SET  count = ?  where id = 1";
        Integer count = count();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, count);
            int executeUpdate = preparedStatement.executeUpdate();
            if (executeUpdate == 1) {
                return true;
            }

        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
        return false;
    }
}
