<%@ page import="org.amcworld.springcrm.Work" %>

<html>
  <head>
    <meta name="layout" content="main" />
  </head>

  <body>
    <g:applyLayout name="list" model="[list: workInstanceList, type: 'work']">
      <div class="visible-xs">
        <g:letterBar clazz="${Work}" property="name" numLetters="5"
          separator="-" />
      </div>
      <div class="visible-sm">
        <g:letterBar clazz="${Work}" property="name" numLetters="3" />
      </div>
      <div class="hidden-xs hidden-sm">
        <g:letterBar clazz="${Work}" property="name" />
      </div>
      <div class="table-responsive">
        <table class="table data-table">
          <thead>
            <tr>
              <g:sortableColumn property="number" title="${message(code: 'salesItem.number.label')}" />
              <g:sortableColumn property="name" title="${message(code: 'salesItem.name.label')}" />
              <g:sortableColumn property="category.name" title="${message(code: 'salesItem.category.label')}" />
              <g:sortableColumn property="quantity" title="${message(code: 'salesItem.quantity.label')}" />
              <g:sortableColumn property="unit.name" title="${message(code: 'salesItem.unit.label')}" />
              <g:sortableColumn property="unitPrice" title="${message(code: 'salesItem.unitPrice.label')}" />
              <th></th>
            </tr>
          </thead>
          <tbody>
          <g:each in="${workInstanceList}" status="i" var="workInstance">
            <tr>
              <td class="col-type-id work-number"><g:link action="show" id="${workInstance.id}"><g:fieldValue bean="${workInstance}" field="fullNumber" /></g:link></td>
              <td class="col-type-string work-name"><g:link action="show" id="${workInstance.id}"><g:fieldValue bean="${workInstance}" field="name" /></g:link></td>
              <td class="col-type-string work-category"><g:fieldValue bean="${workInstance}" field="category" /></td>
              <td class="col-type-number work-quantity"><g:fieldValue bean="${workInstance}" field="quantity" /></td>
              <td class="col-type-string work-unit"><g:fieldValue bean="${workInstance}" field="unit" /></td>
              <td class="col-type-currency work-unit-price"><g:formatCurrency number="${workInstance.unitPrice}" displayZero="true" /></td>
              <td class="col-actions">
                <g:button action="edit" id="${workInstance.id}"
                  color="success" size="xs" icon="pencil-square-o"
                  message="default.button.edit.label" />
              </td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>
      <nav class="text-center">
        <div class="visible-xs">
          <g:paginate total="${workInstanceTotal}" maxsteps="3"
            class="pagination-sm" />
        </div>
        <div class="hidden-xs">
          <g:paginate total="${workInstanceTotal}" />
        </div>
      </nav>
    </g:applyLayout>
  </body>
</html>
