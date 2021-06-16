package com.lf.blog.pojo;


public class ArticleTags {

  private long id;
  private long articleId;
  private long tagsId;


  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }


  public long getArticleId() {
    return articleId;
  }

  public void setArticleId(long articleId) {
    this.articleId = articleId;
  }


  public long getTagsId() {
    return tagsId;
  }

  public void setTagsId(long tagsId) {
    this.tagsId = tagsId;
  }

}
