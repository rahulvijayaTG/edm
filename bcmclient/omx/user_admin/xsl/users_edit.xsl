<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:xalan="http://xml.apache.org/xalan" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" exclude-result-prefixes="xalan" version="1.0">	

  <xsl:import href="../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../core/xsl/container.xsl"/>
  <xsl:import href="../../../bcm/framework/xsl/buttons.xsl"/>
  <xsl:import href="../../../bcm/framework/xsl/code_master.xsl"/>
  <xsl:import href="../../../bcm/framework/xsl/required_field.xsl"/>  
  	
  <xsl:output method="html"/>
  
  <!-- **********************************************************************
     *********************************************************************** -->  
  <xsl:template match="RESPONSES" mode="content">
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>    
    <xsl:call-template name="include_form_validation_js"/>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="container_content">
    <!-- Body -->
    <table border="0" cellpadding="0" cellspacing="2" width="100%">
      <tr>
        <td width="100%">
          <!-- Errors -->
          <xsl:if test="count(SUCCESS_MESSAGE) &gt; 0">
          	<table border="0" cellpadding="0" cellspacing="6" width="100%">
				<tr>
				  <td>
					<!--  save success message -->
					<xsl:apply-templates select="SUCCESS_MESSAGE"/>
				  </td>
				</tr>
            </table>
          </xsl:if>
          <!-- error message taken care of -->
          <xsl:apply-templates select="USER_PROFILE"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!-- **********************************************************************
    *********************************************************************** --> 
  <xsl:template match="USER_PROFILE">
    <xsl:variable name="viewMode">
      <xsl:value-of select="/RESPONSES/RESPONSE/VIEW_MODE/@Value"/>
    </xsl:variable>
    <xsl:variable name="caption_title">
      <i18n:text>General Information</i18n:text>
    </xsl:variable>
    <xsl:variable name="userGroupID">
      <xsl:value-of select="/RESPONSES/RESPONSE/USER_PROFILE/USER_GRP_ID/@Value"/>
    </xsl:variable>
    <xsl:variable name="userGroupName">
      <xsl:value-of select="/RESPONSES/RESPONSE/USER_PROFILE/USER_GRP_NAME/@Value"/>
    </xsl:variable>
    <xsl:variable name="userOrgID">
      <xsl:value-of select="/RESPONSES/RESPONSE/USER_PROFILE/ORG_ID/@Value"/>
    </xsl:variable>
    <xsl:variable name="userOrgName">
      <xsl:value-of select="/RESPONSES/RESPONSE/USER_PROFILE/ORG_FULL_NAME/@Value"/>
    </xsl:variable>
    <table border="0" cellpadding="0" cellspacing="5" width="100%">
      <form name="user_form" method="POST" target="appFrame">
        <tr>
          <td>
            <i2:container title="{$caption_title}" inner="yes">
              <xsl:call-template name="display_instruction_area"/>
              <input type="hidden" name="ID" value="{ID/@Value}"/>
              <input type="hidden" name="USER_GRP_ID" value="{$userGroupID}"/>
              <input type="hidden" name="ADDRESS_ID" value="{ADDRESS_ID/@Value}"/>
              <input type="hidden" name="STATUS" value="{STATUS/@Value}"/>
              <input type="hidden" name="VIEW_MODE" value="{$viewMode}"/>
              <input type="Hidden" name="RE_CIR_PARAM_NAME" value="VIEW_MODE"/>
              <input type="Hidden" name="PAGE" value="users_edit"/>
              <input type="Hidden" name="RE_CIR_PARAM_NAME" value="ID"/>
              <input type="Hidden" name="RET_PAGE" value="{/RESPONSES/RESPONSE/RET_PAGE/@Value}"/>
              <input type="hidden" name="USER_GRP_NAME" value="{$userGroupName}"/>
              <input type="hidden" name="ORG_FULL_NAME" value="{$userOrgName}"/>
              <input type="hidden" name="FORCE_PASSWORD_CHANGE" value="true"/>
              <input type="hidden" name="CHANGE_PASSWD" value="no"/>
              <input type="hidden" name="MY_PROFILE" value="yes"/>
              <input type="Hidden" name="WHERE" value="{/RESPONSES/RESPONSE/WHERE/@Value}"/>
              <input type="Hidden" name="fromPage" value="{/RESPONSES/RESPONSE/fromPage/@Value}"/>
              <input type="Hidden" name="page" value="{/RESPONSES/RESPONSE/page/@Value}"/>

              <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr class="text">
                  <td class="rightBorder">
                    <table border="0" cellpadding="0" cellspacing="9" width="50%">
                      <xsl:choose>
                        <xsl:when test=" $viewMode = 'PREFERENCE' and string-length($viewMode) &gt; 0 ">
                          <tr class="text">
                            <td nowrap="nowrap">
                              <i18n:text>Login Name</i18n:text>
                              <xsl:text>:</xsl:text>
                            </td>
                            <td nowrap="nowrap">
                              <xsl:value-of select="LOGIN_NAME/@Value"/>
                              <input type="hidden" name="LOGIN_NAME" value="{LOGIN_NAME/@Value}"/>
                            </td>
                          </tr>
                        </xsl:when>
                        <xsl:otherwise>
                          <tr class="text">
                            <td nowrap="nowrap">
                              <i18n:text>Login Name</i18n:text>
                              <xsl:text>:</xsl:text>
                              <xsl:call-template name="display_alert_mark"/>
                            </td>
                            <td nowrap="nowrap">
                              <input type="field" name="LOGIN_NAME" value="{LOGIN_NAME/@Value}" required="true" tabIndex="" class="inputfieldIE" maxlength="32" size="27"/>
                              <xsl:call-template name="display_alert_image">
                                <xsl:with-param name="fieldName" select="'LOGIN_NAME'"/>
                              </xsl:call-template>
                            </td>
                          </tr>
                        </xsl:otherwise>
                      </xsl:choose>
                      <!-- Adding PASSWORD and PASSWORD1 fields -->
                      <xsl:choose>
                        <xsl:when test="( string-length(ID/@Value) > 0 ) or ( $viewMode='PREFERENCE')">
                          <tr class="text">
                            <td nowrap="nowrap">
                              <i18n:text>Password</i18n:text>
                              <xsl:text>:</xsl:text>
                            </td>
                            <td nowrap="nowrap">
                             	********
                            </td>
                          </tr>
                        </xsl:when>
                        <xsl:otherwise>
                          <tr class="text">
                            <td nowrap="nowrap">
                              <i18n:text>Password</i18n:text>
                              <xsl:text>:</xsl:text>
                              <xsl:call-template name="display_alert_mark"/>
                            </td>
                            <td nowrap="nowrap">
                              <input type="password" name="PASSWORD" value="{PASSWORD/@Value}" required="true" tabIndex="" class="inputfieldIE" maxlength="8" size="27"/>
                              <xsl:call-template name="display_alert_image">
                                <xsl:with-param name="fieldName" select="'PASSWORD'"/>
                              </xsl:call-template>
                            </td>
                          </tr>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:choose>
                        <xsl:when test="( string-length(ID/@Value) > 0 ) or ( $viewMode='PREFERENCE')">
                          <!-- Don't do anything -->
                        </xsl:when>
                        <xsl:otherwise>
                          <tr class="text">
                            <td nowrap="nowrap">
                              <i18n:text>Verify Password</i18n:text>
                              <xsl:text>:</xsl:text>
                              <xsl:call-template name="display_alert_mark"/>
                            </td>
                            <td nowrap="nowrap">
                              <input type="password" name="PASSWORD1" value="{PASSWORD/@Value}" required="true" tabIndex="" class="inputfieldIE" maxlength="8" size="27"/>
                              <xsl:call-template name="display_alert_image">
                                <xsl:with-param name="fieldName" select="'PASSWORD1'"/>
                              </xsl:call-template>
                            </td>
                          </tr>
                        </xsl:otherwise>
                      </xsl:choose>
                      <tr>
                        <td nowrap="nowrap">
                          <i18n:text>First Name</i18n:text>
                          <xsl:text>:</xsl:text>
                          <xsl:call-template name="display_alert_mark"/>
                        </td>
                        <td nowrap="nowrap">
                          <input type="field" name="FIRST_NAME" value="{FIRST_NAME/@Value}" required="true" tabIndex="" class="inputfieldIE" maxlength="32" size="27"/>
                          <xsl:call-template name="display_alert_image">
                            <xsl:with-param name="fieldName" select="'FIRST_NAME'"/>
                          </xsl:call-template>
                        </td>
                      </tr>
                      <tr class="text">
                        <td nowrap="nowrap">
                          <i18n:text>Last Name</i18n:text>
                          <xsl:text>:</xsl:text>
                          <xsl:call-template name="display_alert_mark"/>
                        </td>
                        <td nowrap="nowrap">
                          <input type="field" name="LAST_NAME" value="{LAST_NAME/@Value}" required="true" class="inputfieldIE" maxlength="32" size="27" tabIndex=""/>
                          <xsl:call-template name="display_alert_image">
                            <xsl:with-param name="fieldName" select="'LAST_NAME'"/>
                          </xsl:call-template>
                        </td>
                      </tr>
                      <tr class="text">
                        <td nowrap="nowrap">
                          <i18n:text>Organization</i18n:text>
                          <xsl:text>:</xsl:text>
                        </td>
                        <xsl:variable name="orgId">
                          <xsl:choose>
                            <xsl:when test="ORG_ID/@Value">
                              <xsl:value-of select="ORG_ID/@Value"/>
                            </xsl:when>
                          </xsl:choose>
                        </xsl:variable>
                        <td nowrap="nowrap">
                          <xsl:choose>
                            <xsl:when test=" ( (/RESPONSES/RESPONSE/IN_DOMAIN/@Access = 'All') and ( (string-length($viewMode) = 0) or ($viewMode != 'PREFERENCE') ) ) ">
                              <xsl:value-of select="$userOrgName"/>
                              <xsl:text>&#xA0;</xsl:text>
                              <input type="hidden" required="true" name="ORG_ID" value="{$userOrgID}"/>
                              <xsl:variable name="orgTitle">
                                <i18n:text>Get Organization</i18n:text>
                              </xsl:variable>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="$userOrgName"/>
                              <input type="hidden" name="ORG_ID" value="{$userOrgID}"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </td>
                      </tr>
                      <tr class="text">
                        <td nowrap="nowrap">
                          <i18n:text>User Group</i18n:text>
                          <xsl:text>:</xsl:text>
                        </td>
                        <td nowrap="nowrap">
                          <xsl:choose>
                            <xsl:when test="../VIEW_USER_GROUP_DETAILS/@Value = 'yes' ">
                                <xsl:value-of select="$userGroupName"/>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="$userGroupName"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </td>
                      </tr>
                      <tr class="text">
                        <td nowrap="nowrap">
                          <i18n:text>Phone</i18n:text>
                          <xsl:text>:</xsl:text>
                        </td>
                        <td nowrap="nowrap">
                          <input type="field" name="PHONE" value="{PHONE/@Value}" class="inputfieldIE" onkeyup="javascript:onlyValidCharacters(/[A-Za-z0-9]/)" maxlength="32" size="27" tabIndex=""/>
                        </td>
                      </tr>
                      <tr class="text">
                        <td nowrap="nowrap">
                          <i18n:text>Fax</i18n:text>
                          <xsl:text>:</xsl:text>
                        </td>
                        <td nowrap="nowrap">
                          <input type="field" name="FAX" value="{FAX/@Value}" class="inputfieldIE" onkeyup="javascript:onlyValidCharacters(/[A-Za-z0-9]/)" maxlength="32" size="27" tabIndex=""/>
                        </td>
                      </tr>
                      <tr class="text">
                        <td nowrap="nowrap">
                          <i18n:text>E-mail Address</i18n:text>
                          <xsl:text>:</xsl:text>
                          <xsl:call-template name="display_alert_mark"/>
                        </td>
                        <td nowrap="nowrap">
                          <input type="field" class="inputfieldIE" name="EMAIL_ADDRESS" value="{EMAIL_ADDRESS/@Value}" required="true" size="27" tabIndex="">
                          </input>
                          <xsl:call-template name="display_alert_image">
                            <xsl:with-param name="fieldName" select="'EMAIL_ADDRESS'"/>
                          </xsl:call-template>
                        </td>
                      </tr>
                      <tr class="text">
                        <td nowrap="nowrap">
                          <i18n:text>Address Line 1</i18n:text>
                          <xsl:text>:</xsl:text>
                          <xsl:call-template name="display_alert_mark"/>
                        </td>
                        <td nowrap="nowrap">
                          <input type="field" name="ADDRESS1" value="{ADDRESS1/@Value}" required="true" class="inputfieldIE" maxlength="32" size="27" tabIndex=""/>
                          <xsl:call-template name="display_alert_image">
                            <xsl:with-param name="fieldName" select="'ADDRESS1'"/>
                          </xsl:call-template>
                        </td>
                      </tr>
                    </table>
                  </td>
                  <!-- second column -->
                  <td>
                    <table border="0" cellpadding="0" cellspacing="9" width="50%" class="tablebackground">
                      <tr class="text">
                        <td nowrap="nowrap">
                          <i18n:text>Address Line 2</i18n:text>
                          <xsl:text>:</xsl:text>
                        </td>
                        <td nowrap="nowrap">
                          <input type="field" name="ADDRESS2" value="{ADDRESS2/@Value}" class="inputfieldIE" maxlength="32" size="27" tabIndex=""/>
                        </td>
                      </tr>
                      <tr class="text">
                        <td nowrap="nowrap">
                          <i18n:text>Address Line 3</i18n:text>
                          <xsl:text>:</xsl:text>
                        </td>
                        <td nowrap="nowrap">
                          <input type="field" name="ADDRESS3" value="{ADDRESS3/@Value}" class="inputfieldIE" maxlength="32" size="27" tabIndex=""/>
                        </td>
                      </tr>
                      <tr class="text">
                        <td nowrap="nowrap">
                          <i18n:text>City</i18n:text>
                          <xsl:text>:</xsl:text>
                          <xsl:call-template name="display_alert_mark"/>
                        </td>
                        <td nowrap="nowrap">
                          <input type="field" name="CITY" value="{CITY/@Value}" required="true" class="inputfieldIE" maxlength="32" size="27" tabIndex=""/>
                          <xsl:call-template name="display_alert_image">
                            <xsl:with-param name="fieldName" select="'CITY'"/>
                          </xsl:call-template>
                        </td>
                      </tr>
                      <tr class="text">
                        <td nowrap="nowrap">
                          <i18n:text>State</i18n:text>
                          <xsl:text>:</xsl:text>
                          <xsl:call-template name="display_alert_mark"/>
                        </td>
                        <td nowrap="nowrap">
                          <select class="inputfieldIE" name="STATE" required="true" tabIndex="">
                            <option value="">
                              <i18n:text>Select...</i18n:text>
                            </option>
                            <xsl:choose>
                              <xsl:when test="string-length(STATE/@Value) &gt; 0">
                                <xsl:apply-templates select="/RESPONSES/RESPONSE/STATES/CODE_MASTER_VALUE" mode="pulldown">
                                  <xsl:sort select="DISPLAY_TEXT/@Value"/>
                                  <xsl:with-param name="selectedId" select="STATE/@Value"/>
                                </xsl:apply-templates>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:apply-templates select="/RESPONSES/RESPONSE/STATES/CODE_MASTER_VALUE" mode="pulldown"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </select>
                          <xsl:call-template name="display_alert_image">
                            <xsl:with-param name="fieldName" select="'STATE'"/>
                          </xsl:call-template>
                        </td>
                      </tr>
                      <tr class="text">
                        <td nowrap="nowrap">
                          <i18n:text>Postal Code</i18n:text>
                          <xsl:text>:</xsl:text>
                          <xsl:call-template name="display_alert_mark"/>
                        </td>
                        <td nowrap="nowrap">
                          <input type="field" name="POSTAL_CODE" value="{POSTAL_CODE/@Value}" onkeyup="javascript:onlyValidCharacters(/[A-Za-z0-9]/)" required="true" class="inputfieldIE" size="27" maxlength="32" tabIndex=""/>
                          <xsl:call-template name="display_alert_image">
                            <xsl:with-param name="fieldName" select="'POSTAL_CODE'"/>
                          </xsl:call-template>
                        </td>
                      </tr>
                      <tr class="text">

                        <td nowrap="nowrap">
                          <i18n:text>Country</i18n:text>
                          <xsl:text>:</xsl:text>
                          <xsl:call-template name="display_alert_mark"/>
                        </td>
                        <td nowrap="nowrap">
                          <select class="inputfieldIE" name="COUNTRY" tabIndex="" required="true" onchange="javascript:refresh();">
                            <option value="">
                              <i18n:text>Select...</i18n:text>
                            </option>
                            <xsl:apply-templates select="/RESPONSES/RESPONSE/COUNTRIES/CODE_MASTER_VALUE" mode="pulldown">
                              <xsl:with-param name="selectedId">
                                <xsl:value-of select="/RESPONSES/RESPONSE/COUNTRIES/COUNTRY_DEFAULT/@Value"/>
                              </xsl:with-param>
                            </xsl:apply-templates>
                          </select>
                          <xsl:call-template name="display_alert_image">
                            <xsl:with-param name="fieldName" select="'COUNTRY'"/>
                          </xsl:call-template>
                        </td>
                      </tr>
                      <xsl:choose>
                        <xsl:when test=" $viewMode = 'PREFERENCE' and string-length($viewMode) &gt; 0 ">
                          <tr class="text">
                            <td nowrap="nowrap">
                              <i18n:text>Designation</i18n:text>
                              <xsl:text>:</xsl:text>
                            </td>
                            <td nowrap="nowrap">
                              <xsl:variable name="valueId">
                                <xsl:value-of select="DESIGNATION/@Value"/>
                              </xsl:variable>
                              <xsl:choose>
                                <xsl:when test=" string-length($valueId) &gt; 0 ">
                                  <i18n:text>
                                    <xsl:value-of select="/RESPONSES/RESPONSE/DESIGNATIONS/CODE_MASTER_VALUE[ VALUE_ID/@Value = $valueId ]/DESCRIPTION/@Value"/>
                                  </i18n:text>
                                  <input type="hidden" name="DESIGNATION" Value="{$valueId}"/>
                                </xsl:when>
                                <xsl:otherwise>
                                  <i18n:text>N/A</i18n:text>
                                </xsl:otherwise>
                              </xsl:choose>
                            </td>
                          </tr>
                        </xsl:when>
                        <xsl:otherwise>
                          <tr class="text">
                            <td nowrap="nowrap">
                              <i18n:text>Designation</i18n:text>
                              <xsl:text>:</xsl:text>
                            </td>
                            <td nowrap="nowrap">
                              <xsl:variable name="designation">
                                <xsl:value-of select="DESIGNATION/@Value"/>
                              </xsl:variable>
                              <select class="inputfieldIE" name="DESIGNATION" tabIndex="" width="27">
                                <option value="">
                                  <i18n:text>Select...</i18n:text>
                                </option>
                                <xsl:for-each select="/RESPONSES/RESPONSE/DESIGNATIONS/CODE_MASTER_VALUE">
                                  <xsl:sort select="DESCRIPTION/@Value"/>
                                  <xsl:choose>
                                    <xsl:when test="$designation = VALUE_ID/@Value">
                                      <option value="{VALUE_ID/@Value}" selected="true">
                                        <i18n:text>
                                          <xsl:value-of select="DESCRIPTION/@Value"/>
                                        </i18n:text>
                                      </option>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <option value="{VALUE_ID/@Value}">
                                        <i18n:text>
                                          <xsl:value-of select="DESCRIPTION/@Value"/>
                                        </i18n:text>
                                      </option>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </xsl:for-each>
                              </select>
                            </td>
                          </tr>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:choose>
                        <xsl:when test=" $viewMode = 'PREFERENCE' and string-length($viewMode) &gt; 0 ">
                          <tr class="text">
                            <td nowrap="nowrap">
                              <i18n:text>Manager</i18n:text>
                              <xsl:text>:</xsl:text>
                            </td>
                            <td nowrap="nowrap">
                              <xsl:variable name="managerId">
                                <xsl:value-of select="MANAGER_ID/@Value"/>
                              </xsl:variable>
                              <xsl:choose>
                                <xsl:when test=" string-length($managerId) &gt; 0 ">
                                  <i18n:text>
                                    <xsl:value-of select="/RESPONSES/RESPONSE/USER_PROFILES/USER_PROFILE[ ID/@Value = $managerId ]/LOGIN_NAME/@Value"/>
                                  </i18n:text>
                                  <input type="hidden" name="MANAGER_ID" Value="{$managerId}"/>
                                </xsl:when>
                                <xsl:otherwise>
                                  <i18n:text>N/A</i18n:text>
                                </xsl:otherwise>
                              </xsl:choose>
                            </td>
                          </tr>
                        </xsl:when>
                        <xsl:otherwise>
                          <tr class="text">
                            <td nowrap="nowrap">
                              <i18n:text>Manager</i18n:text>
                              <xsl:text>:</xsl:text>
                            </td>
                            <xsl:variable name="managerId">
                              <xsl:value-of select="MANAGER_ID/@Value"/>
                            </xsl:variable>
                            <td nowrap="nowrap">
                              <select class="inputfieldIE" name="MANAGER_ID" tabindex="">
                                <option value="">
                                  <i18n:text>Select...</i18n:text>
                                </option>
                                <xsl:for-each select="/RESPONSES/RESPONSE/USER_PROFILES/USER_PROFILE">
                                  <xsl:sort select="LOGIN_NAME/@Value"/>
                                  <xsl:choose>
                                    <xsl:when test="$managerId = ID/@Value">
                                      <option value="{ID/@Value}" selected="true">
                                        <i18n:text>
                                          <xsl:value-of select="LOGIN_NAME/@Value"/>
                                        </i18n:text>
                                      </option>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <option value="{ID/@Value}">
                                        <i18n:text>
                                          <xsl:value-of select="LOGIN_NAME/@Value"/>
                                        </i18n:text>
                                      </option>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </xsl:for-each>
                              </select>
                            </td>
                          </tr>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:choose>
                        <xsl:when test=" $viewMode = 'PREFERENCE' and string-length($viewMode) &gt; 0 ">
                          <tr class="text">
                            <td nowrap="nowrap">
                              <i18n:text>Absentee</i18n:text>
                              <xsl:text>:</xsl:text>
                            </td>
                            <td nowrap="nowrap">
                              <xsl:variable name="absenteeId">
                                <xsl:value-of select="ABSENTEE_ID/@Value"/>
                              </xsl:variable>
                              <xsl:choose>
                                <xsl:when test=" string-length($absenteeId) &gt; 0 ">
                                  <i18n:text>
                                    <xsl:value-of select="/RESPONSES/RESPONSE/USER_PROFILES/USER_PROFILE[ ID/@Value = $absenteeId ]/LOGIN_NAME/@Value"/>
                                  </i18n:text>
                                  <input type="hidden" name="ABSENTEE_ID" Value="{$absenteeId}"/>
                                </xsl:when>
                                <xsl:otherwise>
                                  <i18n:text>N/A</i18n:text>
                                </xsl:otherwise>
                              </xsl:choose>
                            </td>
                          </tr>
                        </xsl:when>
                        <xsl:otherwise>
                          <tr class="text">
                            <td nowrap="nowrap">
                              <i18n:text>Absentee</i18n:text>
                              <xsl:text>:</xsl:text>
                            </td>
                            <xsl:variable name="absenteeId">
                              <xsl:value-of select="ABSENTEE_ID/@Value"/>
                            </xsl:variable>
                            <td nowrap="nowrap">
                              <select class="inputfieldIE" name="ABSENTEE_ID" tabindex="">
                                <option value="">
                                  <i18n:text>Select...</i18n:text>
                                </option>
                                <xsl:for-each select="/RESPONSES/RESPONSE/USER_PROFILES/USER_PROFILE">
                                  <xsl:sort select="LOGIN_NAME/@Value"/>
                                  <xsl:choose>
                                    <xsl:when test="$absenteeId = ID/@Value">
                                      <option value="{ID/@Value}" selected="true">
                                        <xsl:value-of select="LOGIN_NAME/@Value"/>
                                      </option>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <option value="{ID/@Value}">
                                        <xsl:value-of select="LOGIN_NAME/@Value"/>
                                      </option>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </xsl:for-each>
                              </select>
                            </td>
                          </tr>
                        </xsl:otherwise>
                      </xsl:choose>
                      <tr class="text">
                        <xsl:variable name="locale">
                          <xsl:choose>
                            <xsl:when test="LOCALE/@Value">
                              <xsl:value-of select="LOCALE/@Value"/>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="/RESPONSES/RESPONSE/LOCALES/LOCALE_DEFAULT/@Value"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:variable>
                        <td nowrap="nowrap">
                          <i18n:text>Locale</i18n:text>
                          <xsl:text>:</xsl:text>
                          <xsl:call-template name="display_alert_mark"/>
                        </td>
                        <td nowrap="nowrap">
                          <select class="inputfieldIE" name="LOCALE" required="true" tabIndex="" width="27">
                            <option value="">
                              <i18n:text>Select...</i18n:text>
                            </option>
                            <xsl:apply-templates select="/RESPONSES/RESPONSE/LOCALES/CODE_MASTER_VALUE" mode="pulldown">
                              <xsl:with-param name="selectedId">
                                <xsl:value-of select="$locale"/>
                              </xsl:with-param>
                            </xsl:apply-templates>
                          </select>
                          <xsl:call-template name="display_alert_image">
                            <xsl:with-param name="fieldName" select="'LOCALE'"/>
                          </xsl:call-template>
                        </td>
                        <input type="hidden" name="userLocale" value="{$locale}"/>
                      </tr>
                      <tr class="text">
                        <td/>
                      </tr>
                      <tr class="text"/>
                      <tr class="text"/>
                    </table>
                  </td>
                </tr>
              </table>
            </i2:container>
          </td>
        </tr>
      </form>
    </table>

    <!-- java script -->
    <script><![CDATA[
	function GoToUserGroup(){
	  document.forms.user_form.action = omxContextPath + '/omx/user_admin/user_group_details/getUserGroupDetails.cmd?WHERE=USER_GROUP_MAIN';
	  document.forms.user_form.submit();
	}
	
	function saveAs()
	{
		error = "false";
		error = requiredFieldCheck();
		if ( error == 'false' ) {
			]]>
				<xsl:if test="not(( string-length(ID/@Value) > 0 ) or ( $viewMode='PREFERENCE'))">
					<![CDATA[
					if(document.user_form.PASSWORD.value != document.user_form.PASSWORD1.value) {
						core_alert("]]><i18n:text>UserSecurity.Passwords_Mismatch</i18n:text><![CDATA[");
						return;
					}
					]]>
				</xsl:if>
			<![CDATA[
			document.user_form.action="users_edit/addUserProfile.cmd";
			document.user_form.submit();
		}
		return;
	}        

	function activate() 
	{
		document.user_form.WHERE.value = 'USER_DETAILS';
		document.user_form.action="users_edit/activateUser.cmd";
		document.user_form.submit();
	}
		
	function deactivate() 
	{
		document.user_form.WHERE.value = 'USER_DETAILS';
		document.user_form.action="users_edit/deactivateUser.cmd";
		document.user_form.submit();
	}

	function resetUserDetails() 
	{
		document.user_form.WHERE.value = 'USER_DETAILS';
		document.user_form.action="users_edit/resetUserDetails.cmd";
		document.user_form.submit();
	}

	function onCancel() 
	{
		document.user_form.WHERE.value = 'USER_DETAILS';
		document.user_form.action="users_edit/onCancel.cmd";
		document.user_form.submit();
	}
	
	function save()
	{
		error = "false";
		error = requiredFieldCheck();
		if ( error == 'false' )
		{
			if(document.user_form.userLocale.value != "" && 
				document.user_form.userLocale.value != document.user_form.LOCALE.options[document.user_form.LOCALE.selectedIndex].value)
			{
				core_alert("LOCALE_ALERT");
			}
			document.user_form.WHERE.value = 'USER_DETAILS';
			document.user_form.action="users_edit/updateUserProfile.cmd";
			document.user_form.submit();
		}
	  	return;
	}		
	
	function refresh()
	{
		if(document.user_form.COUNTRY.selectIndex != 0) {
			document.user_form.action="../../omx/common/reload.cmd";
		  	document.user_form.submit();
		}
	}

	function changePassword(user_form)
	{
		document.user_form.CHANGE_PASSWD.value = "yes";
		document.user_form.action= omxContextPath + "/omx/user_admin/users_edit/changePasswordFromMyProfile.cmd";
		document.user_form.submit();
	}
	
	function SetfocusSubmit( target )
	{
	]]>
		<xsl:choose>
			<xsl:when test="/RESPONSES/RESPONSE/WHERE/@Value = 'NEW_USERS' and string-length(ID/@Value) = 0 ">
				<![CDATA[ saveAs();]]>
			</xsl:when>
			<xsl:otherwise>
				<![CDATA[ 				
				save();]]>
			</xsl:otherwise>
		</xsl:choose>
	<![CDATA[
    } 
    ]]></script>
  </xsl:template>

  <!-- **********************************************************************
   *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {
      requiredFieldCheck('onLoad');
    }
  </xsl:template>
  
</xsl:stylesheet>