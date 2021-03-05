
<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.model.respone;
import com.alibaba.fastjson.JSONArray;
import com.sinaif.king.finance.${classNameLower}.model.respone.base.${className}BaseRsp;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}Agreement;
import com.sinaif.king.finance.${classNameLower}.model.respone.vo.${className}RepayPlan;
import java.io.Serializable;
import java.util.List;

<#include "/java_imports.include" />
public class ${className}ApplyComputeRepayPlanRsp extends ${className}BaseRsp implements Serializable {


    private static final long serialVersionUID = -6429951798550299658L;

    List<${className}RepayPlan> repayPlans;

	public List<${className}RepayPlan> getRepayPlans() {
		return repayPlans;
	}

	public void setRepayPlans(List<${className}RepayPlan> repayPlans) {
		this.repayPlans = repayPlans;
	}
    
    

}