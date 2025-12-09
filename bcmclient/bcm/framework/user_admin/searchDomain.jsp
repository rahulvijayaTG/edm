<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
  <head>
    <title>searchDomain.jsp</title>
  </head>
  <frameset rows="30%,*" frameborder="no" border="0" bordercolor="#e6e6e6">
      <frame name="topFrame" src=<%="execDomainSearch.jsp"%> noresize="yes" scrolling="no"/>
      <frame name="bottomFrame" src=<%="searchDomainResult.jsp"%> scrolling="auto"/>
    </frameset>
</html>