<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:import href="../../xsl/messaging.xsl"/>
  
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="LOCAL_CUSTOMER" mode="edit">
    
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <input type="hidden" name="IS_LOCAL_NEW" value="{IS_LOCAL_NEW/@Value}"/>
        <input type="hidden" name="LOCAL_STATUS" value="{STATUS/@Value}"/>
        <input type="hidden" name="CUSTOMER_ORG_ID" value="{CUSTOMER_ORG_ID/@Value}"/>
        
        <xsl:variable name="caption_title"><i18n:text>Customer Relationship Details</i18n:text></xsl:variable>
        <tr>
          <td height="100%">
            <i2:container title="{$caption_title}" stretch="yes" inner="yes">
              <xsl:call-template name="display_instruction_area">
			    <xsl:with-param name="pFormName" select="'form'"/>
			  	<xsl:with-param name="pAnyFieldIsRequired" select="'true'"/>
			  	<xsl:with-param name="pErrorMessage" select="../ERROR_MESSAGE/@Value"/>
			  	<xsl:with-param name="pSuccessMessage" select="../SUCCESS_MESSAGE/@Value"/>
        	  </xsl:call-template>
              <table border="0" cellpadding="0" cellspacing="5" width="100%">
                <tr>
                  <td nowrap="true" width="10%"><i18n:text>Customer Type</i18n:text><xsl:text>:</xsl:text>
                    <xsl:call-template name="display_alert_mark"/>
                  </td>
                  <td nowrap="true">
                    <select class="inputfieldIE" name="CUSTOMER_TYPE" tabIndex="1">
                      <xsl:apply-templates select="/RESPONSES/RESPONSE/CUSTOMER_TYPES/CODE_MASTER_VALUE" mode="pulldown">
                        <xsl:with-param name="selectedId">
                          <xsl:value-of select="CUSTOMER_TYPE/@Value"/>
                        </xsl:with-param>
                      </xsl:apply-templates>
                    </select>
                  </td>
                  <td nowrap="true" width="25%">&amp;nbsp;</td>
                  <td nowrap="true" width="25%">&amp;nbsp;</td>
                </tr>
                <tr>            
                  <td nowrap="true"><i18n:text>Pricing Template</i18n:text><xsl:text>:</xsl:text>
                    <xsl:call-template name="display_alert_mark"/>
                  </td>
                  <td nowrap="true">
                    <select class="inputfieldIE" name="PRICING_TEMPLATE" tabIndex="3">
                      <xsl:apply-templates select="/RESPONSES/RESPONSE/PRICING_TEMPLATES/CODE_MASTER_VALUE" mode="pulldown">
                        <xsl:with-param name="selectedId">
                          <xsl:value-of select="PRICING_TEMPLATE/@Value"/>
                        </xsl:with-param>
                      </xsl:apply-templates>
                    </select>
                  </td>
                </tr>
                <tr>            
                  <td nowrap="true"><i18n:text>Status</i18n:text><xsl:text>:</xsl:text></td>
                  <td nowrap="true">
                    <xsl:if test="not(STATUS)">
                      <i18n:text>There are no existing relationships.</i18n:text>
                    </xsl:if>
                    <xsl:if test=" (STATUS/@Value = 'ACTIVE') ">
                      <i18n:text>Active</i18n:text>
                    </xsl:if>
					          <xsl:if test=" (STATUS/@Value = 'DORMANT' or STATUS/@Value = 'INACTIVE') ">
                      <i18n:text>Inactive</i18n:text>
                    </xsl:if>
                  </td>
                </tr>
              </table>
			        <i2:footer>
                <i2:buttonbar>
                  <xsl:if test="string-length(CUSTOMER_ORG_ID/@Value) &gt; 0 and STATUS/@Value = 'ACTIVE'">
				            <i2:button onclick="javascript:document.location='Org.jsp?ORG_ID={CUSTOMER_ORG_ID/@Value}'" tabindex="201">&#xA0;<i18n:text>Reset</i18n:text>&#xA0;</i2:button>
				            <i2:buttonbardivider/>
                    <i2:button onclick="javascript:onDeactivateLocal();" tabindex="203">&#xA0;<i18n:text>Deactivate</i18n:text>&#xA0;</i2:button>
                  </xsl:if>
                  <xsl:if test="string-length(CUSTOMER_ORG_ID/@Value) &gt; 0 and STATUS/@Value = 'DORMANT'">
                    <i2:button onclick="javascript:onActivateLocal();" tabindex="203">&#xA0;<i18n:text>Activate</i18n:text>&#xA0;</i2:button>
                  </xsl:if>
                 
                  <xsl:if test=" (string-length(IS_LOCAL_NEW/@Value) &gt; 0) ">
                     <i2:buttonbardivider/>
                    <i2:button emphasized="yes" onclick="javascript:onSaveLocal()" tabindex="204">&#xA0;<i18n:text>Save</i18n:text>&#xA0;</i2:button>
                  </xsl:if>
                 
                  <xsl:if test=" not(IS_LOCAL_NEW) and STATUS/@Value = 'ACTIVE'">
                     <i2:buttonbardivider/>
                    <i2:button emphasized="yes" onclick="javascript:onSaveLocal()" tabindex="204">&#xA0;<i18n:text>Update</i18n:text>&#xA0;</i2:button>
                  </xsl:if>
                 </i2:buttonbar>
              </i2:footer>    
            </i2:container>
          </td>
        </tr>
    </table>
    
  </xsl:template>
  
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="LOCAL_CUSTOMER" mode="view">
  
    <xsl:variable name="caption_title"><i18n:text>Customer Relationship Details</i18n:text></xsl:variable>
	<input type="hidden" name="IS_LOCAL_NEW" value="{IS_LOCAL_NEW/@Value}"/>
    <input type="hidden" name="LOCAL_STATUS" value="{STATUS/@Value}"/>
    <input type="hidden" name="CUSTOMER_ORG_ID" value="{CUSTOMER_ORG_ID/@Value}"/>
    <i2:container title="{$caption_title}">
	  <xsl:call-template name="display_instruction_area">
	    <xsl:with-param name="pFormName" select="'form'"/>
		<xsl:with-param name="pAnyFieldIsRequired" select="'false'"/>
		<xsl:with-param name="pErrorMessage" select="../ERROR_MESSAGE/@Value"/>
		<xsl:with-param name="pSuccessMessage" select="../SUCCESS_MESSAGE/@Value"/>
	  </xsl:call-template>
	  <table width="100%" class="tableRow1">
  		  <tr><td>	
  			<xsl:choose>
    		  <xsl:when test="IS_NEW/@Value = 'true'">
	  		    <br/>
	  			<center><i18n:text>Relationship information has not been entered for this organization.</i18n:text></center>
	  			<br/>
			  </xsl:when>
			  <xsl:otherwise>
  			    <table border="0" cellpadding="0" cellspacing="5" width="100%">
    			  <tr>
					<td nowrap="true" width="5%"><i18n:text>Customer Type</i18n:text>:</td>
					<td nowrap="true" width="45%">
	 				<xsl:variable name="type"><xsl:value-of select="CUSTOMER_TYPE/@Value"/></xsl:variable>
	 				<i18n:text>
	   				  <xsl:value-of select="/RESPONSES/RESPONSE/CUSTOMER_TYPES/CODE_MASTER_VALUE[VALUE_ID/@Value = $type]/DESCRIPTION/@Value"/>
	 				</i18n:text>
	 			  </td>
				  <td nowrap="true" width="5%"><i18n:text>Status</i18n:text>:</td>
				  <td nowrap="true" width="45%">
	  				<xsl:if test="not(STATUS)">
	    			  <i18n:text>There are no existing relationships.</i18n:text>
	  				</xsl:if>
	  			    <xsl:if test=" (STATUS/@Value = 'ACTIVE') ">
	    			  <i18n:text>Active</i18n:text>
	  				</xsl:if>
	  				<xsl:if test=" (STATUS/@Value = 'DORMANT' or STATUS/@Value = 'INACTIVE') ">
	    			  <i18n:text>Inactive</i18n:text>
	  				</xsl:if>
				  </td>
    			</tr>
    			<tr>
				  <td nowrap="true" width="5%"><i18n:text>Pricing Template</i18n:text>:</td>
      				<xsl:variable name="type"><xsl:value-of select="PRICING_TEMPLATE/@Value"/></xsl:variable>
	    			<xsl:choose>
		  			  <xsl:when test="/RESPONSES/RESPONSE/PRICING_TEMPLATES/CODE_MASTER_VALUE[VALUE_ID/@Value = $type]/DESCRIPTION/@Value != ''">
		    			<td nowrap="true">
			  			  <i18n:text>
			    			<xsl:value-of select="/RESPONSES/RESPONSE/PRICING_TEMPLATES/CODE_MASTER_VALUE[VALUE_ID/@Value = $type]/DESCRIPTION/@Value"/>
			  			</i18n:text>
					  </td>
		  			</xsl:when>
		  			<xsl:otherwise>
		    		  <td nowrap="true">N/A</td>
		  		 	</xsl:otherwise>
				  </xsl:choose>			                          
				</tr>
			  </table>	  
			</xsl:otherwise>
       	  </xsl:choose>
        </td></tr>
   	  </table>
	  <xsl:if test="EDITABLE">
	    <i2:footer>
          <i2:buttonbar>
            <xsl:if test="string-length(CUSTOMER_ORG_ID/@Value) &gt; 0 and STATUS/@Value = 'DORMANT'">
              <i2:button onclick="javascript:onActivateLocal();" tabindex="203">&#xA0;<i18n:text>Activate</i18n:text>&#xA0;</i2:button>
            </xsl:if>
          </i2:buttonbar>
        </i2:footer>
	  </xsl:if>
    </i2:container>

  </xsl:template>
  
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="LOCAL_SELLER">
    
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <input type="hidden" name="IS_LOCAL_SELLER_NEW" value="{IS_LOCAL_SELLER_NEW/@Value}"/>
        <input type="hidden" name="SELLER_ORG_ID" value="{SELLING_ORG_ID/@Value}"/>
		<input type="hidden" name="LOCAL_SELLER_STATUS" value="{STATUS/@Value}"/>
        
        <xsl:variable name="caption_title"><i18n:text>Seller Relationship Details</i18n:text></xsl:variable>
        
        <tr>
          <td height="100%">
            <i2:container title="{$caption_title}" stretch="yes" inner="yes">
			  <xsl:if test="EDITABLE/@Value='true' or IS_LOCAL_SELLER_NEW">
                <xsl:call-template name="display_instruction_area">
			      <xsl:with-param name="pFormName" select="'form'"/>
			  	  <xsl:with-param name="pAnyFieldIsRequired" select="'true'"/>
			  	  <xsl:with-param name="pErrorMessage" select="../ERROR_MESSAGE/@Value"/>
			  	  <xsl:with-param name="pSuccessMessage" select="../SUCCESS_MESSAGE/@Value"/>
        	    </xsl:call-template>
			  </xsl:if>
              <table border="0" cellpadding="0" cellspacing="5" width="100%">
                <tr>            
                  <td nowrap="true" width="10%"><i18n:text>Status</i18n:text><xsl:text>:</xsl:text></td>
                  <td nowrap="true">
                    <xsl:if test=" not(STATUS/@Value) ">
                      <i18n:text>There are no existing relationships.</i18n:text>
                    </xsl:if>
					<xsl:if test=" STATUS/@Value = 'DORMANT' or STATUS/@Value = 'INACTIVE' ">
                      <i18n:text>Inactive</i18n:text>
                    </xsl:if>
                    <xsl:if test=" (STATUS/@Value = 'ACTIVE') ">
                      <i18n:text>Active</i18n:text>
                    </xsl:if>
                  </td>
                  <td nowrap="true" width="25%">&amp;nbsp;</td>
                  <td nowrap="true" width="25%">&amp;nbsp;</td>
                </tr>
              </table>    
              
              <i2:footer>
                <i2:buttonbar>
                  <xsl:if test="STATUS/@Value = 'ACTIVE'">
                    <i2:button emphasized="yes" onclick="javascript:onDeactivateLocalSeller();" tabindex="203">&#xA0;<i18n:text>Deactivate</i18n:text>&#xA0;</i2:button>
                  </xsl:if>
                  <xsl:if test="STATUS/@Value = 'DORMANT'">
                    <i2:button emphasized="yes" onclick="javascript:onActivateLocalSeller();" tabindex="203">&#xA0;<i18n:text>Activate</i18n:text>&#xA0;</i2:button>
                  </xsl:if>
				  <xsl:if test="IS_LOCAL_SELLER_NEW or string-length(IS_LOCAL_SELLER_NEW/@Value) &gt; 0">
                    <i2:button emphasized="yes" onclick="javascript:onSaveLocalSeller()" tabindex="204">&#xA0;<i18n:text>Save</i18n:text>&#xA0;</i2:button>
                  </xsl:if>
                 </i2:buttonbar>
              </i2:footer>
            </i2:container>
          </td>
        </tr>
    </table>
    
  </xsl:template>
  
  <!-- **********************************************************************
  *********************************************************************** -->
</xsl:stylesheet>


