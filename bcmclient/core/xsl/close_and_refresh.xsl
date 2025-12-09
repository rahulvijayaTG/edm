<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:import href="page.xsl"/>
  <xsl:output method="html"/>
  
  <!-- Entry point -->  
  <!-- ********************************************************************** 
     *********************************************************************** -->  
  <xsl:template match="RESPONSES" mode="content">

  <![CDATA[
<% 
if( request.isRequestedSessionIdFromURL() ){
      System.out.println( "SESSION ID FROM URL" );
      Cookie cookie = new Cookie( "JSESSIONID", session.getId() );
      cookie.setPath( "/" );
      cookie.setMaxAge( session.getMaxInactiveInterval() );
      response.addCookie( cookie );
    }
%>

 ]]>
 </xsl:template>  

<!-- page.xsl Javascript -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="onLoad_js">  
    function onLoad()
    {
      onCloseAndRefresh('<xsl:value-of select="/RESPONSES/RESPONSE/REQUEST_PARAMETERS/REFRESH_PAGE/@Value"/>');
    }
  </xsl:template>
    
  </xsl:stylesheet>

