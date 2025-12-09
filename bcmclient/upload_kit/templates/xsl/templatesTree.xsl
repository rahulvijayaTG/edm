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
    <script type="text/javascript" src="../reports.js"></script>

    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE/TEMPLATES"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <!-- ********************************************************************** 
      *********************************************************************** -->
  <xsl:template match="TEMPLATES" mode="container_content">
    <xsl:apply-templates/>
  </xsl:template>
 
  <!-- ********************************************************************** 
      *********************************************************************** -->
  <xsl:template match="STATIC_TEMPLATES|TRANSACTION_TEMPLATES">
    <xsl:variable name="caption_title">
      <i18n:text>Select Template For Upload</i18n:text>
    </xsl:variable>

    <table border="0" cellpadding="0" cellspacing="1" width="100%">
      <tr>
        <td>
          <i2:navarea>
            <i2:pad title="{$caption_title}" name="templates" collapsable="no" width="100%">
      			  <xsl:choose>
      			    <xsl:when test="count(*) > 0">
      			      <xsl:for-each select="TEMPLATE_TYPE">
                    <i2:paditem target="appFrame">
                      <i2:attribute name="text"><i18n:text><xsl:value-of select="substring-after(@Value, '.')"/></i18n:text></i2:attribute>
                      <xsl:for-each select="TEMPLATE">
        				        <xsl:choose>
          					      <xsl:when test="starts-with(../@Value, 'Static')">
                            <i2:paditem target="appFrame" onclick="../uploads/local_upload_details.jsp?TEMPLATE_NAME={@Name}&amp;DISPLAY_NAME={@DisplayName}&amp;DATA_TYPE={@DataType}">
                              <i2:attribute name="text"><i18n:text><xsl:value-of select="@DisplayName"/></i18n:text></i2:attribute>
          					        </i2:paditem>
          					      </xsl:when>
          					      <xsl:otherwise>
          					        <i2:paditem target="appFrame"  onclick="../uploads/local_trans_upload_details.jsp?TEMPLATE_NAME={@Name}&amp;DISPLAY_NAME={@DisplayName}&amp;DATA_TYPE={@DataType}">
                              <i2:attribute name="text"><i18n:text><xsl:value-of select="@DisplayName"/></i18n:text></i2:attribute>
          					        </i2:paditem>
          					      </xsl:otherwise>
          					    </xsl:choose>
                      </xsl:for-each>
                    </i2:paditem>
                  </xsl:for-each>
        				</xsl:when>
        				<xsl:otherwise>
        				  <xsl:variable name="noTemp"><i18n:text>No Templates Available</i18n:text></xsl:variable>
        				  <i2:paditem target="appFrame">
        				    <i2:attribute name="text"><xsl:value-of select="$noTemp"/> </i2:attribute>
        				  </i2:paditem>
        				</xsl:otherwise>
      			  </xsl:choose>
            </i2:pad>
          </i2:navarea>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {
    <xsl:call-template name="javascript_onLoad_tab"/>
    <xsl:call-template name="javascript_onLoad_page"/>
    }
  </xsl:template>

  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="onResize_js">

    function onResize()
    {
    <xsl:call-template name="javascript_onResize_tab"/>
    <xsl:call-template name="javascript_onResize_page"/>
    }
  </xsl:template>


  <!-- Javascript -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="javascript_onLoad_tab">
    <xsl:call-template name="javascript_resizeTabs"/>
  </xsl:template>


  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="javascript_onResize_tab">
    <xsl:call-template name="javascript_resizeTabs"/>
  </xsl:template>

  <xsl:template name="javascript_resizeTabs">
    i2uiTilePads();
  </xsl:template>
</xsl:stylesheet>


