<%@ page import="org.amcworld.springcrm.Dunning" %>
<html>
<head>
  <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'dunning.label', default: 'Dunning')}" />
  <g:set var="entitiesName" value="${message(code: 'dunning.plural', default: 'Dunnings')}" />
  <title><g:message code="default.create.label" args="[entityName]" /></title>
</head>

<body>
  <header>
    <h1><g:message code="${entitiesName}" /></h1>
    <g:render template="/layouts/toolbarForm" model="[formName: 'dunning']" />
  </header>
  <div id="content">
    <g:if test="${flash.message}">
    <div class="flash-message message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${dunningInstance}">
    <div class="flash-message form-error-hint"><g:message code="default.form.errorHint" /></div>
    </g:hasErrors>
    <h2><g:message code="dunning.new.label" default="New ${entityName}" /></h2>
    <g:form name="dunning-form" action="save"
      params="[returnUrl: params.returnUrl]">
      <g:hiddenField name="project" value="${project}" />
      <g:hiddenField name="projectPhase" value="${projectPhase}" />
      <g:render template="/dunning/form" />
    </g:form>
  </div>
</body>
</html>
