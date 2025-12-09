<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

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

<frameset cols="33%,*" frameborder="no" border="0" bordercolor="#e6e6e6">
    <frame name="memberHierarchy_parent" src=<%="memberHierarchy_parent.jsp"+queryStr%> scrolling="auto"/>
    <frame name="memberHierarchy_childs" src=<%="memberHierarchy_childs.jsp"+queryStr%> scrolling="auto"/>    
 </frameset>
