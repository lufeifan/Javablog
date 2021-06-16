package com.lf.blog.dao.daoimpl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.lf.blog.dao.CategoryDao;
import com.lf.blog.pojo.ArticleCategory;
import com.lf.blog.pojo.Category;
import com.lf.blog.utils.DBUtils;
import com.lf.blog.vo.ArticleMSg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDaoImpl implements CategoryDao {

    @Override
    public List<Category> list() {
        Connection connection = new DBUtils().getConnection();
        String sql = "select * from category";
        List<Category> list = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet resultSet = preparedStatement.executeQuery();
            String data = new DBUtils().getData(resultSet, Category.class);
            list = JSONArray.parseArray(data, Category.class);
        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
        return list;
    }

    //获取分类名
    @Override
    public String name(Integer id) {
        Connection connection = new DBUtils().getConnection();
        String sql = "select * from category where id = ?";
        Category category = new Category();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            String data = new DBUtils().getData(resultSet, Category.class);
            category = JSON.parseObject(data, Category.class);

        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
        return category.getCategoryName();
    }

    //    通过文章ID 查出分类id
    @Override
    public String categoryName(Integer articleId) {
        Connection connection = new DBUtils().getConnection();
        String sql = "select * from article_category where articleId = ?";
        ArticleCategory articleCategory = new ArticleCategory();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setInt(1, articleId);
            ResultSet resultSet = preparedStatement.executeQuery();
            String data = new DBUtils().getData(resultSet, ArticleCategory.class);
            articleCategory = JSON.parseObject(data, ArticleCategory.class);

        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
        return name((int) articleCategory.getCategoryId());
    }

    @Override
    public boolean saveArticleCategory(Integer articleId, Integer categoryId) {
        String sql = "INSERT INTO article_category (articleId,categoryId) VALUES (?,?)";
        Connection connection = new DBUtils().getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, articleId);
            preparedStatement.setInt(2, categoryId);
            int executeUpdate = preparedStatement.executeUpdate();
            if (executeUpdate == 1) {
                return true;
            }
        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
        return false;
    }

    @Override
    public List<ArticleMSg> ArticleByCategoryId(Integer categoryId) {
//        获取该分类id 下面的全部文章id
        Connection connection = new DBUtils().getConnection();
        String sql = "select * from article_category where categoryId = ?";
        List<ArticleMSg> ArticleMSgList = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setInt(1, categoryId);
            ResultSet resultSet = preparedStatement.executeQuery();
            int rowCount = 0;
            resultSet.last();
            rowCount = resultSet.getRow();
            resultSet.beforeFirst();

            String data = new DBUtils().getData(resultSet, ArticleCategory.class);
            if (rowCount > 1) {
                List<ArticleCategory> articleIdList = JSONArray.parseArray(data, ArticleCategory.class);
                for (ArticleCategory articleCategory : articleIdList) {
//                通过 文章id 查出全部文章
                    ArticleMSg articleMSg = new ArticleDaoImpl().one((int) articleCategory.getArticleId());
                    ArticleMSgList.add(articleMSg);
                }
            } else if (rowCount == 1){
                //                通过 文章id 查出全部文章
                ArticleCategory articleCategory = JSON.parseObject(data, ArticleCategory.class);
                ArticleMSg articleMSg = new ArticleDaoImpl().one((int) articleCategory.getArticleId());
                ArticleMSgList.add(articleMSg);
            }
        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
        return ArticleMSgList;
    }

}
