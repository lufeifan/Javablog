package com.lf.blog.dao;

import com.lf.blog.pojo.Category;
import com.lf.blog.vo.ArticleMSg;

import java.util.List;

public interface CategoryDao {

//    获取全部分类
    List<Category> list();

//   获取分类名
    String name(Integer id);

// 通过文章id 查出分类名
    String categoryName(Integer articleId);
//    将分类名和文章进行关联
    boolean saveArticleCategory(Integer articleId,Integer categoryId);

//    通过分类id 查出该分类所有文章
    List<ArticleMSg> ArticleByCategoryId(Integer categoryId);

}
