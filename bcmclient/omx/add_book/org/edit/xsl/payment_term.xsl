<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:xalan="http://xml.apache.org/xalan"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                exclude-result-prefixes="xalan"
                version="1.0">

  
 <xsl:import href="../../../../../core/xsl/page.xsl"/>
 <xsl:import href="../../../../../core/xsl/container.xsl"/>
 <xsl:import href="../../../../../core/xsl/validation.xsl"/>
 <xsl:import href="../../../../xsl/code_master.xsl"/>

 
  <!-- Entry Point -->
  <!-- ********************************************************************** 
      *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
  
	<xsl:call-template name="include_javascript_payment_term"/>
    
	<xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
	
  </xsl:template>

  <!-- ********************************************************************** 
  *********************************************************************** --> 
  <xsl:template match="RESPONSE" mode="container_content">     

    <table border="0" cellpadding="0" cellspacing="0" width="100%">
	  <tr>
	  <form name="form" method="post" target="appFrame">
	    <input type="hidden" name="PAGE" value="org_payment_term"/>
	    <td>
        <!-- Body -->
      	  <table border="0" cellpadding="0" cellspacing="0" width="100%">
	        <tr>
			  <td  width="100%">
	          <xsl:choose>
  			    <xsl:when test="PAYMENT_TERMS/EDITABLE or PAYMENT_TERMS/IS_NEW">
    			  <xsl:apply-templates mode="edit" select="PAYMENT_TERMS"/>
  			    </xsl:when>
  				<xsl:otherwise>
    			  <xsl:apply-templates mode="view" select="PAYMENT_TERMS"/>
  				</xsl:otherwise>
			  </xsl:choose>
	        </td>
			</tr>
         </table>
		 </td>
	   </form>
      </tr>
    </table>
  </xsl:template>  
 
  <!-- ********************************************************************** 
  *********************************************************************** --> 
  <xsl:template match="PAYMENT_TERMS" mode="edit"> 
    <table border="0" cellpadding="0" cellspacing="1" width="100%" height="100%">
	  <tr>
	    <td width="100%" height="100%">
		  <xsl:variable name="caption_title"><i18n:text>Term Details</i18n:text></xsl:variable>
		    <!--<i2:container title="{$caption_title}" inner="yes" stretch="yes">-->
              <xsl:call-template name="display_instruction_area">
			    <xsl:with-param name="pFormName" select="'form'"/>
			  	<xsl:with-param name="pAnyFieldIsRequired" select="'true'"/>
			  	<xsl:with-param name="pErrorMessage" select="../ERROR_MESSAGE/@Value"/>
			  	<xsl:with-param name="pSuccessMessage" select="../SUCCESS_MESSAGE/@Value"/>
        	  </xsl:call-template>
			  
			  <input type="hidden" name="RE_CIR_ID_NAME" value="ORG_ID"/>
			  <input type="hidden" name="PAGE" value="org_payment_term"/>
			  <input type="hidden" name="IS_NEW" value="{IS_NEW/@Value}"/>
			  <input type="hidden" name="SELLING_ORG_ID" value="{SELLING_ORG_ID/@Value}"/>
			  <input type="hidden" name="ORIGINAL_NAME" value="{RESPONSE/PAYMENT_TERMS/NAME/@Value}"/>
			  
			  <table border="0" cellpadding="0" cellspacing="1" width="100%">
			  <tr><td>
			    <table border="0" cellpadding="0" cellspacing="8" width="100%">
				  <tr class="text">
				    <td nowrap="nowrap" width="10%"><i18n:text>ID</i18n:text><xsl:text>:</xsl:text></td>
					<td nowrap="nowrap">
					  <xsl:choose>
					    <xsl:when test="ID/@Value != ''">
						  <xsl:value-of select="ID/@Value"/>
						  <input type="hidden" name="ID" value="{ID/@Value}" class="inputfieldIE"/>
						</xsl:when>
						<xsl:otherwise>
						  <i18n:text>System Assigned</i18n:text>
						</xsl:otherwise>
					  </xsl:choose>
					</td>
				  </tr>
				  <tr class="text">           
				    <td nowrap="nowrap"><i18n:text>Due Days</i18n:text><xsl:text>:</xsl:text>
					  <xsl:call-template name="display_alert_mark"/>
					</td>
					<td nowrap="nowrap">
					  <input type="field" name="DUE_DAYS" value="{DUE_DAYS/@Value}" class="inputfieldIE" size="17" required="true"/>
					  <xsl:call-template name="display_alert_image">
					    <xsl:with-param name="fieldName" select="'DUE_DAYS'"/>
					  </xsl:call-template>
					</td>           
				  </tr>
				  <tr class="text">           
				    <td nowrap="nowrap"><i18n:text>Name</i18n:text><xsl:text>:</xsl:text>
					  <xsl:call-template name="display_alert_mark"/>
					</td>
					<td nowrap="nowrap">
					  <input type="field" name="NAME" value="{NAME/@Value}" class="inputfieldIE" size="17" required="true"/>
					  <xsl:call-template name="display_alert_image">
					    <xsl:with-param name="fieldName" select="'NAME'"/>
					  </xsl:call-template>
					</td>           
				  </tr>          
				  <tr class="text">           
				    <td nowrap="nowrap"><i18n:text>Discount Percentage</i18n:text><xsl:text>:</xsl:text>
					  <xsl:call-template name="display_alert_mark"/>
					</td>
					<td nowrap="nowrap">
					  <input type="field" name="DISCOUNT_PERCENT" value="{DISCOUNT_PERCENT/@Value}" class="inputfieldIE" size="17" required="true"/>
					  <xsl:call-template name="display_alert_image">
					    <xsl:with-param name="fieldName" select="'DISCOUNT_PERCENT'"/>
					  </xsl:call-template>
					</td>           
				  </tr>
				  <tr class="text">           
				    <td nowrap="nowrap"><i18n:text>Discount Due Days</i18n:text><xsl:text>:</xsl:text>
					  <xsl:call-template name="display_alert_mark"/>
					</td>
					<td nowrap="nowrap">
					  <input type="field" name="DISCOUNT_DAYS" value="{DISCOUNT_DAYS/@Value}" class="inputfieldIE" size="17" required="true"/>
					  <xsl:call-template name="display_alert_image">
					    <xsl:with-param name="fieldName" select="'DISCOUNT_DAYS'"/>
					  </xsl:call-template>
					</td>           
				  </tr>
				  <tr class="text">           
				    <td nowrap="nowrap"><i18n:text>Start Day</i18n:text><xsl:text>:</xsl:text>
					  <xsl:call-template name="display_alert_mark"/>
					</td>
					<td nowrap="nowrap">
					  <input type="field" name="START_DAY" value="{START_DAY/@Value}" class="inputfieldIE" size="17" required="true"/>
					  <xsl:call-template name="display_alert_image">
					    <xsl:with-param name="fieldName" select="'START_DAY'"/>
					  </xsl:call-template>
					</td>           
				  </tr>
				  <tr class="text">           
				    <td nowrap="nowrap"><i18n:text>Details</i18n:text><xsl:text>:</xsl:text>
					  <xsl:call-template name="display_alert_mark"/>
					</td>
					<td nowrap="nowrap">
					  <textarea  name="DESCRIPTION"  class="inputfieldIE" rows="5" cols="40" required="true">
					    <xsl:value-of select="DESCRIPTION/@Value"/>
					  </textarea>
					  <xsl:call-template name="display_alert_image">
					    <xsl:with-param name="fieldName" select="'DESCRIPTION'"/>
					  </xsl:call-template>
					</td>           
				  </tr>
				</table>
			  </td>
			</tr>
		  </table>
		<!--</i2:container>-->
	  </td></tr>
    </table>
  </xsl:template>
  
  <!-- ********************************************************************** 
  *********************************************************************** --> 
  <xsl:template match="PAYMENT_TERMS" mode="view">
    <table border="0" cellpadding="0" cellspacing="1" width="100%" height="100%">
      <tr>
        <td width="100%" height="100%">
          <xsl:variable name="caption_title"><i18n:text>Term Details</i18n:text></xsl:variable>
          <!--<i2:container title="{$caption_title}" inner="yes" stretch="yes">-->
            <table border="0" cellpadding="0" cellspacing="1" width="100%">
              <tr>
                <td>
                  <table border="0" cellpadding="0" cellspacing="8" width="100%">
                    <tr class="text">
                      <td nowrap="nowrap" width="10%"><i18n:text>ID</i18n:text><xsl:text>:</xsl:text></td>
                      <td nowrap="nowrap"><xsl:value-of select="ID/@Value"/></td>
                    </tr>
                    
                    <tr class="text">           
                      <td nowrap="nowrap"><i18n:text>Due Days</i18n:text><xsl:text>:</xsl:text></td>
                      <td nowrap="nowrap">
                        <xsl:value-of select="DUE_DAYS/@Value"/>
                      </td>           
                    </tr>
                    
                    <tr class="text">           
                      <td nowrap="nowrap"><i18n:text>Name</i18n:text><xsl:text>:</xsl:text></td>
                      <td nowrap="nowrap">
                        <xsl:value-of select="NAME/@Value"/>
                      </td>           
                    </tr>
                    
                    <tr class="text">           
                      <td nowrap="nowrap"><i18n:text>Discount Percentage</i18n:text><xsl:text>:</xsl:text></td>
                      <td nowrap="nowrap">
                        <xsl:value-of select="DISCOUNT_PERCENT/@Value"/>
                      </td>           
                    </tr>
                    
                    <tr class="text">           
                      <td nowrap="nowrap"><i18n:text>Discount Due Days</i18n:text><xsl:text>:</xsl:text></td>
                      <td nowrap="nowrap">
                        <xsl:value-of select="DISCOUNT_DAYS/@Value"/>
                      </td>           
                    </tr>
                    
                    <tr class="text">           
                      <td nowrap="nowrap"><i18n:text>Start Day</i18n:text><xsl:text>:</xsl:text></td>
                      <td nowrap="nowrap">
                        <xsl:value-of select="START_DAY/@Value" />
                      </td>           
                    </tr>
                    
                    <tr class="text">           
                      <td nowrap="nowrap"><i18n:text>Details</i18n:text><xsl:text>:</xsl:text></td>
                      <td nowrap="nowrap">
                        <xsl:value-of select="DESCRIPTION/@Value"/>
                      </td>           
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          <!--</i2:container>-->
        </td>
      </tr>
    </table>
  </xsl:template>

  <!-- page.xsl Javascript -->
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

   <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="include_javascript_payment_term">
    <script type="text/javascript">
        function onReset(id, orgid)
		{
		  document.location="payment_term.jsp?ID=" + id + "&amp;SELLING_ORG_ID=" + orgid;
		}   

  		function onSave()
		{
		  var bIsFormValid = isFormValid('form') ;
      	  if ( bIsFormValid == true)
          {
    		document.form.action = "payment_term/controller/addEdit.cmd";
  			document.form.IS_NEW.value = "true";
	  		document.form.submit();
  		  }
  		  return;
		}
		
		function onSaveAsNew()
		{
		  var bIsFormValid = isFormValid('form') ;
      	  if ( bIsFormValid == true)
          {
    		document.form.action = "payment_term/controller/addEdit.cmd";
			document.form.IS_NEW.value = "true";
	  		document.form.submit();
  		  }
  		  return;
		}
		
		function onUpdate()
  		{
		  var bIsFormValid = isFormValid('form') ;
      	  if ( bIsFormValid == true)
          {
  			document.form.action="payment_term/controller/addEdit.cmd";
  			document.form.target="appFrame";
  			document.form.submit();
		  }
  		}

	  </script>
   </xsl:template>

</xsl:stylesheet>

