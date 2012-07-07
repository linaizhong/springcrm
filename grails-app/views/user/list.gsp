<%@ page import="org.amcworld.springcrm.User" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
  <g:set var="entitiesName" value="${message(code: 'user.plural', default: 'Users')}" />
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
    <div class="flash-message message" role="status">${flash.message}</div>
    </g:if>
    <g:if test="${userInstanceList}">
    <g:letterBar clazz="${User}" property="userName" />
    <table class="content-table">
      <thead>
        <tr>
          <th id="content-table-headers-user-row-selector"><input type="checkbox" id="user-row-selector" /></th>
          <g:sortableColumn id="content-table-headers-user-user-name" property="userName" title="${message(code: 'user.userName.label', default: 'User Name')}" />
          <g:sortableColumn id="content-table-headers-user-last-name" property="lastName" title="${message(code: 'user.lastName.label', default: 'Last Name')}" />
          <g:sortableColumn id="content-table-headers-user-first-name" property="firstName" title="${message(code: 'user.firstName.label', default: 'First Name')}" />
          <g:sortableColumn id="content-table-headers-user-phone" property="phone" title="${message(code: 'user.phone.label', default: 'Phone')}" />
          <g:sortableColumn id="content-table-headers-user-mobile" property="mobile" title="${message(code: 'user.mobile.label', default: 'Mobile')}" />
          <g:sortableColumn id="content-table-headers-user-email" property="email" title="${message(code: 'user.email.label', default: 'E-mail')}" />
          <th id="content-table-headers-user-buttons"></th>
        </tr>
      </thead>
      <tbody>
      <g:each in="${userInstanceList}" status="i" var="userInstance">
        <tr>
          <td class="content-table-row-selector" headers="content-table-headers-user-row-selector"><input type="checkbox" id="user-row-selector-${userInstance.id}" data-id="${userInstance.id}" /></td>
          <td class="content-table-type-string content-table-column-user-user-name" headers="content-table-headers-user-user-name"><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "userName")}</g:link></td>
          <td class="content-table-type-string content-table-column-user-last-name" headers="content-table-headers-user-last-name">${fieldValue(bean: userInstance, field: "lastName")}</td>
          <td class="content-table-type-string content-table-column-user-first-name" headers="content-table-headers-user-first-name">${fieldValue(bean: userInstance, field: "firstName")}</td>
          <td class="content-table-type-string content-table-column-user-phone" headers="content-table-headers-user-phone"><a href="tel:${fieldValue(bean: userInstance, field: "phone")}">${fieldValue(bean: userInstance, field: "phone")}</a></td>
          <td class="content-table-type-string content-table-column-user-mobile" headers="content-table-headers-user-mobile"><a href="tel:${fieldValue(bean: userInstance, field: "mobile")}">${fieldValue(bean: userInstance, field: "mobile")}</a></td>
          <td class="content-table-type-string content-table-column-user-email" headers="content-table-headers-user-email"><a href="mailto:${fieldValue(bean: userInstance, field: "email")}">${fieldValue(bean: userInstance, field: "email")}</a></td>
          <td class="content-table-buttons" headers="content-table-headers-user-buttons">
            <g:link action="edit" id="${userInstance.id}" class="button small green"><g:message code="default.button.edit.label" /></g:link>
            <g:if test="${session.user != userInstance}">
            <g:link action="delete" id="${userInstance?.id}" class="button small red delete-btn"><g:message code="default.button.delete.label" /></g:link>
            </g:if>
          </td>
        </tr>
      </g:each>
      </tbody>
    </table>
    <div class="paginator">
      <g:paginate total="${userInstanceTotal}" />
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
