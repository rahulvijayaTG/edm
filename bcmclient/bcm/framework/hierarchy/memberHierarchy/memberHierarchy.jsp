<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<html>
  <head>
    <title>Member Hierarchy</title>
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
<frameset rows="5%,*" frameborder="no" border="0" bordercolor="#e6e6e6">
    <frame name="header" src=<%="memberHierarchy_header_new.jsp"+queryStr%> noresize="yes" scrolling="no" />
    <frame name="content_new" src=<%="memberHierarchy_content_new.jsp"+queryStr%> />
</frameset>
</html>