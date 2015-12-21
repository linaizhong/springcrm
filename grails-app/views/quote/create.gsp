<html>
  <head>
    <meta name="layout" content="main" />
    <meta name="stylesheet" content="invoicing-transaction" />
  </head>

  <body>
    <g:applyLayout name="create"
      model="[type: 'quote', instance: quoteInstance]">
      <g:hiddenField name="project" value="${project}" />
      <g:hiddenField name="projectPhase" value="${projectPhase}" />
    </g:applyLayout>

    <content tag="scripts">
      <asset:javascript src="invoicing-transaction-form" />
      <asset:script>//<![CDATA[
        new SPRINGCRM.InvoicingTransaction(
          $("#quote-form"), {
              checkStageTransition: false,
              stageValues: {
                  shipping: 602
              },
              type: "Q"
          });
      //]]></asset:script>
    </content>
  </body>
</html>
