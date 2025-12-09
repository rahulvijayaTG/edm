<%@ include file="/omx/headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <title>Reports</title>
  <script>document.domain=document.domain.substring(document.domain.indexOf('.') + 1);</script>
</head>

<body class="contentFrameBody" topmargin="0" marginheight="0" >

<!-- Page Title Area -->
	<i2:xslt xslfile="$xsl:reportlinks_xsl">      
      <x2:execute command="omx.report.view:getReportLinksPageData" />
  </i2:xslt>

	</body>
</html>
