<r:require modules="organizationForm" />
<fieldset>
  <header><h3><g:message code="organization.fieldset.general.label" /></h3></header>
  <div class="multicol-content">
    <div class="col col-l">
      <div class="form">
        <f:field bean="${organizationInstance}" property="number" />
        <f:field bean="${organizationInstance}" property="recType" />
        <f:field bean="${organizationInstance}" property="name" />
        <f:field bean="${organizationInstance}" property="legalForm" />
        <f:field bean="${organizationInstance}" property="type" />
        <f:field bean="${organizationInstance}" property="industry" />
        <f:field bean="${organizationInstance}" property="rating" />
      </div>
    </div>
    <div class="col col-r">
      <div class="form">
        <f:field bean="${organizationInstance}" property="phone" />
        <f:field bean="${organizationInstance}" property="fax" />
        <f:field bean="${organizationInstance}" property="phoneOther" />
        <f:field bean="${organizationInstance}" property="email1" />
        <f:field bean="${organizationInstance}" property="email2" />
        <f:field bean="${organizationInstance}" property="website" />
        <f:field bean="${organizationInstance}" property="owner" />
        <f:field bean="${organizationInstance}" property="numEmployees" size="10" />
      </div>
    </div>
  </div>
</fieldset>
<div class="multicol-content" id="addresses">
  <div class="col col-l left-address">
    <fieldset>
      <header>
        <h3><g:message code="organization.fieldset.billingAddr.label" /></h3>
        <div class="buttons">
          <g:menuButton color="white" size="small" icon="location-arrow"
            message="default.options.label" />
        </div>
      </header>
      <div class="form-fragment">
        <f:field bean="${organizationInstance}" property="billingAddrStreet" cols="35" rows="3" />
        <f:field bean="${organizationInstance}" property="billingAddrPoBox" />
        <f:field bean="${organizationInstance}" property="billingAddrPostalCode" size="10" />
        <f:field bean="${organizationInstance}" property="billingAddrLocation" />
        <f:field bean="${organizationInstance}" property="billingAddrState" />
        <f:field bean="${organizationInstance}" property="billingAddrCountry" />
      </div>
    </fieldset>
  </div>
  <div class="col col-r right-address">
    <fieldset>
      <header>
        <h3><g:message code="organization.fieldset.shippingAddr.label" /></h3>
        <div class="buttons">
          <g:menuButton color="white" size="small" icon="location-arrow"
            message="default.options.label" />
        </div>
      </header>
      <div class="form-fragment">
        <f:field bean="${organizationInstance}" property="shippingAddrStreet" cols="35" rows="3" />
        <f:field bean="${organizationInstance}" property="shippingAddrPoBox" />
        <f:field bean="${organizationInstance}" property="shippingAddrPostalCode" size="10" />
        <f:field bean="${organizationInstance}" property="shippingAddrLocation" />
        <f:field bean="${organizationInstance}" property="shippingAddrState" />
        <f:field bean="${organizationInstance}" property="shippingAddrCountry" />
      </div>
    </fieldset>
  </div>
</div>
<fieldset>
  <header><h3><g:message code="organization.fieldset.notes.label" /></h3></header>
  <div class="form-fragment">
    <f:field bean="${organizationInstance}" property="notes" cols="80" rows="5" />
  </div>
</fieldset>
<fieldset>
  <header><h3><g:message code="organization.fieldset.misc.label" /></h3></header>
  <div class="form-fragment">
    <f:field bean="${organizationInstance}" property="docPlaceholderValue"
      size="50"/>
  </div>
</fieldset>
