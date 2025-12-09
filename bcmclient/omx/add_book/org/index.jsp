<%@ include file="../../headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>Enterprise Address Book</title>
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

<frameset rows="30,*" frameborder="no" border="0" bordercolor="#e6e6e6">
    <frame name="header" src=<%="header.jsp"+queryStr%> noresize="yes" scrolling="no"/>
    <frame name="content" src=<%="index_content.jsp"+queryStr%> scrolling="auto"/>
  </frameset>
</html>
