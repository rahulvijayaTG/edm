<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  
  <xsl:import href="../../xsl/required_field.xsl"/>

  <xsl:output method="html"/>
  
  <xsl:template match="RESPONSE">
    <xsl:param name="page"  select="''"/>
    <xsl:param name="searchUrl"  select="''"/>
    <xsl:param name="orgId"   select="''"/>
    <xsl:param name="entityType"  select="''"/>
    <xsl:param name="entityId" select="''"/>
    
      <xsl:variable name="opType">
        <xsl:value-of select="OP_TYPE/@Value"/>
      </xsl:variable>
    
      <xsl:variable name="edit_contact_id">
        <xsl:value-of select="EDIT_CONTACT_ID/@Value"/>
      </xsl:variable>

      <xsl:variable name="caption_title"><i18n:text>Contacts</i18n:text></xsl:variable>
      <table width="100%" height="100%" cellspacing="1" border="0">
        <tr>  
          <td width="100%"> 
            <i2:container title="{$caption_title}" inner="yes">
              <table width="100%" height="100%" cellspacing="0" border="0">
                <form name="contactsForm" action="" method="post" target="appFrame">
                  <input type="hidden" name="PAGE" value="{$page}"/>   
                  <input type="hidden" name="ENTITY_ID" value="{$entityId}"/>   
                  <input type="hidden" name="ENTITY_TYPE" value="{$entityType}"/>  
                  <input type="hidden" name="EDIT_CONTACT_ID" value="{$edit_contact_id}"/>   
                  <tr>
                    <td>
                      <xsl:choose>
                        <xsl:when test="count( /RESPONSES/RESPONSE/CONTACTS/CONTACT ) > 0">    
                          <i2:table id="contactTable" width="100%" height="100%" scrollablerows="yes" scrollablecolumns="auto">    
                          <i2:tr header="yes">
                            <xsl:if test="/RESPONSES/RESPONSE/CONTACTS/EDITABLE">
                              <td nowrap="yes" width="4%">
                                <input type="checkbox" name="SELECT_ALL" value="true" onclick="javascript:toggleCheckboxes(document.forms.contactsForm, document.forms.contactsForm.CONTACT_ID, document.forms.contactsForm.SELECT_ALL);"/>
                              </td>
                            </xsl:if>
                              <td nowrap="yes"><i18n:text>Name</i18n:text></td>
                              <td nowrap="yes"><i18n:text>Email</i18n:text></td>
                              <td nowrap="yes"><i18n:text>Phone</i18n:text></td>
                              <td nowrap="yes"><i18n:text>Fax</i18n:text></td>
                            </i2:tr>
                            <xsl:apply-templates select="/RESPONSES/RESPONSE/CONTACTS/CONTACT"/>
                          </i2:table>
                        </xsl:when>
                        <xsl:otherwise>
                          <table width="100%" height="100%" class="tableRow1">
                            <tr>  
                              <td width="100%"> 
                                <i18n:text>No contacts have been specified</i18n:text>.
                              </td>
                            </tr>
                          </table>
                        </xsl:otherwise>
                      </xsl:choose>
                      
                      
                      <xsl:if test="/RESPONSES/RESPONSE/CONTACTS/EDITABLE">
                        <i2:footer header="true">
                          <i2:buttonbar>
						    <xsl:if test="$opType='LOCATIONS_SHIPTO' or $opType='LOCATIONS_SHIPFROM'">
							  <i2:button onclick="javascript:makeDefaultContact()">&#xA0;<i18n:text>Set Default</i18n:text>&#xA0;</i2:button>
							</xsl:if>
                            <i2:button onclick="javascript:confirmRemoveContact()">&#xA0;<i18n:text>Delete</i18n:text>&#xA0;</i2:button>
                          </i2:buttonbar>
                        </i2:footer>
                      </xsl:if>
                    </td>
                  </tr>
                </form>
              </table>
            </i2:container>
          </td>
        </tr>
          
        <xsl:if test="/RESPONSES/RESPONSE/CONTACTS/EDITABLE">
          <xsl:variable name="caption_title"><i18n:text>Add Contact</i18n:text></xsl:variable>
          
          <tr>
            <td width="100%"> 
              <i2:container title="{$caption_title}" inner="yes">
                <table width="100%">
                  <tr>  
                    <td>  
                      
                      <xsl:choose>
                        <xsl:when test="/RESPONSES/RESPONSE/CONTACTS/SEARCH_RESULTS">
                          <i18n:text>Search for an existing contact.</i18n:text><br/>
                        </xsl:when>
                        <xsl:otherwise>
                          <i18n:text>Search for an existing contact or fill out the information below to add a new contact.</i18n:text><br/>
                        </xsl:otherwise>
                      </xsl:choose>
                      
                      <table>
                        <form name="contactSearchForm" action="{$searchUrl}" method="get" target="appFrame">
                          
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
                            <xsl:when test="$entityType = 'FC'">
                              <input type="hidden" name="RE_CIR_ID_NAME" value="FULFILLMENT_CENTER_ID"/>
                              <input type="hidden" name="FULFILLMENT_CENTER_ID" value="{$entityId}"/>
                            </xsl:when>
							<xsl:when test="$entityType = 'SF'">
                              <input type="hidden" name="RE_CIR_ID_NAME" value="SHIP_FROM_ID"/>
                              <input type="hidden" name="SHIP_FROM_ID" value="{$entityId}"/>
							  <input type="hidden" name="OP_TYPE" value="{$opType}"/>
                            </xsl:when>
                          </xsl:choose>
                          <tr>
                            <td><i18n:text>Last Name</i18n:text><xsl:text>:</xsl:text></td>
                            <td><input type="field" class="inputfieldIE" name="SEARCH_LAST_NAME" size="15"/></td>
                          </tr>
                        </form>
                      </table>
                    </td>
                  </tr>
                </table>
                
                <i2:footer header="true">
                  <i2:buttonbar>
                    <i2:button onclick="javascript:contactSearchForm.submit()"><i18n:text>Search</i18n:text></i2:button>
                  </i2:buttonbar>
                </i2:footer>
              </i2:container>
            </td>
          </tr>
          
          
          <xsl:choose>
            <xsl:when test="count(/RESPONSES/RESPONSE/CONTACTS/SEARCH_RESULTS/CONTACT) > 0">
              <tr>
                <td width="100%"> 
                <xsl:apply-templates select="/RESPONSES/RESPONSE/CONTACTS/SEARCH_RESULTS">
                    <xsl:with-param name="page" select="$page"/>
                    <xsl:with-param name="orgId" select="$orgId"/>
                    <xsl:with-param name="entityType" select="$entityType"/>
                    <xsl:with-param name="entityId" select="$entityId"/>
                  </xsl:apply-templates>
                </td>
              </tr>
            </xsl:when>
            <xsl:otherwise>

              <xsl:variable name="caption_title"><i18n:text>Contact Details</i18n:text></xsl:variable>
              <tr>
                <td width="100%"> 
                  <i2:container title="{$caption_title}" inner="yes">

                    <xsl:call-template name="display_instruction_area"/>

                    <table width="100%">
                      <form name="addNewContactForm" action="" method="post" target="appFrame">
                        
                        <input type="hidden" name="PAGE" value="{$page}"/>                       
                        <input type="hidden" name="EDIT_CONTACT_ID" value="{$edit_contact_id}"/>   
                        
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
                          <xsl:when test="$entityType = 'FC'">
                            <input type="hidden" name="RE_CIR_ID_NAME" value="FULFILLMENT_CENTER_ID"/>
                            <input type="hidden" name="FULFILLMENT_CENTER_ID" value="{$entityId}"/>
                          </xsl:when>
						  <xsl:when test="$entityType = 'SF'">
                            <input type="hidden" name="RE_CIR_ID_NAME" value="SHIP_FROM_ID"/>
                            <input type="hidden" name="SHIP_FROM_ID" value="{$entityId}"/>
							<input type="hidden" name="OP_TYPE" value="{$opType}"/>
                          </xsl:when>
                        </xsl:choose>
                        
                        <input type="hidden" name="ENTITY_ID" value="{$entityId}"/>   
                        <input type="hidden" name="ENTITY_TYPE" value="{$entityType}"/>
                        
                        <input type="hidden" name="REQ_FIELDS" value="FIRST_NAME,LAST_NAME,EMAIL_ADDRESS"/>
                        

                        <tr class="text">
                          <td nowrap="nowrap"><i18n:text>First Name</i18n:text><xsl:text>:</xsl:text>
                            <xsl:call-template name="display_alert_mark"/>
                          </td>
                          <td nowrap="nowrap">
                            <input type="field" name="FIRST_NAME" required="true" tabIndex="" class="inputfieldIE" maxlength="32" size="15">
                              <xsl:attribute name="value">
                                <xsl:choose>
                                  <xsl:when test="string-length( $edit_contact_id ) != 0">
                                    <xsl:value-of select="CONTACTS/CONTACT[ID/@Value = $edit_contact_id]/FIRST_NAME/@Value"/>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:value-of select="FIRST_NAME/@Value"/>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:attribute>
                            </input>
                            <xsl:call-template name="display_alert_image">
                              <xsl:with-param name="fieldName" select="'FIRST_NAME'"/>
                            </xsl:call-template>
                          </td>

                          <td nowrap="nowrap"><i18n:text>Phone</i18n:text><xsl:text>:</xsl:text></td>
                          <td nowrap="nowrap">
                            <input type="field" name="PHONE" tabIndex="" class="inputfieldIE" maxlength="32" size="15">
                              <xsl:attribute name="value">
                                <xsl:choose>
                                  <xsl:when test="string-length( $edit_contact_id ) != 0">
                                    <xsl:value-of select="CONTACTS/CONTACT[ID/@Value = $edit_contact_id]/PHONE/@Value"/>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:value-of select="PHONE/@Value"/>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:attribute>
                            </input>
                          </td>
                        </tr>

                        <tr class="text">
                          <td nowrap="nowrap"><i18n:text>Last Name</i18n:text><xsl:text>:</xsl:text>
                            <xsl:call-template name="display_alert_mark"/>
                          </td>
                          <td nowrap="nowrap">
                            <input type="field" name="LAST_NAME" required="true" tabIndex="" class="inputfieldIE" maxlength="32" size="15">
                              <xsl:attribute name="value">
                                <xsl:choose>
                                  <xsl:when test="string-length( $edit_contact_id ) != 0">
                                    <xsl:value-of select="CONTACTS/CONTACT[ID/@Value = $edit_contact_id]/LAST_NAME/@Value"/>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:value-of select="LAST_NAME/@Value"/>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:attribute>
                            </input>
                            <xsl:call-template name="display_alert_image">
                              <xsl:with-param name="fieldName" select="'LAST_NAME'"/>
                            </xsl:call-template>
                          </td>

                          <td nowrap="nowrap"><i18n:text>Fax</i18n:text><xsl:text>:</xsl:text></td>
                          <td nowrap="nowrap">
                            <input type="field" name="FAX" tabIndex="" class="inputfieldIE" maxlength="32" size="15">
                              <xsl:attribute name="value">
                                <xsl:choose>
                                  <xsl:when test="string-length( $edit_contact_id ) != 0">
                                    <xsl:value-of select="CONTACTS/CONTACT[ID/@Value = $edit_contact_id]/FAX/@Value"/>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:value-of select="FAX/@Value"/>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:attribute>
                            </input>
                          </td>
                        </tr>

                        <tr class="text">
                          <td nowrap="nowrap"><i18n:text>Email</i18n:text><xsl:text>:</xsl:text>
                            <xsl:call-template name="display_alert_mark"/>
                          </td>
                          <td nowrap="nowrap">
                            <input type="field" name="EMAIL_ADDRESS" required="true" tabIndex="" class="inputfieldIE" maxlength="64" size="15">
                              <xsl:attribute name="value">
                                <xsl:choose>
                                  <xsl:when test="string-length( $edit_contact_id ) != 0">
                                    <xsl:value-of select="CONTACTS/CONTACT[ID/@Value = $edit_contact_id]/EMAIL_ADDRESS/@Value"/>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:value-of select="EMAIL_ADDRESS/@Value"/>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:attribute>
                            </input>
                            <xsl:call-template name="display_alert_image">
                              <xsl:with-param name="fieldName" select="'EMAIL_ADDRESS'"/>
                            </xsl:call-template>
                          </td>
                        </tr>
                      </form>
                    </table>
                    <i2:footer header="true">
                      <table border="0" cellpadding="2" cellspacing="0" width="100%">
                        <tr>
                          <td width="100%"></td>
                          <td align="right">
                            <i2:buttonbar>
                              <xsl:choose>
                                <xsl:when test="string-length( $edit_contact_id ) != 0">
                                  <i2:button emphasized="yes" onclick="javascript:updateContact()">&#xA0;<i18n:text>Update</i18n:text>&#xA0;</i2:button>
                                </xsl:when>
                                <xsl:otherwise>
                                  <i2:button emphasized="yes" onclick="javascript:addNewContact()">&#xA0;<i18n:text>Save</i18n:text>&#xA0;</i2:button>
                                </xsl:otherwise>
                              </xsl:choose>
                            </i2:buttonbar>
                          </td>
                        </tr>
                      </table>    
                    </i2:footer>
                  </i2:container>
                </td>
              </tr>

              <script type="text/javascript">
                requiredFieldCheck('onLoad');
              </script>

            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </table>
    
  </xsl:template> 
  
  <xsl:template match="SEARCH_RESULTS">
    <xsl:param name="page"/>
    <xsl:param name="orgId"/>
    <xsl:param name="entityType"/>
    <xsl:param name="entityId"/>
    
    <xsl:variable name="caption_title"><i18n:text>Search Results</i18n:text></xsl:variable>
    <i2:container title="{$caption_title}" inner="yes" stretch="yes">
      <table width="100%" height="100%" cellspacing="0" border="0">
        <form name="addExistingForm" action="" method="post" target="appFrame">
          <input type="hidden" name="PAGE" value="{$page}"/>   
          <input type="hidden" name="ORG_ID" value="{$orgId}"/>   
          <input type="hidden" name="ENTITY_ID" value="{$entityId}"/>   
          <input type="hidden" name="ENTITY_TYPE" value="{$entityType}"/>  
          <tr>
            <td>
              <i2:table width="100%" height="100%" id="usersTable" scrollablerows="yes" scrollablecolumns="auto">
                <i2:tr header="yes">
                  <td nowrap="yes" width="4%">
                    <input type="checkbox" name="SELECT_ALL" value="true" onclick="javascript:toggleCheckboxes(document.forms.addExistingForm, document.forms.addExistingForm.CONTACT_ID, document.forms.addExistingForm.SELECT_ALL);"/>
                  </td>
                  <td nowrap="yes"><i18n:text>Name</i18n:text></td>
                  <td nowrap="yes"><i18n:text>Email</i18n:text></td>
                  <td nowrap="yes"><i18n:text>Phone</i18n:text></td>
                  <td nowrap="yes"><i18n:text>Fax</i18n:text></td>
                </i2:tr>
                <xsl:apply-templates select="CONTACT"/>
              </i2:table>
              
              <i2:footer>
                <i2:buttonbar>
                  <i2:button onclick="javascript:addFromExisting()">&#xA0;<i18n:text>Add</i18n:text>&#xA0;</i2:button>
                </i2:buttonbar>
              </i2:footer>
            </td>
          </tr>
        </form>
      </table>
    </i2:container>
  </xsl:template>
  
  <xsl:template match="CONTACT">
    <i2:tr class="table2">
      <xsl:choose>
        <xsl:when test="/RESPONSES/RESPONSE/CONTACTS/EDITABLE">
          <td nowrap="yes" width="4%" class="checkboxColumn">
            <input type="checkbox" name="CONTACT_ID"  value="{ID/@Value}"></input>
          </td>
          <td nowrap="yes">
            <a href="javascript:editContact('{ID/@Value}')">
              <xsl:value-of select="LAST_NAME/@Value"/>, <xsl:value-of select="FIRST_NAME/@Value"/>
            </a>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td nowrap="yes">
            <xsl:value-of select="LAST_NAME/@Value"/>, <xsl:value-of select="FIRST_NAME/@Value"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>

      <td nowrap="yes"><xsl:value-of select="EMAIL_ADDRESS/@Value"/></td>
      <td nowrap="yes"><xsl:value-of select="PHONE/@Value"/></td>
      <td nowrap="yes"><xsl:value-of select="FAX/@Value"/></td>
    </i2:tr>
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


