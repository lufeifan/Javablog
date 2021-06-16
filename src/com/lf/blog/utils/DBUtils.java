package com.lf.blog.utils;

import com.alibaba.fastjson.JSON;
import com.lf.blog.pojo.User;

import java.lang.reflect.Field;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DBUtils {

    private static final String DBDRIVER = "com.mysql.jdbc.Driver";
    private static final String DBURL = "jdbc:mysql://localhost:3307/blog";
    private static final String DBUSER = "root";
    private static final String PASSWORD = "root";
    private static Connection connection;

    //数据库连接
    public Connection getConnection() {

        try {
            Class.forName(DBDRIVER);
            connection = DriverManager.getConnection(DBURL, DBUSER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }

    public String getData(ResultSet resultSet, Class clazz) throws Exception {

        Field[] fields = clazz.getDeclaredFields();
        int rowCount = 0;
        resultSet.last();
        rowCount = resultSet.getRow();
        resultSet.beforeFirst();
        List<Object> list = new ArrayList<>();
        if (rowCount > 1) {
            //遍历ResultSet
            while (resultSet.next()) {
                Object object = clazz.newInstance();
                dataFor(resultSet, fields, object);
                list.add(object);
            }
            return JSON.toJSONString(list);
        } else {
            Object object = clazz.newInstance();
            while (resultSet.next()) {
                dataFor(resultSet, fields, object);
            }
            return JSON.toJSONString(object);
        }
    }

    private void dataFor(ResultSet resultSet, Field[] fields, Object object) throws SQLException, IllegalAccessException {
        for (int j = 1; j <= resultSet.getMetaData().getColumnCount(); j++) {
            String columnName = resultSet.getMetaData().getColumnName(j);
            for (Field field : fields) {
                field.setAccessible(true);
                if (field.getName().equalsIgnoreCase(columnName)) {
                    field.set(object, resultSet.getObject(columnName));
                }
            }
        }
    }
}