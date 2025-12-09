<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<HTML>
  <HEAD>
    <i2:stylesheet path="/style_sheet_core.css"></i2:stylesheet>
    <script src="/bcmclient/bcm/scmtop.js" language="JavaScript"></script>
    <script>
    function onScenarioLog()
    {
      logWindow = popUpNewWindow(omxContextPath+"/bcm/scenario/scenarioLog.jsp",'popUp2');
    }

    function popUpNewWindow(url, popUp)
    {
      if ( (window.popUp2 != null) && (!window.popUp2.closed) )
      {
              var windowURL = window.popUp2.location.href.toString();
              if (windowURL.indexOf(url)>0)
              {
                      window.popUp2.focus();
                      return;
              }
              else
              {
                      window.popUp2.close();
              }
      }

      logWindow = window.popUp2 = window.open('',popUp,'height=525, width=820, top=100, left=100');
      logWindow.location.href = url;

      for (var i=0; i <5000; i++)
        {
            if (window.popUp2)
                {
                    window.popUp2.location = url;
                    i = 5000;
                }
        }

      return logWindow;
    }

    function onRefresh()
    {
      scmtop.data_frame.appFrame.history.go(0);
    }

    </script>
  </HEAD>
  <BODY class="bodyBackground" topmargin="0px" bottommargin="0px" leftmargin="0px" rightmargin="0px" >
      <A id="dorefilter"/>
      <A id="dosaveas"/>
      <A id="snapshot"/>
      <A id="addtofav"/>
      <A id="dorefresh"/>
      <A id="docustomize"/>
      <TABLE align="right" border="0" vspace="0" hspace="0" cellspacing="0" cellpadding="0">
        <TR>
      <TD width="18px" leftmargin="1px" rightmargin="1px">
            <i2:img onclick="javascript:onScenarioLog();" src="/list.gif" border="0">
              <i2:attribute name="alt">
                <i18n:text>Scenario Log</i18n:text>
              </i2:attribute>
            </i2:img>
         </TD>
          <TD width="18px" leftmargin="1px" rightmargin="1px">
            <i2:img onclick = "javascript:onRefresh();" src="/rfrsh_actv.gif" border="0" >
              <i2:attribute name="alt"><i18n:text>Refresh</i18n:text></i2:attribute>
            </i2:img>
          </TD>
        </TR>
      </TABLE>
  </BODY>
</HTML>