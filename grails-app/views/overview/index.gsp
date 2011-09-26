<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="main" />
  <title>SpringCRM</title>
</head>

<body>
  <div id="main-container-header">
    <h2><g:message code="overview.title" /></h2>
    <nav id="toolbar-container">
      <ul id="toolbar">
        <li><g:link controller="overview" action="listAvailablePanels" class="white" elementId="add-panel"><g:message code="overview.addPanel.label" /></g:link></li>
      </ul>
    </nav>
  </div>
  <section id="content" style="left: 0; position: relative; top: 0;">
    <div id="panel-list"></div>
    <div class="overview-columns">
    <g:each in="${(0..2)}" var="i">
      <section id="col-${i}" class="overview-column">
      <g:each in="${panels[i]}" var="panel">
        <div id="${panel.panelId}" class="panel" itemscope="itemscope" itemtype="http://www.amc-world.de/data/xml/springcrm/panel-vocabulary">
          <div class="panel-header">
            <h3>${panel.panelDef.title}</h3>
            <g:link controller="overview" action="removePanel" class="panel-close-btn">�</g:link>
          </div>
          <link itemprop="panel-link" href="${createLink(controller:panel.panelDef.controller, action:panel.panelDef.action)}" />
          <div class="panel-content" style="${panel.panelDef.style}"></div>
        </div>
      </g:each>
      </section>
    </g:each>
    </div>
  </section>
  <content tag="additionalJavaScript">
  <script type="text/javascript" src="${resource(dir:'js', file:'overview.js')}"></script>
  <script type="text/javascript">
  (function (SPRINGCRM) {
      new SPRINGCRM.OverviewPanels({
              addPanelUrl: "${createLink(controller:'overview', action:'addPanel')}",
              columnSel: ".overview-column",
              movePanelUrl: "${createLink(controller:'overview', action:'movePanel')}",
              panelSel: ".panel",
              removePanelUrl: "${createLink(controller:'overview', action:'removePanel')}"
          })
          .initialize();
  }(SPRINGCRM));
  </script>
  </content>
</body>
</html>