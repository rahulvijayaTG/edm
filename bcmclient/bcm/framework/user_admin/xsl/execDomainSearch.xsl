<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:xalan="http://xml.apache.org/xalan" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" exclude-result-prefixes="xalan" version="1.0">
  <!-- Core -->
  <xsl:import href="../../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../../core/xsl/container.xsl"/>
  <xsl:import href="../../../../bcm/framework/xsl/required_field.xsl"/>
  <xsl:import href="../../../../bcm/framework/xsl/code_master.xsl"/>
  <!-- Errors -->
  <xsl:import href="../../../../core/xsl/error.xsl"/>
  <xsl:output method="html"/>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:call-template name="include_javascript_dom_assign"/>
     <xsl:variable name="heading" select="concat('Search Domain:', /RESPONSES/RESPONSE/node[1]/@Value)"/>
    <i2:container id="container" title="{$heading}">
      <form name="result_form" method="POST">
        <input name="domainType" type="hidden" value="{/RESPONSES/RESPONSE/node[1]/@Value}"/>
        <table border="0" cellpadding="0" cellspacing="5" height="100%" width="100%">
          <tr>
            <td nowrap="DomainEntity">
            &#xA0;
            <i18n:text>Domain Entity
            </i18n:text>
              <xsl:text>:</xsl:text>
            </td>
            <td>
              <input type="field" name="searchKey" tabIndex="" class="inputfieldIE" maxlength="32" size="27"/>
            </td>
          </tr>
        </table>
      </form>
      <i2:footer>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
          <tr>
            <td>
              <xsl:apply-templates select="RESPONSE"/>
            </td>
          </tr>
        </table>
      </i2:footer>
    </i2:container>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="content">
    <xsl:apply-templates select="BUTTONS"/>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_dom_assign">
    <script>
    document.onkeypress=IEEnterKey;
    document.onkeydown=IEEnterKey;
    
        function onSearch()
        {
           if ((document.result_form.domainType.value== null)||(document.result_form.domainType.value=="") )
               { 
                   core_alert("Please select the Domain Type from the Domain Tree using a Left Click");
                  }
              else
              {
                document.result_form.target="bottomFrame";
               document.result_form.method="POST";
               document.result_form.action='assignDomainController/search.cmd';
               document.result_form.submit();                
                } 
        }
         function IEEnterKey() 
          {
              if(window.event.keyCode == 13)
                  { 
                       onSearch();
                  }  
          }

	</script>
  </xsl:template>
</xsl:stylesheet>
