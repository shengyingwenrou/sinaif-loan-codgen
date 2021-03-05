<#include "/macro.include" />
<#include "/java_copyright.include" />
<#assign className = table.className />
<#assign classNameLower = className?uncap_first />
package ${base_package}.${project_name}.entity

import cn.com.magicwifi.framework.core.mybatis.Criterion
import com.google.common.collect.Lists
<#if table.dateColumns?size gt 0>
import java.util.*
</#if>

class ${className}Example {
    var orderByClause: String? = null
    var distinct: Boolean? = false
    val oredCriteria: MutableList<Criteria> = Lists.newArrayList()

    fun or(criteria: Criteria) {
        oredCriteria.add(criteria)
    }

    fun or(): Criteria {
        val criteria = createCriteriaInternal()
        oredCriteria.add(criteria)
        return criteria
    }

    fun createCriteria(): Criteria {
        val criteria = createCriteriaInternal()
        if (oredCriteria.size == 0) {
            oredCriteria.add(criteria)
        }
        return criteria
    }

    fun clear() {
        oredCriteria.clear()
        orderByClause = null
        distinct = false
    }

    private fun createCriteriaInternal(): Criteria {
        return Criteria()
    }

    abstract class AbstractGeneratedCriteria {
        val criteria: MutableList<Criterion> = Lists.newArrayList()

        fun isValid(): Boolean {
            return criteria.size > 0
        }

        fun getAllCriteria(): List<Criterion> {
            return criteria
        }

        private fun addCriterion(condition: String) {
            criteria.add(Criterion(condition))
        }

        private fun addCriterion(condition: String, value: Any) {
            criteria.add(Criterion(condition, value))
        }

        private fun addCriterion(condition: String, value1: Any, value2: Any) {
            criteria.add(Criterion(condition, value1, value2))
        }

        <#list table.columns as c>
        fun and${c.fieldName}IsNull(): Criteria {
            addCriterion("${c.sqlName} is null")
            return this as Criteria
        }

        fun and${c.fieldName}IsNotNull(): Criteria {
            addCriterion("${c.sqlName} is not null")
            return this as Criteria
        }

        fun and${c.fieldName}EqualTo(value: ${c.kotlinType}): Criteria {
            addCriterion("${c.sqlName} =", value)
            return this as Criteria
        }

        fun and${c.fieldName}NotEqualTo(value: ${c.kotlinType}): Criteria {
            addCriterion("${c.sqlName} <>", value)
            return this as Criteria
        }

        fun and${c.fieldName}GreaterThan(value: ${c.kotlinType}): Criteria {
            addCriterion("${c.sqlName} >", value)
            return this as Criteria
        }

        fun and${c.fieldName}GreaterThanOrEqualTo(value: ${c.kotlinType}): Criteria {
            addCriterion("${c.sqlName} >=", value)
            return this as Criteria
        }

        fun and${c.fieldName}LessThan(value: ${c.kotlinType}): Criteria {
            addCriterion("${c.sqlName} <", value)
            return this as Criteria
        }

        fun and${c.fieldName}LessThanOrEqualTo(value: ${c.kotlinType}): Criteria {
            addCriterion("${c.sqlName} <=", value)
            return this as Criteria
        }

        fun and${c.fieldName}In(values: List<${c.kotlinType}>): Criteria {
            addCriterion("${c.sqlName} in", values)
            return this as Criteria
        }

        fun and${c.fieldName}NotIn(values: List<${c.kotlinType}>): Criteria {
            addCriterion("${c.sqlName} not in", values)
            return this as Criteria
        }

        fun and${c.fieldName}Between(value1: ${c.kotlinType}, value2: ${c.kotlinType}): Criteria {
            addCriterion("${c.sqlName} between", value1, value2)
            return this as Criteria
        }

        fun and${c.fieldName}NotBetween(value1: ${c.kotlinType}, value2: ${c.kotlinType}): Criteria {
            addCriterion("${c.sqlName} not between", value1, value2)
            return this as Criteria
        }

            <#if c.stringColumn>
        fun and${c.fieldName}Like(value: ${c.kotlinType}): Criteria {
            addCriterion("${c.sqlName} like", value)
            return this as Criteria
        }

        fun and${c.fieldName}NotLike(value: ${c.kotlinType}): Criteria {
            addCriterion("${c.sqlName} not like", value)
            return this as Criteria
        }
            </#if>
        </#list>
    }

    class Criteria : AbstractGeneratedCriteria()
}