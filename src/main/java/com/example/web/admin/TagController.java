package com.example.web.admin;

import com.example.po.Tag;
import com.example.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Controller
@RequestMapping("/admin")
public class TagController {

    @Autowired
    private TagService tagService;

    /**
     * 启动标签页面
     * @param pageable
     * @param model
     * @return
     */
    @GetMapping("/tags")
    public String Tags(@PageableDefault(size = 5,sort = {"id"},direction = Sort.Direction.DESC)  //设置pageable 设置排序方式
                               Pageable pageable, Model model){   //pageable 是已经定义好的，有当前页，页容量，排序字段等属性

        model.addAttribute("page",tagService.listTag(pageable));
        return "admin/tags";
    }

    /**
     * 启动标签添加页面
     * @param model
     * @return
     */
    @GetMapping("/tags/input")
    public String input(Model model){
        model.addAttribute("tag",new Tag());   //传递给前台一个空的   tag
        return "admin/tags-input";
    }

    /**
     * 启动标签修改页面
     * @param id
     * @param model
     * @return
     */
    @GetMapping("/tags/{id}/input")
    public String editInput(@PathVariable Long id,Model model){
        model.addAttribute("tag",tagService.getTag(id));
        return "admin/tags-input";
    }


    /**
     * 请求 新增标签数据
     * @param tag
     * @param result
     * @param attributes
     * @return
     */
    @PostMapping("/tags")
    public String post(@Valid Tag tag, BindingResult result, RedirectAttributes attributes){
        Tag tag1 = tagService.getTagsByName(tag.getName());
        if (tag1!=null){
            result.rejectValue("name","nameError","不能添加重复的标签");
        }
        if (result.hasErrors()){
            return "admin/tags-input";
        }

        Tag t = tagService.saveTag(tag);
        if (t == null ){
            attributes.addFlashAttribute("message","新增失败");
            //如果 t 为空 则新增失败
        }else{
            attributes.addFlashAttribute("message","新增成功");
        }
        return "redirect:/admin/tags";

    }

    /**
     * 请求  更新标签
     * @param tag
     * @param result
     * @param id
     * @param attributes
     * @return
     */
    @PostMapping("/tags/{id}")
    public String eidtpost(@Valid Tag tag, BindingResult result,
                           @PathVariable Long id,RedirectAttributes attributes){
        Tag tag1 = tagService.getTagsByName(tag.getName());
        if (tag1!=null){
            result.rejectValue("name","nameError","不能添加重复的标签");
        }
        if (result.hasErrors()){
            return "admin/tags-input";
        }

        Tag t = tagService.upadteTag(id,tag);
        if (t == null ){
            attributes.addFlashAttribute("message","更新失败");
            //如果 t 为空 则新增失败
        }else{
            attributes.addFlashAttribute("message","更新成功");
        }
        return "redirect:/admin/tags";

    }

    /**
     * 请求  删除标签
     * @param id
     * @param attributes
     * @return
     */
    @GetMapping("tags/{id}/delete")
    public String delete(@PathVariable Long id,RedirectAttributes attributes){
        tagService.delete(id);
        attributes.addFlashAttribute("message","删除成功");
        return "redirect:/admin/tags";
    }
}
