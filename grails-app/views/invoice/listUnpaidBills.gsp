<ol class="simple-ordered-list">
<g:each in="${invoiceInstanceList}" var="invoiceInstance">
  <li>
    <g:link controller="invoice" action="show" id="${invoiceInstance.id}">${invoiceInstance.fullNumber} ${invoiceInstance.subject}</g:link><br />
    <g:message code="invoice.for.label" /> ${invoiceInstance.organization.name}<br />
    <g:message code="invoice.due.label" />: <g:formatDate date="${invoiceInstance.dueDatePayment}" type="date" /><br />
    <g:message code="invoice.amount.label" />: <g:formatCurrency number="${invoiceInstance.total}" /><g:if test="${invoiceInstance.paymentAmount}">, <g:message code="invoice.stillUnpaid.label" default="still unpaid" />: <g:formatCurrency number="${invoiceInstance.total - invoiceInstance.paymentAmount}" /></g:if>
  </li>
</g:each>
</ol>