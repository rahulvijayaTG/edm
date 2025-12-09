<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:import href="../../core/xsl/page.xsl"/>
  <xsl:import href="../../core/xsl/container.xsl"/>
  <xsl:import href="../../core/xsl/table.xsl"/>
  <xsl:import href="../../core/xsl/validation.xsl"/>
  <xsl:import href="../../core/search/xsl/search.xsl"/>
  <xsl:import href="../../core/xsl/buttons.xsl"/>
<!--
  These are imported implicitly
  <xsl:import href="../../core/xsl/links.xsl"/>
  <xsl:import href="../../core/xsl/page_header.xsl"/>
  <xsl:import href="../../core/xsl/table_field.xsl"/>
  <xsl:import href="../../core/xsl/buttons.xsl"/>
  <xsl:import href="../../core/xsl/pagination.xsl"/>
  <xsl:import href="../../core/xsl/header.xsl"/>
  <xsl:import href="../../core/xsl/footer.xsl"/>
  <xsl:import href="../../core/xsl/wizard.xsl"/>
  <xsl:import href="../../core/xsl/tabs.xsl"/>
 -->

  <xsl:output method="html"/>

  <xsl:variable name="target"/>

  <!-- Page Content -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <i2:javascript path="/page.js"></i2:javascript>

    <!-- Is this Javascript dump still needed? -->
    <xsl:apply-templates select="RESPONSE/JAVASCRIPT"/>

    <script>
       // used by other, non-standard forms which allows you to pass the form name manually
       function submitForm(formName, action, target)
       {
         var formObj = eval('document.' + formName);
         formObj.action = action;
         if (target != null)
         {
           formObj.target = target;
         }
         formObj.submit();
       }

      // Pagination
      function getRecords(actionName, startCount, search_form, page_form)
      {
          if(page_form == null)  page_form = form;
          if(page_form == null)  page_form = form;

          if(search_form == null)  search_form = document.form;

          jumpTo(actionName, startCount, null, page_form);
      }

     </script>


    <xsl:apply-templates select="RESPONSE" mode="top"/>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="top">
    <xsl:apply-templates select="FORM|CONTAINER|GRID" mode="top"/>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FORM" mode="top">
    <form name="{@Name}" method="{@method}" action="{@Action}" target="{@Target}">
      <xsl:apply-templates select="CONTAINER">
        <xsl:with-param name="content" select="CONTAINER/STEP"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="FIELDS" mode="layout"/>
    </form>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="CONTAINER" mode="top">
    <xsl:apply-templates select=".">
      <xsl:with-param name="content" select="STEP"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="GRID" mode="top">
    <xsl:apply-templates select="."/>
  </xsl:template>


  <!-- **********************************************************************
      *********************************************************************** -->
   <xsl:template match="FORM" mode="layout">
     <form name="{@Name}" method="{@method}" action="{@Action}" target="{@Target}">
       <xsl:apply-templates select="CONTAINER">
   <xsl:with-param name="content" select="CONTAINER/STEP"/>
       </xsl:apply-templates>
       <xsl:apply-templates select="FIELDS" mode="layout"/>
     </form>
   </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="CONTAINER">
    <xsl:param name="content" select="/RESPONSES"/>


    <xsl:choose>
      <!-- Container -->
      <xsl:when test="(@Hide = 'true')  or (count(STEP) = 1 and( string-length(@Force) = 0  or @Force !='true'))">
        <xsl:apply-templates select="." mode="container">
          <xsl:with-param name="content" select="$content"/>
        </xsl:apply-templates>
      </xsl:when>
      <!-- wizard -->
      <xsl:when test="@Type = 'Wizard'">
        <xsl:apply-templates select="." mode="wizard">
          <xsl:with-param name="content" select="$content"/>
        </xsl:apply-templates>
      </xsl:when>
      <!-- tabs -->
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="tabs">
          <xsl:with-param name="content" select="$content"/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="SEARCH">

    <!-- Javascript -->
    <xsl:call-template name="include_javascript_search"/>

    <!-- Search Form -->
    <!--xsl:apply-templates select="FORM"/-->


    <!-- Javascript -->
    <i2:javascript path="/calendar.js"></i2:javascript>
    <xsl:call-template name="include_javascript_validation">
    </xsl:call-template>

    <xsl:variable name="cellspacing">
      <xsl:choose>
        <xsl:when test="@Type= 'Hidden'">0</xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="label">
      <xsl:choose>
        <xsl:when test="string-length(@DisplayText) > 0">
          <i18n:text>
            <xsl:value-of select="@DisplayText"/>
          </i18n:text>
        </xsl:when>
        <xsl:otherwise>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <!-- Form -->
    <table width="100%" cellspacing="{$cellspacing}" cellpadding="0" border="0">
      <form name="{@Name}" method="{@method}" action="{@Action}" target="{@Target}">
        <tr>
          <td>
            <xsl:choose>
              <xsl:when test="@Type= 'Hidden'">
              </xsl:when>
              <xsl:otherwise>
                <i2:container collapsable="{@Collapsable}" title="{$label}" inner="yes" scrollable="yes" id="search_form_container">

                  <xsl:apply-templates select="." mode="validation_area"/>

                  <!-- Fields -->
                    <!-- Simple Fields -->
                    <xsl:apply-templates select="FIELDS" mode="layout"/>

                  <!-- Footer -->
                  <i2:footer>
                    <xsl:apply-templates select="BUTTONS"/>
                  </i2:footer>

                </i2:container>
              </xsl:otherwise>
            </xsl:choose>
            <!-- Container -->


            <!-- Hidden Fields -->
            <xsl:choose>
              <xsl:when test="FIELD[@Name = 'SEARCH_TYPE']/@Value = 'Advanced'">
                <xsl:for-each select="FIELD[@Type='Hidden' and (@Visibility = 'Advanced' or @Visibility = 'Simple' or string-length(@Visibility) =  0 or @Visibility = 'AdvancedOnly' )]">
                  <input name="{@Name}" type="hidden" value="{@Value}"/>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select="FIELD[@Type='Hidden' and (@Visibility = 'Simple' or string-length(@Visibility) =  0 or @Visibility = 'SimpleOnly' )]">
                  <input name="{@Name}" type="hidden" value="{@Value}"/>
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>

          </td>
        </tr>
      </form>
    </table>




    <!-- Search Error -->
    <xsl:apply-templates select="REPORT/_ERROR"/>

    <!-- Search Report

    <xsl:apply-templates select="REPORT/TABLE"/> -->

  </xsl:template>


  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="CONTAINER" mode="top">
    <xsl:apply-templates select=".">
      <xsl:with-param name="content" select="STEP"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="GRID" mode="top">
    <xsl:apply-templates select="."/>

  </xsl:template>


 <!-- Container Content -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="STEP" mode="container_content">

   <xsl:apply-templates select="VALIDATION" mode="validation_area"/>

    <table cellpadding="0" cellspacing="2" border="0" width="100%">

      <!-- To handle container within another container -->
      <xsl:for-each select="CONTAINER">
        <tr>
          <td>
            <xsl:apply-templates select=".">
              <xsl:with-param name="content" select="STEP"/>
            </xsl:apply-templates>
          </td>
        </tr>
      </xsl:for-each>

      <!-- Other Layouts -->
      <xsl:if test="SEARCH|GRID|FIELDS|REPORT|FORM">
      <tr>
        <td>
          <xsl:apply-templates select="SEARCH|GRID|FIELDS|REPORT|FORM" mode="layout"/>
        </td>
      </tr>
      </xsl:if>

    </table>

  </xsl:template>




   <!-- **********************************************************************
   *********************************************************************** -->
   <xsl:template match="VALIDATION" mode="validation_area">
       <xsl:call-template name="display_validation_area">
         <xsl:with-param name="pFormName" select="'search_form'"/>
         <xsl:with-param name="pAnyFieldIsRequired" select="@AnyFieldIsRequired"/>
         <xsl:with-param name="pAnyFieldHasErrors" select="@AnyFieldHasErrors"/>
         <xsl:with-param name="pSuccessMessage" select="_SUCCESS_MSG/@Value"/>
         <xsl:with-param name="pErrorMessage"><xsl:value-of select="'DUMMY'"/></xsl:with-param>
       </xsl:call-template>
   </xsl:template>
  <!-- **********************************************************************
      *********************************************************************** -->
      <xsl:template name="display_form_error_message">
        <xsl:param name="pFormName"/>

        <xsl:for-each select="_ERRORS/_ERROR">
          <tr id="error_message{$pFormName}">
            <td align="center">
              <i2:img src="/alert_static_small.gif" border="0" align="middle">
                <i2:attribute name="alt"><i18n:text>Error</i18n:text></i2:attribute>
              </i2:img>
            </td>
            <td width="100%">
                <xsl:if test="@Description">
                  <i18n:text><xsl:value-of select="@Description"/></i18n:text>&#xA0;
                </xsl:if>

                <i18n:text><xsl:value-of select="@Value"/></i18n:text>
            </td>
          </tr>
        </xsl:for-each>

      </xsl:template>


  <!-- CURRENTLY OVERRIDDEN -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="FIELDS" mode="layout">
    <table border="0" cellpadding="2" cellspacing="2" width="100%" height="100%">
      <xsl:choose>
        <xsl:when test="count(ROW) > 0">
          <xsl:apply-templates select="ROW" mode="layout_row"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="*" mode="layout_column"/>
        </xsl:otherwise>
      </xsl:choose>
    </table>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="*" mode="layout_column">
    <tr>
      <xsl:apply-templates select="." mode="label_form"/>
      <xsl:apply-templates select="." mode="content"/>
      <td width="50%"></td>
    </tr>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="ROW" mode="layout_row">
    <tr>
      <xsl:apply-templates mode="layout_row"/>
    </tr>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="*" mode="layout_row">
    <xsl:apply-templates select="." mode="label_form"/>
    <xsl:apply-templates select="." mode="content"/>
    <td width="50%"></td>
  </xsl:template>


  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="BUTTON" mode="content">
    <td nowrap="yes"><xsl:apply-templates select="."/></td>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="BUTTON" mode="label_form">
    <td nowrap="yes"></td>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_VR" mode="content">
    <td nowrap="yes" class="rightBorder">&#xA0;</td>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="SEARCH" mode="layout">
    <xsl:apply-templates select="."/>
  </xsl:template>

  <!-- **********************************************************************
   *********************************************************************** -->
   <xsl:template match="REPORT" mode="layout">
     <xsl:choose>
       <xsl:when test="TABLE/@WrapInForm='true'">
         <xsl:apply-templates select="TABLE"/>
       </xsl:when>
       <xsl:otherwise>
         <xsl:apply-templates select="TABLE" mode="no_forms"/>
       </xsl:otherwise>
     </xsl:choose>
   </xsl:template>


  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="GRID" mode="layout">
    <xsl:apply-templates select="."/>
  </xsl:template>

  <!-- Need to add this template to core/xsl. -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="JAVASCRIPT">
    <xsl:for-each select="LINK">
      <script type="text/javascript" src="{@Value}"></script>
    </xsl:for-each>

    <script>
      <xsl:value-of select="SOURCE"/>
    </script>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="GRID">
    <table width="100%">
      <xsl:for-each select="ROW">
        <tr>
          <xsl:for-each select="CELL">
            <td>
              <xsl:if test="@Class">
                <xsl:attribute name="class"><xsl:value-of select="@Class"/></xsl:attribute>
              </xsl:if>
              <xsl:if test="@ColSpan">
                <xsl:attribute name="colspan"><xsl:value-of select="@ColSpan"/></xsl:attribute>
              </xsl:if>
              <xsl:if test="@RowSpan">
                <xsl:attribute name="rowspan"><xsl:value-of select="@RowSpan"/></xsl:attribute>
              </xsl:if>
              <xsl:choose>
                <xsl:when test="CONTAINER">
                  <xsl:apply-templates select="CONTAINER">
                    <xsl:with-param name="content" select="CONTAINER/STEP"/>
                  </xsl:apply-templates>
                </xsl:when>
                <xsl:when test="FIELDS">
                  <xsl:apply-templates select="FIELDS" mode="layout"/>
                </xsl:when>
                <xsl:when test="T_FIELD">
                  <xsl:apply-templates select="T_FIELD" mode="content"/>
                </xsl:when>
                <xsl:when test="T_FIELD_E_INPUT">
                  <xsl:apply-templates select="T_FIELD_E_INPUT" mode="content"/>
                </xsl:when>
                <xsl:when test="T_FIELD_LK">
                  <xsl:apply-templates select="T_FIELD_LK" mode="content"/>
                </xsl:when>
                <xsl:when test="T_FIELD_VR">
                  <xsl:apply-templates select="T_FIELD_VR" mode="content"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates/>
                </xsl:otherwise>
              </xsl:choose>
            </td>
          </xsl:for-each>
        </tr>
      </xsl:for-each>
    </table>

  </xsl:template>

 <!--  Label - form-->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="*" mode="label_form">
    <td nowrap="yes">
      <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text><xsl:if test="string-length(@DisplayText) > 0">:</xsl:if>
      <xsl:if test="@Required = 'true' and @Editable='true'">
        <xsl:call-template name="display_required_field_indicator"/>
      </xsl:if>
    </td>
  </xsl:template>

  <!-- page.xsl Javascript -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {
    <xsl:call-template name="javascript_onLoad_page"/>
    scrollHelper();
    }
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="onResize_js">
    function onResize()
    {
    <xsl:call-template name="javascript_onResize_page"/>
    scrollHelper();
    }
  </xsl:template>

</xsl:stylesheet>
