<?xml version="1.0" standalone="no"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="pad.xsl"/>
  <xsl:output method="html"/>
  <xsl:template match="/RESPONSES/RESPONSE">
    <xsl:call-template name="include_javascript"/>
    <table width="100%" height="100%">
      <form action="POST" id="instance_form" name="instance_form">
        <tr>
          <td width="100%" valign="top" align="left">
            <xsl:value-of select="ACTIVITY/@Value"/>
            <xsl:apply-templates select="PAD"/>
            <!--xsl:apply-templates select="TASKS/PAD"/>
             <xsl:apply-templates select="TOOLS/PAD"/> 
             <xsl:apply-templates select="FAVORITES/PAD"/-->
          </td>
        </tr>
      </form>  
    </table>   
  </xsl:template> 
  <!-- *********************************************************************
        ********************************************************************* -->
  <xsl:template name="include_javascript">
    <script>
      function solutionLink(solution) 
      {
        top.location.href="/i2/login.jsp?solution="+ solution;
      }
      function onSelectInstance()
      {
        document.instance_form.target="_top";
        document.instance_form.action="instance/controller/onSelectInstance.cmd";
        document.instance_form.submit();
      }
      function onManageFavorites()
        {
            document.instance_form.target="appFrame";
            document.instance_form.action=omxContextPath+ "/bcm/framework/favorites/manageFavorites.jsp";
            document.instance_form.submit();
        }
      
    </script>
  </xsl:template>
  <!-- *********************************************************************
        ********************************************************************* -->
</xsl:stylesheet>
