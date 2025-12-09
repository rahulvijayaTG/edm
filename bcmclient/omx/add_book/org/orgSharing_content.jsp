<%@ include file="../../headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>Address Book</title>
<script type="text/javascript" src="js/org.js"></script>
</head>

<body  class="contentFrameBody" topmargin="0" marginheight="0">

	<i2:xslt xslfile="xsl/orgSharing.xsl">
	  <x2:execute command="omx.add_book.org.orgSharing:getPageData"/>
    </i2:xslt>
	</body>
</html>
