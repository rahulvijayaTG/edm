<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

  <xsl:import href="../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../core/xsl/container.xsl"/>

  <xsl:output method="html"/>

  <!-- ********************************************************************** 
      *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <script type="text/javascript">
    function uploadNewData()
    {
      document.errorDetail.target="appFrame";
      document.errorDetail.action="correction/uploadCorrectedData.x2c";
          document.errorDetail.submit();
    }
    </script>
    
    <form name="errorDetail" action="" method="post">
      <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
        <xsl:with-param name="content" select="RESPONSE"/>
      </xsl:apply-templates>
    </form>
  </xsl:template>

  <!-- ********************************************************************** 
      *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="container_content">

    <input type="hidden" name="REPORT_ID" value="{REPORT_DETAILS/REPORT_ID/@Value}"/>
    <input type="hidden" name="INDEX" value="{REPORT_DETAILS/INDEX/@Value}"/>
    <input type="hidden" name="TEMPLATE_NAME" value="{REPORT_DETAILS/TEMPLATE_NAME/@Value}"/>
    <i2:table>      
      <i2:tr header="yes">
      <td align="center"> <i18n:text>Field Name</i18n:text></td>
      <td align="center"> <i18n:text>Field Value</i18n:text></td>
      <td align="center"> <i18n:text>New Value</i18n:text></td>
      </i2:tr>
      <xsl:for-each select="REPORTS/ERROR_REPORT/ERROR_REQUEST/REQUESTS/REQUEST/*">
        <i2:tr>
          <td><input type="hidden" name="FIELD_NAME" value="name()"/><xsl:value-of select="name()"/></td>
          <td><xsl:value-of select="./@Value"/></td>
          <td><input class="inputFieldIE" name="NEW_VALUE" value="{./@Value}"/></td>
        </i2:tr>
      </xsl:for-each>
    </i2:table>
  </xsl:template>

</xsl:stylesheet>
