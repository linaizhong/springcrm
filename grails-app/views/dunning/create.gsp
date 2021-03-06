<html>
  <head>
    <meta name="layout" content="main" />
    <meta name="stylesheet" content="invoicing-transaction" />
  </head>

  <body>
    <g:applyLayout name="create"
      model="[type: 'dunning', instance: dunningInstance]">
      <g:hiddenField name="project" value="${project}" />
      <g:hiddenField name="projectPhase" value="${projectPhase}" />
    </g:applyLayout>

    <content tag="scripts">
      <asset:javascript src="invoicing-transaction-form" />
      <asset:script>//<![CDATA[
        new SPRINGCRM.InvoicingTransaction(
          $("#dunning-form"), {
              checkStageTransition: false,
              stageValues: {
                  payment: 2203,
                  shipping: 2202
              },
              type: "I"
          });
      //]]></asset:script>
    </content>
  </body>
</html>
