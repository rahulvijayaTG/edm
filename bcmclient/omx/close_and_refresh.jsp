<%@ include file="/bcm/framework/headerinclude.jsp" %>
<script>
<%
if( request.isRequestedSessionIdFromURL() ){
      System.out.println( "SESSION ID FROM URL" );
      Cookie cookie = new Cookie( "JSESSIONID", session.getId() );
      cookie.setPath( "/" );
      cookie.setMaxAge( session.getMaxInactiveInterval() );
      response.addCookie( cookie );
    }
%>


<%
  String location =  request.getParameter("PAGE");
%>

parent.opener.parent.location="<%=location%>";
top.window.close()
</script>