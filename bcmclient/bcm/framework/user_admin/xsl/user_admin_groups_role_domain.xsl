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
  <xsl:template match="RESPONSES" mode="content">

        <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <form name="roleDomainForm" target="appFrame" method="post">
            <tr>
                <td>
                    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="tabs">
                        <xsl:with-param name="content" select="RESPONSE"/>
                    </xsl:apply-templates>
                </td>
            </tr>
        </form>
        </table>
    </xsl:template>

    <xsl:template match="RESPONSE" mode="container_content">
    <script>
        function submitFormToAddDomainListValues(){
            document.forms.roleDomainForm.action = omxContextPath + '/bcm/framework/user_admin/user_admin_groups_new/addDomain.cmd';
            document.forms.roleDomainForm.submit();
        }
        function goToNewUserGroup(){
            document.location.href = omxContextPath + '/bcm/framework/user_admin/user_admin_groups_new/goToPage.cmd?WHERE=USER_GROUP_CONTENTS' ;
        }
        function submitFormToRemoveDomainListValues(){
            document.forms.roleDomainForm.action = omxContextPath + "/bcm/framework/user_admin/user_admin_groups_new/removeDomainListValues.cmd" ;
            document.forms.roleDomainForm.submit();
        }

    </script>
        <table border="0" width="100%">
            <tr>
                <td align="left" valign="top" >
                        <xsl:call-template name="ROLE_DOMAIN_TAB_CONTENTS" >
                                <xsl:with-param name="tabContents" select="/RESPONSES/RESPONSE"/>
                                <xsl:with-param name="domainTypeMaster" select="/RESPONSES/RESPONSE/DOMAIN_TYPE_MASTER"/>
                        </xsl:call-template>
                </td>
            </tr>
        </table>
        <i2:footer>
            <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <i2:buttonbar aligncontents="right">
                                <xsl:call-template name="mdmButton">
                                    <xsl:with-param name="onclick" select="'javascript:goToNewUserGroup();'"/>
                                    <xsl:with-param name="text" select="'Done'"/>
                                    <xsl:with-param name="emphasized" select="yes"/>
                                </xsl:call-template>
                            <!--i2:button emphasized="yes" onclick="javascript:goToNewUserGroup()" nopadding="yes">Done</i2:button-->
                        </i2:buttonbar>
                    </td>
                </tr>
            </table>
        </i2:footer>
    </xsl:template>

    <xsl:template name="ROLE_DOMAIN_TAB_CONTENTS" >
        <xsl:param name="tabContents"/>
        <xsl:param name="domainTypeMaster" />
        <!-- Show domain tab pane body -->
        <xsl:variable name="selectedTabName" select="$tabContents/CONTAINER/STEP[./@Selected = 'yes' or ./@Selected ='true']/@DisplayText"/>
        <xsl:variable name="selectedTabID" select="$domainTypeMaster/DOMAIN_TYPE[./NAME/@Value = $selectedTabName]/ID/@Value"/>
        <input type="Hidden" name="SELECTED_DOMAIN_TYPE" value="{$selectedTabID}" />
    <input type="Hidden" name="USER_GRP_ID" value="{$tabContents/USER_GRP_PROFILE/ID/@Value}"/>
    <input type="Hidden" name="ROLE_ID" value="{$tabContents/USER_GRP_PROFILE/ROLE_TEMP_ID/@Value}"/>
    <input type="Hidden" name="SUBPAGE" value="{$selectedTabID}"/>
    <input type="Hidden" name="DOMAIN_TYPE_ID" value="{$tabContents/DOMAIN_TYPE_ID/@Value}"/>
         <table border="0" scrollablerows="no" scrollablecolumns="yes" width="100%">
          <tr class="text">
            <td>
                <xsl:choose>
                <!-- for LIST -->
                  <xsl:when test="$tabContents/USER_GRP_PROFILE/ASSIGNED_ROLE_TEMPLATE/DOMAIN_TYPE[./DOMAIN_TYPE_ID/@Value = $selectedTabID]/DOMAIN_SCOPE/@Value = 'List' ">
                    <xsl:choose>
                        <xsl:when test="count($tabContents/USER_GRP_PROFILE/ASSIGNED_ROLE_TEMPLATE/DOMAIN_TYPE[./DOMAIN_TYPE_ID/@Value = $selectedTabID]/ENTITY_LIST/ENTITY) &gt; 0">
                              <i2:table border="1" bordercolor="green" cellpadding="0" cellspacing="5" width="100%">
                                <i2:tr header="true" class="table2" >
                                    <td align="center" nowrap="nowrap" class="checkboxColumn" width="10%">
                                    <input type="checkbox" name="SELECT_ALL" value="true"
                                            onclick="javascript:toggleCheckboxes(document.forms.user_group_form, document.forms.user_group_form.ORG_ID, document.forms.user_group_form.SELECT_ALL);"/>
                                  </td>
                                  <td>Listed Entities</td>
                                </i2:tr>
                                <xsl:for-each select="$tabContents/USER_GRP_PROFILE/ASSIGNED_ROLE_TEMPLATE/DOMAIN_TYPE[./DOMAIN_TYPE_ID/@Value = $selectedTabID]/ENTITY_LIST/ENTITY" >
                                  <i2:tr>
                                            <td align="center" nowrap="nowrap" class="checkboxColumn">
                                                <input name="ORG_ID" type="checkbox" value="{./@Value}">
                                                </input>
                                            </td>
                                    <td><i18n:text><xsl:value-of select="./@Name" /></i18n:text></td>
                                  </i2:tr>
                                </xsl:for-each>
                              </i2:table>
                            </xsl:when>
                            <xsl:otherwise>
                                <i2:container title="Listed Entities" inner="yes" scrollable="true" indentcontent="true" height="75" >
                                    <table border="0" bordercolor="green" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td>
                                                <i18n:text>
                                                    Currently, there are no entities listed.
                                                </i18n:text>
                                            </td>
                                        </tr>
                                    </table>
                                </i2:container>
                            </xsl:otherwise>
                        </xsl:choose>
                        <i2:buttonbar>
                                <xsl:call-template name="mdmButton">
                                    <xsl:with-param name="onclick" select="'javascript:submitFormToAddDomainListValues();'"/>
                                    <xsl:with-param name="text" select="'Add'"/>
                                </xsl:call-template>
                            <!--i2:button onclick="javascript:submitFormToAddDomainListValues();">&#xA0;<i18n:text>Add</i18n:text>&#xA0;</i2:button-->
                            <xsl:if test="count($tabContents/USER_GRP_PROFILE/ASSIGNED_ROLE_TEMPLATE/DOMAIN_TYPE[./DOMAIN_TYPE_ID/@Value = $selectedTabID]/ENTITY_LIST/ENTITY) &gt; 0">
                                <i2:buttonbardivider/>
                                <xsl:call-template name="mdmButton">
                                    <xsl:with-param name="onclick" select="'javascript:submitFormToRemoveDomainListValues();'"/>
                                    <xsl:with-param name="text" select="'Remove'"/>
                                </xsl:call-template>
                                <!--i2:button onclick="javascript:submitFormToRemoveDomainListValues();">&#xA0;<i18n:text>Remove</i18n:text>&#xA0;</i2:button-->
                            </xsl:if>
                        </i2:buttonbar>
                  </xsl:when>
                <!-- for ALL -->
                  <xsl:when test="$tabContents/USER_GRP_PROFILE/ASSIGNED_ROLE_TEMPLATE/DOMAIN_TYPE[./DOMAIN_TYPE_ID/@Value = $selectedTabID]/DOMAIN_SCOPE/@Value = 'All' ">
                    <i2:container title="All Enabled" inner="yes" scrollable="true" indentcontent="true" height="40" >
                        <table border="0" bordercolor="green" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <i18n:text>
                                        This user group has permissions to access allenabled organization entities along this domain dimensions
                                    </i18n:text>
                                </td>
                            </tr>
                        </table>
                    </i2:container>
                  </xsl:when>
                <!-- for SELF -->
                  <xsl:when test="$tabContents/USER_GRP_PROFILE/ASSIGNED_ROLE_TEMPLATE/DOMAIN_TYPE[./DOMAIN_TYPE_ID/@Value = $selectedTabID]/DOMAIN_SCOPE/@Value = 'Self'" >
                    <i2:container title="Self" inner="yes" scrollable="true" indentcontent="true" height="40" >
                        <table border="0" bordercolor="green" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <i18n:text>
                                        This user group has permissions to access only its own organization entities along this domain dimensions.
                                    </i18n:text>
                                </td>
                            </tr>
                        </table>
                    </i2:container>
                   </xsl:when>
              </xsl:choose>
            </td>
          </tr>
      </table>
    </xsl:template>

</xsl:stylesheet>










