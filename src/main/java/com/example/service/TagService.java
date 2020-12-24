package com.example.service;

import com.example.po.Tag;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface TagService {

    //新增
    Tag saveTag(Tag tag);

    //根据id获取
    Tag getTag(Long id);

    //根据名称查询
    Tag getTagsByName(String name);

    //分页查询
    Page<Tag> listTag(Pageable pageable);


    //获取所有标签
    List<Tag> listTag();

    List<Tag> listTag(String ids);

    List<Tag> listTagTop(Integer size);

    //更新
    Tag  upadteTag(Long id,Tag tag);

    //删除
    void delete(Long id);
}
