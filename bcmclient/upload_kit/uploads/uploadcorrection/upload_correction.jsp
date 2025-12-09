<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">
<html>
  <head>
    <title>Data Correction</title>
    <i2:stylesheet path="/style_sheet_core.css"></i2:stylesheet>
    <i2:stylesheet path="/omx_core.css"></i2:stylesheet>
    <i2:stylesheet path="/i2uipad.css"></i2:stylesheet>
    <i2:javascript path="/global_javascript.js"></i2:javascript>
    <i2:javascript path="/date_validation.js"></i2:javascript>
    <i2:javascript path="/calendar.js"></i2:javascript>
    <i2:dhtml padsupport="yes" owcsupport="yes"></i2:dhtml>
  </head>
  <body style="background-color:#E6E6E6; margin:0px; border-right:0px solid #ffffff; border-bottom:0px solid #ffffff; border-top:0px solid #999999; border-left:0px solid #999999;" onLoad="onLoad();" onResize="resize();">
    <script>
    function submit() 
    {
      document.correction.CORRECTED_FORM.value = document.AppApplet.getCorrectedForm();
      document.correction.submit();
      return "success";
    }
    function resize() 
    {
      var w_newWidth,w_newHeight;
      var w_maxWidth=1600, w_maxHeight=1200;

      if (navigator.appName.indexOf("Microsoft") != -1)
      {
         w_newWidth=document.body.offsetWidth;
         w_newHeight=document.body.offsetHeight;
         window.status = "width="+w_newWidth+" height="+ w_newHeight;
      }
      else
      {
         var netscapeScrollWidth=15;
         w_newWidth=window.innerWidth-netscapeScrollWidth;
         w_newHeight=window.innerHeight-netscapeScrollWidth;
      }

       if (w_newWidth>w_maxWidth)
         w_newWidth=w_maxWidth;
       if (w_newHeight>w_maxHeight)
         w_newHeight=w_maxHeight;
         
       w_newHeight = 0.96 * w_newHeight;
       w_newWidth = 0.99 * w_newWidth;
       
       document.AppApplet.resizeApplet(w_newWidth,w_newHeight);

       window.scroll(0,0);
       
       onResizeSuper();
    }
    </script>
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
      <i2:xslt xslfile="applet_header.xsl">
        <x2:execute command="upload_kit.uploads.uploadcorrection.correction:getHeader"/>
      </i2:xslt>
    </table>
    <applet name="AppApplet" code=com.i2.applet.dataupload.DatauploadApplet archive="../../../bpeapplet/bpe-applet.jar,../../../bpeapplet/bpe-applet-helper.jar,./bpe-upload-applet.jar"
        vspace=0 hspace=0 align=left width=99% height=96% MAYSCRIPT>
      <param name=appContextPath value="<%=request.getContextPath()%>" >
      <param name=appServletRef value="xcore" >
      <param name=appLogging value="false" >
      <param name=appService value="DATAUPLOAD">
      <param name=appRootNodeCmd value="com.i2.xservice.dataupload.jc.cmds.AppGetRootNode">
      <param name=appBreadCrumbHeading value="Error Correction">
      <param name=appHideTopPanel value="true">
      <param name=apl.Param1 value="<%=request.getParameter("REPORT_ID")%>"/>
      <param name=apl.Param2 value="<%=request.getParameter("INDEX")%>"/>
    </applet>
    <form name="correction" action="correction/submit.x2c" method="post">
     <INPUT type="hidden" name="CORRECTED_FORM" value=""/>
     <INPUT type="hidden" name="ID" value="<%=request.getParameter("REPORT_ID")%>"/>
     <INPUT type="hidden" name="INDEX" value="<%=request.getParameter("INDEX")%>"/>
    </form>     
  </body>
</html>
