<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
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
 <frameset rows="35,*" frameborder="no" border="0" bordercolor="#e6e6e6">
     <frame name="header" src=<%="assignDomainHeader.jsp"%> noresize="yes" scrolling="no"/>
     <frame name="content" src=<%="assignDomain.jsp"+queryStr%> scrolling="auto"/>
  </frameset>
</html>