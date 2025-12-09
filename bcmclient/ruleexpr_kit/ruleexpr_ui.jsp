<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">
<html>
  <head>
    <title>Data Correction</title>
  </head>
  <body style="background-color:#E6E6E6; margin:0px; border-right:0px solid #ffffff; border-bottom:0px solid #ffffff; border-top:0px solid #999999; border-left:0px solid #999999;">
		<script>
			function togglenav()
			{
				var frameCol = top.i2ui_shell_content.document.body.cols;
				if ( frameCol.charAt(0) == "0") 
				{
							if (document.all) 
							{
									top.i2ui_shell_content.document.body.cols="170,*";
									tabShow = 0;
									return;
							}
					}
					else
					{    
							if (document.all) 
							{
									top.i2ui_shell_content.document.body.cols="0%,100%";
									tabShow = 1;
							}
					}
			}
    	function onRefresh()
    	{
    		javascript:history.go(0);
    	}
    	function onPrint()
			{
			  javascript:window.print();
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
   			
   			document.AppApplet.resizeApplet(w_newWidth,w_newHeight);
				
   			window.scroll(0,0);

       }

   		window.onResize = resize;
    </script>
    <applet name="AppApplet" code="com.i2.applet.ruleexpr.RuleExpressionApplet" archive="../bpeapplet/bpe-applet.jar,../bpeapplet/bpe-applet-helper.jar,bpe-rule-expr-applet.jar"
        vspace="0" hspace="0" align="left" width="100%" height="100%" MAYSCRIPT>
      <param name="appContextPath" value="<%=request.getContextPath()%>" >
      <param name="appServletRef" value="xcore" >
      <param name="appDebug" value="false" >
			<param name="appHideTopPanel" value="true">
      <param name="appService" value="BPE_META">
      <param name="appRootNodeCmd" value="com.i2.xservice.meta.jc.cmds.AppGetRootNode">
      <param name="appBreadCrumbHeading" value="Rule Expression Editor">
      <param name="appMainDividerLocation" value="200" />
    </applet>
  </body>
</html>
