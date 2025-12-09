<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<!--
<i2:xslt xslfile="$xsl:assignDomainHome">
 <x2:execute command="bcm.framework.user_admin.assignDomainView:load"/>
</i2:xslt>
<x2:execute command="bcm.framework.user_admin.assignDomainView:load"/>
-->
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
    
  <frameset cols="50%,*" frameborder="no" border="0" bordercolor="#e6e6e6">
      <frame name="domainFrame" src=<%="domainTree.jsp"+queryStr%> noresize="yes" scrolling="no"/>
      <frame name="rightFrame" src=<%="searchDomain.jsp"%> scrolling="auto"/>
    </frameset>
</html>

