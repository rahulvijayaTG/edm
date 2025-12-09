<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:xalan="http://xml.apache.org/xalan" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" exclude-result-prefixes="xalan" version="1.0">
  <xsl:import href="../../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../../core/xsl/container.xsl"/>
  <xsl:import href="../../../../omx/xsl/required_field.xsl"/>
  <xsl:import href="../../../../omx/xsl/code_master.xsl"/>
  <xsl:import href="../../../../core/xsl/error.xsl"/>
  <xsl:output method="html"/>
  <xsl:template match="RESPONSES" mode="content">
    <!-- jlava script -->
    <script>
          function add()
          {
          //  document.location.href = omxContextPath + "/omx/user_admin/user_admin_users/view.cmd" ;
            document.user_group_form.action= omxContextPath + "/omx/user_admin/user_admin_users/view.cmd?WHERE=NEW_USERS" ;
            document.user_group_form.submit();
          }

        function onGroupTypeChange()
        {
            var adminGroupCode = '<xsl:value-of select="//RESPONSES/RESPONSE/USER_GROUP_TYPES/USER_GROUP_TYPE[./@isAdminType = 'yes' ]/@Value"/>';
            var grpType = document.forms.user_group_form.USER_GROUP_TYPE.options[document.forms.user_group_form.USER_GROUP_TYPE.selectedIndex].value;
            if( grpType == adminGroupCode ){ goAssignableRoleTemplate(); }
        }
      function goAssignableRoleTemplate(){
            document.forms.user_group_form.action = omxContextPath + '/bcm/framework/user_admin/user_admin_groups_new/gotoUserGroupAssinableRoleTemplate.cmd';
            document.forms.user_group_form.submit();
      }

      function gotoEditRoleDomain(){
            document.forms.user_group_form.action = omxContextPath + '/bcm/framework/user_admin/user_admin_groups_new/gotoEditRoleDomain.cmd';
            document.forms.user_group_form.submit();
      }
        function goToViewUsers(){
            document.forms.user_group_form.action = omxContextPath + '/bcm/framework/user_admin/user_admin_groups_new/goToPage.cmd?WHERE=VIEW_USERS&amp;fromPage=user_group_profile' ;
            document.forms.user_group_form.submit();
        }
        function goToAssignUsers(){
            document.forms.user_group_form.action = omxContextPath + '/bcm/framework/user_admin/user_admin_groups_new/goToPage.cmd?WHERE=ASSIGN_USERS&amp;fromPage=user_group_profile' ;
            document.forms.user_group_form.submit();
        }
        function goToNewUsers(){
            document.forms.user_group_form.action = omxContextPath + '/bcm/framework/user_admin/user_admin_groups_new/goToPage.cmd?WHERE=NEW_USERS&amp;fromPage=user_group_profile' ;
            document.forms.user_group_form.submit();
        }
        function submitFormToAddDomainListValues(){
            document.forms.user_group_form.action = omxContextPath + "/bcm/framework/user_admin/user_admin_groups_new/addDomainListValues.cmd" ;
            document.forms.user_group_form.submit();
        }

        function submitFormToRemoveDomainListValues(){
            document.forms.user_group_form.action = omxContextPath + "/bcm/framework/user_admin/user_admin_groups_new/removeDomainListValues.cmd" ;
            document.forms.user_group_form.submit();
        }

        function submitFormToCreateNewUserGroup(type){
        var isSubmitOK = false;
        if( type == 'SAVE' ){    // SAVE
            error = "false";
            error = requiredFieldCheck();
            if ( error == 'false' ){
            isSubmitOK = true;
          }else{
            isSubmitOK = false;
          }
        }
        else if( type == 'SAVE_AS' ){  // SAVE_AS button
            if( document.forms.user_group_form.OLD_GRP_NAME.value
                    != document.forms.user_group_form.GRP_NAME.value ){
                 isSubmitOK = true;
             }else{
                core_alert( 'User Group name must be unique.' );
                isSubmitOK = false;
             }
        }
        if( isSubmitOK ){
                    document.forms.user_group_form.action = omxContextPath + "/bcm/framework/user_admin/user_admin_groups_new/createNewUserGroup.cmd" ;
                    document.forms.user_group_form.submit();
        }
        return;
        }

        function submitFormToModifyUserGroup(){
        error = "false";
        error = requiredFieldCheck();
        if ( error == 'false' )
        {
                document.forms.user_group_form.action = omxContextPath + "/bcm/framework/user_admin/user_admin_groups_new/modifyUserGroupDetails.cmd" ;
                document.forms.user_group_form.submit();
         }
         return;
        }
        function submitFormToDeactivate(){
            document.forms.user_group_form.action = omxContextPath + "/bcm/framework/user_admin/user_admin_groups_new/inActivateUserGroup.cmd" ;
            document.forms.user_group_form.submit();
        }
        function submitFormToActivate(){
            document.forms.user_group_form.action = omxContextPath + "/bcm/framework/user_admin/user_admin_groups_new/activateUserGroup.cmd" ;
            document.forms.user_group_form.submit();
        }
        function onAssignDomain(){
           //document.forms.user_group_form.action="assignDomainToUserGrp.jsp";
           document.forms.user_group_form.action="assignDomainHome.jsp";
           document.forms.user_group_form.submit();
          }
          function onCancel()
             {
             var xaction =  null;
             <xsl:if test="RESPONSE/CANCELDEST/@Value = 'user_details'">                
                xaction = omxContextPath + "/omx/user_admin/user_admin_users/view.cmd?fromPage=users_search&amp;ID=<xsl:value-of select="RESPONSE/USERID/@Value"/>";
                parent.location.href = xaction;
             </xsl:if>
             <xsl:if test="not(RESPONSE/CANCELDEST/@Value) = 'user_details'">
                xaction = omxContextPath + "/bcm/framework/user_admin/user_admin_groups_new/onCancel.cmd";
                document.forms.user_group_form.action = xaction;
                document.forms.user_group_form.submit();
             </xsl:if>                           
          }
      </script>
    <!-- end java script -->
    <!--     <xsl:apply-templates select="RESPONSE/USER_GRP_PROFILE"/> -->
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="tabs">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
  </xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="container_content">
    <!-- Body -->
    <table border="0" cellpadding="0" cellspacing="6" width="100%">
      <tr>
        <td width="100%">
          <!-- Errors -->
          <xsl:if test="count(SUCCESS_MESSAGE) &gt; 0">
            <tr>
              <td>
                <!--  save success message -->
                <xsl:apply-templates select="SUCCESS_MESSAGE"/>
              </td>
            </tr>
          </xsl:if>
          <xsl:if test="count(ERROR_MESSAGE) &gt; 0">
            <tr>
              <td>
                <!--  save error message -->
                <xsl:apply-templates select="ERROR_MESSAGE"/>
              </td>
            </tr>
          </xsl:if>
                <xsl:apply-templates select="USER_GRP_PROFILE"/>
        </td>
      </tr>
    </table>
  </xsl:template>
    <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="USER_GRP_PROFILE">
    <!--       <i18n:text><xsl:value-of select="/RESPONSES/RESPONSE/_ERROR/@Value"/></i18n:text> -->
    <xsl:call-template name="display_instruction_area"/>
    <xsl:variable name="viewMode">
      <xsl:value-of select="/RESPONSES/RESPONSE/VIEW_MODE/@Value"/>
    </xsl:variable>
    <xsl:variable name="grpType">
      <xsl:value-of select="/RESPONSES/RESPONSE/USER_GRP_PROFILE/TYPE/@Value"/>
    </xsl:variable>
    <xsl:variable name="isNewUserGroup" select="not( (string-length(ID/@Value) &gt; 0))"/>
    <xsl:variable name="isReadOnly">
      <xsl:choose>
        <xsl:when test="(string-length($viewMode) &gt; 0) and ( $viewMode = 'EDIT' )">
          <xsl:value-of select="false()"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="true()"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="isUserGroupInfoActionDisabled" select="( ( $isNewUserGroup = 'true' )  or ( $isReadOnly = 'true' )) "/>
    <xsl:variable name="editAssignableRolesDisabled" select="( ($isUserGroupInfoActionDisabled = 'true') or ($grpType != 'ADMIN'))"/>
    <!--
      <xsl:value-of select="$isNewUserGroup"/>
      <br/>
      <xsl:value-of select="$isReadOnly"/>
      <br/>
      <xsl:value-of select="$isUserGroupInfoActionDisabled"/>
      <br/>
      <xsl:value-of select="$isUserGroupInfoActionDisabled"/>
      <br/>
      <xsl:value-of select="$grpType"/>
      <br/>
      <xsl:value-of select="$editAssignableRolesDisabled"/>
      <br/>
-->
    <xsl:variable name="isUserViewDisabled" select="( $isNewUserGroup = 'true' ) "/>
    <xsl:variable name="caption_title">
      <i18n:text>General Information</i18n:text>
    </xsl:variable>
    <table border="0" cellpadding="0" cellspacing="5" width="100%">
      <form name="user_group_form" method="POST" target="appFrame">
        <tr>
          <td>
            <i2:container title="{$caption_title}" inner="yes" indentcontent="true">
              <input type="hidden" name="ID" value="{ID/@Value}"/>
              <input type="hidden" name="STATUS" value="{STATUS/@Value}"/>
              <input type="hidden" name="VIEW_MODE" value="{$viewMode}"/>
              <input type="Hidden" name="PAGE" value="user_admin_users"/>
              <input type="Hidden" name="CANCELDEST" value="{/RESPONSES/RESPONSE/CANCELDEST/@Value}"/>              
              <input type="Hidden" name="USERID" value="{/RESPONSES/RESPONSE/USERID/@Value}"/>              
              <input type="Hidden" name="RET_PAGE" value="{/RESPONSES/RESPONSE/RET_PAGE/@Value}"/>
              <table border="0" bordercolor="red" cellpadding="0" cellspacing="0" width="100%" valign="top">
                <tr class="text">
                  <td class="rightBorder" valign="top" width="50%">
                    <table border="0" bordercolor="red" cellpadding="0" cellspacing="9" width="70%">
                      <xsl:choose>
                        <xsl:when test=" $viewMode = 'READ' and string-length($viewMode) &gt; 0 ">
                          <tr class="text">
                            <td nowrap="nowrap">
                              <i18n:text>Group Name</i18n:text>
                              <xsl:text>:</xsl:text>
                            </td>
                            <td nowrap="nowrap">
                              <xsl:value-of select="GRP_NAME/@Value"/>
                              <input type="hidden" name="GRP_NAME" value="{GRP_NAME/@Value}"/>
                            </td>
                          </tr>
                        </xsl:when>
                        <xsl:otherwise>
                          <tr class="text">
                            <td nowrap="nowrap">
                              <i18n:text>Group Name</i18n:text>
                              <xsl:text>:</xsl:text>
                              <xsl:call-template name="display_alert_mark"/>
                            </td>
                            <td nowrap="nowrap">
                              <input type="field" name="GRP_NAME" value="{GRP_NAME/@Value}" required="true" tabIndex="" class="inputfieldIE" maxlength="32" size="35"/>
                              <xsl:call-template name="display_alert_image">
                                <xsl:with-param name="fieldName" select="'GRP_NAME'"/>
                              </xsl:call-template>
                              <!-- used in save as validation-->
                              <input type="hidden" name="OLD_GRP_NAME" value="{GRP_NAME/@Value}"/>
                            </td>
                          </tr>
                        </xsl:otherwise>
                      </xsl:choose>
                      <tr>
                        <td nowrap="nowrap" valign="top">
                          <i18n:text>Description</i18n:text>
                          <xsl:text>:</xsl:text>
                        </td>
                        <td nowrap="nowrap">
                          <xsl:choose>
                            <xsl:when test=" $viewMode = 'READ' and string-length($viewMode) &gt; 0 ">
                              <TEXTAREA name="DESCRIPTION" tabIndex="" class="noneditable" maxlength="50" size="50" cols="35" rows="5">
                                <xsl:value-of select="DESCRIPTION/@Value"/>
                              </TEXTAREA>
                            </xsl:when>
                            <xsl:otherwise>
                              <TEXTAREA name="DESCRIPTION" tabIndex="" class="editable" maxlength="50" size="50" cols="35" rows="5">
                                <xsl:value-of select="DESCRIPTION/@Value"/>
                              </TEXTAREA>
                            </xsl:otherwise>
                          </xsl:choose>
                        </td>
                      </tr>
                      <tr class="text">
                        <td nowrap="nowrap">
                          <i18n:text>Organization</i18n:text>
                          <xsl:text>:</xsl:text>
                        </td>
                        <xsl:variable name="orgId">
                          <xsl:value-of select="/RESPONSES/RESPONSE/ORGANIZATION/ID/@Value"/>
                        </xsl:variable>
                        <td nowrap="nowrap">
                          <xsl:value-of select="/RESPONSES/RESPONSE/ORGANIZATION/FULL_NAME/@Value"/>
                          <input type="hidden" name="ORG_ID" value="{$orgId}"/>
                          <input type="hidden" name="loadFirst" value="TRUE"/>
                          <input type="hidden" name="ORG_FULL_NAME" value="{/RESPONSES/RESPONSE/ORGANIZATION/FULL_NAME/@Value}"/>
                        </td>
                      </tr>
                      <xsl:choose>
                        <xsl:when test=" $viewMode = 'READ' and string-length($viewMode) &gt; 0 ">
                          <tr class="text">
                            <td nowrap="nowrap">
                              <i18n:text>Type</i18n:text>
                              <xsl:text>:</xsl:text>
                              <xsl:call-template name="display_alert_mark"/>
                            </td>
                            <td nowrap="nowrap">
                              <xsl:variable name="typeId">
                                <xsl:value-of select="TYPE/@Value"/>
                              </xsl:variable>
                              <xsl:variable name="typeName">
                                <xsl:value-of select="/RESPONSES/RESPONSE/USER_GROUP_TYPES/USER_GROUP_TYPE[$typeId = ./@Value]/@Name"/>
                              </xsl:variable>
                              <i18n:text>
                                <xsl:value-of select="$typeName"/>
                              </i18n:text>
                              <input type="hidden" name="TYPE" Value="{$typeId}"/>
                            </td>
                          </tr>
                        </xsl:when>
                        <xsl:otherwise>
                          <tr class="text">
                            <td nowrap="nowrap">
                              <i18n:text>Type</i18n:text>
                              <xsl:text>:</xsl:text>
                              <xsl:call-template name="display_alert_mark"/>
                            </td>
                            <td nowrap="nowrap">
                              <xsl:variable name="typeId">
                                <xsl:value-of select="TYPE/@Value"/>
                              </xsl:variable>
                              <select class="inputfieldIE" name="USER_GROUP_TYPE" required="true" tabIndex="" width="40">
                                <option value="">
                                  <i18n:text>Select...</i18n:text>
                                </option>
                                <xsl:for-each select="/RESPONSES/RESPONSE/USER_GROUP_TYPES/USER_GROUP_TYPE">
                                  <xsl:sort select="./@Name"/>
                                  <option value="{./@Value}">
                                    <xsl:if test="$typeId = ./@Value">
                                      <xsl:attribute name="selected">selected</xsl:attribute>
                                    </xsl:if>
                                    <i18n:text>
                                      <xsl:value-of select="./@Name"/>
                                    </i18n:text>
                                  </option>
                                </xsl:for-each>
                              </select>
                              <xsl:call-template name="display_alert_image">
                                <xsl:with-param name="fieldName" select="'USER_GROUP_TYPE'"/>
                              </xsl:call-template>
                            </td>
                          </tr>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:if test="not( $editAssignableRolesDisabled) ">
                        <tr>
                          <td/>
                          <td>
                            <i2:container title="Assignable Roles" inner="yes" scrollable="true" indentcontent="true" height="100">
                              <i2:table border="0">
                                <xsl:for-each select="ASSINABLE_USER_GRP_ROLE_TEMPLATES/ROLE_TEMPLATES">
                                  <i2:tr>
                                    <td>
                                      <xsl:variable name="roleTemplate" select="./@Value"/>
                                      <i18n:text>
                                        <xsl:value-of select="./@Name"/>
                                      </i18n:text>
                                    </td>
                                  </i2:tr>
                                </xsl:for-each>
                              </i2:table>
                            </i2:container>
                            <i2:buttonbar>
                                <xsl:call-template name="mdmButton">
                                    <xsl:with-param name="onclick" select="'javascript:goAssignableRoleTemplate();'"/>
                                    <xsl:with-param name="text" select="'Edit List'"/>
                                </xsl:call-template>
                            
                              <!--i2:button onclick="javascript:goAssignableRoleTemplate()">
                                                    &#xA0;<i18n:text>Edit List</i18n:text>&#xA0;
                                                  </i2:button-->
                            </i2:buttonbar>
                          </td>
                        </tr>
                      </xsl:if>
                      <tr class="text">
                        <td nowrap="nowrap">
                          <i18n:text>Users</i18n:text>
                          <xsl:text>:</xsl:text>
                        </td>
                        <td nowrap="nowrap">
                          <i2:buttonbar nopadding="yes" aligncontents="left">
                                <xsl:call-template name="mdmButton">
                                    <xsl:with-param name="onclick" select="'javascript:goToViewUsers();'"/>
                                    <xsl:with-param name="text" select="'View'"/>
                                    <xsl:with-param name="disabled" select="$isUserViewDisabled"/>
                                </xsl:call-template>
                            <!--i2:button onclick="javascript:goToViewUsers()" disabled="{$isUserViewDisabled}">&#xA0;<i18n:text>View</i18n:text>&#xA0;</i2:button-->
                            <i2:buttonbardivider/>

                                <xsl:call-template name="mdmButton">
                                    <xsl:with-param name="onclick" select="'javascript:goToAssignUsers();'"/>
                                    <xsl:with-param name="text" select="'Assign'"/>
                                    <xsl:with-param name="disabled" select="$isUserGroupInfoActionDisabled"/>
                                </xsl:call-template>
                            <!--i2:button onclick="javascript:goToAssignUsers()" disabled="{$isUserGroupInfoActionDisabled}">&#xA0;<i18n:text>Assign</i18n:text>&#xA0;</i2:button-->
                            <i2:buttonbardivider/>
                                <xsl:call-template name="mdmButton">
                                    <xsl:with-param name="onclick" select="'javascript:goToNewUsers();'"/>
                                    <xsl:with-param name="text" select="'Add New'"/>
                                    <xsl:with-param name="disabled" select="$isUserGroupInfoActionDisabled"/>
                                </xsl:call-template>
                            
                            <!--i2:button onclick="javascript:goToNewUsers()" disabled="{$isUserGroupInfoActionDisabled}">&#xA0;<i18n:text>Add New</i18n:text>&#xA0;</i2:button-->
                          </i2:buttonbar>
                        </td>
                      </tr>
                    </table>
                  </td>
                  <td valign="top" width="50%">
                    <table border="0" bordercolor="red" cellpadding="0" cellspacing="9" width="100%" class="tablebackground">
                      <xsl:choose>
                        <xsl:when test=" $viewMode = 'READ' and string-length($viewMode) &gt; 0 ">
                          <tr class="text">
                            <td nowrap="nowrap">
                              <i18n:text>Role</i18n:text>
                              <xsl:text>:</xsl:text>
                              <xsl:call-template name="display_alert_mark"/>
                            </td>
                            <td nowrap="nowrap">
                              <xsl:variable name="roleId">
                                <xsl:value-of select="ROLE_TEMP_ID/@Value"/>
                              </xsl:variable>
                              <xsl:variable name="roleName">
                                <xsl:value-of select="ROLE_TEMP_ID/@Name"/>
                              </xsl:variable>
                              <i18n:text>
                                <xsl:value-of select="$roleName"/>
                              </i18n:text>
                              <input type="hidden" name="ROLE_ID" Value="{$roleId}"/>
                            </td>
                          </tr>
                        </xsl:when>
                        <xsl:otherwise>
                          <tr class="text">
                            <td nowrap="nowrap">
                              <i18n:text>Role</i18n:text>
                              <xsl:text>:</xsl:text>
                              <xsl:call-template name="display_alert_mark"/>
                            </td>
                            <td nowrap="nowrap">
                              <xsl:variable name="roleId">
                                <xsl:value-of select="ROLE_TEMP_ID/@Value"/>
                              </xsl:variable>
                              <xsl:variable name="roleName">
                                <xsl:value-of select="ROLE_TEMP_ID/@Name"/>
                              </xsl:variable>
                              <xsl:choose>
                                <xsl:when test="($isNewUserGroup = 'true') or ( count( //RESPONSES/RESPONSE/ASSIGNABLE_ROLES/ASSIGNABLE_ROLE[$roleId = VALUE_ID/@Value] ) &gt; 0 )">
                                  <select class="inputfieldIE" name="ROLE_ID" required="true" tabIndex="" width="27">
                                    <option value="">
                                      <i18n:text>Select...</i18n:text>
                                    </option>
                                    <xsl:for-each select="/RESPONSES/RESPONSE/ASSIGNABLE_ROLES/ASSIGNABLE_ROLE">
                                      <option value="{VALUE_ID/@Value}">
                                        <xsl:if test="$roleId = VALUE_ID/@Value">
                                          <xsl:attribute name="selected">selected</xsl:attribute>
                                        </xsl:if>
                                        <i18n:text>
                                          <xsl:value-of select="DESCRIPTION/@Value"/>
                                        </i18n:text>
                                      </option>
                                    </xsl:for-each>
                                  </select>
                                </xsl:when>
                                <xsl:otherwise>
                                  <i18n:text>
                                    <xsl:value-of select="$roleName"/>
                                  </i18n:text>
                                  <input type="hidden" name="ROLE_ID" Value="{$roleId}"/>
                                </xsl:otherwise>
                              </xsl:choose>
                              <xsl:call-template name="display_alert_image">
                                <xsl:with-param name="fieldName" select="'ROLE_ID'"/>
                              </xsl:call-template>
                            </td>
                          </tr>
                        </xsl:otherwise>
                      </xsl:choose>
                      <tr>
                        <td/>
                        <td>
                          <!-- start role domain -->
                          <table border="0" bordercolor="red" scrollablerows="no" scrollablecolumns="yes" id="usersTable" width="100%">
                            <xsl:for-each select="//ASSIGNED_ROLE_TEMPLATE/DOMAIN_TYPE">
                              <tr class="text">
                                <td>
                                  <xsl:call-template name="ROLE_DOMAIN_VALUES_SHEET">
                                    <xsl:with-param name="domainTypeNode" select="."/>
                                    <xsl:with-param name="domainTypeMaster" select="/RESPONSES/RESPONSE/DOMAIN_TYPE_MASTER"/>
                                  </xsl:call-template>
                                </td>
                              </tr>
                            </xsl:for-each>
                            <tr>
                              <td>
                                <!--
                                            <i2:buttonbar nopadding="yes" aligncontents="right">
                                                <i2:button onclick="javascript:gotoEditRoleDomain()" disabled="{$isUserGroupInfoActionDisabled}">&#xA0;<i18n:text>Edit Domains</i18n:text>&#xA0;</i2:button>
                                            </i2:buttonbar>
-->
                              </td>
                            </tr>
                          </table>
                          <!-- end role domain -->
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </i2:container>
          </td>
        </tr>
      </form>
    </table>
  </xsl:template>
  <!-- the role domain sheet -->
  <xsl:template name="ROLE_DOMAIN_VALUES_SHEET">
    <xsl:param name="domainTypeNode"/>
    <xsl:param name="domainTypeMaster"/>
    <xsl:variable name="lowercase">abcdefghijklmnopqrstuvwxyz</xsl:variable>
    <xsl:variable name="uppercase">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
    <xsl:variable name="domainScope" select="translate($domainTypeNode/DOMAIN_SCOPE/@Value , $lowercase , $uppercase )"/>
    <xsl:variable name="titleString">
      <i18n:text>
        <xsl:value-of select="$domainTypeMaster/DOMAIN_TYPE[./ID/@Value = $domainTypeNode/DOMAIN_TYPE_ID/@Value]/NAME/@Value"/>
      </i18n:text>
    </xsl:variable>
    <!-- for LIST -->
    <xsl:if test="$domainScope = 'LIST' ">
      <xsl:choose>
        <xsl:when test="count($domainTypeNode/ENTITY_LIST/ENTITY) > 0">
          <i2:container id="{$titleString}" title="{$titleString}" inner="yes" scrollable="true" indentcontent="true" height="75" collapsable="true">
            <i2:table border="0" bordercolor="green" cellpadding="0" cellspacing="0" width="100%">
              <i2:tr header="true">
                <td>Listed Entities</td>
              </i2:tr>
              <xsl:for-each select="$domainTypeNode/ENTITY_LIST/ENTITY">
                <i2:tr>
                  <td>
                    <xsl:value-of select="./@Name"/>
                  </td>
                </i2:tr>
              </xsl:for-each>
            </i2:table>
          </i2:container>
        </xsl:when>
        <xsl:otherwise>
          <i2:container id="{$titleString}" title="{$titleString}" inner="yes" scrollable="true" indentcontent="true" height="40" collapsable="false">
            <i2:table border="0" bordercolor="green" cellpadding="0" cellspacing="0" width="100%">
              <i2:tr header="true">
                <td>Listed Entities</td>
              </i2:tr>
              <i2:tr>
                <td>
                  <i18n:text>
                                        Currently, there are no organization entities listed.
                                    </i18n:text>
                </td>
              </i2:tr>
            </i2:table>
          </i2:container>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <!-- for ALL -->
    <xsl:if test="$domainScope = 'ALL' ">
      <i2:container id="{$titleString}" title="{$titleString}" inner="yes" scrollable="true" indentcontent="yes" height="75" collapsable="true">
        <i2:table border="0" bordercolor="green" cellpadding="0" cellspacing="0" width="100%">
          <i2:tr header="true">
            <td>All Enabled</td>
          </i2:tr>
          <i2:tr>
            <td>
              <i18n:text>
                                This user group has permissions to access all enabled entities along this domain dimensions.
                            </i18n:text>
            </td>
          </i2:tr>
        </i2:table>
      </i2:container>
    </xsl:if>
    <!-- for SELF -->
    <xsl:if test="$domainScope = 'SELF' ">
      <i2:container id="{$titleString}" title="{$titleString}" inner="yes" scrollable="true" indentcontent="true" height="75" collapsable="true">
        <i2:table border="0" bordercolor="green" cellpadding="0" cellspacing="0" width="100%">
          <i2:tr header="true">
            <td>Self</td>
          </i2:tr>
          <i2:tr>
            <td>
              <i18n:text>
                                This user group has permissions to access only its own organization entities along this domain dimensions.
                            </i18n:text>
            </td>
          </i2:tr>
        </i2:table>
      </i2:container>
    </xsl:if>
    <script>
      i2uiCollapseContainer('<xsl:value-of select="$titleString"/>');
    </script>
  </xsl:template>
  <!-- page.xsl Javascript -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {
      requiredFieldCheck('onLoad');
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
    <xsl:call-template name="javascript_resizeRegTabs"/>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="javascript_onResize_tab">
    <xsl:call-template name="javascript_resizeRegTabs"/>
  </xsl:template>
  <!-- overrides the js in tabs.xsl -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="javascript_resizeRegTabs">
    i2uiResizeScrollableContainer('container',document.body.offsetHeight - 90, null, document.body.offsetWidth - 40, true, 'yes');
    i2uiResizeScrollableContainer('tabs_container_description',document.body.offsetHeight -105, null, document.body.offsetWidth - 20, true, 'yes');
  </xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>
