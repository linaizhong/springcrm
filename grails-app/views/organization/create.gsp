<%@ page import="org.amcworld.springcrm.Organization" %>
<html>
<head>
  <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'organization.label', default: 'Organization')}" />
  <g:set var="entitiesName" value="${message(code: 'organization.plural', default: 'Organizations')}" />
  <title><g:message code="default.create.label" args="[entityName]" /></title>
</head>

<body>
  <header>
    <h1><g:message code="${entitiesName}" /></h1>
    <nav id="toolbar-container">
      <ul id="toolbar">
        <li><g:button color="green" class="submit-btn" icon="floppy-o"
          data-form="organization-form" message="default.button.save.label"
          /></li>
        <li><g:button action="list" params="[type: params.recType]"
          color="red" icon="times-circle-o"
          message="default.button.cancel.label" /></li>
      </ul>
    </nav>
  </header>
  <div id="content">
    <g:if test="${flash.message}">
    <div class="flash-message message" role="status">${raw(flash.message)}</div>
    </g:if>
    <g:hasErrors bean="${organizationInstance}">
    <div class="flash-message form-error-hint"><g:message code="default.form.errorHint" /></div>
    </g:hasErrors>
    <h2><g:message code="organization.new.label" /></h2>
    <g:form name="organization-form" action="save" >
      <g:render template="/organization/form" />
    </g:form>
  </div>
  <content tag="scripts">
    <asset:javascript src="organization-form" />
  </content>
</body>
</html>
