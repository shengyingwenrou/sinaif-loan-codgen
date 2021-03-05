/*******************************************************************************
 * Copyright (c) 2015 magicwifi.com.cn
 *******************************************************************************/
package cn.com.sinaif.@Component@.@FunctionName@.web.controller;

import cn.com.sinaif.admin.client.ClientConstants;
import cn.com.sinaif.@Component@.@FunctionName@.entity.@EntityBeanName@;
import cn.com.sinaif.@Component@.@FunctionName@.service.@EntityBeanName@Svc;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

/**
 * // @EntityBeanName@Controller
 * Created by skysong(841676215@qq.com).
 */
@RequestMapping("/@FunctionName@")
@Controller
public class @EntityBeanName@Controller {

    @Autowired
    private @EntityBeanName@Svc svc;

    @RequiresPermissions("@FunctionName@:@TableName@:v_list")
    @RequestMapping(value = "/@TableName@/v_list")
    public String list(Model model) throws Exception {
        return "@FunctionName@/@TableName@/list";
    }

    @RequiresPermissions("@FunctionName@:@TableName@:v_add")
    @RequestMapping(value = "/@TableName@/v_add", method = RequestMethod.GET)
    public String add() throws Exception {
        return "@FunctionName@/@TableName@/add";
    }

    @RequiresPermissions("@FunctionName@:@TableName@:v_edit")
    @RequestMapping(value = "/@TableName@/v_edit", method = RequestMethod.GET)
    public String edit(Integer id) throws Exception {
        return "@FunctionName@/@TableName@/edit";
    }

    @RequiresPermissions("@FunctionName@:@TableName@:o_save")
    @RequestMapping(value = "/@TableName@/o_save", method = RequestMethod.POST)
    public String save(@Valid @EntityBeanName@ bean, BindingResult result, RedirectAttributes ra) throws Exception {
        if (result.hasFieldErrors()) {
            ra.addFlashAttribute(ClientConstants.WEB_ERROR_KEY, result.getFieldError().getField() + result.getFieldError().getDefaultMessage());
            return "redirect:v_add";
        }
        // TODO 保存逻辑
        ra.addFlashAttribute(ClientConstants.WEB_MESSAGE_KEY, ClientConstants.WEB_MESSAGE_PREFIX);
        return "redirect:v_list";
    }

    @RequiresPermissions("@FunctionName@:@TableName@:o_update")
    @RequestMapping(value = "/@TableName@/o_update", method = RequestMethod.POST)
    public String update(@Valid @EntityBeanName@ bean, BindingResult result, RedirectAttributes ra) throws Exception {
        if (result.hasFieldErrors()) {
            ra.addFlashAttribute(ClientConstants.WEB_ERROR_KEY, result.getFieldError().getField() + result.getFieldError().getDefaultMessage());
            return "redirect:v_edit";
        }
        // TODO 更新逻辑
        ra.addFlashAttribute(ClientConstants.WEB_MESSAGE_KEY, ClientConstants.WEB_MESSAGE_PREFIX);
        return "redirect:v_list";
    }

    @RequiresPermissions("@FunctionName@:@TableName@:o_delete")
    @RequestMapping(value = "/@TableName@/o_delete")
    public String delete(Integer[] ids, RedirectAttributes ra) throws Exception {
        // TODO 删除逻辑
        ra.addFlashAttribute(ClientConstants.WEB_MESSAGE_KEY, ClientConstants.WEB_MESSAGE_PREFIX);
        return "redirect:v_list";
    }
}
