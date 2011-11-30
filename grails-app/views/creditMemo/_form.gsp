<fieldset>
  <h4><g:message code="creditMemo.fieldset.general.label" /></h4>
  <div class="multicol-content">
    <div class="col col-l">
      <div class="row">
        <div class="label">
          <label for="number"><g:message code="invoicingTransaction.number.label" default="Number" /></label>
        </div>
        <div class="field${hasErrors(bean: creditMemoInstance, field: 'number', ' error')}">
          <g:autoNumber prefix="${seqNumberPrefix}" suffix="${seqNumberSuffix}" value="${creditMemoInstance?.number}" /><br />
          <g:hasErrors bean="${creditMemoInstance}" field="number">
            <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="number"><g:message error="${it}" /> </g:eachError></span>
          </g:hasErrors>
        </div>
      </div>

      <div class="row">
        <div class="label">
          <label for="subject"><g:message code="invoicingTransaction.subject.label" default="Subject" /></label>
        </div>
        <div class="field${hasErrors(bean: creditMemoInstance, field: 'subject', ' error')}">
          <g:textField name="subject" value="${creditMemoInstance?.subject}" size="40" /><br /><span class="info-msg"><g:message code="default.required" default="required" /></span>
          <g:hasErrors bean="${creditMemoInstance}" field="subject">
            <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="subject"><g:message error="${it}" /> </g:eachError></span>
          </g:hasErrors>
        </div>
      </div>
      
      <div class="row">
        <div class="label">
          <label for="organization"><g:message code="invoicingTransaction.organization.label" default="Organization" /></label>
        </div>
        <div class="field${hasErrors(bean: creditMemoInstance, field: 'organization', ' error')}">
          <input type="text" id="organization" value="${creditMemoInstance?.organization?.name}" size="35" />
          <input type="hidden" name="organization.id" id="organization-id" value="${creditMemoInstance?.organization?.id}" /><br /><span class="info-msg"><g:message code="default.required" default="required" /></span>
          <g:hasErrors bean="${creditMemoInstance}" field="organization">
            <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="organization"><g:message error="${it}" /> </g:eachError></span>
          </g:hasErrors>
        </div>
      </div>
      
      <div class="row">
        <div class="label">
          <label for="person"><g:message code="invoicingTransaction.person.label" default="Person" /></label>
        </div>
        <div class="field${hasErrors(bean: creditMemoInstance, field: 'person', ' error')}">
          <input type="text" id="person" value="${creditMemoInstance?.person?.fullName}" size="35" />
          <input type="hidden" name="person.id" id="person-id" value="${creditMemoInstance?.person?.id}" /><br />
          <g:hasErrors bean="${creditMemoInstance}" field="person">
            <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="person"><g:message error="${it}" /> </g:eachError></span>
          </g:hasErrors>
        </div>
      </div>

      <div class="row">
        <div class="label">
          <label for="invoice"><g:message code="creditMemo.invoice.label" default="Invoice" /></label>
        </div>
        <div class="field${hasErrors(bean: creditMemoInstance, field: 'invoice', ' error')}">
          <input type="text" id="invoice" value="${creditMemoInstance?.invoice?.fullName}" size="35" />
          <input type="hidden" name="invoice.id" id="invoice-id" value="${creditMemoInstance?.invoice?.id}" /><br />
          <g:hasErrors bean="${creditMemoInstance}" field="invoice">
            <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="invoice"><g:message error="${it}" /> </g:eachError></span>
          </g:hasErrors>
        </div>
      </div>

      <div class="row">
        <div class="label">
          <label for="dunning"><g:message code="creditMemo.dunning.label" default="Dunning" /></label>
        </div>
        <div class="field${hasErrors(bean: creditMemoInstance, field: 'dunning', ' error')}">
          <input type="text" id="dunning" value="${creditMemoInstance?.dunning?.fullName}" size="35" />
          <input type="hidden" name="dunning.id" id="dunning-id" value="${creditMemoInstance?.dunning?.id}" /><br />
          <g:hasErrors bean="${creditMemoInstance}" field="dunning">
            <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="dunning"><g:message error="${it}" /> </g:eachError></span>
          </g:hasErrors>
        </div>
      </div>

      <div class="row">
        <div class="label">
          <label for="stage"><g:message code="creditMemo.stage.label" default="Stage" /></label>
        </div>
        <div class="field${hasErrors(bean: creditMemoInstance, field: 'stage', ' error')}">
          <input type="hidden" id="old-stage" value="${session.user.admin ? 0 : creditMemoInstance?.stage?.id}" />
          <g:select name="stage.id" id="stage" from="${org.amcworld.springcrm.CreditMemoStage.list()}" optionKey="id" value="${creditMemoInstance?.stage?.id}"  /><br />
          <g:hasErrors bean="${creditMemoInstance}" field="stage">
            <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="stage"><g:message error="${it}" /> </g:eachError></span>
          </g:hasErrors>
        </div>
      </div>
    </div>
    <div class="col col-r">
      <div class="row">
        <div class="label">
          <label for="docDate-date"><g:message code="creditMemo.docDate.label" default="Doc Date" /></label>
        </div>
        <div class="field${hasErrors(bean: creditMemoInstance, field: 'docDate', ' error')}">
          <g:dateInput name="docDate" precision="day" value="${creditMemoInstance?.docDate}" /><br />
          <g:hasErrors bean="${creditMemoInstance}" field="docDate">
            <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="docDate"><g:message error="${it}" /> </g:eachError></span>
          </g:hasErrors>
        </div>
      </div>

      <div class="row">
        <div class="label">
          <label for="shippingDate-date"><g:message code="creditMemo.shippingDate.label" default="Shipping Date" /></label>
        </div>
        <div class="field${hasErrors(bean: creditMemoInstance, field: 'shippingDate', ' error')}">
          <g:dateInput name="shippingDate" precision="day" value="${creditMemoInstance?.shippingDate}" /><br />
          <g:hasErrors bean="${creditMemoInstance}" field="shippingDate">
            <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="shippingDate"><g:message error="${it}" /> </g:eachError></span>
          </g:hasErrors>
        </div>
      </div>

      <div class="row">
        <div class="label">
          <label for="carrier.id"><g:message code="invoicingTransaction.carrier.label" default="Carrier" /></label>
        </div>
        <div class="field${hasErrors(bean: creditMemoInstance, field: 'carrier', ' error')}">
          <g:select name="carrier.id" from="${org.amcworld.springcrm.Carrier.list()}" optionKey="id" value="${creditMemoInstance?.carrier?.id}" noSelection="['null': '']" /><br />
          <g:hasErrors bean="${creditMemoInstance}" field="carrier">
            <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="carrier"><g:message error="${it}" /> </g:eachError></span>
          </g:hasErrors>
        </div>
      </div>

      <div class="row">
        <div class="label">
          <label for="paymentDate-date"><g:message code="invoicingTransaction.paymentDate.label" default="Payment Date" /></label>
        </div>
        <div class="field${hasErrors(bean: creditMemoInstance, field: 'paymentDate', ' error')}">
          <g:dateInput name="paymentDate" precision="day" value="${creditMemoInstance?.paymentDate}" /><br />
          <g:hasErrors bean="${creditMemoInstance}" field="paymentDate">
            <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="paymentDate"><g:message error="${it}" /> </g:eachError></span>
          </g:hasErrors>
        </div>
      </div>

      <div class="row">
        <div class="label">
          <label for="paymentAmount"><g:message code="invoicingTransaction.paymentAmount.label" default="Payment Amount" /></label>
        </div>
        <div class="field${hasErrors(bean: creditMemoInstance, field: 'paymentAmount', ' error')}">
          <g:textField name="paymentAmount" value="${formatNumber(number: creditMemoInstance?.paymentAmount, minFractionDigits: 2)}" size="8" />&nbsp;<g:currency /><br />
          <g:hasErrors bean="${creditMemoInstance}" field="paymentAmount">
            <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="paymentAmount"><g:message error="${it}" /> </g:eachError></span>
          </g:hasErrors>
        </div>
      </div>

      <div class="row">
        <div class="label">
          <label for="paymentMethod.id"><g:message code="invoicingTransaction.paymentMethod.label" default="Payment Method" /></label>
        </div>
        <div class="field${hasErrors(bean: creditMemoInstance, field: 'paymentMethod', ' error')}">
          <g:select name="paymentMethod.id" from="${org.amcworld.springcrm.PaymentMethod.list()}" optionKey="id" value="${creditMemoInstance?.paymentMethod?.id}" noSelection="['null': '']" /><br />
          <g:hasErrors bean="${creditMemoInstance}" field="paymentMethod">
            <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="paymentMethod"><g:message error="${it}" /> </g:eachError></span>
          </g:hasErrors>
        </div>
      </div>
    </div>
  </div>
</fieldset>
<div class="multicol-content">
  <div class="col col-l left-address">
    <fieldset>
      <div class="header-with-menu">
        <h4><g:message code="invoicingTransaction.fieldset.billingAddr.label" /></h4>
        <div class="menu">
          <span class="button menu-button small white"><span><g:message code="default.options.label" /></span></span>
        </div>
      </div>
      <div class="fieldset-content form-fragment">
        <div class="row">
          <div class="label">
            <label for="billingAddrStreet"><g:message code="invoicingTransaction.billingAddrStreet.label" default="Street" /></label>
          </div>
          <div class="field${hasErrors(bean: creditMemoInstance, field: 'billingAddrStreet', ' error')}">
            <g:textArea name="billingAddrStreet" cols="35" rows="3" value="${creditMemoInstance?.billingAddrStreet}" /><br />
            <g:hasErrors bean="${creditMemoInstance}" field="billingAddrStreet">
              <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="billingAddrStreet"><g:message error="${it}" /> </g:eachError></span>
            </g:hasErrors>
          </div>
        </div>
        
        <div class="row">
          <div class="label">
            <label for="billingAddrPoBox"><g:message code="invoicingTransaction.billingAddrPoBox.label" default="PO Box" /></label>
          </div>
          <div class="field${hasErrors(bean: creditMemoInstance, field: 'billingAddrPoBox', ' error')}">
            <g:textField name="billingAddrPoBox" value="${creditMemoInstance?.billingAddrPoBox}" size="40" /><br />
            <g:hasErrors bean="${creditMemoInstance}" field="billingAddrPoBox">
              <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="billingAddrPoBox"><g:message error="${it}" /> </g:eachError></span>
            </g:hasErrors>
          </div>
        </div>
        
        <div class="row">
          <div class="label">
            <label for="billingAddrPostalCode"><g:message code="invoicingTransaction.billingAddrPostalCode.label" default="Postal Code" /></label>
          </div>
          <div class="field${hasErrors(bean: creditMemoInstance, field: 'billingAddrPostalCode', ' error')}">
            <g:textField name="billingAddrPostalCode" value="${creditMemoInstance?.billingAddrPostalCode}" size="10" /><br />
            <g:hasErrors bean="${creditMemoInstance}" field="billingAddrPostalCode">
              <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="billingAddrPostalCode"><g:message error="${it}" /> </g:eachError></span>
            </g:hasErrors>
          </div>
        </div>
        
        <div class="row">
          <div class="label">
            <label for="billingAddrLocation"><g:message code="invoicingTransaction.billingAddrLocation.label" default="Location" /></label>
          </div>
          <div class="field${hasErrors(bean: creditMemoInstance, field: 'billingAddrLocation', ' error')}">
            <g:textField name="billingAddrLocation" value="${creditMemoInstance?.billingAddrLocation}" size="40" /><br />
            <g:hasErrors bean="${creditMemoInstance}" field="billingAddrLocation">
              <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="billingAddrLocation"><g:message error="${it}" /> </g:eachError></span>
            </g:hasErrors>
          </div>
        </div>
        
        <div class="row">
          <div class="label">
            <label for="billingAddrState"><g:message code="invoicingTransaction.billingAddrState.label" default="State" /></label>
          </div>
          <div class="field${hasErrors(bean: creditMemoInstance, field: 'billingAddrState', ' error')}">
            <g:textField name="billingAddrState" value="${creditMemoInstance?.billingAddrState}" size="40" /><br />
            <g:hasErrors bean="${creditMemoInstance}" field="billingAddrState">
              <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="billingAddrState"><g:message error="${it}" /> </g:eachError></span>
            </g:hasErrors>
          </div>
        </div>
        
        <div class="row">
          <div class="label">
            <label for="billingAddrCountry"><g:message code="invoicingTransaction.billingAddrCountry.label" default="Country" /></label>
          </div>
          <div class="field${hasErrors(bean: creditMemoInstance, field: 'billingAddrCountry', ' error')}">
            <g:textField name="billingAddrCountry" value="${creditMemoInstance?.billingAddrCountry}" size="40" /><br />
            <g:hasErrors bean="${creditMemoInstance}" field="billingAddrCountry">
              <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="billingAddrCountry"><g:message error="${it}" /> </g:eachError></span>
            </g:hasErrors>
          </div>
        </div>
      </div>
    </fieldset>
  </div>
  <div class="col col-r right-address">
    <fieldset>
      <div class="header-with-menu">
        <h4><g:message code="invoicingTransaction.fieldset.shippingAddr.label" /></h4>
        <div class="menu">
          <span class="button menu-button small white"><span><g:message code="default.options.label" /></span></span>
        </div>
      </div>
      <div class="fieldset-content form-fragment">
        <div class="row">
          <div class="label">
            <label for="shippingAddrStreet"><g:message code="invoicingTransaction.shippingAddrStreet.label" default="Street" /></label>
          </div>
          <div class="field${hasErrors(bean: creditMemoInstance, field: 'shippingAddrStreet', ' error')}">
            <g:textArea name="shippingAddrStreet" cols="35" rows="3" value="${creditMemoInstance?.shippingAddrStreet}" /><br />
            <g:hasErrors bean="${creditMemoInstance}" field="shippingAddrStreet">
              <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="shippingAddrStreet"><g:message error="${it}" /> </g:eachError></span>
            </g:hasErrors>
          </div>
        </div>
        
        <div class="row">
          <div class="label">
            <label for="shippingAddrPoBox"><g:message code="invoicingTransaction.shippingAddrPoBox.label" default="PO Box" /></label>
          </div>
          <div class="field${hasErrors(bean: creditMemoInstance, field: 'shippingAddrPoBox', ' error')}">
            <g:textField name="shippingAddrPoBox" value="${creditMemoInstance?.shippingAddrPoBox}" size="40" /><br />
            <g:hasErrors bean="${creditMemoInstance}" field="shippingAddrPoBox">
              <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="shippingAddrPoBox"><g:message error="${it}" /> </g:eachError></span>
            </g:hasErrors>
          </div>
        </div>
        
        <div class="row">
          <div class="label">
            <label for="shippingAddrPostalCode"><g:message code="invoicingTransaction.shippingAddrPostalCode.label" default="Postal Code" /></label>
          </div>
          <div class="field${hasErrors(bean: creditMemoInstance, field: 'shippingAddrPostalCode', ' error')}">
            <g:textField name="shippingAddrPostalCode" value="${creditMemoInstance?.shippingAddrPostalCode}" size="10" /><br />
            <g:hasErrors bean="${creditMemoInstance}" field="shippingAddrPostalCode">
              <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="shippingAddrPostalCode"><g:message error="${it}" /> </g:eachError></span>
            </g:hasErrors>
          </div>
        </div>
        
        <div class="row">
          <div class="label">
            <label for="shippingAddrLocation"><g:message code="invoicingTransaction.shippingAddrLocation.label" default="Location" /></label>
          </div>
          <div class="field${hasErrors(bean: creditMemoInstance, field: 'shippingAddrLocation', ' error')}">
            <g:textField name="shippingAddrLocation" value="${creditMemoInstance?.shippingAddrLocation}" size="40" /><br />
            <g:hasErrors bean="${creditMemoInstance}" field="shippingAddrLocation">
              <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="shippingAddrLocation"><g:message error="${it}" /> </g:eachError></span>
            </g:hasErrors>
          </div>
        </div>
        
        <div class="row">
          <div class="label">
            <label for="shippingAddrState"><g:message code="invoicingTransaction.shippingAddrState.label" default="State" /></label>
          </div>
          <div class="field${hasErrors(bean: creditMemoInstance, field: 'shippingAddrState', ' error')}">
            <g:textField name="shippingAddrState" value="${creditMemoInstance?.shippingAddrState}" size="40" /><br />
            <g:hasErrors bean="${creditMemoInstance}" field="shippingAddrState">
              <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="shippingAddrState"><g:message error="${it}" /> </g:eachError></span>
            </g:hasErrors>
          </div>
        </div>
        
        <div class="row">
          <div class="label">
            <label for="shippingAddrCountry"><g:message code="invoicingTransaction.shippingAddrCountry.label" default="Country" /></label>
          </div>
          <div class="field${hasErrors(bean: creditMemoInstance, field: 'shippingAddrCountry', ' error')}">
            <g:textField name="shippingAddrCountry" value="${creditMemoInstance?.shippingAddrCountry}" size="40" /><br />
            <g:hasErrors bean="${creditMemoInstance}" field="shippingAddrCountry">
              <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="shippingAddrCountry"><g:message error="${it}" /> </g:eachError></span>
            </g:hasErrors>
          </div>
        </div>
      </div>
    </fieldset>
  </div>
</div>
<fieldset>
  <h4><g:message code="invoicingTransaction.fieldset.header.label" /></h4>
  <div class="fieldset-content">
    <div class="row">
      <div class="label">
        <label for="headerText"><g:message code="invoicingTransaction.headerText.label" default="Header Text" /></label>
      </div>
      <div class="field${hasErrors(bean: creditMemoInstance, field: 'headerText', ' error')}">
        <g:textArea name="headerText" cols="80" rows="3" value="${creditMemoInstance?.headerText}" /><br />
        <g:hasErrors bean="${creditMemoInstance}" field="headerText">
          <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="headerText"><g:message error="${it}" /> </g:eachError></span>
        </g:hasErrors>
      </div>
    </div>
  </div>
</fieldset>
<fieldset>
  <div class="header-with-menu">
    <h4><g:message code="creditMemo.fieldset.items.label" /></h4>
    <div class="menu">
      <a href="javascript:void 0;" class="add-invoicing-item-btn button small green"><g:message code="invoicingTransaction.button.addRow.label" /></a>
    </div>
  </div>
  <div class="fieldset-content">
    <g:each in="${creditMemoInstance.items}" status="i" var="item">
    <g:if test="${item.id}">
    <input type="hidden" name="items[${i}].id" value="${item.id}" />
    </g:if>
    </g:each>
    <table id="creditMemo-items" class="invoicing-items content-table">
      <thead>
        <tr>
          <th id="invoice-items-pos"><g:message code="invoicingTransaction.pos.label" default="Pos." /></th>
          <th id="invoice-items-number"><g:message code="invoicingTransaction.number.label" default="No." /></th>
          <th id="invoice-items-quantity"><g:message code="invoicingTransaction.quantity.label" default="Qty" /></th>
          <th id="invoice-items-unit"><g:message code="invoicingTransaction.unit.label" default="Unit" /></th>
          <th id="invoice-items-name"><g:message code="invoicingTransaction.name.label" default="Name" /></th>
          <th id="invoice-items-unit-price"><g:message code="invoicingTransaction.unitPrice.label" default="Unit price" /></th>
          <th id="invoice-items-total"><g:message code="invoicingTransaction.total.label" default="Total" /></th>
          <th id="invoice-items-tax"><g:message code="invoicingTransaction.tax.label" default="Tax" /></th>
          <th></th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td headers="invoice-items-name" colspan="5" class="invoicing-items-label"><label><g:message code="creditMemo.subtotalNet.label" default="Subtotal excl. VAT" /></label></td>
          <td headers="invoice-items-unitPrice"></td>
          <td headers="invoice-items-total" class="invoicing-items-total"><strong><span id="invoicing-items-subtotal-net" class="value">0,00</span>&nbsp;<g:currency /></strong></td>
          <td headers="invoice-items-tax"></td>
          <td></td>
        </tr>
        <tr>
          <td headers="invoice-items-name" colspan="5" class="invoicing-items-label"><label><g:message code="invoicingTransaction.subtotalGross.label" default="Subtotal incl. VAT" /></label></td>
          <td headers="invoice-items-unitPrice"></td>
          <td headers="invoice-items-total" class="invoicing-items-total"><strong><span id="invoicing-items-subtotal-gross" class="value">0,00</span>&nbsp;<g:currency /></strong></td>
          <td headers="invoice-items-tax"></td>
          <td></td>
        </tr>
        <tr>
          <td headers="invoice-items-name" colspan="5" class="invoicing-items-label"><label for="discountPercent"><g:message code="invoicingTransaction.discountPercent.label" default="Discount Percent" /></label></td>
          <td headers="invoice-items-unitPrice" class="invoicing-items-unit-price${hasErrors(bean: creditMemoInstance, field: 'discountPercent', ' error')}">
            <g:textField name="discountPercent" value="${fieldValue(bean: creditMemoInstance, field: 'discountPercent')}" size="8" />&nbsp;%<br />
            <g:hasErrors bean="${creditMemoInstance}" field="discountPercent">
              <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="discountPercent"><g:message error="${it}" /> </g:eachError></span>
            </g:hasErrors>
          </td>
          <td headers="invoice-items-total" class="invoicing-items-total"><span id="invoicing-items-discount-from-percent" class="value">0,00</span>&nbsp;<g:currency /></td>
          <td headers="invoice-items-tax"></td>
          <td></td>
        </tr>
        <tr>
          <td headers="invoice-items-name" colspan="5" class="invoicing-items-label"><label for="discountAmount"><g:message code="invoicingTransaction.discountAmount.label" default="Discount Amount" /></label></td>
          <td headers="invoice-items-unitPrice"></td>
          <td headers="invoice-items-total" class="invoicing-items-total${hasErrors(bean: creditMemoInstance, field: 'discountAmount', ' error')}">
            <g:textField name="discountAmount" value="${formatNumber(number: creditMemoInstance?.discountAmount, minFractionDigits: 2)}" size="8" class="currency" />&nbsp;<g:currency /><br />
            <g:hasErrors bean="${creditMemoInstance}" field="discountAmount">
              <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="discountAmount"><g:message error="${it}" /> </g:eachError></span>
            </g:hasErrors>
          </td>
          <td headers="invoice-items-tax"></td>
          <td></td>
        </tr>
        <tr>
          <td headers="invoice-items-name" colspan="5" class="invoicing-items-label"><label for="adjustment"><g:message code="invoicingTransaction.adjustment.label" default="Adjustment" /></label></td>
          <td headers="invoice-items-unitPrice"></td>
          <td headers="invoice-items-total" class="invoicing-items-total${hasErrors(bean: creditMemoInstance, field: 'adjustment', ' error')}">
            <g:textField name="adjustment" value="${formatNumber(number: creditMemoInstance?.adjustment, minFractionDigits: 2)}" size="8" class="currency" />&nbsp;<g:currency /><br />
            <g:hasErrors bean="${creditMemoInstance}" field="adjustment">
              <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="adjustment"><g:message error="${it}" /> </g:eachError></span>
            </g:hasErrors>
          </td>
          <td headers="invoice-items-tax"></td>
          <td></td>
        </tr>
        <tr>
          <td headers="invoice-items-name" colspan="5" class="invoicing-items-label"><label><g:message code="creditMemo.total.label" default="Total" /></label></td>
          <td headers="invoice-items-unitPrice"></td>
          <td headers="invoice-items-total" class="invoicing-items-total total"><span id="invoicing-items-total" class="value">0,00</span>&nbsp;<g:currency /></td>
          <td headers="invoice-items-tax"></td>
          <td></td>
        </tr>
      </tfoot>
      <tbody id="invoicing-items">
        <g:each in="${creditMemoInstance.items}" status="i" var="item">
        <tr>
          <td headers="invoice-items-pos" class="invoicing-items-pos">${i + 1}.</td>
          <td headers="invoice-items-number" class="invoicing-items-number">
            <input type="text" name="items[${i}].number" size="10" value="${item.number}" />
          </td>
          <td headers="invoice-items-quantity" class="invoicing-items-quantity">
            <input type="text" name="items[${i}].quantity" size="4" value="${formatNumber(number: item.quantity, maxFractionDigits: 3)}" />
          </td>
          <td headers="invoice-items-unit" class="invoicing-items-unit">
            <input type="text" name="items[${i}].unit" size="5" value="${item.unit}" />
          </td>
          <td headers="invoice-items-name" class="invoicing-items-name">
            <input type="text" name="items[${i}].name" size="28" value="${item.name}" /><g:ifModuleAllowed modules="product">&nbsp;<a href="javascript:void 0;" class="select-btn-products"><img src="${resource(dir: 'img', file: 'products.png')}" alt="${message(code: 'invoicingTransaction.selector.products.title')}" title="${message(code: 'invoicingTransaction.selector.products.title')}" width="16" height="16" style="vertical-align: middle;" /></a></g:ifModuleAllowed><g:ifModuleAllowed modules="service">&nbsp;<a href="javascript:void 0;" class="select-btn-services"><img src="${resource(dir: 'img', file: 'services.png')}" alt="${message(code: 'invoicingTransaction.selector.services.title')}" title="${message(code: 'invoicingTransaction.selector.services.title')}" width="16" height="16" style="vertical-align: middle;" /></a></g:ifModuleAllowed><br /><textarea name="items[${i}].description" cols="30" rows="3">${item.description}</textarea>
          </td>
          <td headers="invoice-items-unit-price" class="invoicing-items-unit-price">
            <input type="text" name="items[${i}].unitPrice" size="8" value="${formatNumber(number: item.unitPrice, minFractionDigits: 2)}" class="currency" />&nbsp;<g:currency />
          </td> 
          <td headers="invoice-items-total" class="invoicing-items-total">
            <span class="value">${formatNumber(number: item.total, minFractionDigits: 2)}</span>&nbsp;<g:currency />
          </td> 
          <td headers="invoice-items-tax" class="invoicing-items-tax">
            <input type="text" name="items[${i}].tax" size="4" value="${formatNumber(number: item.tax, minFractionDigits: 1)}" />&nbsp;%
          </td>
          <td class="invoicing-items-buttons">
            <a href="javascript:void 0;" class="up-btn"><img src="${resource(dir: 'img', file: 'up.png')}" alt="${message(code: 'default.btn.up')}" title="${message(code: 'default.btn.up')}" width="16" height="16" /></a>
            <a href="javascript:void 0;" class="down-btn"><img src="${resource(dir: 'img', file: 'down.png')}" alt="${message(code: 'default.btn.down')}" title="${message(code: 'default.btn.down')}" width="16" height="16" /></a>
            <a href="javascript:void 0;" class="remove-btn"><img src="${resource(dir: 'img', file: 'remove.png')}" alt="${message(code: 'default.btn.remove')}" title="${message(code: 'default.btn.remove')}" width="16" height="16" /></a>
          </td>
        </tr>
        </g:each>
      </tbody>
      <tbody>
        <tr>
          <td headers="invoice-items-name" colspan="5" class="invoicing-items-label"><label for="shippingCosts"><g:message code="invoicingTransaction.shippingCosts.label" default="Shipping Costs" /></label></td>
          <td headers="invoice-items-unitPrice"></td>
          <td headers="invoice-items-total" class="invoicing-items-total${hasErrors(bean: creditMemoInstance, field: 'shippingCosts', ' error')}">
            <g:textField name="shippingCosts" value="${formatNumber(number: creditMemoInstance?.shippingCosts, minFractionDigits: 2)}" size="8" class="currency" />&nbsp;<g:currency /><br />
            <g:hasErrors bean="${creditMemoInstance}" field="shippingCosts">
              <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="shippingCosts"><g:message error="${it}" /> </g:eachError></span>
            </g:hasErrors>
          </td>
          <td headers="invoice-items-tax" class="invoicing-items-tax${hasErrors(bean: creditMemoInstance, field: 'shippingTax', ' error')}">
            <g:textField name="shippingTax" value="${formatNumber(number: creditMemoInstance?.shippingTax, minFractionDigits: 1)}" size="4" />&nbsp;%<br />
            <g:hasErrors bean="${creditMemoInstance}" field="shippingTax">
              <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="shippingTax"><g:message error="${it}" /> </g:eachError></span>
            </g:hasErrors>
          </td>
          <td></td>
        </tr>
      </tbody>
    </table>
    <div class="table-actions">
      <a href="javascript:void 0;" class="add-invoicing-item-btn button medium green"><g:message code="invoicingTransaction.button.addRow.label" /></a>
    </div>
    <g:hasErrors bean="${creditMemoInstance}" field="items.*">
      <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="items.*">${it.arguments[0]}: <g:message error="${it}" /> </g:eachError></span>
    </g:hasErrors>
    <div id="inventory-selector-products" title="${message(code: 'invoicingTransaction.selector.products.title')}"></div>
    <div id="inventory-selector-services" title="${message(code: 'invoicingTransaction.selector.services.title')}"></div>
  </div>
</fieldset>
<fieldset>
  <h4><g:message code="invoicingTransaction.fieldset.footer.label" /></h4>
  <div class="fieldset-content">
    <div class="row">
      <div class="label">
        <label for="footerText"><g:message code="invoicingTransaction.footerText.label" default="Footer Text" /></label>
      </div>
      <div class="field${hasErrors(bean: creditMemoInstance, field: 'footerText', ' error')}">
        <g:textArea name="footerText" cols="80" rows="3" value="${creditMemoInstance?.footerText}" /><br />
        <g:hasErrors bean="${creditMemoInstance}" field="footerText">
          <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="footerText"><g:message error="${it}" /> </g:eachError></span>
        </g:hasErrors>
      </div>
    </div>
    
    <div class="row">
      <div class="label">
        <label for="termsAndConditions"><g:message code="invoicingTransaction.termsAndConditions.label" default="Terms And Conditions" /></label>
      </div>
      <div class="field${hasErrors(bean: creditMemoInstance, field: 'termsAndConditions', ' error')}">
        <g:select name="termsAndConditions" from="${org.amcworld.springcrm.TermsAndConditions.list()}" optionKey="id" value="${creditMemoInstance?.termsAndConditions*.id}" multiple="true" /><br />
        <g:hasErrors bean="${creditMemoInstance}" field="termsAndConditions">
          <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="termsAndConditions"><g:message error="${it}" /> </g:eachError></span>
        </g:hasErrors>
      </div>
    </div>
  </div>
</fieldset>
<fieldset>
  <h4><g:message code="invoicingTransaction.fieldset.notes.label" /></h4>
  <div class="fieldset-content">
    <div class="row">
      <div class="label">
        <label for="notes"><g:message code="invoicingTransaction.notes.label" default="Notes" /></label>
      </div>
      <div class="field${hasErrors(bean: creditMemoInstance, field: 'notes', ' error')}">
        <g:textArea name="notes" cols="80" rows="5" value="${creditMemoInstance?.notes}" /><br />
        <g:hasErrors bean="${creditMemoInstance}" field="notes">
          <span class="error-msg"><g:eachError bean="${creditMemoInstance}" field="notes"><g:message error="${it}" /> </g:eachError></span>
        </g:hasErrors>
      </div>
    </div>
  </div>
</fieldset>
<content tag="additionalJavaScript">
<script type="text/javascript" src="${resource(dir: 'js', file: 'invoicing-items.js')}"></script>
<script type="text/javascript">
//<![CDATA[
(function (window, SPRINGCRM, $) {

    "use strict";

    var $stage,
        addrFields,
        taxes,
        units;
    
    taxes = [ <g:each in="${taxClasses}">${it.taxValue}, </g:each> ];
    units = [ <g:each in="${units}">"${it.name}", </g:each> ];

    new SPRINGCRM.FixedSelAutocomplete({
            baseId: "organization",
            findUrl: "${createLink(controller:'organization', action:'find', params:[type:1])}",
            onSelect: function () {
                addrFields.loadFromOrganizationToLeft("billingAddr");
                addrFields.loadFromOrganizationToRight("shippingAddr");
            }
        })
        .init();
    new SPRINGCRM.FixedSelAutocomplete({
            baseId: "person",
            findUrl: "${createLink(controller:'person', action:'find')}",
            parameters: function () {
                return { organization: $("#organization-id").val() };
            }
        })
        .init();
    new SPRINGCRM.FixedSelAutocomplete({
            baseId: "invoice",
            findUrl: "${createLink(controller:'invoice', action:'find')}",
            parameters: function () {
                return { organization: $("#organization-id").val() };
            }
        })
        .init();
    new SPRINGCRM.FixedSelAutocomplete({
            baseId: "dunning",
            findUrl: "${createLink(controller:'dunning', action:'find')}",
            parameters: function () {
                return { organization: $("#organization-id").val() };
            }
        })
        .init();
    new SPRINGCRM.InvoicingItems({
            baseName: "creditMemo", imgPath: "${resource(dir: 'img')}",
            productListUrl: "${createControllerLink(controller:'product', action:'selectorList')}",
            serviceListUrl: "${createControllerLink(controller:'service', action:'selectorList')}",
            units: units,
            taxes: taxes
        })
        .init();

    addrFields = new SPRINGCRM.AddrFields({
        leftPrefix: "billingAddr", rightPrefix: "shippingAddr",
        retrieveOrgUrl: "${createLink(controller: 'organization', action: 'get')}",
        orgFieldId: "organization-id"
    });
    addrFields.addMenuItemCopy(
        true, '${message(code: "invoicingTransaction.billingAddr.copy")}'
    );
    addrFields.addMenuItemLoadFromOrganization(
        true, '${message(code: "invoicingTransaction.addr.fromOrgBillingAddr")}',
        "billingAddr"
    );
    addrFields.addMenuItemCopy(
        false, '${message(code: "invoicingTransaction.shippingAddr.copy")}'
    );
    addrFields.addMenuItemLoadFromOrganization(
        false, '${message(code: "invoicingTransaction.addr.fromOrgShippingAddr")}',
        "shippingAddr"
    );
    
    $stage = $("#stage");
    $stage.change(function () {
        switch ($(this).val()) {
        case "2502":
            SPRINGCRM.Page.fillInDate($("#shippingDate-date"));
            break;
        case "2503":
            SPRINGCRM.Page.fillInDate($("#paymentDate-date"));
            break;
        }
    });
    $("#shippingDate-date").change(function () {
        if ($(this).val() !== "" && $stage.val() < 2502) {
            $stage.val(2502);
        }
    });
    $("#paymentDate-date").change(function () {
        if ($(this).val() !== "" && $stage.val() < 2503) {
            $stage.val(2503);
        }
    });

    $("#creditMemo-form").submit(function () {
        var newVal,
            oldVal,
            res = true;

        oldVal = $("#old-stage").val();
        if (oldVal > 0) {
            newVal = $("#stage").val();
            if ((oldVal < 2502) && (newVal >= 2502)) {
                res = window.confirm(
                    '${message(code: "invoicingTransaction.changeState.label")}'
                );
            }
        }
        return res;
    });
}(window, SPRINGCRM, jQuery));
//]]></script>
</content>