<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<html>
  <head>
    <title>Childs</title>
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

<frameset cols="55%,*" frameborder="no" border="0" bordercolor="#e6e6e6">
    <frame name="memberHierarchy_child" src=<%="memberHierarchy_child.jsp"+queryStr%> scrolling="auto"/>
    <frame name="memberHierarchy_unassignedChild" src=<%="memberHierarchy_unassignedChild.jsp"+queryStr%> scrolling="auto"/>
</frameset>

</html>