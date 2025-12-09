<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<%@ include file="/bcm/framework/headerinclude.jsp" %>

<html>
<head>
<title>Receipt Confirmation</title>
</head>

<%
  String queryStr = request.getQueryString();

  if (queryStr == null)
  {
    queryStr = "";
  }
  else
  {
    queryStr = "?"+queryStr;
  }
%>
	<frameset rows="30,*" frameborder="no"  border="0" bordercolor="#e6e6e6">
  	<frame name="header" src=<%="confirmation_header.jsp"+queryStr%> noresize="yes" scrolling="no"/>
  	<frame name="content" src=<%="confirmation_content.jsp"+queryStr%> scrolling="auto"/>
	</frameset>
</html>
