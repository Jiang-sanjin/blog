package com.example.service.impl;

import com.example.NotFoundException;
import com.example.dao.TypeRepository;
import com.example.po.Type;
import com.example.service.TypeService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class TypeServiceImpl implements TypeService {

    @Autowired
    private TypeRepository typeRepository;

    @Transactional
    @Override
    public Type saveType(Type type) {
        return typeRepository.save(type);
    }

    @Override
    public Type getType(Long id) {
        return typeRepository.findById(id).orElse(null);
    }

    /**
     * 根据名字查信息
     * @param name
     * @return
     */
    @Override
    public Type getTypeByName(String name) {
        return typeRepository.findByName(name);
    }

    /**
     * 分页查询
     * @param pageable
     * @return
     */
    @Transactional
    @Override
    public Page<Type> listType(Pageable pageable) {
        return typeRepository.findAll(pageable);
    }

    /**
     * 查询全部
     * @return
     */
    @Override
    public List<Type> listType() {
        return typeRepository.findAll();
    }

    /**
     * 博客页面   右上角 查询分类
     * @param size
     * @return
     */
    @Override
    public List<Type> listTypeTop(Integer size) {

        // 设置排序对象   blogs集合的大小
        Sort sort = Sort.by(Sort.Direction.DESC,"blogs.size");   //根据博客大小排序
        Pageable pageable = PageRequest.of(0, size, sort);   //排序取前size个
        return typeRepository.findTop(pageable);
    }

    @Transactional
    @Override
    public Type updateType(Long id, Type type) {
        Type t = typeRepository.findById(id).orElse(null);  //根据id查询   存在就更新保存
        if (t ==null ){
            throw new NotFoundException("不存在该类型");
        }
        BeanUtils.copyProperties(type,t);   //将type值赋给t

        return typeRepository.save(t);
    }

    @Transactional
    @Override
    public void deleteType(Long id) {

        typeRepository.deleteById(id);
    }
}
