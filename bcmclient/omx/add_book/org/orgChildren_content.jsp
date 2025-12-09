<%@ include file="../../headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>Enterprise Address Book</title>
</head>

<body class="contentFrameBody" >

   <i2:xslt xslfile="xsl/pageChildOrgs.xsl">
      <x2:execute command="omx.add_book.org.orgChildren:getPageData" />   
   </i2:xslt>

</body>
</html>
