
<%@ page import="org.amcworld.springcrm.SalesOrder" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'salesOrder.label', default: 'SalesOrder')}" />
  <g:set var="entitiesName" value="${message(code: 'salesOrder.plural', default: 'SalesOrders')}" />
  <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>
  <div id="main-container-header">
    <h2><g:message code="${entitiesName}" /></h2>
    <nav id="toolbar-container">
      <ul id="toolbar">
        <li><g:link action="list" class="white"><g:message code="default.button.list.label" /></g:link></li>
        <li><g:link action="edit" id="${salesOrderInstance?.id}" class="green"><g:message code="default.button.edit.label" /></g:link></li>
        <li><g:link action="copy" id="${salesOrderInstance?.id}" class="blue"><g:message code="default.button.copy.label" /></g:link></li>
        <li><g:link action="delete" id="${salesOrderInstance?.id}" class="red" onclick="return confirm(springcrm.messages.deleteConfirmMsg);"><g:message code="default.button.delete.label" /></g:link></li>
      </ul>
    </nav>
  </div>
  <aside id="action-bar">
    <h4><g:message code="default.actions" /></h4>
    <ul>
      <li><g:link action="print" id="${salesOrderInstance?.id}" class="button medium white" target="_blank"><g:message code="default.button.print.label"/></g:link></li>
      <li><g:link controller="invoice" action="create" params="[salesOrder:salesOrderInstance?.id]" class="button medium white"><g:message code="salesOrder.button.createInvoice" /></g:link></li>
    </ul>
  </aside>
  <section id="content" class="with-action-bar">
    <g:if test="${flash.message}">
    <div class="flash-message message">${flash.message}</div>
    </g:if>
    <h3>${salesOrderInstance?.toString()}</h3>
    <div class="data-sheet">
      <div class="fieldset">
        <h4><g:message code="invoicingItem.fieldset.general.label" /></h4>
        <div class="multicol-content">
          <div class="col col-l">
            <div class="row">
              <div class="label"><g:message code="invoicingItem.number.label" default="Number" /></div>
              <div class="field">${salesOrderInstance?.fullNumber}</div>
            </div>
            
            <div class="row">
              <div class="label"><g:message code="invoicingItem.subject.label" default="Subject" /></div>
              <div class="field">${fieldValue(bean: salesOrderInstance, field: "subject")}</div>
            </div>
            
            <div class="row">
              <div class="label"><g:message code="invoicingItem.organization.label" default="Organization" /></div>
              <div class="field">
                <g:link controller="organization" action="show" id="${salesOrderInstance?.organization?.id}">${salesOrderInstance?.organization?.encodeAsHTML()}</g:link>
              </div>
            </div>

            <div class="row">
              <div class="label"><g:message code="invoicingItem.person.label" default="Person" /></div>
              <div class="field">
                <g:link controller="person" action="show" id="${salesOrderInstance?.person?.id}">${salesOrderInstance?.person?.encodeAsHTML()}</g:link>
              </div>
            </div>

            <div class="row">
              <div class="label"><g:message code="salesOrder.quote.label" default="Quote" /></div>
              <div class="field">
                <g:link controller="quote" action="show" id="${salesOrderInstance?.quote?.id}">${salesOrderInstance?.quote?.fullName?.encodeAsHTML()}</g:link>
              </div>
            </div>

            <div class="row">
              <div class="label"><g:message code="invoicingItem.carrier.label" default="Carrier" /></div>
              <div class="field">${salesOrderInstance?.carrier?.encodeAsHTML()}</div>
            </div>
          </div>
          <div class="col col-r">
            <div class="row">
              <div class="label"><g:message code="salesOrder.docDate.label" default="Order date" /></div>
              <div class="field"><g:formatDate date="${salesOrderInstance?.docDate}" type="date" /></div>
            </div>
            
            <div class="row">
              <div class="label"><g:message code="salesOrder.dueDate.label" default="Due date" /></div>
              <div class="field"><g:formatDate date="${salesOrderInstance?.dueDate}" type="date" /></div>
            </div>
            
            <div class="row">
              <div class="label"><g:message code="salesOrder.shippingDate.label" default="Shipping Date" /></div>
              <div class="field"><g:formatDate date="${salesOrderInstance?.shippingDate}" type="date" /></div>
            </div>
            
            <div class="row">
              <div class="label"><g:message code="salesOrder.deliveryDate.label" default="Delivery Date" /></div>
              <div class="field"><g:formatDate date="${salesOrderInstance?.deliveryDate}" type="date" /></div>
            </div>
            
            <div class="row">
              <div class="label"><g:message code="salesOrder.stage.label" default="Stage" /></div>
              <div class="field">${salesOrderInstance?.stage?.encodeAsHTML()}</div>
            </div>
          </div>
        </div>
      </div>
      
      <div class="multicol-content">
        <div class="col col-l">
          <div class="fieldset">
            <h4><g:message code="invoicingItem.fieldset.billingAddr.label" /></h4>
            <div class="fieldset-content form-fragment">
              <div class="row">
                <div class="label"><g:message code="invoicingItem.billingAddrStreet.label" default="Street" /></div>
                <div class="field">${fieldValue(bean: salesOrderInstance, field: "billingAddrStreet")}</div>
              </div>
              
              <div class="row">
                <div class="label"><g:message code="invoicingItem.billingAddrPoBox.label" default="PO Box" /></div>
                <div class="field">${fieldValue(bean: salesOrderInstance, field: "billingAddrPoBox")}</div>
              </div>
              
              <div class="row">
                <div class="label"><g:message code="invoicingItem.billingAddrPostalCode.label" default="Postal Code" /></div>
                <div class="field">${fieldValue(bean: salesOrderInstance, field: "billingAddrPostalCode")}</div>
              </div>
              
              <div class="row">
                <div class="label"><g:message code="invoicingItem.billingAddrLocation.label" default="Location" /></div>
                <div class="field">${fieldValue(bean: salesOrderInstance, field: "billingAddrLocation")}</div>
              </div>
              
              <div class="row">
                <div class="label"><g:message code="invoicingItem.billingAddrState.label" default="State" /></div>
                <div class="field">${fieldValue(bean: salesOrderInstance, field: "billingAddrState")}</div>
              </div>
              
              <div class="row">
                <div class="label"><g:message code="invoicingItem.billingAddrCountry.label" default="Country" /></div>
                <div class="field">${fieldValue(bean: salesOrderInstance, field: "billingAddrCountry")}</div>
              </div>
              
              <g:if test="${fieldValue(bean: salesOrderInstance, field: 'billingAddr')}">
              <div class="row">
                <div class="label empty-label"></div>
                <div class="field"><a href="http://maps.google.de/maps?hl=&amp;q=${salesOrderInstance?.billingAddr?.encodeAsURL()}" target="_blank" class="button small blue"><g:message code="default.link.viewInGoogleMaps" /></a></div>
              </div>
              </g:if>
            </div>
          </div>
        </div>
        <div class="col col-r">
          <div class="fieldset">
            <h4><g:message code="invoicingItem.fieldset.shippingAddr.label" /></h4>
            <div class="fieldset-content form-fragment">
              <div class="row">
                <div class="label"><g:message code="invoicingItem.shippingAddrStreet.label" default="Street" /></div>
                <div class="field">${fieldValue(bean: salesOrderInstance, field: "shippingAddrStreet")}</div>
              </div>
              
              <div class="row">
                <div class="label"><g:message code="invoicingItem.shippingAddrPoBox.label" default="PO Box" /></div>
                <div class="field">${fieldValue(bean: salesOrderInstance, field: "shippingAddrPoBox")}</div>
              </div>
              
              <div class="row">
                <div class="label"><g:message code="invoicingItem.shippingAddrPostalCode.label" default="Postal Code" /></div>
                <div class="field">${fieldValue(bean: salesOrderInstance, field: "shippingAddrPostalCode")}</div>
              </div>
              
              <div class="row">
                <div class="label"><g:message code="invoicingItem.shippingAddrLocation.label" default="Location" /></div>
                <div class="field">${fieldValue(bean: salesOrderInstance, field: "shippingAddrLocation")}</div>
              </div>
              
              <div class="row">
                <div class="label"><g:message code="invoicingItem.shippingAddrState.label" default="State" /></div>
                <div class="field">${fieldValue(bean: salesOrderInstance, field: "shippingAddrState")}</div>
              </div>
              
              <div class="row">
                <div class="label"><g:message code="invoicingItem.shippingAddrCountry.label" default="Country" /></div>
                <div class="field">${fieldValue(bean: salesOrderInstance, field: "shippingAddrCountry")}</div>
              </div>
              
              <g:if test="${fieldValue(bean: salesOrderInstance, field: 'shippingAddr')}">
              <div class="row">
                <div class="label empty-label"></div>
                <div class="field"><a href="http://maps.google.de/maps?hl=&amp;q=${salesOrderInstance?.shippingAddr?.encodeAsURL()}" target="_blank" class="button small blue"><g:message code="default.link.viewInGoogleMaps" /></a></div>
              </div>
              </g:if>
            </div>
          </div>
        </div>
      </div>

      <div class="fieldset">
        <h4><g:message code="invoicingItem.fieldset.header.label" /></h4>
        <div class="fieldset-content">
          <div class="row">
            <div class="label"><g:message code="invoicingItem.headerText.label" default="Header Text" /></div>
            <div class="field">${salesOrderInstance?.headerText}</div>
          </div>
        </div>
      </div>
      
      <div class="fieldset">
        <h4><g:message code="salesOrder.fieldset.items.label" /></h4>
        <div class="fieldset-content">
          <table id="quote-items" class="invoicing-items content-table">
            <thead>
              <tr>
                <th id="quote-items-pos"><g:message code="invoicingItem.pos.label" default="Pos." /></th>
                <th id="quote-items-number"><g:message code="invoicingItem.number.label" default="No." /></th>
                <th id="quote-items-quantity"><g:message code="invoicingItem.quantity.label" default="Qty" /></th>
                <th id="quote-items-unit"><g:message code="invoicingItem.unit.label" default="Unit" /></th>
                <th id="quote-items-name"><g:message code="invoicingItem.name.label" default="Name" /></th>
                <th id="quote-items-unit-price"><g:message code="invoicingItem.unitPrice.label" default="Unit price" /></th>
                <th id="quote-items-total"><g:message code="invoicingItem.total.label" default="Total" /></th>
                <th id="quote-items-tax"><g:message code="invoicingItem.tax.label" default="Tax" /></th>
              </tr>
            </thead>
            <tfoot>
              <tr>
                <td headers="quote-items-name" colspan="5" class="invoicing-items-label"><strong><g:message code="salesOrder.subtotalNet.label" default="Subtotal excl. VAT" /></strong></td>
                <td headers="quote-items-unit-price"></td>
                <td headers="quote-items-total" class="invoicing-items-total"><strong>${formatNumber(number: salesOrderInstance?.subtotalNet, minFractionDigits: 2)}&nbsp;€</strong></td>
                <td headers="quote-items-tax"></td>
              </tr>
              <g:each in="${salesOrderInstance.taxRateSums}" var="item">
              <tr>
                <td headers="quote-items-name" colspan="5" class="invoicing-items-label"><g:message code="invoicingItem.taxRate.label" default="VAT {0} %" args="${[item.key]}" /></td>
                <td headers="quote-items-unit-price"></td>
                <td headers="quote-items-total" class="invoicing-items-total">${formatNumber(number: item.value, minFractionDigits: 2)}&nbsp;€</td>
                <td headers="quote-items-tax"></td>
              </tr>
              </g:each>
              <g:if test="${salesOrderInstance?.discountPercent != 0 || salesOrderInstance?.discountAmount != 0 || salesOrderInstance?.adjustment != 0}">
              <tr>
                <td headers="quote-items-name" colspan="5" class="invoicing-items-label"><strong><g:message code="invoicingItem.subtotalGross.label" default="Subtotal incl. VAT" /></strong></td>
                <td headers="quote-items-unit-price"></td>
                <td headers="quote-items-total" class="invoicing-items-total"><strong>${formatNumber(number: salesOrderInstance?.subtotalGross, minFractionDigits: 2)}&nbsp;€</strong></td>
                <td headers="quote-items-tax"></td>
              </tr>
              </g:if>
              <g:if test="${salesOrderInstance?.discountPercent != 0}">
              <tr>
                <td headers="quote-items-name" colspan="5" class="invoicing-items-label"><g:message code="invoicingItem.discountPercent.label" default="Discount Percent" /></td>
                <td headers="quote-items-unit-price" class="invoicing-items-unit-price">${formatNumber(number: salesOrderInstance?.discountPercent, minFractionDigits: 2)}&nbsp;%</td>
                <td headers="quote-items-total" class="invoicing-items-total">${formatNumber(number: salesOrderInstance?.discountPercentAmount, minFractionDigits: 2)}&nbsp;€</td>
                <td headers="quote-items-tax"></td>
              </tr>
              </g:if>
              <g:if test="${salesOrderInstance?.discountAmount != 0}">
              <tr>
                <td headers="quote-items-name" colspan="5" class="invoicing-items-label"><g:message code="invoicingItem.discountAmount.label" default="Discount Amount" /></td>
                <td headers="quote-items-unit-price"></td>
                <td headers="quote-items-total" class="invoicing-items-total">${formatNumber(number: salesOrderInstance?.discountAmount, minFractionDigits: 2)}&nbsp;€</td>
                <td headers="quote-items-tax"></td>
              </tr>
              </g:if>
              <g:if test="${salesOrderInstance?.adjustment != 0}">
              <tr>
                <td headers="quote-items-name" colspan="5" class="invoicing-items-label"><g:message code="invoicingItem.adjustment.label" default="Adjustment" /></td>
                <td headers="quote-items-unit-price"></td>
                <td headers="quote-items-total" class="invoicing-items-total">${formatNumber(number: salesOrderInstance?.adjustment, minFractionDigits: 2)}&nbsp;€</td>
                <td headers="quote-items-tax"></td>
              </tr>
              </g:if>
              <tr>
                <td headers="quote-items-name" colspan="5" class="invoicing-items-label"><strong><g:message code="salesOrder.total.label" default="Total" /></strong></td>
                <td headers="quote-items-unit-price"></td>
                <td headers="quote-items-total" class="invoicing-items-total total">${formatNumber(number: salesOrderInstance?.total, minFractionDigits: 2)}&nbsp;€</td>
                <td headers="quote-items-tax"></td>
              </tr>
            </tfoot>
            <tbody id="invoicing-items">
              <g:each in="${salesOrderInstance.items}" status="i" var="item">
              <tr>
                <td headers="quote-items-pos" class="invoicing-items-pos">${i + 1}.</td>
                <td headers="quote-items-number" class="invoicing-items-number">${item.number}</td>
                <td headers="quote-items-quantity" class="invoicing-items-quantity">${formatNumber(number: item.quantity, maxFractionDigits: 3)}</td>
                <td headers="quote-items-unit" class="invoicing-items-unit">${item.unit}</td>
                <td headers="quote-items-name" class="invoicing-items-name">${item.name}<br />${item.description}</td>
                <td headers="quote-items-unit-price" class="invoicing-items-unit-price">${formatNumber(number: item.unitPrice, minFractionDigits: 2)}&nbsp;€</td> 
                <td headers="quote-items-total" class="invoicing-items-total">${formatNumber(number: item.total, minFractionDigits: 2)}&nbsp;€</td>
                <td headers="quote-items-tax" class="invoicing-items-tax">${formatNumber(number: item.tax, minFractionDigits: 1)}&nbsp;%</td>
              </tr>
              </g:each>
            </tbody>
            <tbody>
              <tr>
                <td headers="quote-items-pos" class="invoicing-items-pos" colspan="4"></td>
                <td headers="quote-items-name" class="invoicing-items-name"><g:message code="invoicingItem.shippingCosts.label" default="Shipping Costs" /></td>
                <td headers="quote-items-unit-price" class="invoicing-items-unit-price"></td> 
                <td headers="quote-items-total" class="invoicing-items-total">${formatNumber(number: salesOrderInstance?.shippingCosts, minFractionDigits: 2)}&nbsp;€</td>
                <td headers="quote-items-tax" class="invoicing-items-tax">${formatNumber(number: salesOrderInstance?.shippingTax, minFractionDigits: 1)}&nbsp;%</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      
      <div class="fieldset">
        <h4><g:message code="invoicingItem.fieldset.footer.label" /></h4>
        <div class="fieldset-content">
          <div class="row">
            <div class="label"><g:message code="invoicingItem.footerText.label" default="Footer Text" /></div>
            <div class="field">${salesOrderInstance?.footerText}</div>
          </div>
          
          <div class="row">
            <div class="label"><g:message code="invoicingItem.termsAndConditions.label" default="Terms And Conditions" /></div>
            <div class="field">${salesOrderInstance?.termsAndConditions?.name.join(', ')}</div>
          </div>
        </div>
      </div>
    </div>

    <p class="record-timestamps">
      <g:message code="default.recordTimestamps" args="[formatDate(date: salesOrderInstance?.dateCreated, style: 'SHORT'), formatDate(date: salesOrderInstance?.lastUpdated, style: 'SHORT')]" />
    </p>
  </section>
  <content tag="jsTexts">
  deleteConfirmMsg: "${message(code: 'default.button.delete.confirm.message')}"
  </content>
</body>
</html>