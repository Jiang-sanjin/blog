package com.example.service;

import com.example.po.Blog;
import com.example.vo.BlogQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

public interface BlogService {

    // 根据id查询blog
    Blog getBlog(Long id);

    //转换为markdown语法输出
    Blog getAndConvert(Long id);

    //分页查询   blog查询条件
    Page<Blog> listBlog(Pageable pageable, BlogQuery blog);

    Page<Blog> listBlog(Pageable pageable);

    Page<Blog> listBlog(Long tagId, Pageable pageable);

    //根据查询跳转页面
    Page<Blog> listBlog(String query, Pageable pageable);


    List<Blog> listRecommendBlogTop(Integer size);

    Map<String,List<Blog>> archiveBlog();

    Long countBlog();

    //新增
    Blog saveBlog(Blog blog);

    //更新博客
    Blog updateBlog(Long id,Blog blog);

    void deleteBlog(Long id);


    List<Blog> listNewBlog(Integer size);
}
