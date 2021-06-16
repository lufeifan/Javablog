package com.lf.blog.dao;

import com.lf.blog.pojo.ArticleTags;
import com.lf.blog.pojo.Tags;
import com.lf.blog.vo.ArticleMSg;

import java.util.List;

public interface TagsDao {

    List<Tags> list();

    List<String> tag(Integer articleId);

    String tagName(Integer tagId);

    boolean insertArticleTags(Integer articleId,List<Integer> list);

//    通过标签id 查文章
    List<ArticleMSg> aArticleMSgList(Integer tagId);
}
