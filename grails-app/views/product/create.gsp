<html>
  <head>
    <meta name="layout" content="main" />
    <meta name="stylesheet" content="sales-item-pricing" />
  </head>

  <body>
    <g:applyLayout name="create" model="[
        type: 'product', instance: productInstance
      ]" />

    <content tag="scripts">
      <asset:javascript src="sales-item-pricing" />
    </content>
  </body>
</html>
