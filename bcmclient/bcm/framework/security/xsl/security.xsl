<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../../core/xsl/container.xsl"/>

  <xsl:output method="html"/>
  <!-- Page.xsl -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
  <form name="security_form" method="POST">           
  	<input type="hidden" name="selectedID" value=""/>
	<input type="hidden" name="selectedDoc" value=""/>
	
	<xsl:apply-templates select="RESPONSE/CONTAINER">
		<xsl:with-param name="content" select="RESPONSE"/>
	</xsl:apply-templates>
	<xsl:call-template name="include_javascript_table"/>
     </form>              
      	
  
  </xsl:template>
         
  <xsl:template match="RESPONSE" mode="container_content">       
	<xsl:variable name="selAuthDoc">
		
	     	<xsl:choose>
	     		<xsl:when test= "string-length(selectedDoc/@Value) &gt; 0">
	     			<xsl:value-of select="selectedDoc/@Value"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test= "string-length(AUTHDOC/@Value) &gt; 0" >
						<xsl:value-of select="AUTHDOC/@Value"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="FIRST_AUTHDOC/@Value"/>
					</xsl:otherwise>
				</xsl:choose>										
			</xsl:otherwise>
		</xsl:choose>			
	</xsl:variable>
	
	<xsl:variable name="selAuthID">
		<xsl:choose>
			<xsl:when test= "string-length(AUTHORIZATION/*[@Name=$selAuthDoc]/AuthID/@Value) &gt; 0" >
		      		<xsl:value-of select="AUTHORIZATION/*[@Name=$selAuthDoc]/AuthID/@Value"/>
		      	</xsl:when>
		</xsl:choose>			
	</xsl:variable>
	
	
	<xsl:variable name="idValue"/>
	  
          	<i2:table id="security_form_table" scrollablerows="yes" scrollablecolumns="yes">
		      <i2:tr nowrap="yes" header="yes">
		        <th width="10" nowrap="yes" align="center"  class="checkboxColumn"/>
			<td nowrap="yes" align="left"><i18n:text>ID</i18n:text></td>
			<td nowrap="yes" align="left"><i18n:text>Name</i18n:text></td>
		      </i2:tr>    		
		      <xsl:for-each select= "RESPONSE/*[@Name= $selAuthDoc]/AUTH_ID">
			<i2:tr>
			  <xsl:variable name="idValue">
			  	<xsl:value-of select="./*/@Value"/> 
			  </xsl:variable>	
			  <xsl:choose>
				<xsl:when test= "$selAuthID = $idValue" >
					<td align="center" class="checkboxColumn"><input type="radio" name="{$selAuthDoc}" value="{$idValue}" onclick="onChange(this)" checked="true"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td align="center" class="checkboxColumn"><input type="radio" name="{$selAuthDoc}" value="{$idValue}" onclick="onChange(this)"/></td>
				</xsl:otherwise>
			  </xsl:choose>							  			  
			  <td><xsl:value-of select="./*/@Value"/></td>
			  <td><xsl:value-of select="./name/@Value"/></td>
			</i2:tr> 
		      </xsl:for-each>			      		      
                </i2:table>
		<i2:footer>
		        <xsl:apply-templates select="CONTAINER/BUTTONS"/>
		</i2:footer>
            
  </xsl:template>

 <!-- **********************************************************************
      *********************************************************************** -->
      

 <!-- **********************************************************************
      *********************************************************************** -->
<xsl:template name="include_javascript_table">
    <script>
    
    function onLoad()
   {
            
          resize_Containers();
    }

    

    function onChange(radiobutton){		
	document.security_form.selectedDoc.value=radiobutton.name;
	document.security_form.selectedID.value=radiobutton.value;                       
	
	document.security_form.action= "controller/setSelectedID.cmd";
	document.security_form.submit();
	
	return;            
    }

    <![CDATA[

    function resize_Containers()
   {
      var table_id = 'security_form_table';
      var width = document.body.offsetWidth;
      var height = document.body.scrollHeight;
      // resize table   approx
      i2uiResizeColumns(table_id);
      i2uiResizeScrollableArea(table_id, height-400, width-35, null, null, null,null, null);
      i2uiResizeScrollableContainer('security_form_container',document.body.offsetHeight-400, null, document.body.offsetWidth - 35, true, 'yes');
      
      //i2uiResizeScrollableArea(table_id, 700, width-35, null, null, null,null, null);
      //i2uiResizeScrollableContainer('security_form_container',document.body.offsetHeight-400, null, document.body.offsetWidth - 35, true, 'yes');
   }

      function dispatchSave()
      {
	document.security_form.target="_top";
	document.security_form.action= "controller/onSaveSecurityContext.cmd";
	document.security_form.submit();
	return;
      }
      
      function dispatchCancel()
      {
	document.security_form.target="_top";
	document.security_form.action= "controller/onSecurityCancel.cmd";
	document.security_form.submit();
	return;            
      }
    ]]></script>
  </xsl:template> 
</xsl:stylesheet>