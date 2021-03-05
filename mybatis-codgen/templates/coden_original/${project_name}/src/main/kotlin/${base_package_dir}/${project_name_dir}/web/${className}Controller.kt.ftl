<#include "/java_copyright.include" />
<#assign className = table.className />
<#assign classNameLower = className?uncap_first />
package ${base_package}.${project_name}.web

import cn.com.magicwifi.framework.core.web.controller.BaseController
import ${base_package}.${project_name}.entity.${className}
import ${base_package}.${project_name}.service.${className}Svc
import org.apache.shiro.authz.annotation.RequiresPermissions
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.servlet.mvc.support.RedirectAttributes
import java.util.Arrays
import javax.servlet.http.HttpServletRequest

<#include "/java_imports.include" />
@RequestMapping("/${project_name}")
@Controller
open class ${className}Controller : BaseController() {

    @Autowired
    private lateinit var ${classNameLower}Svc: ${className}Svc

    @RequiresPermissions("${project_name}:${table.constantName?lower_case}:v_list")
    @RequestMapping(value = ["/${table.constantName?lower_case}/v_list"])
    open fun list(pageNo: Int?, request: HttpServletRequest, model: Model): String {
        model.addAttribute("pageNo", pageNo)
        return "${project_name}/${table.constantName?lower_case}/list"
    }

    @RequiresPermissions("${project_name}:${table.constantName?lower_case}:v_list")
    @RequestMapping(value = ["/${table.constantName?lower_case}/v_edit"], method = [RequestMethod.GET])
    open fun edit(id: ${table.pkColumns[0].kotlinType}?, model: Model): String {
        if (null != id) {
            val bean = ${classNameLower}Svc.get(id)
            model.addAttribute("bean", bean)
        }
        return "${project_name}/${table.constantName?lower_case}/edit"
    }

    @RequiresPermissions("${project_name}:${table.constantName?lower_case}:o_update")
    @RequestMapping(value = ["/${table.constantName?lower_case}/o_save"], method = [RequestMethod.POST])
    open fun save(bean: ${className}, model: Model, ra: RedirectAttributes): String {
        if (!beanValidator(model, bean)) {
            return edit(null, model)
        }
        ${classNameLower}Svc.create(bean)
        success(ra)
        return "redirect:v_list"
    }

    @RequiresPermissions("${project_name}:${table.constantName?lower_case}:o_update")
    @RequestMapping(value = ["/${table.constantName?lower_case}/o_update"], method = [RequestMethod.POST])
    open fun update(bean: ${className}, model: Model, ra: RedirectAttributes): String {
        if (!beanValidator(model, bean)) {
            return edit(bean.id, model)
        }
        ${classNameLower}Svc.modifySelective(bean)
        success(ra)
        return "redirect:v_list"
    }

    @RequiresPermissions("${project_name}:${table.constantName?lower_case}:o_update")
    @RequestMapping(value = ["/${table.constantName?lower_case}/o_delete"])
    open fun delete(ids: Array<${table.pkColumns[0].kotlinType}>, ra: RedirectAttributes): String {
        ${classNameLower}Svc.batchRemove(Arrays.asList(*ids))
        success(ra)
        return "redirect:v_list"
    }
}