<#include "/java_copyright.include" />
<#assign className = table.className />
<#assign classNameLower = className?uncap_first />
package ${base_package}.admin.${project_name}.controller;

import cn.com.sinaif.framework.core.datasource.DBContextHolder;
import cn.com.sinaif.framework.core.page.Page;
import cn.com.sinaif.framework.core.page.PageUtils;
import cn.com.sinaif.framework.core.web.controller.BaseController;
import cn.com.sinaif.framework.core.web.utils.ServletUtils;
import ${base_package}.admin.common.config.DataSource;

import org.apache.commons.lang3.StringUtils;
import ${base_package}.${project_name}.entity.${className};
import ${base_package}.${project_name}.service.${className}Svc;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.beans.propertyeditors.CustomDateEditor;

import javax.servlet.http.HttpServletRequest;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

<#include "/java_imports.include" />
@RequestMapping("/${project_name}")
@Controller
public class ${className}Controller extends BaseController {

    @Autowired
    private ${className}Svc ${classNameLower}Svc;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd" );
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

     /**
       * 分页列表
       */
     @RequiresPermissions("${project_name}:${table.constantName?lower_case}:v_list")
     @RequestMapping(value = "/${table.constantName?lower_case}/v_list")
     public String list(Integer pageNo,String queryCodetype,String queryCodekey, HttpServletRequest request,
             Model model, RedirectAttributes ra) {
         DBContextHolder.setDBKey(DataSource.SINAIF_KING);
         Page<${className}> page = ${classNameLower}Svc.pagination(pageNo, PageUtils.getPageSize(request),queryCodetype,queryCodekey);
         DBContextHolder.setDBKey(DataSource.CORE);
         model.addAttribute("queryCodetype", queryCodetype);
         model.addAttribute("queryCodekey", queryCodekey);
         model.addAttribute("pageNo", pageNo);
         return "${project_name}/${table.constantName?lower_case}/index";
     }

    /**
     * 重置查询条件
     */
    @RequiresPermissions("${project_name}:${table.constantName?lower_case}:v_list")
    @RequestMapping(value = "/${table.constantName?lower_case}/v_reset")
    public String reset(HttpServletRequest request, RedirectAttributes ra) {
        ServletUtils.removeSessionAttribute(request, "queryCodetype");
        ServletUtils.removeSessionAttribute(request, "queryCodekey");
        addMessage(ra,"重置成功");
        return "redirect:/${project_name}/${table.constantName?lower_case}/v_list";
    }

    /**
     * 添加
     */
     @RequiresPermissions("${project_name}:${table.constantName?lower_case}:v_list")
    @RequestMapping(value = "/${table.constantName?lower_case}/v_add", method = RequestMethod.GET)
    public String add( Model model) {
        ${className} bean = new ${className}();
        model.addAttribute("bean", bean);
        return "${project_name}/${table.constantName?lower_case}/add";
    }

   /**
     * 编辑
     */
    @RequiresPermissions("${project_name}:${table.constantName?lower_case}:v_list")
    @RequestMapping(value = "/${table.constantName?lower_case}/v_edit", method = RequestMethod.GET)
    public String edit(String id, Model model) {
        if (null != id) {
            DBContextHolder.setDBKey(DataSource.SINAIF_KING);
            ${className} bean = ${classNameLower}Svc.get(id);
            DBContextHolder.setDBKey(DataSource.CORE);
            model.addAttribute("bean", bean);
        }
        return "${project_name}/${table.constantName?lower_case}/edit";
    }

    /**
     * 保存
     */
    @RequiresPermissions("${project_name}:${table.constantName?lower_case}:o_update")
    @RequestMapping(value = "/${table.constantName?lower_case}/o_save", method = RequestMethod.POST)
    public String save(${className} bean, Model model, RedirectAttributes ra) {
        DBContextHolder.setDBKey(DataSource.SINAIF_KING);
        Date d = new Date();
        if(StringUtils.isNotBlank(bean.getId())){
            bean.setUpdatetime(d);
            ${classNameLower}Svc.modifySelective(bean);
        }else{
            bean.setId(String.valueOf(System.currentTimeMillis()));
            bean.setCreatetime(d);
            ${classNameLower}Svc.create(bean);
        }
        DBContextHolder.setDBKey(DataSource.CORE);
        success(ra);
        return "redirect:/${project_name}/${table.constantName?lower_case}/v_list";
    }

    /**
     * 克隆
     */
     @RequiresPermissions("${project_name}:${table.constantName?lower_case}:o_update")
      @RequestMapping(value = "/${table.constantName?lower_case}/v_copy")
      public String copy(String id, RedirectAttributes ra) {
          DBContextHolder.setDBKey(DataSource.SINAIF_KING);
          if(StringUtils.isNotBlank(id)){
              ${className} ${classNameLower}=${classNameLower}Svc.get(id);
              if(null!=${classNameLower}){
                  Date d = new Date();
                  ${classNameLower}.setId(String.valueOf(System.currentTimeMillis()));
                  ${classNameLower}.setCreatetime(d);
                  ${classNameLower}Svc.create(${classNameLower});
              }
          }
          DBContextHolder.setDBKey(DataSource.CORE);
          success(ra);
          return "redirect:/${project_name}/${table.constantName?lower_case}/v_list";
      }

    /**
     * 更新排序
     */
    @RequiresPermissions("${project_name}:${table.constantName?lower_case}:o_update")
    @RequestMapping(value = "/${table.constantName?lower_case}/o_sort")
    public String sort(String[] wids, Integer[] ranks, RedirectAttributes ra) {
        DBContextHolder.setDBKey(DataSource.SINAIF_KING);
        // ${classNameLower}Svc.modifyRank(wids, ranks);
        DBContextHolder.setDBKey(DataSource.CORE);
        success(ra);
        return "redirect:/${project_name}/${table.constantName?lower_case}/v_list";
    }


    /**
     * 删除
     */
    @RequiresPermissions("${project_name}:${table.constantName?lower_case}:o_update")
    @RequestMapping(value = "/${table.constantName?lower_case}/o_delete")
    public String delete(String[] ids, RedirectAttributes ra) {
        DBContextHolder.setDBKey(DataSource.SINAIF_KING);
        ${classNameLower}Svc.batchRemove(Arrays.asList(ids));
        DBContextHolder.setDBKey(DataSource.CORE);
        success(ra);
        return "redirect:/${project_name}/${table.constantName?lower_case}/v_list";
    }

}