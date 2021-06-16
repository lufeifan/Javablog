package com.lf.blog.vo;


import java.util.Date;
import java.util.List;

public class ArticleMSg {

  private long id;
  private String title;
  private String categoryName;
  private List tagName;
  private String content;
  private String doc;
  private String author;
  private Integer score;
  private Integer status;
  private Date createtime;
  private Date updatatime;

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getCategoryName() {
    return categoryName;
  }

  public void setCategoryName(String categoryName) {
    this.categoryName = categoryName;
  }



  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public String getDoc() {
    return doc;
  }

  public List getTagName() {
    return tagName;
  }

  public void setTagName(List tagName) {
    this.tagName = tagName;
  }

  public void setDoc(String doc) {
    this.doc = doc;
  }

  public String getAuthor() {
    return author;
  }

  public void setAuthor(String author) {
    this.author = author;
  }

  public Integer getScore() {
    return score;
  }

  public void setScore(Integer score) {
    this.score = score;
  }

  public Integer getStatus() {
    return status;
  }

  public void setStatus(Integer status) {
    this.status = status;
  }

  public Date getCreatetime() {
    return createtime;
  }

  public void setCreatetime(Date createtime) {
    this.createtime = createtime;
  }

  public Date getUpdatatime() {
    return updatatime;
  }

  public void setUpdatatime(Date updatatime) {
    this.updatatime = updatatime;
  }
}
