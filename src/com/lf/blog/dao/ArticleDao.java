package com.lf.blog.dao;

import com.lf.blog.pojo.Article;
import com.lf.blog.vo.ArticleMSg;

import java.util.List;

public interface ArticleDao {

//    文章保存
    boolean save(ArticleMSg article);

//  获取一篇文章信息
    ArticleMSg one(int id);

//    获取全部文章
    List<Article> list();

//    文章更新
    boolean update(Article article);

//    修改文章状态，
    boolean changStatus(int id,int status);

}
