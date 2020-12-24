package com.example.service;

import com.example.po.Type;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;


public interface TypeService {

    //新增 保存
    Type saveType(Type type);

    //根据id查询
    Type getType(Long id);

    //根据名字查询
    Type getTypeByName(String name);

    //分页查询
    Page<Type> listType(Pageable pageable);

    //查询全部
    List<Type> listType();

    List<Type> listTypeTop(Integer size);

    //更新
    Type updateType(Long id,Type type);

    //删除
    void deleteType(Long id);
}
