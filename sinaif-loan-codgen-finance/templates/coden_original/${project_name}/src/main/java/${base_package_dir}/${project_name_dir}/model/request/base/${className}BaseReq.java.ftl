
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.request.base;

import com.alibaba.fastjson.annotation.JSONField;
import com.sinaif.king.finance.${classNameLower}.enums.${className}TransCode;
import com.sinaif.king.model.finance.base.DataItem;

<#include "/java_imports.include" />

public abstract class ${className}BaseReq extends DataItem {

	private static final long serialVersionUID = 4536757632884013467L;

	@JSONField(serialize = false)
    private ${className}ReqHeader header = new ${className}ReqHeader();

    public ${className}ReqHeader getHeader() {
        return header;
    }

    public void setHeader(${className}ReqHeader header) {
        this.header = header;
    }
    @JSONField(serialize = false)
    public abstract ${className}TransCode getTransCode();
    
    /**
     * 客户端ip，必填 会影响风控
     */
    String clientIp;
    
    /**
     *操作系统类型 h5,android,ios
     *进件时必填
     */
    String osType;
    
    /**
     * 操作系统版本 10.1.1,8.0
     */
    String osVersion;
    
    /**
     * 端设备id C3A41D3D-FF28-4053-9EC3-722D419042D9
     * 进件时必填
     */
    String deviceId;
    
    /**
     * 端软件版本  1.1.0
     */
    String softVersion;

	public String getClientIp() {
		return clientIp;
	}

	public void setClientIp(String clientIp) {
		this.clientIp = clientIp;
	}

	public String getOsType() {
		return osType;
	}

	public void setOsType(String osType) {
		this.osType = osType;
	}

	public String getOsVersion() {
		return osVersion;
	}

	public void setOsVersion(String osVersion) {
		this.osVersion = osVersion;
	}

	public String getDeviceId() {
		return deviceId;
	}

	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}

	public String getSoftVersion() {
		return softVersion;
	}

	public void setSoftVersion(String softVersion) {
		this.softVersion = softVersion;
	}
}
