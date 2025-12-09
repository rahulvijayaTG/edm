<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  

  <xsl:output method="html"/>
  
  <xsl:template match="CONTACT_MAP" mode="view">
    <xsl:param name="page"/>
    <xsl:param name="searchUrl"/>
    <xsl:param name="orgId"/>
    <xsl:param name="entityType" />
    <xsl:param name="entityId"/>
    
    <xsl:variable name="opType">
      <xsl:value-of select="OP_TYPE/@Value"/>
    </xsl:variable>
	
	<table width="100%" height="100%" cellspacing="0" border="0">
	    <tr>
		<td width="100%"> 
		  <!--<i2:container title="{$caption_title}" inner="yes">-->
		    <table class="tableRow1" width="100%">
			  <form name="addNewContactForm" method="get" target="appFrame">          
			    <input type="hidden" name="ID" value="{ID/@Value}"/>
				<input type="hidden" name="CONTACT_ID" value="{CONTACT_ID/@Value}"/>
			    <input type="hidden" name="PAGE" value="{$page}"/>
				<xsl:choose>
				  <xsl:when test="$entityType = 'Org'">
				    <input type="hidden" name="RE_CIR_ID_NAME" value="ORG_ID"/>
					<input type="hidden" name="ORG_ID" value="{$entityId}"/>
				  </xsl:when>
				  <xsl:when test="$entityType = 'OP'">
				    <input type="hidden" name="RE_CIR_ID_NAME" value="ORDER_POINT_ID"/>
					<input type="hidden" name="ORDER_POINT_ID" value="{$entityId}"/>
				  </xsl:when>
				  <xsl:when test="$entityType = 'BT'">
				    <input type="hidden" name="RE_CIR_ID_NAME" value="BILL_TO_ID"/>
					<input type="hidden" name="BILL_TO_ID" value="{$entityId}"/>
				  </xsl:when>
				  <xsl:when test="$entityType = 'ST'">
				    <input type="hidden" name="RE_CIR_ID_NAME" value="SHIP_TO_ID"/>
					<input type="hidden" name="SHIP_TO_ID" value="{$entityId}"/>
					<input type="hidden" name="OP_TYPE" value="{$opType}"/>
				  </xsl:when>
				  <xsl:when test="$entityType = 'SF'">
				    <input type="hidden" name="RE_CIR_ID_NAME" value="SHIP_FROM_ID"/>
					<input type="hidden" name="SHIP_FROM_ID" value="{$entityId}"/>
					<input type="hidden" name="OP_TYPE" value="{$opType}"/>
				  </xsl:when>
				</xsl:choose>
				
				<input type="hidden" name="ENTITY_ID" value="{$entityId}"/>   
				<input type="hidden" name="ENTITY_TYPE" value="{$entityType}"/>
                
				<tr class="text">
				  <td nowrap="nowrap"><i18n:text>First Name</i18n:text><xsl:text>:</xsl:text></td>
	  			  <td nowrap="nowrap"><xsl:value-of select="FIRST_NAME/@Value"/></td>
				  
				  <td nowrap="nowrap"><i18n:text>Phone</i18n:text><xsl:text>:</xsl:text></td>
				  <td nowrap="nowrap"><xsl:value-of select="PHONE/@Value"/></td>
			  </tr>
			  <tr class="text">
			    <td nowrap="nowrap"><i18n:text>Last Name</i18n:text><xsl:text>:</xsl:text></td>
				<td nowrap="nowrap"><xsl:value-of select="LAST_NAME/@Value"/></td>
				
				<td nowrap="nowrap"><i18n:text>Fax</i18n:text><xsl:text>:</xsl:text></td>
				<td nowrap="nowrap"><xsl:value-of select="FAX/@Value"/></td>
			  </tr>
			  <tr class="text">
			    <td nowrap="nowrap"><i18n:text>Email</i18n:text><xsl:text>:</xsl:text></td>
				<td nowrap="nowrap"><xsl:value-of select="EMAIL_ADDRESS/@Value"/></td>
			  </tr>
			</form>
		  </table>
		<!--</i2:container>-->
	  </td>
	</tr>
   </table>
    
  </xsl:template>
  
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="CONTACT_MAP" mode="edit">
    <xsl:param name="page"/>
    <xsl:param name="orgId"/>
    <xsl:param name="entityType" />
    <xsl:param name="entityId"/>
    
      <xsl:variable name="opType">
        <xsl:value-of select="OP_TYPE/@Value"/>
      </xsl:variable>
	
	  <xsl:variable name="caption_title"><i18n:text>Contact Details</i18n:text></xsl:variable>
    
    <table  width="100%"   cellspacing="0" cellpadding="0" border="0">
    <form name="addNewContactForm" method="get" target="appFrame">          
    <tr><td>

     <xsl:call-template name="display_instruction_area"/>

	  <table width="100%" height="100%" cellspacing="1" border="0">
	    <tr>
		<td> 
		  <!--<i2:container title="{$caption_title}" inner="yes">-->
		   
		    <!-- <table width="100%"> -->
		
			    <input type="hidden" name="ID" value="{ID/@Value}"/>
				<input type="hidden" name="CONTACT_ID" value="{CONTACT_ID/@Value}"/>
			    <input type="hidden" name="PAGE" value="{$page}"/>
				<xsl:choose>
				  <xsl:when test="$entityType = 'Org'">
				    <input type="hidden" name="RE_CIR_ID_NAME" value="ORG_ID"/>
					<input type="hidden" name="ORG_ID" value="{$entityId}"/>
				  </xsl:when>
				  <xsl:when test="$entityType = 'OP'">
				    <input type="hidden" name="RE_CIR_ID_NAME" value="ORDER_POINT_ID"/>
					<input type="hidden" name="ORDER_POINT_ID" value="{$entityId}"/>
				  </xsl:when>
				  <xsl:when test="$entityType = 'BT'">
				    <input type="hidden" name="RE_CIR_ID_NAME" value="BILL_TO_ID"/>
					<input type="hidden" name="BILL_TO_ID" value="{$entityId}"/>
				  </xsl:when>
				  <xsl:when test="$entityType = 'ST'">
				    <input type="hidden" name="RE_CIR_ID_NAME" value="SHIP_TO_ID"/>
					<input type="hidden" name="SHIP_TO_ID" value="{$entityId}"/>
					<input type="hidden" name="OP_TYPE" value="{$opType}"/>
				  </xsl:when>
				  <xsl:when test="$entityType = 'SF'">
				    <input type="hidden" name="RE_CIR_ID_NAME" value="SHIP_FROM_ID"/>
					<input type="hidden" name="SHIP_FROM_ID" value="{$entityId}"/>
					<input type="hidden" name="OP_TYPE" value="{$opType}"/>
				  </xsl:when>
				</xsl:choose>
				
				<input type="hidden" name="ENTITY_ID" value="{$entityId}"/>   
				<input type="hidden" name="ENTITY_TYPE" value="{$entityType}"/>
				
                                <table border="0" cellpadding="0" cellspacing="9" width="50%"> 
				<tr class="text">
				  <td nowrap="nowrap"><i18n:text>First Name</i18n:text><xsl:text>:</xsl:text>
				    <xsl:call-template name="display_alert_mark"/>
				  </td>
				  <td nowrap="nowrap">
				    <input type="field" name="FIRST_NAME" value="{FIRST_NAME/@Value}" required="true" tabIndex="" class="inputfieldIE" maxlength="32" size="15"/>
				  <xsl:call-template name="display_alert_image">
				    <xsl:with-param name="fieldName" select="'FIRST_NAME'"/>
				  </xsl:call-template>
				</td>
				</tr>
				<tr class="text">
				    <td nowrap="nowrap"><i18n:text>Last Name</i18n:text><xsl:text>:</xsl:text>
					  <xsl:call-template name="display_alert_mark"/>
					</td>
					<td nowrap="nowrap">
					  <input type="field" name="LAST_NAME" value="{LAST_NAME/@Value}" required="true" tabIndex="" class="inputfieldIE" maxlength="32" size="15"/>
					  <xsl:call-template name="display_alert_image">
					    <xsl:with-param name="fieldName" select="'LAST_NAME'"/>
					  </xsl:call-template>
					</td>
			  	</tr>
			  	<tr class="text">
				    <td nowrap="nowrap"><i18n:text>Email</i18n:text><xsl:text>:</xsl:text>
					  <xsl:call-template name="display_alert_mark"/>
					</td>
					<td nowrap="nowrap">
					  <input type="field" name="EMAIL_ADDRESS" value="{EMAIL_ADDRESS/@Value}" required="true" tabIndex="" class="inputfieldIE" maxlength="64" size="15"/>
					  <xsl:call-template name="display_alert_image">
					    <xsl:with-param name="fieldName" select="'EMAIL_ADDRESS'"/>
					  </xsl:call-template>
				    </td>
			  	</tr>
			  	</table>
			  	</td>
			  	
			  	<td>
			  	<table border="0" cellpadding="0" cellspacing="9" width="50%"> 
			  	<tr>
				<td nowrap="nowrap"><i18n:text>Phone</i18n:text><xsl:text>:</xsl:text></td>
				<td nowrap="nowrap">
				  <input type="field" name="PHONE" value="{PHONE/@Value}" tabIndex="" class="inputfieldIE" maxlength="32" size="15"/>
			        </td>
			        </tr>
			        <tr>
			        <td nowrap="nowrap"><i18n:text>Fax</i18n:text><xsl:text>:</xsl:text></td>
				<td nowrap="nowrap">
					<input type="field" name="FAX" value="{FAX/@Value}" tabIndex="" class="inputfieldIE" maxlength="32" size="15"/>
				</td>
				</tr>
				</table>
 				</td>
 				
 		
 		<!--
		  </table>
		</i2:container>-->
	
	</tr>
   </table>
    </td></tr></form></table>
  </xsl:template> 
  
    
  <!-- Common Contacts Javascript template -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="include_javascript_contacts_common">
    <script type="text/javascript">
      	
	  function isOnlyOneSelected()
      {
	    if(!document.contactsForm.CONTACT_ID)
		{
	      return false;
		  }
	    else
	    {
		
	      var len = document.contactsForm.CONTACT_ID.length;
	      if(isNaN(len))
	      {
	        if (document.contactsForm.CONTACT_ID.checked)
	          return true;
	      }
		  var j = 0;
	      for (var i=0;i&lt;len;i++)
	      { 
	        if (document.contactsForm.CONTACT_ID[i].checked)
	        {
			  j++;
	        }
	      }	 
		  if (j!=1)
		    return false;
	    }  
	    return true;	 	    
      }
	  
	  function checkExistingList()
      {
	  var length = document.addExistingForm.CONTACT_ID.length;
	  if(isNaN(length))
	  {
	    if (document.addExistingForm.CONTACT_ID.checked)
          {
  	      if (checkExisting(document.addExistingForm.CONTACT_ID.value))
	        return false;
          }
	  }
	  for (var i=0;i&lt;length;i++)
	  {
	    if (document.addExistingForm.CONTACT_ID[i].checked)
          {
  	      if (checkExisting(document.addExistingForm.CONTACT_ID[i].value))
	        return false;
          }
        }	 	    
	  return true;
      }


      function checkExisting( id )
      {
 	  if(!document.contactsForm.CONTACT_ID)
	    return false;
	  else
	  {
	    var length = document.contactsForm.CONTACT_ID.length;
	    if(isNaN(length))
	    {
	      if (document.contactsForm.CONTACT_ID.value == id)
            {
              omx_alert( "Contact is allready in the contacts list" );
		  return true;
            }
	    }
	    for (var i=0;i&lt;length;i++)
	    {
	      if (document.contactsForm.CONTACT_ID[i].value == id)
            {
              omx_alert( "Contact is allready in the contacts list" );
		  return true;
            }
	    }	 	    
	  }  
	  return false;
      }
	  
      function isCheckboxSelected()
      {
	    if(!document.contactsForm.CONTACT_ID)
	      return false;
	    else
	    {
	      var len = document.contactsForm.CONTACT_ID.length;
	      if(isNaN(len))
	      {
	        if (document.contactsForm.CONTACT_ID.checked)
	          return true;
	      }
	      for (var i=0;i&lt;len;i++)
	      {
	        if (document.contactsForm.CONTACT_ID[i].checked)
	        {
		      return true;
	        }
	      }	 	    
	    }  
	    return false;
      }
      
	  function initUsersTable()
	  {
		 
		   if (!document.layers)
  	       {
 
            // scroller + left margin + right margin = 16 + 10 + 10 = 36
			var y = document.body.scrollHeight - 420;
            var x = document.body.scrollWidth - 46;
             i2uiResizeScrollableArea('usersTable',y,x,null,20);
             i2uiResizeColumns('usersTable');
		    }
	  }

	  function initContactTable()
	  {
		   if (!document.layers)
  	       {
 
            // scroller + left margin + right margin = 16 + 10 + 10 = 36
             var x = document.body.scrollWidth - 46;
             i2uiResizeScrollableArea('contactTable',200,x,null,20);
             i2uiResizeColumns('contactTable');
		    }
		}
		function onresize()
		{
			 initUsersTable();
			 initContactTable();   
		}
		
        function onload()
		{
			initUsersTable();
			initContactTable();
		}
	
	</script>
  </xsl:template>
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="include_javascript_contacts">
    <script type="text/javascript">
	  function editContact( con_id )
      {
        document.contactsForm.EDIT_CONTACT_ID.value = con_id;
        document.contactsForm.action="../../contacts/editContact.cmd";
        document.contactsForm.submit();
      }
	
	  function addFromExisting()
      {
        if ( checkExistingList() )
        {
          document.addExistingForm.action="../../contacts/addExistingContact.cmd";
          document.addExistingForm.submit();
        }
      }
          
      function confirmRemoveContact()
      {
	     if (!isCheckboxSelected())
	       omx_alert("PLEASE_SELECT_CONTACT");
	     else
	     {
            document.contactsForm.action="../../contacts/removeContact.cmd";
            document.contactsForm.submit();
	     }
      }
	  
	  function makeDefaultContact()
      {
	     if (!isOnlyOneSelected())
	       omx_alert("select only one contact");
	     else
	     {
            document.contactsForm.action="../../contacts/setDefaultContact.cmd";
            document.contactsForm.submit();
	     }
      }
        
      function addNewContact()
      {
        if( requiredFieldCheck() == 'false' )
        {
         document.addNewContactForm.action="../../contacts/addNewContact.cmd";
         document.addNewContactForm.submit();
        }
      }
        
      function updateContact()
      {
        if( requiredFieldCheck() == 'false' )
        {
         document.addNewContactForm.action="../../contacts/updateContact.cmd";
         document.addNewContactForm.submit();
        }
      }  

 	</script>
  </xsl:template>
  
</xsl:stylesheet>


