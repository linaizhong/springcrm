<%@ page import="org.amcworld.springcrm.Ticket" %>
<html>
<head>
  <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'ticket.label', default: 'Ticket')}" />
  <g:set var="entitiesName" value="${message(code: 'ticket.plural', default: 'Tickets')}" />
  <title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>

<body>
  <header>
    <h1><g:message code="${entitiesName}" /></h1>
    <g:render template="/layouts/toolbarForm" model="[formName: 'ticket']" />
  </header>
  <div id="content">
    <g:if test="${flash.message}">
    <div class="flash-message message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${ticketInstance}">
    <div class="flash-message form-error-hint"><g:message code="default.form.errorHint" /></div>
    </g:hasErrors>
    <h2>${ticketInstance?.toString()}</h2>
    <g:uploadForm name="ticket-form" action="update" method="post"
      params="[returnUrl: params.returnUrl]">
      <g:hiddenField name="id" value="${ticketInstance?.id}" />
      <g:hiddenField name="version" value="${ticketInstance?.version}" />
      <g:render template="form"/>
    </g:uploadForm>
  </div>
</body>
</html>