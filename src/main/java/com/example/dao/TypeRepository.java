package com.example.dao;

import com.example.po.Type;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;


import java.util.List;


public interface TypeRepository extends JpaRepository<Type, Long> {

    //根据名称查询Type
    Type findByName(String name);

    //根据每个分类大小由大到小排序取前6个
    @Query("select t from Type t")
    List<Type> findTop(Pageable pageable);

}
