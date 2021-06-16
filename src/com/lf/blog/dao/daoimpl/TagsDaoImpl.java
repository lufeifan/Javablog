package com.lf.blog.dao.daoimpl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.lf.blog.dao.TagsDao;
import com.lf.blog.pojo.ArticleCategory;
import com.lf.blog.pojo.ArticleTags;
import com.lf.blog.pojo.Tags;
import com.lf.blog.utils.DBUtils;
import com.lf.blog.vo.ArticleMSg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TagsDaoImpl implements TagsDao {

    @Override
    public List<Tags> list() {
        Connection connection = new DBUtils().getConnection();
        String sql = "select * from tags";
        List<Tags> jsonArray = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet resultSet = preparedStatement.executeQuery();
            String data = new DBUtils().getData(resultSet, Tags.class);
            jsonArray = JSONArray.parseArray(data, Tags.class);
        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
        return jsonArray;
    }

    @Override
    public List<String> tag(Integer articleId) {
        Connection connection = new DBUtils().getConnection();
        String sql = "select * from article_tags where articleId = ?";
        List<ArticleTags> articleTags = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setInt(1, articleId);
            ResultSet resultSet = preparedStatement.executeQuery();
            String data = new DBUtils().getData(resultSet, ArticleTags.class);
            articleTags = JSONArray.parseArray(data, ArticleTags.class);
        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
        List<String> list = new ArrayList<>();
        for (ArticleTags tag : articleTags) {
            String s = tagName((int) tag.getTagsId());
            list.add(s);
        }
        return list;
    }

    @Override
    public String tagName(Integer tagId) {
        Connection connection = new DBUtils().getConnection();
        String sql = "select * from tags where id = ?";
        Tags tags = new Tags();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setInt(1, tagId);
            ResultSet resultSet = preparedStatement.executeQuery();
            String data = new DBUtils().getData(resultSet, Tags.class);
            tags = JSON.parseObject(data, Tags.class);

        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
        return tags.getTagName();
    }

    @Override
    public boolean insertArticleTags(Integer articleId, List<Integer> list) {
        String sql = "INSERT INTO article_tags (articleId,tagsId) VALUES (?,?)";
        for (Integer item : list) {
            try {
                Connection connection = new DBUtils().getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setInt(1, articleId);
                preparedStatement.setInt(2, item);
                preparedStatement.executeUpdate();
            } catch (Exception throwables) {
                throwables.printStackTrace();
            }
        }
        return false;
    }

    @Override
    public List<ArticleMSg> aArticleMSgList(Integer tagId) {
//        到article_tags 查出所有 tagID
        Connection connection = new DBUtils().getConnection();
        String sql = "select * from article_tags where tagsId = ?";
        List<ArticleMSg> list = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setInt(1,tagId);
            ResultSet resultSet = preparedStatement.executeQuery();

            int rowCount = 0;
            resultSet.last();
            rowCount = resultSet.getRow();
            resultSet.beforeFirst();

            String data = new DBUtils().getData(resultSet, ArticleTags.class);
            if (rowCount > 1) {
                List<ArticleTags> articleTagsList = JSONArray.parseArray(data, ArticleTags.class);
//            通过 文章id 获取文章详情
                for (ArticleTags articleTag : articleTagsList) {
                    ArticleMSg articleMSg = new ArticleDaoImpl().one((int) articleTag.getArticleId());
                    list.add(articleMSg);
                }
            }else if (rowCount == 1){
                //                通过 文章id 查出全部文章
                ArticleTags articleTags = JSON.parseObject(data, ArticleTags.class);
                ArticleMSg articleMSg = new ArticleDaoImpl().one((int) articleTags.getArticleId());
                list.add(articleMSg);
            }

        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
        return list;
    }
}
