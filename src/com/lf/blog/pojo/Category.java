package com.lf.blog.pojo;


public class Category {

  private long id;
  private String categoryName;
  private String categoryDescribe;


  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }


  public String getCategoryName() {
    return categoryName;
  }

  public void setCategoryName(String categoryName) {
    this.categoryName = categoryName;
  }


  public String getCategoryDescribe() {
    return categoryDescribe;
  }

  public void setCategoryDescribe(String categoryDescribe) {
    this.categoryDescribe = categoryDescribe;
  }

}
