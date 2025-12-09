<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n" version="1.0">

  <!-- ****************************************************
   ****************************************************-->
   <xsl:template name= "authScopeSelectOption">
       <xsl:param name="authDetails"/>
       <xsl:param name="formName"/>
       <xsl:param name="formName"/>
        <table border="0" cellpadding="2" cellspacing="0">
         <tr>
           <xsl:apply-templates select="$authDetails/USER_AUTH_SCOPE/AUTH_DOCS/AUTH_DOC">
             <xsl:with-param name="currentUserAuthScope" select="$authDetails/CURR_USER_AUTH_SCOPE"/>
             <xsl:with-param name="isAdminType" select="$authDetails/USER_AUTH_SCOPE/@IsAdminType"/>
             <xsl:with-param name="formName" select="$formName"/>
           </xsl:apply-templates>
         </tr>
        </table>
       <xsl:call-template name="include_javascript"/>
     </xsl:template>
  <!-- ****************************************************
   ****************************************************-->
      <xsl:template match="AUTH_DOC">
        <xsl:param name="currentUserAuthScope"/>
        <xsl:param name="isAdminType"/>
        <xsl:param name="formName"/>
        <td>
          <table border="0"  bordercolor="red" cellpadding="2" cellspacing="0">
          <tr>
            <td align="left">
              <i18n:text><xsl:value-of select="./@DisplayName"/></i18n:text>:
            </td>
            <td align="left">
              <xsl:variable name="onChangeAction" select="concat('javascript:onScopeSelected(' , ' ' , 'this' , ' , ' , 'document.' , $formName , ' )' )"/>
<!--
              <xsl:value-of select="$onChangeAction"/>
-->
              <select class="inputfieldIE" name="selectedAuthScope" onchange="{$onChangeAction}">
                  <!-- This is commented but may be required in future ....
                <xsl:if test=" $isAdminType = 'Yes' or $isAdminType = 'yes' ">
                  <option value="#">All</option>
                 </xsl:if>
                 -->
                <xsl:apply-templates select="AUTH_ID">
                  <xsl:with-param name="currentUserAuthScope" select="$currentUserAuthScope"/>
                </xsl:apply-templates>
              </select>
            </td>
          </tr>
        </table>
        </td>
      </xsl:template>
  <!-- ****************************************************
   ****************************************************-->
      <xsl:template match="AUTH_ID">
        <xsl:param name="currentUserAuthScope"/>

        <xsl:variable name="tempVar" />

        <xsl:variable name="optionText">
          <xsl:for-each select="./*">
            <xsl:value-of select="concat($tempVar , '' , ./@Value)"/>
          </xsl:for-each>
        </xsl:variable>

        <xsl:variable name="optionValue" select="@Key" />

        <xsl:choose>
          <xsl:when test="$currentUserAuthScope/AUTH_SCOPE[ $optionValue = @Value ]">
            <option selected="yes" value="{$optionValue}">
                <i18n:text><xsl:value-of select="$optionText"/></i18n:text>
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option value="{$optionValue}">
              <i18n:text><xsl:value-of select="$optionText"/></i18n:text>
            </option>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:template>
<!-- ****************************************************
 ****************************************************-->
  <xsl:template name="include_javascript">
  <script>

    function onScopeSelected(authSelect , thisForm){

      var newAuthScope = authSelect.options[authSelect.selectedIndex].value;
      thisForm.SELECTED_AUTH_SCOPE.value = authSelect.options[authSelect.selectedIndex].value ;

      dispatchSearch();
    }

  </script>
  </xsl:template>
  </xsl:stylesheet>


