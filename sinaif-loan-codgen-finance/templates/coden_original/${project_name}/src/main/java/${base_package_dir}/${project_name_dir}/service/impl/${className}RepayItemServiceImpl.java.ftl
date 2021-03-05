<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.sinaif.king.enums.finance.product.ProductEnum;
import com.sinaif.king.gateway.repay.item.impl.AbstractRepayItemService;
import com.sinaif.king.model.finance.bill.BillDetailBean;
import com.sinaif.king.model.finance.bill.BillInfoBean;
import com.sinaif.king.model.finance.bill.BillItemBeanResult;
import com.sinaif.king.model.finance.credit.CreditApplyBean;
import com.sinaif.king.model.finance.product.ProductRepayConfBean;
import com.sinaif.king.model.finance.product.ProductRepayConfBeanResult;
import com.sinaif.king.model.finance.product.ProductRepayConfExtBean;
import com.sinaif.king.model.finance.repay.RepayApplyInitResult;
import com.sinaif.king.model.finance.repay.RepayApplyPreResultBean;
import com.sinaif.king.model.finance.repay.apply.RepayApplyInitVO;
import com.sinaif.king.model.finance.repay.apply.RepayApplyVO;
import com.sinaif.king.model.finance.withdraw.WithdrawApplyBean;

<#include "/java_imports.include" />
@Service
public class ${className}RepayItemServiceImpl extends AbstractRepayItemService {
	
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    public ProductEnum getServiceName() {
        return ProductEnum.${classNameUpper};
    }

    @Override
    protected List<BillItemBeanResult> getNormalExtraFeeItem(RepayApplyInitVO vo, BillInfoBean bill) {
        return null;
    }

    @Override
    protected List<BillItemBeanResult> getOverdueExtraFeeItem(RepayApplyInitVO vo, BillInfoBean bill) {
        return null;
    }

    @Override
    protected void initSettleFlowInfo(RepayApplyInitVO vo, RepayApplyInitResult result) {

    }

	@Override
	protected void requestApplyItem(RepayApplyVO apply, CreditApplyBean creditApplyBean, WithdrawApplyBean withdrawApplyBean, RepayApplyPreResultBean result) {

	}

    @Override
    protected String saveRepayApplyItem(RepayApplyVO apply, CreditApplyBean creditApplyBean, WithdrawApplyBean withdrawApplyBean) {

    	return null;
    }

	@Override
	protected void setIsManualRepay(RepayApplyInitVO vo, ProductRepayConfBeanResult conf, ProductRepayConfBean repayConf, BillInfoBean billInfo, List<ProductRepayConfExtBean> byRepayconfid) {
    	
	}

	@Override
	protected void initNormalRepayFlowInfoRemote(RepayApplyInitResult result, BillInfoBean bill, List<BillDetailBean> detailBeans) {

	}

	@Override
	protected void initAutoRepayFlowInfoRemote(RepayApplyInitResult result, BillInfoBean bill, List<BillDetailBean> detailBeans) {

	}

	@Override
	protected void initSingleOverDueRepayFlowInfoRemote(RepayApplyInitResult result, BillInfoBean bill, List<BillDetailBean> detailBeans) {

	}

	@Override
	protected void initMultiOverDueRepayFlowInfoRemote(RepayApplyInitResult result, BillInfoBean bill, List<BillDetailBean> detailBeans) {

	}
}
