<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>OMS User Admin</title>
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
    <frame name="header" src=<%="user_admin_groups_header_new.jsp"+queryStr%> noresize="yes" scrolling="no"/>
    <frame name="content" src=<%="user_admin_groups_content_role_domain.jsp"+queryStr%> scrolling="auto"/>
  </frameset>
</html>
