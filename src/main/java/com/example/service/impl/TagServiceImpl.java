package com.example.service.impl;

import com.example.NotFoundException;
import com.example.dao.TagRepository;
import com.example.po.Tag;
import com.example.service.TagService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class TagServiceImpl implements TagService {

    @Autowired
    private TagRepository tagRepository;

    @Transactional    //事务
    @Override
    public Tag saveTag(Tag tag) {
        return tagRepository.save(tag);
    }

    @Override
    public Tag getTag(Long id) {
        return tagRepository.findById(id).orElse(null);
    }

    @Override
    public Tag getTagsByName(String name) {
        return tagRepository.findByName(name);
    }

    @Transactional
    @Override
    public Page<Tag> listTag(Pageable pageable) {
        return tagRepository.findAll(pageable);
    }

    @Override
    public List<Tag> listTag() {
        return tagRepository.findAll();
    }

    @Override
    public List<Tag> listTag(String ids) { //1,2,3

        // return tagRepository.findAll(convertToList(ids));   无效
        return tagRepository.findAllById(convertToList(ids));
    }

    /**
     * 博客首页  右侧标签展示
     * @param size
     * @return
     */
    @Override
    public List<Tag> listTagTop(Integer size) {
        // 设置排序对象
        Sort sort = Sort.by(Sort.Direction.DESC,"blogs.size");
        Pageable pageable = PageRequest.of(0, size, sort);
        return tagRepository.findTop(pageable);
    }

    private List<Long> convertToList(String ids) {
        List<Long> list = new ArrayList<>();
        if (!"".equals(ids) && ids != null) {
            String[] idarray = ids.split(",");
            for (int i=0; i < idarray.length;i++) {
                list.add(new Long(idarray[i]));
            }
        }
        return list;
    }

    @Transactional
    @Override
    public Tag upadteTag(Long id, Tag tag) {
        Tag t = tagRepository.findById(id).orElse(null);
        if (t==null){
            throw new NotFoundException("不存在该标签");
        }
        BeanUtils.copyProperties(tag,t);   //将tag赋值给t
        return tagRepository.save(t);
    }

    @Override
    public void delete(Long id) {
        tagRepository.deleteById(id);
    }
}
