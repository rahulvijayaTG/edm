<%@ include file="/omx/headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>View Organization</title>
</head>
<body class="contentFrameBody" topmargin="0" marginheight="0" 
	  onload="javascript:i2uiManageTreeTable('deployment','deployment_1',0,null,null,null,'i2uiTilePads()')">

<i2:xslt xslfile="$xsl:org_tree_view_xsl"><x2:execute command="omx.add_book.org.orgTreeView:getPageData"/>
</i2:xslt>	
</body>
</html>
