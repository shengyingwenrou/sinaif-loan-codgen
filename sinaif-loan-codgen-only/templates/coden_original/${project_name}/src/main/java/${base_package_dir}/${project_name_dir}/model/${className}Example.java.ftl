<#include "/macro.include" />
<#include "/java_copyright.include" />
<#assign className = table.className />
<#assign classNameLower = className?uncap_first />
package ${base_package}.model.${project_name};

import java.util.ArrayList;
<#if table.dateColumns?size gt 0>
import java.util.Date;
</#if>
import java.util.List;

import cn.com.sinaif.codgen.config.Criterion;

public class ${className}Example {
    protected String orderByClause;

    protected String paginationByLimit;

    protected boolean distinct;

    protected String regexp;

    protected List<Criteria> oredCriteria;

    public ${className}Example() {
        oredCriteria = new ArrayList<>();
    }


   public void setRegexp(String regexp) {
      this.regexp = regexp;
   }

   public String getRegexp() {
      return regexp;
   }


   public void setPaginationByLimit(String paginationByLimit) {
       this.paginationByLimit = paginationByLimit;
   }

    public String getPaginationByLimit() {
         return paginationByLimit;
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        <#list table.columns as c>
        public Criteria and${c.fieldName}IsNull() {
            addCriterion("${c.sqlName} is null");
            return (Criteria) this;
        }

        public Criteria and${c.fieldName}IsNotNull() {
            addCriterion("${c.sqlName} is not null");
            return (Criteria) this;
        }

        public Criteria and${c.fieldName}EqualTo(${c.simpleJavaType} value) {
            addCriterion("${c.sqlName} =", value, "${c.sqlName}");
            return (Criteria) this;
        }

        public Criteria and${c.fieldName}NotEqualTo(${c.simpleJavaType} value) {
            addCriterion("${c.sqlName} <>", value, "${c.sqlName}");
            return (Criteria) this;
        }

        public Criteria and${c.fieldName}GreaterThan(${c.simpleJavaType} value) {
            addCriterion("${c.sqlName} >", value, "${c.sqlName}");
            return (Criteria) this;
        }

        public Criteria and${c.fieldName}GreaterThanOrEqualTo(${c.simpleJavaType} value) {
            addCriterion("${c.sqlName} >=", value, "${c.sqlName}");
            return (Criteria) this;
        }

        public Criteria and${c.fieldName}LessThan(${c.simpleJavaType} value) {
            addCriterion("${c.sqlName} <", value, "${c.sqlName}");
            return (Criteria) this;
        }

        public Criteria and${c.fieldName}LessThanOrEqualTo(${c.simpleJavaType} value) {
            addCriterion("${c.sqlName} <=", value, "${c.sqlName}");
            return (Criteria) this;
        }

        public Criteria and${c.fieldName}In(List<${c.simpleJavaType}> values) {
            addCriterion("${c.sqlName} in", values, "${c.sqlName}");
            return (Criteria) this;
        }

        public Criteria and${c.fieldName}NotIn(List<${c.simpleJavaType}> values) {
            addCriterion("${c.sqlName} not in", values, "${c.sqlName}");
            return (Criteria) this;
        }

        public Criteria and${c.fieldName}Between(${c.simpleJavaType} value1, ${c.simpleJavaType} value2) {
            addCriterion("${c.sqlName} between", value1, value2, "${c.sqlName}");
            return (Criteria) this;
        }

        public Criteria and${c.fieldName}NotBetween(${c.simpleJavaType} value1, ${c.simpleJavaType} value2) {
            addCriterion("${c.sqlName} not between", value1, value2, "${c.sqlName}");
            return (Criteria) this;
        }

        <#if c.stringColumn>
        public Criteria and${c.fieldName}Like(${c.simpleJavaType} value) {
            addCriterion("${c.sqlName} like", value, "${c.sqlName}");
            return (Criteria) this;
        }

        public Criteria and${c.fieldName}NotLike(${c.simpleJavaType} value) {
            addCriterion("${c.sqlName} not like", value, "${c.sqlName}");
            return (Criteria) this;
        }
        </#if>

        </#list>
    }

    public static class Criteria extends GeneratedCriteria {
        protected Criteria() {
            super();
        }
    }
}