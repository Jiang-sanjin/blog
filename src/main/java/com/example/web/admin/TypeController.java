package com.example.web.admin;

import com.example.po.Type;
import com.example.service.TypeService;
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
public class TypeController {

    @Autowired
    private TypeService typeService;

    /**
     * 分页查询   （显示分类页面）
     *
     * @param pageable
     * @param model
     * @return
     */
    @GetMapping("/types")
    public String types(@PageableDefault(size = 5, sort = {"id"}, direction = Sort.Direction.DESC)  //设置pageable 设置排序方式
                                Pageable pageable, Model model) {   //pageable 是已经定义好的，有当前页，页容量，排序字段等属性

        model.addAttribute("page", typeService.listType(pageable));  //往前台传数据   记录页面信息
        return "admin/types";
    }


    /**
     * 添加分类名称   （跳转页面）
     *
     * @return 返回新增页面
     */
    @GetMapping("/types/input")
    public String input(Model model) {
        model.addAttribute("type", new Type());  //
        return "admin/types-input";
    }

    /**
     * 跳转修改分类名称   （根据id跳转页面）
     *
     * @param id
     * @param model
     * @return
     */
    @GetMapping("/types/{id}/input")
    public String editInput(@PathVariable Long id, Model model) {   // @PathVariable  接收id
        model.addAttribute("type", typeService.getType(id));  //查询需要
        return "admin/types-input";
    }

    /**
     * 保存分类名称    （请求 实现保存）
     *
     * @param type
     * @param result
     * @param attributes
     * @return
     */
    @PostMapping("/types")
    public String post(@Valid Type type, BindingResult result, RedirectAttributes attributes) {  // @Valid验证注解  BindingResult校验参数必须跟在Valid后面

        Type type1 = typeService.getTypeByName(type.getName());   //根据名字查询该分类是否存在
        if (type1 != null) {
            result.rejectValue("name", "nameError", "不能添加重复的分类");
        }

        if (result.hasErrors()) {    //检验参数
            return "admin/types-input";
        }
        Type t = typeService.saveType(type);
        if (t == null) {
            attributes.addFlashAttribute("message", "新增失败");
            //如果 t 为空 则新增失败
        } else {
            attributes.addFlashAttribute("message", "新增成功");
        }
        return "redirect:/admin/types";

    }

    /**
     * 更新分类名称   （请求 实现更新）
     *
     * @param type
     * @param result
     * @param id
     * @param attributes
     * @return
     */

    @PostMapping("/types/{id}")
    public String editPost(@Valid Type type, BindingResult result,
                           @PathVariable Long id, RedirectAttributes attributes) {

        //查询type是否存在
        Type type1 = typeService.getTypeByName(type.getName());
        if (type1 != null) {
            result.rejectValue("name", "nameError", "不能添加重复的分类");
        }

        if (result.hasErrors()) {
            return "admin/types-input";
        }
        Type t = typeService.updateType(id, type);
        if (t == null) {
            attributes.addFlashAttribute("message", "更新失败");
            //如果 t 为空 则新增失败
        } else {
            attributes.addFlashAttribute("message", "更新成功");
        }
        return "redirect:/admin/types";
    }

    /**
     * 删除分类   （请求）
     *
     * @param id
     * @param attributes
     * @return
     */
    @GetMapping("/types/{id}/delete")
    public String delete(@PathVariable Long id, RedirectAttributes attributes) {
        typeService.deleteType(id);
        attributes.addFlashAttribute("message", "删除成功");
        return "redirect:/admin/types";
    }


}
