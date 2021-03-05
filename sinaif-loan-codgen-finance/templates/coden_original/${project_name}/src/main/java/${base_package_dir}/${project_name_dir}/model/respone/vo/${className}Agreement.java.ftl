
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone.vo;
import java.io.Serializable;
<#include "/java_imports.include" />

public class ${className}Agreement implements Serializable {

    private static final long serialVersionUID = 4351907343738083460L;

    /** 合同标题 **/
    private String title;
    /** 合同链接 **/
    private String url;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

}
