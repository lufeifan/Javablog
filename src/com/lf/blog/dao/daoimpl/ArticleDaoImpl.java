package com.lf.blog.dao.daoimpl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lf.blog.dao.ArticleDao;
import com.lf.blog.pojo.Article;
import com.lf.blog.utils.DBUtils;
import com.lf.blog.vo.ArticleMSg;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ArticleDaoImpl implements ArticleDao {

    @Override
    public boolean save(ArticleMSg article) {
        Connection connection = new DBUtils().getConnection();
        String sql = "INSERT INTO article (content,doc,createtime,author,status,updatatime,title,score) VALUES (?,?,?,?,?,?,?,?)";
        try {
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
            String datetime = df.format(new Date());
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, article.getContent());
            preparedStatement.setString(2, article.getDoc());
            preparedStatement.setString(3, datetime);
            preparedStatement.setString(4,article.getAuthor());
            preparedStatement.setInt(5,0);
            preparedStatement.setString(6, datetime);
            preparedStatement.setString(7, article.getTitle());
            preparedStatement.setInt(8,0);
            int i = preparedStatement.executeUpdate();
            Integer id = selectLast();
//            保存分类
            new CategoryDaoImpl().saveArticleCategory(id, Integer.valueOf(article.getCategoryName()));
//            保存标签
            new TagsDaoImpl().insertArticleTags(id,article.getTagName());
            if (i == 1) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Integer selectLast(){
        Connection connection = new DBUtils().getConnection();
        String sql = "SELECT * FROM article ORDER BY id DESC LIMIT 1";
        Integer id = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                id =  resultSet.getInt("id");
            }
        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
        return id;
    }

    @Override
    public ArticleMSg one(int id) {
        Connection connection = new DBUtils().getConnection();
        String sql = "select * from article where id = ?";
        ArticleMSg article = new ArticleMSg();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);

            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            String data = new DBUtils().getData(resultSet, Article.class);
            article = JSON.parseObject(data, ArticleMSg.class);
//           获取文章标签
            List<String> tag = new TagsDaoImpl().tag((int) article.getId());
            article.setTagName(tag);
//           获取文章分类
            String categoryName = new CategoryDaoImpl().categoryName((int) article.getId());
            article.setCategoryName(categoryName);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return article;
    }

    @Override
    public List<Article> list() {
        Connection connection = new DBUtils().getConnection();
        String sql = "select * from article";
        List<Article> list = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet resultSet = preparedStatement.executeQuery();
            String data = new DBUtils().getData(resultSet, Article.class);
            list = JSONObject.parseArray(data, Article.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    @Override
    public boolean update(Article article) {
        Connection connection = new DBUtils().getConnection();
        String sql = "UPDATE article SET title = ?,content = ? ,doc = ? ,updatatime = ? WHERE id = ? ";
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        String datetime = df.format(new Date());
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setString(1, article.getTitle());
            preparedStatement.setString(2, article.getContent());
            preparedStatement.setString(3, article.getDoc());
            preparedStatement.setString(4, datetime);
            preparedStatement.setInt(5, (int) article.getId());
            int resultSet = preparedStatement.executeUpdate();
            if (resultSet == 1) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean changStatus(int id,int status) {
        Connection connection = new DBUtils().getConnection();
        String sql = "UPDATE article SET status = ? WHERE id = ? ";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setInt(1, status);
            preparedStatement.setInt(2, id);
            int resultSet = preparedStatement.executeUpdate();
            if (resultSet == 1) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
