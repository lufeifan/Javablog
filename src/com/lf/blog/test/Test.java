package com.lf.blog.test;

import com.lf.blog.utils.DBUtils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

public class Test {

    public static void main(String[] args) {
        Connection conn = null;
        Statement stm = null;
        ResultSet rs = null;
        try {
            int rows = 5;//每页的行数
            //for循环中的变量j可以理解为页数
            for(int j = 1; j <= 5; j++) {
                System.out.println("-------------------------第" + j +"页------------------------");
                StringBuffer sqlBuffer = new StringBuffer();
                sqlBuffer.append("select * from user");
                conn =new DBUtils().getConnection();
                try {
                    stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
                int endIndex = j > 0 ? j*rows : 1 * rows;
                stm.setMaxRows(endIndex);
                rs = stm.executeQuery(sqlBuffer.toString());
                int beginIndex = (j - 1) * rows;
                if(beginIndex > 0) {
                    rs.absolute(beginIndex);
                }
                int index = 0;
                String[] columns = new String[] {"id", "username"};
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    for (int i = 0; i < columns.length; i++) {
                        String columnName = columns[i].toLowerCase();
                        map.put(columnName, rs.getObject(columnName));
                    }
                    index ++;
                    System.out.println("row num : " + index + ", "+ map);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (null != conn) {
                    conn.close();
                }
                if (null != stm) {
                    stm.close();
                }
                if (null != rs) {
                    rs.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
