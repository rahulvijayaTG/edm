<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  <!-- 
    TODO TR_FOOTER
         T_FIELD_FOOTER
   -->
  <!-- Header - of UnEditable Col -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="T_FIELD_HR" mode="content">
    <td nowrap="yes" align="left">
      <xsl:value-of select="@Value"/>
    </td>  
  </xsl:template>

  <!-- Header - of Sortable Col-->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="T_FIELD_HR[@Sortable ='yes']" mode="content">
    <td nowrap="yes" align="left">
      <a onmouseover="javascript:i2uiSetMenuCoords(this,event)">
        <xsl:attribute name="href">
          <xsl:variable name="quote">'</xsl:variable>
          <xsl:value-of select="concat('javascript:sort(', $quote, @Name, $quote, ')' )"/>
        </xsl:attribute>
        <xsl:value-of select="@Value"/>
      </a>
      <xsl:if test="@Sorted">
        <b>
        <xsl:choose>
            <xsl:when test="(@Sorted) = 'Descending'">
              &#xA0;&#xA0;&#xA0;<i2:img src="/descending_table_column.gif"/>
          </xsl:when>
          <xsl:otherwise>
            &#xA0;&#xA0;&#xA0;&#xA0;<i2:img src="/ascending_table_column.gif"/>
          </xsl:otherwise>
        </xsl:choose>
        </b>
      </xsl:if>
    </td>  
  </xsl:template>

  <!-- Header - of Editable Col-->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="T_FIELD_HR_E" mode="content">
    <td nowrap="yes" align="left">
      <xsl:value-of select="@Value"/>
    <xsl:if test="@Required = 'true'">
      <font color="red">*</font>
    </xsl:if>   
    </td>  
  </xsl:template>
  

  <!-- Row Selector -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="ROW_SELECTOR" mode="content">
    <i2:rowselector checked="{@Checked}" select="{@Select}" name="{@Name}" value="{@Value}" global="{@Header}">
    </i2:rowselector>
  </xsl:template>

 <xsl:template match="ROW_SELECTOR[@Header and @Select='single']" mode="content">
   <td nowrap="yes"></td>
  </xsl:template>

  <!-- Field  - Hidden-->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="T_FIELD_HN" mode="content">
    <input name="{@Name}" type="hidden" value="{@Value}"/>
  </xsl:template>
  

  <!-- Field  - Uneditable-->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="T_FIELD" mode="content">
    <td nowrap="yes" align="{@Align}">
      <xsl:value-of select="@Value"/>
      <xsl:apply-templates select="LINKS/LINK" mode="field_link"/>
      <xsl:apply-templates select="_ERRORS" mode="icon_tip"/>

    </td>  
  </xsl:template>
    
 <!-- Field  - Uom - Uneditable-->
 <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="T_FIELD_UOM" mode="content">
    <td nowrap="yes" align="{@Align}">
      <xsl:value-of select="@Value"/>
       &#xa0;<i18n:text><xsl:value-of select="@Uom"/></i18n:text>
    </td>  
  </xsl:template>
  <!-- Field - Uneditable - Linked -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="T_FIELD_LK" mode="content">
    <td nowrap="yes" align="{@Align}">
      <a>
        <xsl:attribute name="href">
          <xsl:choose>
            <xsl:when test="@OnClickType = 'popup'">javascript:popUpWindow('<xsl:value-of select="@Url"/>','<xsl:value-of select="@PopupName"/>')</xsl:when>
            <xsl:otherwise><xsl:value-of select="@Url"/>&amp;RET_PAGE=<xsl:value-of select="$currentUrl"/></xsl:otherwise>
          </xsl:choose>          
        </xsl:attribute>

        <xsl:attribute name="target">
          <xsl:choose>
            <xsl:when test="@Target"><xsl:value-of select="@Target"/></xsl:when>
            <xsl:otherwise>appFrame</xsl:otherwise>
          </xsl:choose>  
        </xsl:attribute>
                    
        <xsl:value-of select="@Value"/>
      </a>
      
    </td>  
  </xsl:template>
  
  <!-- Field - Image Linked -->
   <!-- ********************************************************************** 
       *********************************************************************** -->
 <xsl:template match="T_FIELD_IMG_LK" mode="content">
  <td align="center" nowrap="yes">
  <xsl:variable name="title"><i18n:text><xsl:value-of select="@Alt"/></i18n:text></xsl:variable>
  <xsl:variable name="onclick">
    <xsl:choose>
      <xsl:when test="@OnClickType = 'popup'">javascript:popUpWindow('<xsl:value-of select="@Url"/>','<xsl:value-of select="@PopupName"/>')</xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@Url"/>&amp;RET_PAGE=<xsl:value-of select="$currentUrl"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <a href="{$onclick}" title="{$title}">
      <xsl:if test="@Src">
        <i2:img src="{@Src}" width="16" height="16" border="0" id="test"/>
      </xsl:if>
  </a>
  </td>
  </xsl:template>

  
  <!-- Field - Input -->  
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template match="T_FIELD_E_INPUT" mode="content">

    <td nowrap="yes" align="left">
      <input name="{@InputName}"  value="{@Value}" fieldtype="{@Type}" size="{@Size}" maxlength="{@MaxLength}" type="field" class="inputfieldIE">

        <!-- isRequired -->
        <xsl:if test="@Required = 'true'">
          <xsl:attribute name="required">
            <xsl:value-of select="'true'"/>
          </xsl:attribute>
        </xsl:if>

        <!-- hasErrors -->
        <xsl:if test="_ERRORS">
          <xsl:attribute name="validationmsg">
            <xsl:value-of select="'error'"/>
          </xsl:attribute>
        </xsl:if>
      </input>                 

      <!-- Required Icon  -->
      <xsl:if test="@Required = 'true'">
        <xsl:call-template name="display_alert_image">
          <xsl:with-param name="fieldName" select="@InputName"/>
        </xsl:call-template>
      </xsl:if>   

      <!-- Type Validation Icon -->
      <xsl:variable name="quote">'</xsl:variable>
       &#xA0;<i2:img onclick="{concat('javascript:core_alert(',$quote, @ValidationMsg, $quote,')')}" id="{@InputName}_ERR" src="/alert_static_small.gif" border="0" align="middle"  hidden="yes">
        <i2:attribute name="alt">
          <i18n:text><xsl:value-of select="@ValidationMsg"/></i18n:text>
        </i2:attribute>
       </i2:img>

      <!-- Link Icons -->
      <xsl:apply-templates select="LINKS/LINK" mode="field_link"/>

      <!-- Error Icon (!) -->
      <xsl:apply-templates select="_ERRORS" mode="icon_tip"/>
      
      <xsl:apply-templates select="." mode="my_children"/>

     </td>  
  </xsl:template>

  <xsl:template name="display_alert_image">
  </xsl:template>

  <!-- PHONE --> 
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="T_FIELD_PHONE" mode="content">
    <td align="left" nowrap="yes"> 
      (<xsl:value-of select="substring(@Value,1,3)" />)&#xA0;<xsl:value-of select="substring(@Value,4,3)"/>&#xA0;-&#xA0;<xsl:value-of 	select="substring(@Value,7,4)"/>
    </td>
  </xsl:template>
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="T_FIELD_E_PHONE" mode="content">
    <td align="left" nowrap="yes">
      (<input fieldtype="{@Type}" name="{concat(@Name,'_AREA_CODE')}" value="{substring(@Value,1,3)}" type="field" class="inputfieldIE" size="3"/>)&#xA0;<input fieldtype="{@Type}" name="{concat(@Name,'_LOCAL_NUM_1')}" value="{substring(@Value,4,3)}" type="field" class="inputfieldIE" size="3"/>&#xA0;-&#xA0;<input fieldtype="{@Type}" name="{concat(@Name,'_LOCAL_NUM_2')}" value="{substring(@Value,7,4)}" type="field" class="inputfieldIE" size="4"/>
    </td>
  </xsl:template>


  <!-- Field - Uneditable - Linked -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="T_TREEFIELD_LK" mode="content">
    <i2:treecell column="{TREECELL/@Column}" depth="{TREECELL/@Depth}" nochildren="{TREECELL/@NoChildren}">
      <a>
        <xsl:attribute name="href">
          <xsl:choose>
            <xsl:when test="@OnClickType = 'popup'">javascript:popUpWindow('<xsl:value-of select="@Url"/>','<xsl:value-of select="@PopupName"/>')</xsl:when>
            <xsl:otherwise><xsl:value-of select="@Url"/>&amp;RET_PAGE=<xsl:value-of select="$currentUrl"/></xsl:otherwise>
          </xsl:choose>          
        </xsl:attribute>

        <xsl:attribute name="target">
          <xsl:choose>
            <xsl:when test="@Target"><xsl:value-of select="@Target"/></xsl:when>
            <xsl:otherwise>appFrame</xsl:otherwise>
          </xsl:choose>  
        </xsl:attribute>
                    
        <xsl:value-of select="@Value"/>
      </a>
      
    </i2:treecell>


    </xsl:template>


    <!-- Option -->
      <!-- **********************************************************************
         *********************************************************************** -->
      <xsl:template match="OPTION">

        <xsl:choose>
          <xsl:when test="./@Id and ./@Value" >
            <xsl:choose>
              <xsl:when test="../@Value = ./@Id">
                <option selected="yes" value="{./@Id}"><i18n:text><xsl:value-of select="./@Value"/></i18n:text></option>
              </xsl:when>
              <xsl:otherwise>
                <option  value="{./@Id}"><i18n:text><xsl:value-of select="./@Value"/></i18n:text></option>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
         <xsl:when test="./@Id and string-length(./@Value) = 0" >
            <xsl:choose>
              <xsl:when test="../@Value = ./@Id">
                <option selected="yes" value="{./@Id}"><i18n:text><xsl:value-of select="./@Id"/></i18n:text></option>
              </xsl:when>
              <xsl:otherwise>
                <option  value="{./@Id}"><i18n:text><xsl:value-of select="./@Id"/></i18n:text></option>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
         <xsl:when test="./@Value and string-length(./@Id) = 0" >
            <xsl:choose>
              <xsl:when test="../@Value = ./@Value">
                <option selected="yes" value="{./@Value}"><i18n:text><xsl:value-of select="./@Value"/></i18n:text></option>
              </xsl:when>
              <xsl:otherwise>
                <option value="{./@Value}"><i18n:text><xsl:value-of select="./@Value"/></i18n:text></option>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
        </xsl:choose>
      </xsl:template>

<!-- **********************************************************************
     *********************************************************************** -->       
</xsl:stylesheet>
