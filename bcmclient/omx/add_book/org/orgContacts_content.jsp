<%@ include file="/omx/headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>View Order Point</title>
<script type="text/javascript" src="addrBookFulfillmentCenter.js"></script>
<script type="text/javascript" src="../addrBookContacts.js"></script>
</head>

<body class="contentFrameBody" topmargin="0" marginheight="0" onresize="onresize()" onLoad="onload()">

<i2:xslt xslfile="$xsl:org_contacts_xsl"><x2:execute command="omx.add_book.org.orgContacts:getPageData"/>
</i2:xslt>	
</body>
</html>
