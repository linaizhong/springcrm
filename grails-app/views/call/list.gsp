
<%@ page import="org.amcworld.springcrm.Call" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'call.label', default: 'Call')}" />
  <g:set var="entitiesName" value="${message(code: 'call.plural', default: 'Calls')}" />
  <title>${entitiesName}</title>
</head>

<body>
  <div id="main-container-header">
    <h2><g:message code="${entitiesName}" /></h2>
    <nav id="toolbar-container">
      <ul id="toolbar">
        <li><g:link action="create" class="green"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
      </ul>
    </nav>
  </div>
  <section id="content">
    <g:if test="${flash.message}">
    <div class="flash-message message">${flash.message}</div>
    </g:if>
    <g:if test="${callInstanceList}">
    <g:letterBar clazz="${Call}" property="subject" />
    <table class="content-table">
      <thead>
        <tr>
          <th><input type="checkbox" id="call-multop-sel" class="multop-sel" /></th>
          <g:sortableColumn property="subject" title="${message(code: 'call.subject.label', default: 'Subject')}" />
          <g:ifModuleAllowed modules="contact"><g:sortableColumn property="organization.name" title="${message(code: 'call.organization.label', default: 'Organization')}" style="width: 15em;" /></g:ifModuleAllowed>
          <g:ifModuleAllowed modules="contact"><g:sortableColumn property="person.lastName" title="${message(code: 'call.person.label', default: 'Person')}" /></g:ifModuleAllowed>
          <g:sortableColumn property="start" title="${message(code: 'call.start.label', default: 'Start')}" style="width: 9em;" />
          <g:sortableColumn property="type" title="${message(code: 'call.type.label', default: 'Type')}" />
          <g:sortableColumn property="status" title="${message(code: 'call.status.label', default: 'Status')}" />
          <th></th>
        </tr>
      </thead>
      <tbody>
      <g:each in="${callInstanceList}" status="i" var="callInstance">
        <tr>
          <td><input type="checkbox" id="call-multop-${callInstance.id}" class="multop-sel-item" /></td>
          <td><g:link action="show" id="${callInstance.id}">${fieldValue(bean: callInstance, field: "subject")}</g:link></td>
          <g:ifModuleAllowed modules="contact"><td><g:link controller="organization" action="show" id="${callInstance.organization?.id}">${fieldValue(bean: callInstance, field: "organization")}</g:link></td></g:ifModuleAllowed>
          <g:ifModuleAllowed modules="contact"><td><g:link controller="person" action="show" id="${callInstance.person?.id}">${fieldValue(bean: callInstance, field: "person")}</g:link></td></g:ifModuleAllowed>
          <td><g:formatDate date="${callInstance.start}" /></td>
          <td><g:message code="call.type.${callInstance?.type}" /></td>
          <td><g:message code="call.status.${callInstance?.status}" /></td>
          <td>
            <g:link action="edit" id="${callInstance.id}" class="button small green"><g:message code="default.button.edit.label" /></g:link>
            <g:link action="delete" id="${callInstance?.id}" class="button small red delete-btn"><g:message code="default.button.delete.label" /></g:link>
          </td>
        </tr>
      </g:each>
      </tbody>
    </table>
    <div class="paginator">
      <g:paginate total="${callInstanceTotal}" />
    </div>
    </g:if>
    <g:else>
      <div class="empty-list">
        <p><g:message code="default.list.empty" /></p>
        <div class="buttons">
          <g:link action="create" class="green"><g:message code="default.new.label" args="[entityName]" /></g:link>
        </div>
      </div>
    </g:else>
  </section>
</body>
</html>
