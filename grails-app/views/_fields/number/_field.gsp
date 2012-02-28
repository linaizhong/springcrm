<g:applyLayout name="field">
  <g:if test="${constraints.widget == 'currency'}">
    <f:input bean="${bean}" property="${property}" value="${formatNumber(number: value, minFractionDigits: 2)}" size="${size ?: 10}" />&nbsp;<g:currency /><br />
  </g:if>
  <g:elseif test="${constraints.widget == 'percent'}">
    <f:input bean="${bean}" property="${property}" value="${formatNumber(number: value, minFractionDigits: 2)}" size="${size ?: 10}" />&nbsp;%<br />
  </g:elseif>
  <g:else>
    <f:input bean="${bean}" property="${property}" value="${fieldValue(bean: bean, field: property)}" size="${size ?: 10}" /><br />
  </g:else>
</g:applyLayout>