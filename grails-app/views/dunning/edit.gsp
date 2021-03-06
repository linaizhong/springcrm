<html>
  <head>
    <meta name="layout" content="main" />
    <title>
      <g:message code="invoicingTransaction.edit.label"
        args="[message(code: 'dunning.label'), dunningInstance.fullNumber]" />
      - <g:message code="dunning.plural" />
    </title>
    <meta name="stylesheet" content="invoicing-transaction" />
  </head>

  <body>
    <g:applyLayout name="edit"
      model="[type: 'dunning', instance: dunningInstance]" />

    <content tag="scripts">
      <asset:javascript src="invoicing-transaction-form" />
      <asset:script>//<![CDATA[
        new SPRINGCRM.InvoicingTransaction(
          $("#dunning-form"), {
              stageValues: {
                  payment: 2203,
                  shipping: 2202
              },
              type: "D"
          });
      //]]></asset:script>
    </content>
  </body>
</html>
