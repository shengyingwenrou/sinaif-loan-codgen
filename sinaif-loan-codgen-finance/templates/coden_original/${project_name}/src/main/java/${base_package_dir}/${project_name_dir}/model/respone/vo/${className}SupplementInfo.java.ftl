<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone.vo;
import java.io.Serializable;
<#include "/java_imports.include" />

/**
 * @Description : 审批107后补件信息
 * @Copyright : Sinaif Software Co.,Ltd. All Rights Reserved
 * @Company : 海南新浪爱问普惠科技有限公司
 * @author : skysong
 * @version : 1.0
 * @Date : 2019年6月27日 下午4:26:13
 */
public class ${className}SupplementInfo implements Serializable {

    private static final long serialVersionUID = -1384825806182090439L;

    public static final String ID_HAND_IMAGE="idHandImage";

    /** 补件失效时间(送件审批 资方人工审核107时) **/
    private String supplementExpireTime;

    public String getSupplementExpireTime() {
        return supplementExpireTime;
    }

    public void setSupplementExpireTime(String supplementExpireTime) {
        this.supplementExpireTime = supplementExpireTime;
    }
}
