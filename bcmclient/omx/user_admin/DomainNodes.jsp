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

<frameset rows="30%,*" frameborder="no" border="0" bordercolor="#e6e6e6">
    <frame name="searchFrame" src='<%="DomainNodesSearch.jsp"+queryStr%>' noresize="yes" scrolling="no" />
    <frame name="resultFrame" src='<%="DomainNodesResult.jsp"+queryStr%>' />
</frameset>