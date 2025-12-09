<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">


  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="FIELDS" mode="layout">
    <xsl:variable name="inner">
      <xsl:choose>
        <xsl:when test="count(ROW) > 0 ">false</xsl:when>
        <xsl:otherwise>true</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="spacing">
      <xsl:choose>
        <xsl:when test="count(ROW) > 0 and @Columns &lt;= 0">0</xsl:when>
        <xsl:otherwise>2</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
     <xsl:variable name="height">
      <xsl:choose>
        <xsl:when test="count(ROW) >0 and @Columns &lt;= 0">100%</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
   <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="string-length(@Width) > 0"><xsl:value-of select="@Width"/></xsl:when>
        <xsl:when test="$inner = 'true'"></xsl:when>
             <xsl:otherwise>100%</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="class">
          <xsl:choose>
            <xsl:when test="@ShowDivider = 'true' and  (position() != last())">bottomBorder</xsl:when>
            <xsl:otherwise></xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

    <table border="0"  class="{$class}"  cellpadding="{$spacing}" cellspacing="{$spacing}" width="{$width}"  height="{$height}"  valign="top">

    <xsl:if test="@DisplayText">
      <tr><td colspan="{3 * @Columns}"><b><i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>:</b></td></tr>
    </xsl:if>

      <xsl:choose>
        <xsl:when test="count(ROW) > 0">
          <xsl:apply-templates select="T_FIELD_HIDDEN" mode="content"/>
          <xsl:apply-templates select="ROW" mode="layout_row">
            <xsl:with-param name="showDivider" select="@ShowDivider"/>
          </xsl:apply-templates>
        </xsl:when>
        <xsl:when test="count(FIELDS) > 0">  <tr> <td>
          <xsl:apply-templates select="FIELDS" mode="layout"/></td></tr>

        </xsl:when>

        <xsl:otherwise>
          <xsl:apply-templates select="*" mode="layout_column"/>
        </xsl:otherwise>
      </xsl:choose>
</table>
  </xsl:template>

  <!-- This is each column -->
  <!-- **********************************************************************
     *********************************************************************** -->
    <xsl:template match="FIELDS" mode="layout_row">
      <xsl:param name="showDivider" select="'false'"/>

      <xsl:variable name="sd">
        <xsl:value-of select="$showDivider"/>
      </xsl:variable>

      <xsl:variable name="count" select="count(../FIELDS)"/>

      <td valign="top" width="{100 div $count}%">

        <xsl:if test="($sd = 'true') and (position() != last())">
          <xsl:attribute name="class">rightBorder</xsl:attribute>
        </xsl:if>
        <!-- This is the table inside each column -->
        <xsl:apply-templates select="." mode="layout"/>

      </td>
    </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="*" mode="layout_column">
    <tr>
      <xsl:apply-templates select="." mode="label_form"/>
      <xsl:apply-templates select="." mode="content"/>
      <td width="5%"></td>
    </tr>
  </xsl:template>
  <!-- **********************************************************************
      *********************************************************************** -->
   <xsl:template match="T_FIELD_HIDDEN" mode="layout_column">
       <xsl:apply-templates select="." mode="content"/>
   </xsl:template>

  <!-- **********************************************************************
      *********************************************************************** -->
   <xsl:template match="IMAGE" mode="content">
     <td nowrap="yes">
      <i2:img src="{@Src}" width="{@Width}" height="{@Height}" border="0" alt="{@DisplayText}"/>
     </td>
   </xsl:template>

  <!-- Decoration for cells -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="*" mode="decorate_cell">
    <xsl:param name="rowSpan" select="@RowSpan"/>
    <xsl:param name="colSpan" select="@ColSpan"/>

    <xsl:if test="string-length(@Id) > 0">
      <xsl:attribute name="id"><xsl:value-of select="@Id"/>_td</xsl:attribute>
    </xsl:if>
    <xsl:if test="string-length(@OnClick) > 0 and name() != 'T_FIELD_CHECK_BOX'">
      <xsl:attribute name="onclick"><xsl:value-of select="@OnClick"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="string-length(@Class) > 0">
      <xsl:attribute name="class"><xsl:value-of select="@Class"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="string-length(@Style) > 0">
      <xsl:attribute name="style"><xsl:value-of select="@Style"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="string-length($rowSpan) > 0">
      <xsl:attribute name="rowSpan"><xsl:value-of select="$rowSpan"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="string-length($colSpan) > 0">
      <xsl:attribute name="colSpan"><xsl:value-of select="$colSpan"/></xsl:attribute>
    </xsl:if>
  </xsl:template>

  <!-- Dont need colspan for field headers-->
  <!-- Decoration for cells  Header-->
    <!-- **********************************************************************
    *********************************************************************** -->
    <xsl:template match="*" mode="decorate_cell_header">
      <xsl:param name="rowSpan" select="@RowSpan"/>
      <xsl:param name="colSpan" select="@ColSpan"/>

      <xsl:if test="string-length(@Id) > 0">
        <xsl:attribute name="id"><xsl:value-of select="@Id"/>_td</xsl:attribute>
      </xsl:if>
      <xsl:if test="string-length(@OnClick) > 0 and name() != 'T_FIELD_CHECK_BOX'">
        <xsl:attribute name="onclick"><xsl:value-of select="@OnClick"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="string-length(@Class) > 0">
        <xsl:attribute name="class"><xsl:value-of select="@Class"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="string-length(@Style) > 0">
        <xsl:attribute name="style"><xsl:value-of select="@Style"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="string-length($rowSpan) > 0">
        <xsl:attribute name="rowSpan"><xsl:value-of select="$rowSpan"/></xsl:attribute>
      </xsl:if>
    </xsl:template>

  <!-- Table Header -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_HR" mode="content">
    <xsl:param name="rowSpan" select="@RowSpan"/>
    <xsl:param name="colSpan" select="@ColSpan"/>

    <!-- Check to see if atleast one value in this column is visible -->
    <!-- WJD 4/1/2005 Not sure why this check is here.  It is breaking with choose-field component -->
    <!--
    <xsl:variable name="colName" select="./@Name"/>
    <xsl:variable name="noOfVisibleRows" select="count(../../TR[not(@Header)]/*[name() != 'T_FIELD_HIDDEN' and @Name=$colName])"/>
    
    <xsl:if test="$noOfVisibleRows &gt; 0">
    -->
    
      <td nowrap="yes" id="{@Id}">
        <!-- 1/24/2005 WJD - Removed to conform with i2 UI design library -->
        <!--
        <xsl:if test="$colSpan > 1">
          <xsl:attribute name="style">font-weight: bold</xsl:attribute>
        </xsl:if>
        -->
        <xsl:attribute name="align">
          <xsl:choose>
            <xsl:when test="string-length(@Align) > 0"><xsl:value-of select="@Align"/></xsl:when>
            <xsl:otherwise>left</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:apply-templates select="." mode="decorate_cell">
          <xsl:with-param name="rowSpan" select="$rowSpan"/>
          <xsl:with-param name="colSpan" select="$colSpan"/>
        </xsl:apply-templates>

        <xsl:choose>
          <xsl:when test="@HeaderLink">
            <a href="{@HeaderLink}"><xsl:value-of select="@Value"/></a>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@Value"/>
            <xsl:if test="@Uom and @Value">
              &#xA0;(<xsl:value-of select="@Uom"/>)
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>

  <!-- WJD 5/6/2004: Required field will now be shown within table cell
        <xsl:if test="@Required = 'true'">
          <font color="red">*</font>
        </xsl:if>
  -->
      </td>
  
  <!-- WJD 4/1/2005 - Commented out with above if 
    </xsl:if>
  -->
  
  </xsl:template>

  <!--  Vertical Ruler-->
  <!-- **********************************************************************
   *********************************************************************** -->
   <xsl:template match="T_FIELD_VR" mode="content">
     <td nowrap="yes" class="rightBorder">&#xA0;</td>
   </xsl:template>

 <!--  Space -->
  <!-- **********************************************************************
   *********************************************************************** -->
   <xsl:template match="FIELD_SPACE" mode="content">
     <td nowrap="yes"><xsl:apply-templates select="." mode="decorate_cell"/>&#xA0;</td>
   </xsl:template>
  <!-- Table Header - Sortable-->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_HR[@Sortable ='true' or @Sortable ='yes']" mode="content">
    <xsl:param name="tableId"/>

    <td nowrap="yes" onmouseover="javascript:i2uiSetMenuCoords(this,event)" id="{@Id}">
         <xsl:attribute name="onClick">
          <xsl:variable name="quote">'</xsl:variable>
          <xsl:value-of select="concat('javascript:sort(', $quote, @Name, $quote,',', $quote, @Position, $quote,',this,', $quote, $tableId, $quote, ')' )"/>
        </xsl:attribute>
      <xsl:attribute name="align">
        <xsl:choose>
          <xsl:when test="string-length(@Align) > 0"><xsl:value-of select="@Align"/></xsl:when>
          <xsl:otherwise>left</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>

      <xsl:apply-templates select="." mode="decorate_cell"/>
      <a onmouseover="javascript:i2uiSetMenuCoords(this,event)">
        <xsl:attribute name="href">
          <xsl:variable name="quote">'</xsl:variable>
          <xsl:value-of select="concat('javascript:sort(', $quote, @Name, $quote,',', $quote, @Position, $quote,',this,', $quote, $tableId, $quote, ')' )"/>
        </xsl:attribute>
        <xsl:value-of select="@Value"/>
         <xsl:if test="@Uom and @Value">
            &#xA0;(<xsl:value-of select="@Uom"/>)
          </xsl:if>
      </a>
      <xsl:if test="@Sorted">
          <span id="ascdesc">    <!-- Id used by client sort-->
        <b>
        <xsl:choose>
            <xsl:when test="(@Sorted) = 'Descending'">
              &#xA0;&#xA0;&#xA0;<i2:img src="/descending_table_column.gif"/>
          </xsl:when>
          <xsl:otherwise>
            &#xA0;&#xA0;&#xA0;&#xA0;<i2:img src="/ascending_table_column.gif"/>
          </xsl:otherwise>
        </xsl:choose>
        </b>  </span>
      </xsl:if>
    </td>
  </xsl:template>

  <!--TODO Merge client and server into one template -->
  <xsl:template match="T_FIELD_HR[@Sortable ='client']" mode="content">
     <td nowrap="yes" onmouseover="javascript:i2uiSetMenuCoords(this,event)" name="{@Name}" sortable="client" id="{@Id}">
       <xsl:attribute name="align">
         <xsl:choose>
           <xsl:when test="string-length(@Align) > 0"><xsl:value-of select="@Align"/></xsl:when>
           <xsl:otherwise>left</xsl:otherwise>
         </xsl:choose>
       </xsl:attribute>

     <xsl:attribute name="onClick">
       <xsl:variable name="quote">'</xsl:variable>
       <xsl:value-of select="concat('javascript:table_onClientSort_getOrder(', $quote, @containerId, $quote,',', $quote, @Position, $quote,  ')' )"/>
        </xsl:attribute>

       <xsl:apply-templates select="." mode="decorate_cell"/>
       <a onmouseover="javascript:i2uiSetMenuCoords(this,event)">
         <xsl:attribute name="href">
           <xsl:variable name="quote">'</xsl:variable>
           <xsl:value-of select="concat('javascript:table_onClientSort_getOrder(', $quote, @containerId, $quote,',', $quote, @Position, $quote,  ')' )"/>
         </xsl:attribute>
         <xsl:value-of select="@Value"/>
         <xsl:if test="@Uom and @Value">
            &#xA0;(<xsl:value-of select="@Uom"/>)
         </xsl:if>

       </a>
        <span id="asc" style="display:none">
         <b>
             &#xA0;&#xA0;&#xA0;&#xA0;<i2:img src="/ascending_table_column.gif"/>
         </b>
          </span>
        <span id="desc" style="display:none">
         <b>
             &#xA0;&#xA0;&#xA0;&#xA0;<i2:img src="/descending_table_column.gif"/>
         </b>
          </span>
     </td>
   </xsl:template>

   <!--table header of editable column-->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_HR[@RowEditable = 'true']" mode="content">
    <td nowrap="yes" id="{@Id}">
      <xsl:attribute name="align">
        <xsl:choose>
          <xsl:when test="string-length(@Align) > 0"><xsl:value-of select="@Align"/></xsl:when>
          <xsl:otherwise>left</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="decorate_cell"/>
      <xsl:value-of select="@Value"/>
<!-- WJD 5/6: Required field will now be shown within table cell
      <xsl:if test="@Required = 'true'">
        <font color="red">*</font>
      </xsl:if>
 -->
    </td>
  </xsl:template>
  <!-- Row Selector -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="ROW_SELECTOR" mode="content">
    <xsl:choose>
      <xsl:when test="@Value or @Name = 'SELECT_ALL'">
        <i2:rowselector checked="{@Checked}" select="{@Select}" name="{@Name}" value="{@Value}" global="{@Header}">
          <xsl:if test="string-length(@RowSpan) > 0">
            <i2:attribute name="rowSpan"><xsl:value-of select="@RowSpan"/></i2:attribute>
          </xsl:if>
          <xsl:if test="string-length(@ColSpan) > 0">
            <i2:attribute name="colSpan"><xsl:value-of select="@ColSpan"/></i2:attribute>
          </xsl:if>
        </i2:rowselector>
      </xsl:when>
      <xsl:otherwise>
        <th nowrap="yes" class="tableColumnHeadings"/>
      </xsl:otherwise>
    </xsl:choose>    
  </xsl:template>

  <!-- **********************************************************************
   *********************************************************************** -->
   <xsl:template match="ROW_SELECTOR[@Header and @Select='single']" mode="content">
     <td nowrap="yes"><xsl:apply-templates select="." mode="decorate_cell"/><xsl:value-of select="@DisplayText"/></td>
   </xsl:template>

  <!-- hidden-field-->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_HIDDEN" mode="content">
    <input name="{@Name}" type="hidden" value="{@Value}"/>
  </xsl:template>

  <!-- display-field-->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_DISPLAY" mode="content">
    <td align="{@Align}" >
      <xsl:if test="@NoWrap = 'true' or not(@NoWrap)">
        <xsl:attribute name="nowrap">yes</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="." mode="decorate_cell"/>
      <xsl:apply-templates select="." mode="t_field_children_before"/>

      <!-- value -->
      <xsl:variable name="maxlength" select="@MaxLength"/>
      
      <xsl:variable name="value">
        <xsl:value-of select="@Value"/>     
      </xsl:variable>

      <xsl:variable name="truncatedValue">      
        <xsl:choose>
          <xsl:when test="(string-length($maxlength) &gt; 0) and (string-length($value) &gt; $maxlength)">
            <xsl:value-of select="concat(substring($value,0,$maxlength+1), '...')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$value"/>
          </xsl:otherwise>
        </xsl:choose>  
      </xsl:variable>

      <xsl:choose>
       <!-- If the string to be displayed has more than one space -->
       <xsl:when test="contains($truncatedValue, '  ')">
         <script>
           //Pass the string from XML source to script.
           var data= '<xsl:value-of select="$truncatedValue"/>'; 
           <![CDATA[
           for (var i=0; i <data.length; i++)
           {
               if (data.charAt(i) == ' ')
                   document.write("&nbsp;");
               else
                   document.write(data.charAt(i));
           }
           ]]>
         </script>
       </xsl:when>
       <xsl:otherwise>
         <xsl:choose>
           <xsl:when test="$truncatedValue = $value">
             <xsl:value-of select="$truncatedValue"/>
           </xsl:when>
           <xsl:otherwise>
             <a title="{$value}">
               <xsl:value-of select="$truncatedValue"/>
             </a>
           </xsl:otherwise>
         </xsl:choose>
       </xsl:otherwise>
      </xsl:choose>
      
      <!-- if there is no value attribute, put a space. for HORIZONTAL TABLE -->
      <xsl:if test="not($truncatedValue)">&#xA0;</xsl:if>
      
      <!-- Added for showing percent -->
      <xsl:if test="@DataType = 'Percent'">
         %
      </xsl:if>
      <xsl:apply-templates select="." mode="t_field_children"/>
    </td>
  </xsl:template>

  <!-- entry-field-->
   <!-- **********************************************************************
   *********************************************************************** -->
   <xsl:template match="T_FIELD_ENTRY[@Editable='false']" mode="content">
     <xsl:param name="rowNo"/>

     <td nowrap="yes" align="{@Align}">
       <xsl:apply-templates select="." mode="decorate_cell"/>
       <xsl:apply-templates select="." mode="t_field_children_before"/>
       <xsl:choose>
         <xsl:when test="@Disabled='true'">
           <!-- Converted to disabled text box -->
           <input id="{@Id}" row="{number($rowNo)}" name="{@InputName}"  value="{@Value}" fieldtype="{@DataType}" size="{@Size}" maxlength="{@MaxLength}"  class="inputfieldIE"
             containerId="{@containerId}" disabled="true"/>       
         </xsl:when>
         <xsl:otherwise>
           <xsl:value-of select="@Value"/>
         </xsl:otherwise>
       </xsl:choose>
       <xsl:if test="@DataType = 'Percent'">
         %
       </xsl:if>
       <input name="{@InputName}" type="hidden" value="{@Value}" row="{number($rowNo)}"/>

       <xsl:apply-templates select="." mode="t_field_children"/>
     </td>
   </xsl:template>

  <!-- Modified by WJD 10/14/04 for eQuality #534945 -->
  <!-- **********************************************************************
    *********************************************************************** -->
    <xsl:template match="*" mode="t_field_children">
      <xsl:apply-templates select="." mode="uom"/>
      <xsl:apply-templates select="." mode="calendar"/>
      <xsl:apply-templates select="LINKS[@location='after']" mode="t_field_link"/>
      <xsl:apply-templates select="_ERRORS" mode="icon_tip"/>
    </xsl:template>

  <!-- **********************************************************************
    *********************************************************************** -->
    <xsl:template match="*" mode="t_field_children_before">
      <xsl:apply-templates select="LINKS[@location='before']" mode="t_field_link"/>
      <xsl:if test="LINKS[@location='before']">&#xA0;</xsl:if>
    </xsl:template>

    <xsl:template match="LINKS" mode="t_field_children">
      <xsl:apply-templates select="LINK | NON_BREAKING_SPACES" mode="t_field_link"/>
    </xsl:template>
  
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="NON_BREAKING_SPACES" mode="t_field_link">
     <xsl:apply-templates mode="t_field_link"/>
  </xsl:template>
  
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="NON_BREAKING_SPACE" mode="t_field_link">
     &#xA0;
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="LINK" mode="t_field_link">
     &#xA0;<xsl:apply-templates select="." mode="content"/>
  </xsl:template>

 <!-- Field  - Uom - Uneditable-->
 <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_UOM" mode="content">
    <td nowrap="yes" align="{@Align}">
      <xsl:apply-templates select="." mode="decorate_cell"/>
      <xsl:value-of select="@Value"/>
       &#xa0;<i18n:text><xsl:value-of select="@Uom"/></i18n:text>
    </td>
  </xsl:template>

  <!-- link-field -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_LINK" mode="content">
      <td nowrap="yes" align="{@Align}">
        <xsl:apply-templates select="." mode="decorate_cell"/>
        <xsl:apply-templates select="." mode="t_field_children_before"/>
        <xsl:variable name="href">


          <xsl:choose>
            <xsl:when test="@Type = 'popup'">javascript:popUpWindow('<xsl:value-of select="@Url"/>','<xsl:value-of select="@PopupName"/>')</xsl:when>
            <xsl:when test="string-length(@Url) &gt; 0">this.href='<xsl:value-of select="@Url"/>'</xsl:when>
            <xsl:otherwise></xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="target">
          <xsl:choose>
            <xsl:when test="@Target"><xsl:value-of select="@Target"/></xsl:when>
            <xsl:otherwise>appFrame</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
  
        <a target="{$target}">
        <xsl:if test="string-length($href) &gt; 0">
          <xsl:attribute name="href">javascript:void(0)</xsl:attribute>
          <xsl:attribute name="onclick"><xsl:value-of select="$href"/></xsl:attribute>
        </xsl:if>
        
        <!--xsl:apply-templates select="." mode="decorate_cell"/-->
          <xsl:value-of select="@Value"/>
        </a>
          <xsl:apply-templates select="." mode="t_field_children"/>
      </td>
  </xsl:template>

  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="T_FIELD_IMG_LK" mode="content">
    <td align="{@Align}" nowrap="yes">
      <xsl:apply-templates select="." mode="decorate_cell"/>
      <xsl:apply-templates select="." mode="t_field_children_before"/>
      <xsl:variable name="title">
        <i18n:text>
          <xsl:value-of select="@Alt"/>
        </i18n:text>
      </xsl:variable>

      <xsl:variable name="url">
        <xsl:choose>
          <xsl:when test="string-length(@OnClick) > 0">
            <xsl:value-of select="@OnClick"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@Url"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:variable name="onclick">
        <xsl:choose>
          <xsl:when test="@Type = 'popup'">javascript:popUpWindow('<xsl:value-of select="$url"/>','<xsl:value-of select="@PopupName"/>')</xsl:when>
          <xsl:when test="@OnClickType = 'popup'">javascript:popUpWindow('<xsl:value-of select="$url"/>','<xsl:value-of select="@PopupName"/>')</xsl:when>
          <xsl:otherwise><xsl:value-of select="$url"/></xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <a href="{$onclick}" title="{$title}">
        <xsl:if test="@Src">
          <i2:img src="{@Src}" width="16" height="16" border="0" id="{@Id}"/>
        </xsl:if>
      </a>
      <!-- Error Icons -->
      <xsl:apply-templates select="." mode="t_field_children"/>

    </td>
  </xsl:template>


   <xsl:template match="T_FIELD_IMG_LK[not(@Url)]" mode="content">
    <td align="{@Align}" nowrap="yes" dataType="Image">
      <xsl:apply-templates select="." mode="decorate_cell"/>
      <xsl:variable name="title">
        <i18n:text>
          <xsl:value-of select="@Alt"/>
        </i18n:text>
      </xsl:variable>
        <xsl:if test="@Src">
          <i2:img src="{@Src}" alt="{$title}" width="16" height="16" border="0" id="{@Id}"/>
        </xsl:if>
    </td>
  </xsl:template>
   <xsl:template match="T_FIELD_IMG_LK[string-length(@Src) = 0]" mode="content">
    <td align="{@Align}" nowrap="yes" dataType="Image">
      <xsl:apply-templates select="." mode="decorate_cell"/>
    </td>
  </xsl:template>
  <!-- entry-field -->
   <!-- **********************************************************************
        *********************************************************************** -->
   <xsl:template match="T_FIELD_ENTRY[@Editable = 'true']" mode="content">
     <xsl:param name="rowNo"/>
     <xsl:param name="inTable" select="false()"/>

     <td nowrap="yes" align="{@Align}">
       <xsl:apply-templates select="." mode="decorate_cell"/>
       <xsl:apply-templates select="." mode="t_field_children_before"/>

       <input row="{number($rowNo)}" name="{@InputName}"  value="{@Value}" fieldtype="{@DataType}" size="{@Size}" maxlength="{@MaxLength}"  class="inputfieldIE"
         onkeyup="javascript:validation_onlyValidData()"
         containerId="{@containerId}"
         >

          <xsl:choose>
        <xsl:when test="string-length(@onChange) > 0" >
          <xsl:attribute name="onchange">
            <xsl:value-of select="@onChange"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="type">javascript:isValid_field_if_data(this)</xsl:attribute>
  </xsl:otherwise>
        </xsl:choose>
        <!-- file -->

        <xsl:choose>
        <xsl:when test="@DataType = 'file'" >
          <xsl:attribute name="type">
            <xsl:value-of select="@DataType"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="type">
            <xsl:value-of select="'field'"/>
          </xsl:attribute>
        </xsl:otherwise>
        </xsl:choose>


         <!-- id -->
         <xsl:if test="string-length(@Id) > 0">
           <xsl:attribute name="id">
             <xsl:value-of select="@Id"/>
           </xsl:attribute>
         </xsl:if>

         <!-- style -->
         <xsl:if test="string-length(@Style) > 0">
          <xsl:attribute name="style">
            <xsl:value-of select="@Style"/>
          </xsl:attribute>
         </xsl:if>

         <!-- isRequired -->
         <xsl:if test="@Required = 'true'">
           <xsl:attribute name="required">
             <xsl:value-of select="'true'"/>
           </xsl:attribute>
         </xsl:if>

         <!-- isReadonly -->
         <xsl:if test="@Readonly = 'true'">
           <xsl:attribute name="readonly">
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
       <xsl:if test="@DataType = 'Percent'">
         %
       </xsl:if>

      <!-- RA 5/5: put * if: field is editable AND displayText is blank -->
      <!-- WJD 5/6: Also show * beside field if it is in a table -->
      <xsl:if test="@Required = 'true' and ((string-length(@DisplayText) = 0) or $inTable)">
        <font color="red">&#xa0;*</font>
      </xsl:if>      

       <!-- Link Icons -->
       <xsl:apply-templates select="." mode="t_field_children"/>

       <xsl:apply-templates select="." mode="required-validator"/>
       <xsl:apply-templates select="." mode="data-type-validator"/>
       <xsl:apply-templates select="compare-validator" mode="fields"/>
       <xsl:apply-templates select="custom-validator" mode="fields"/>

      </td>
   </xsl:template>



   <!-- **********************************************************************
        *********************************************************************** -->
   <xsl:template match="T_FIELD_RECENT_ENTRY[@Editable = 'true']" mode="content">
     <xsl:param name="rowNo"/>
     <xsl:param name="inTable" select="false()"/>

     <td nowrap="yes" align="{@Align}">
       <xsl:apply-templates select="." mode="decorate_cell"/>
       <xsl:apply-templates select="." mode="t_field_children_before"/>

       <input  ondblclick="javascript:textToSelect2('{@Name}')" autocomplete="off"  id="{@Name}"
              row="{number($rowNo)}"  name="{@InputName}"  value="{@Value}" fieldtype="{@DataType}" size="{@Size}" maxlength="{@MaxLength}" type="field" class="inputfieldIE"
         onchange="javascript:isValid_field_if_data(this)"  onkeyup="javascript:validation_onlyValidData()"
         containerId="{@containerId}"
         >

         <!-- id -->
         <xsl:if test="string-length(@Id) > 0">
           <xsl:attribute name="id">
             <xsl:value-of select="@Id"/>
           </xsl:attribute>
         </xsl:if>

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

      <SELECT
      onblur="javascript:selectToText2('{@Name}')"
      class="pulldown"   id="{@Name}_select" ONCHANGE="document.form.{@Name}.value = this.options[this.selectedIndex].text;">
      <xsl:attribute name="style">
         <xsl:value-of select="'width:134px;display:none'"/>
      </xsl:attribute>
        <xsl:attribute name="disabled">true</xsl:attribute>
        <xsl:attribute name="name">
            <xsl:value-of select="concat(@Name,'_select')"/>
         </xsl:attribute>

      <xsl:apply-templates select="OPTION">
        <xsl:sort select="@Value"/>
      </xsl:apply-templates>


    </SELECT>
    
      <!-- RA 5/5: put * if: field is editable AND displayText is blank -->
      <!-- WJD 5/6: Also show * beside field if it is in a table -->
      <xsl:if test="@Required = 'true' and ((string-length(@DisplayText) = 0) or $inTable)">
        <font color="red">&#xa0;*</font>
      </xsl:if>      

       <!-- Link Icons -->
       <xsl:apply-templates select="." mode="t_field_children"/>

       <xsl:apply-templates select="." mode="required-validator"/>
       <xsl:apply-templates select="." mode="data-type-validator"/>
       <xsl:apply-templates select="compare-validator" mode="fields"/>
       <xsl:apply-templates select="custom-validator" mode="fields"/>

      </td>
   </xsl:template>



  <!-- entry-field  with button needs to have table around as otherwise button wraps
       to the next line.   when there is time to test both of them needs to be merged
  -->

  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="T_FIELD_ENTRY[@Editable = 'true' and LINKS/BUTTON]" mode="content">
    <xsl:param name="rowNo"/>
    <xsl:param name="inTable" select="false()"/>

    <td  nowrap="yes" align="{@Align}">
      <xsl:apply-templates select="." mode="decorate_cell"/>
      <table cellspacing="0" cellpadding="0"><tr><td nowrap="yes">
      <input row="{number($rowNo)}" name="{@InputName}"  value="{@Value}" fieldtype="{@DataType}" size="{@Size}" maxlength="{@MaxLength}" type="field" class="inputfieldIE"
        onchange="javascript:isValid_field_if_data(this)"  onkeyup="javascript:validation_onlyValidData()"
        containerId="{@containerId}"
        >

        <!-- id -->
        <xsl:if test="string-length(@Id) > 0">
          <xsl:attribute name="id">
            <xsl:value-of select="@Id"/>
          </xsl:attribute>
        </xsl:if>

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

      <!-- RA 5/5: put * if: field is editable AND displayText is blank -->
      <!-- WJD 5/6: Also show * beside field if it is in a table -->
      <xsl:if test="@Required = 'true' and ((string-length(@DisplayText) = 0) or $inTable)">
        <font color="red">&#xa0;*</font>
      </xsl:if>      

      <!-- Link Icons -->
        <xsl:apply-templates select="." mode="uom"/>


      <xsl:apply-templates select="LINKS/LINK" mode="t_field_link"/>
      <xsl:apply-templates select="." mode="calendar"/>
      <xsl:apply-templates select="." mode="required-validator"/>
      <xsl:apply-templates select="." mode="data-type-validator"/>
      <xsl:apply-templates select="compare-validator" mode="fields"/>
      <xsl:apply-templates select="custom-validator" mode="fields"/>
        &#xA0;</td>

        <td nowrap="yes">
         <xsl:apply-templates select="LINKS/BUTTON"/>
         <xsl:apply-templates select="_ERRORS" mode="icon_tip"/>
       </td>
        </tr></table>

     </td>
  </xsl:template>



  <!-- **********************************************************************
   *********************************************************************** -->
   <xsl:template match="compare-validator" mode="fields">
     <span  style="display:none" type="compare-validator" withField="{@withField}"  operator="{@operator}" severity="{@severity}" message="{@message}">
      &#xA0;<i2:img onclick="javascript:core_alert(this.alt)" src="/alert_static_small.gif" border="0" align="middle">
        <i2:attribute name="alt">
          <i18n:text><xsl:value-of select="@message"/></i18n:text>
       </i2:attribute>
      </i2:img>
     </span>
   </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="custom-validator" mode="fields">
    <span  style="display:none" type="custom-validator" validationFunction="{@validationFunction}" severity="{@severity}" message="{@message}">
     &#xA0;<i2:img onclick="javascript:core_alert(this.alt)" src="/alert_static_small.gif" border="0" align="middle">
       <i2:attribute name="alt">
         <i18n:text><xsl:value-of select="@message"/></i18n:text>
      </i2:attribute>
     </i2:img>
    </span>
  </xsl:template>

 <!-- **********************************************************************
   *********************************************************************** -->
   <xsl:template match="*" mode="required-validator">
     <xsl:if test="@Required = 'true'">
     <span  style="display:none" type="required-validator" severity="STOP">
       &#xA0;<i2:img src="/alert_static_small.gif" alt="Required Field" border="0" align="middle"/>
     </span>
     </xsl:if>
   </xsl:template>
  <!-- **********************************************************************
   *********************************************************************** -->
   <xsl:template match="*" mode="data-type-validator">
     <span  style="display:none" type="data-type-validator" message="{@message}" severity="STOP">
       <xsl:variable name="quote">'</xsl:variable>
        &#xA0;<i2:img onclick="javascript:core_alert(this.alt)" src="/alert_static_small.gif" border="0" align="middle">
         <i2:attribute name="alt">
           <i18n:text><xsl:value-of select="@ValidationMsg"/></i18n:text>
         </i2:attribute>
        </i2:img>
     </span>
   </xsl:template>




  <!-- phone-entry-field -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_PHONE" mode="content">
    <td align="left" nowrap="yes">
      <xsl:apply-templates select="." mode="decorate_cell"/>
      (<xsl:value-of select="substring(@Value,1,3)" />)&#xA0;<xsl:value-of select="substring(@Value,4,3)"/>&#xA0;-&#xA0;<xsl:value-of   select="substring(@Value,7,4)"/>
    </td>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_PHONE[@Editable = 'true']" mode="content">
     <xsl:param name="inTable" select="false()"/>

    <td align="left" nowrap="yes">
      <xsl:apply-templates select="." mode="decorate_cell"/>
      (<input fieldtype="{@Type}" name="{concat(@Name,'_AREA_CODE')}" value="{substring(@Value,1,3)}" type="field" class="inputfieldIE" size="3"/>)&#xA0;<input fieldtype="{@Type}" name="{concat(@Name,'_LOCAL_NUM_1')}" value="{substring(@Value,4,3)}" type="field" class="inputfieldIE" size="3"/>&#xA0;-&#xA0;<input fieldtype="{@Type}" name="{concat(@Name,'_LOCAL_NUM_2')}" value="{substring(@Value,7,4)}" type="field" class="inputfieldIE" size="4"/>

      <!-- RA 5/5: put * if: field is editable AND displayText is blank -->
      <!-- WJD 5/6: Also show * beside field if it is in a table -->
      <xsl:if test="@Required = 'true' and ((string-length(@DisplayText) = 0) or $inTable)">
        <font color="red">&#xa0;*</font>
      </xsl:if>      

    </td>
  </xsl:template>


  <!-- tree-field-->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_TREEFIELD_LK" mode="content">
    <i2:treecell column="{position()-1}" depth="{@Depth}" nochildren="{@NoChildren}">
      <xsl:choose>
        <xsl:when test="@Url">
          <a>
            <xsl:attribute name="href">
              <xsl:choose>
                <xsl:when test="@Type = 'popup'">javascript:popUpWindow('<xsl:value-of select="@Url"/>','<xsl:value-of select="@PopupName"/>')</xsl:when>
                <xsl:otherwise><xsl:value-of select="@Url"/></xsl:otherwise>
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
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@Value"/>
        </xsl:otherwise>
      </xsl:choose>
      <!-- Error Icon (!) -->
      <xsl:apply-templates select="_ERRORS" mode="icon_tip"/>
    </i2:treecell>


  </xsl:template>

  <!-- textarea-->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_TEXTAREA[@Editable='false']" mode="content">
    <td nowrap="yes" align="left">
      <xsl:apply-templates select="." mode="decorate_cell"/>
      <textarea   cols="{@Cols}" rows="{@Rows}" class="textArea" onFocus="this.blur();"><xsl:value-of disable-output-escaping="yes" select="@Value"/></textarea>
    </td>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_TEXTAREA[@Editable='true']" mode="content">
     <xsl:param name="inTable" select="false()"/>

    <td nowrap="yes" align="left">
      <xsl:apply-templates select="." mode="decorate_cell"/>
      
      <textarea  containerId="{@containerId}"  onchange="javascript:isValid_field_if_data(this)" name="{@Name}" cols="{@Cols}" rows="{@Rows}" class="textArea" >
        <!-- isReadonly -->
        <xsl:if test="@Readonly = 'true'">
          <xsl:attribute name="readonly">
            <xsl:value-of select="'true'"/>
          </xsl:attribute>
        </xsl:if>

        <xsl:value-of disable-output-escaping="yes" select="@Value"/>

       </textarea>
                
      <!-- RA 5/5: put * if: field is editable AND displayText is blank -->
      <!-- WJD 5/6: Also show * beside field if it is in a table -->
      <xsl:if test="@Required = 'true' and ((string-length(@DisplayText) = 0) or $inTable)">
        <font color="red">&#xa0;*</font>
      </xsl:if>      

      <xsl:apply-templates select="." mode="required-validator"/>

        </td>
  </xsl:template>

  <!-- checkbox-->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="T_FIELD_CHECK_BOX" mode="content">
     <xsl:param name="inTable" select="false()"/>

    <td nowrap="yes" align="{@Align}">
      <xsl:apply-templates select="." mode="decorate_cell"/>
      <xsl:apply-templates select="." mode="t_field_children_before"/>

  <xsl:choose>
    <xsl:when test="@Value = @checkedValue">
      <input name="{@Name}" value="{@checkedValue}"  checked="true" type="checkbox">
        <xsl:choose>
          <xsl:when test="@Editable = 'false'">
            <xsl:attribute name="disabled">
              <xsl:value-of select="'true'"></xsl:value-of>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="string-length(@OnClick) > 0">
            <xsl:attribute name="onclick"><xsl:value-of select="@OnClick"/></xsl:attribute>
          </xsl:when>
        </xsl:choose>
        <xsl:apply-templates select="." mode="t_field_children" />
      </input>
    </xsl:when>
    <xsl:when test="@Value = 'TRUE' or @Value = 'true'">
      <input name="{@Name}" value="{@checkedValue}"  checked="true" type="checkbox">
        <xsl:choose>
          <xsl:when test="@Editable = 'false'">
            <xsl:attribute name="disabled">
              <xsl:value-of select="'true'"></xsl:value-of>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="string-length(@OnClick) > 0">
            <xsl:attribute name="onclick"><xsl:value-of select="@OnClick"/></xsl:attribute>
          </xsl:when>
        </xsl:choose>
        <xsl:apply-templates select="." mode="t_field_children" />
      </input>
    </xsl:when>
    <xsl:otherwise>
      <input name="{@Name}" value="{@checkedValue}" type="checkbox">
        <xsl:choose>
          <xsl:when test="@Editable = 'false'">
            <xsl:attribute name="disabled">
              <xsl:value-of select="'true'"></xsl:value-of>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="string-length(@OnClick) > 0">
            <xsl:attribute name="onclick"><xsl:value-of select="@OnClick"/></xsl:attribute>
          </xsl:when>
        </xsl:choose>
        <xsl:apply-templates select="." mode="t_field_children" />
      </input>
    </xsl:otherwise>
  </xsl:choose>
  
      <!-- RA 5/5: put * if: field is editable AND displayText is blank -->
      <!-- WJD 5/6: Also show * beside field if it is in a table -->
      <xsl:if test="@Required = 'true' and ((string-length(@DisplayText) = 0) or $inTable)">
        <font color="red">&#xa0;*</font>
      </xsl:if>      

    </td>
  </xsl:template>

  <!-- radio button-->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="T_FIELD_RADIO_BUTTON" mode="content">
     <xsl:param name="inTable" select="false()"/>

    <td nowrap="yes" align="left">
      <xsl:apply-templates select="." mode="decorate_cell"/>
      <xsl:apply-templates select="." mode="t_field_children_before"/>

  <xsl:choose>
    <xsl:when test="@Value = @checkedValue">
      <input name="{@Name}" value="{@checkedValue}" checked="true" type="radio">
         <xsl:apply-templates select="." mode="t_field_children" />
       </input>
    </xsl:when>
    <xsl:otherwise>
      <input name="{@Name}" value="{@checkedValue}" type="radio">
        <xsl:apply-templates select="." mode="t_field_children" />
      </input>
    </xsl:otherwise>
  </xsl:choose>
  
      <!-- RA 5/5: put * if: field is editable AND displayText is blank -->
      <!-- WJD 5/6: Also show * beside field if it is in a table -->
      <xsl:if test="@Required = 'true' and ((string-length(@DisplayText) = 0) or $inTable)">
        <font color="red">&#xa0;*</font>
      </xsl:if>      

    </td>
  </xsl:template>

  <!-- dropdown-->
   <!-- **********************************************************************
   *********************************************************************** -->
   <xsl:template match="T_FIELD_SELECT[@Editable='false']" mode="content">
     <td nowrap="yes" align="{@Align}">
       <xsl:apply-templates select="." mode="decorate_cell"/>
       <xsl:apply-templates select="LINKS[@location='before']" mode="t_field_link"/>
       <xsl:if test="LINKS[@location='before']">&#xa0;</xsl:if>
       
       <xsl:variable name="selectedValue" select="./@Value"/>
       <!-- If its non editable show the description from the option for 
       the selected value instead of the actual value -->
       <xsl:variable name="displayText">
         <xsl:choose>
          <xsl:when test="count(OPTION[@Id = $selectedValue]) &gt; 0">
            <xsl:value-of select="OPTION[@Id = $selectedValue]/@Value"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$selectedValue"/>
          </xsl:otherwise>
         </xsl:choose>
       </xsl:variable>
       
       <xsl:choose>
         <xsl:when test="@DataType = 'Text'">
           <i18n:text><xsl:value-of select="$displayText"/></i18n:text>
         </xsl:when>
         <xsl:otherwise>
           <xsl:value-of select="$displayText"/>
         </xsl:otherwise>
       </xsl:choose>
       
       <input name="{@InputName}" type="hidden" value="{@Value}"/>
       
       <!-- Unit of Measure -->
       <xsl:apply-templates select="." mode="uom"/>

       <xsl:apply-templates select="LINKS[@location='after']" mode="t_field_link"/>
       <xsl:apply-templates select="_ERRORS" mode="icon_tip"/>

     </td>
   </xsl:template>

    <!-- **********************************************************************
         *********************************************************************** -->
    <xsl:template match="T_FIELD_SELECT[@Editable = 'true']" mode="content">
     <xsl:param name="inTable" select="false()"/>

      <td nowrap="yes" align="left">
        <xsl:apply-templates select="." mode="decorate_cell"/>
        <xsl:apply-templates select="LINKS[@location='before']" mode="t_field_link"/>
        <xsl:if test="LINKS[@location='before']">&#xa0;</xsl:if>
        
        <select  containerId="{@containerId}" class="pulldown" name="{@InputName}" onchange="javascript:isValid_field_if_data(this);{@onChange}" size="{@Size}">
         <xsl:choose>
           <xsl:when test="@Size&gt;'1'"> <xsl:attribute name="multiple"/> </xsl:when>
         </xsl:choose>

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

          <xsl:choose>
            <xsl:when test="@SelectOne = 'true'">
              <option value=""><i18n:text>Select...</i18n:text></option>
            </xsl:when>
            <xsl:when test="@SelectAll = 'true'">
              <option value=""><i18n:text>All</i18n:text></option>
            </xsl:when>
            </xsl:choose>

            <xsl:choose>
              <xsl:when test="string-length(@Sort) &gt; 0">
                <xsl:apply-templates select="OPTION">
                  <xsl:sort select="@Value" order="{@Sort}"/>
                  <xsl:with-param name="doI18n" select="@DataType = 'Text'"/>
                </xsl:apply-templates>
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates select="OPTION">
                  <xsl:with-param name="doI18n" select="@DataType = 'Text'"/>
                </xsl:apply-templates>
              </xsl:otherwise>
            </xsl:choose>
           <xsl:apply-templates select="CODE_MASTER_VALUE" mode="pulldown">
             <xsl:sort select="DESCRIPTION/@Value"/>
             <xsl:with-param name="selectedId" select="@Value"/>
            </xsl:apply-templates>

        </select>

       <!-- Unit of Measure -->
       <xsl:apply-templates select="." mode="uom"/>

      <!-- RA 5/5: put * if: field is editable AND displayText is blank -->
      <!-- WJD 5/6: Also show * beside field if it is in a table -->
      <xsl:if test="@Required = 'true' and ((string-length(@DisplayText) = 0) or $inTable)">
        <font color="red">&#xa0;*</font>
      </xsl:if>      

          <xsl:if test="@Required = 'true'">
            <xsl:call-template name="display_alert_image">
              <xsl:with-param name="fieldName" select="@InputName"/>
            </xsl:call-template>
          </xsl:if>

          <xsl:apply-templates select="LINKS[@location='after']" mode="t_field_link"/>
          <!-- Error Icon (!) -->
          <xsl:apply-templates select="_ERRORS" mode="icon_tip"/>

        <xsl:apply-templates select="." mode="required-validator"/>
        <xsl:apply-templates select="." mode="data-type-validator"/>
        <xsl:apply-templates select="custom-validator" mode="fields"/>




      </td>
    </xsl:template>

  <!-- Option -->
       <!-- **********************************************************************
          *********************************************************************** -->
       <xsl:template match="OPTION">
         <xsl:param name="doI18n" select="true()"/>

         <xsl:variable name="value">
           <xsl:choose>
             <xsl:when test="./@Id and ./@Value" >
               <xsl:value-of select="./@Id"/>
             </xsl:when>
             <xsl:when test="./@Id and string-length(./@Value) = 0" >
               <xsl:value-of select="./@Id"/>
             </xsl:when>
             <xsl:when test="./@Value and string-length(./@Id) = 0" >
               <xsl:value-of select="./@Value"/>
             </xsl:when>
           </xsl:choose>
         </xsl:variable>         

         <xsl:variable name="displayText">
           <xsl:choose>
             <xsl:when test="./@Id and ./@Value" >
               <xsl:value-of select="./@Value"/>
             </xsl:when>
             <xsl:when test="./@Id and string-length(./@Value) = 0" >
               <xsl:value-of select="./@Id"/>
             </xsl:when>
             <xsl:when test="./@Value and string-length(./@Id) = 0" >
               <xsl:value-of select="./@Value"/>
             </xsl:when>
           </xsl:choose>
         </xsl:variable>       
         
         <xsl:variable name="i18nDisplayText">
           <xsl:choose>
             <xsl:when test="$doI18n">
               <i18n:text><xsl:value-of select="$displayText"/></i18n:text>
             </xsl:when>
             <xsl:otherwise>
               <xsl:value-of select="$displayText"/>
             </xsl:otherwise>
           </xsl:choose>
         </xsl:variable>

         <xsl:choose>
           <xsl:when test="../@Value = $value or ./@Selected = 'true'">
             <option selected="yes" value="{$value}"><xsl:value-of select="$i18nDisplayText"/></option>
           </xsl:when>
           <xsl:otherwise>
             <option  value="{$value}"><xsl:value-of select="$i18nDisplayText"/></option>
           </xsl:otherwise>
         </xsl:choose>
       </xsl:template>


  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="CODE_MASTER_VALUE" mode="pulldown">
      <xsl:param name="selectedId"/>
     <option value="{VALUE_ID/@Value}">
        <xsl:if test="$selectedId = VALUE_ID/@Value">
          <xsl:attribute name="selected">selected</xsl:attribute>
        </xsl:if>
        <i18n:text><xsl:value-of select="DESCRIPTION/@Value"/></i18n:text>
      </option>
    </xsl:template>


  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="display_alert_image">
    <xsl:param name="fieldName"/>

    <xsl:variable name="id" select="concat($fieldName, '_REQ')"/>
    &#xA0;<i2:img src="/alert_static_small.gif" id="{$id}" alt="Required Field" border="0" align="middle" hidden="yes"/>

  </xsl:template>


  <!--  Label - form-->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="*" mode="label_form">
    <td nowrap="yes">
      <xsl:apply-templates select="." mode="decorate_cell_header"/>
      <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text><xsl:if test="string-length(@DisplayText) > 0">:</xsl:if>
      <xsl:if test="@Required = 'true' and @Editable='true' and (string-length(@DisplayText) > 0)">
        <font color="red">*</font>
      </xsl:if>
    </td>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_ENTRY" mode="calendar">
      <xsl:if test="@DataType = 'Date' and @Editable='true'">
         &#xA0;<A  href="javascript:onLink()" onclick="javascript:ui_calendar(this);" >
           <i2:img src="/cal_icon.gif" border="0" align="middle"/>
         </A>
     </xsl:if>
    </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
      <xsl:template match="*" mode="uom">
       <xsl:if test="@Uom">
         &#xA0;<xsl:value-of select="@Uom"/>
       </xsl:if>
      </xsl:template>

  <!-- DateRange - Start:: -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="T_FIELD_DATE_RANGE_ENTRY" mode="label_form">
    <td nowrap="yes">
      <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>
      &#xA0;<i18n:text>From</i18n:text>:
      <xsl:if test="@Required = 'true' and @Editable='true'">
   <font color="red">*</font>
      </xsl:if>
    </td>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_DATE_RANGE_ENTRY[@Editable = 'true']" mode="content">
     <xsl:param name="inTable" select="false()"/>

    <xsl:variable name="quote">'</xsl:variable>
    <xsl:variable name="dateRangeValidationScript">
      <xsl:value-of select="concat('javascript:test_date_range(',$quote, 'FROM_',  @InputName, $quote, ',', $quote,'TO_', @InputName, $quote, ',', $quote, @DataType, $quote, ')' )"/>
    </xsl:variable>

    <xsl:variable name="size">
      <xsl:choose>
        <xsl:when test="@DataType = 'DateTime'">20</xsl:when>
        <xsl:otherwise>12</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <td nowrap="yes">
      <xsl:apply-templates select="." mode="decorate_cell"/>
      <table cellspacing="4" cellpadding="0" border="0">
        <tr>
          <td nowrap="yes">
            <input name="FROM_{@InputName}" value="{@FromDate}" fieldtype="{@DataType}" size="{$size}"
              maxlength="{@MaxLength}" type="field" class="inputfieldIE" onchange="javascript:isValid_field_if_data(this);{$dateRangeValidationScript}"
              onkeyup="javascript:validation_onlyValidData()" containerId="{@containerId}">

              <!-- id -->
              <xsl:if test="string-length(@Id) > 0">
                <xsl:attribute name="id">
                  <xsl:value-of select="concat('FROM_',@Id)"/>
                </xsl:attribute>
              </xsl:if>

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
            &#xA0;
            <a href="javascript:onLink()" onclick="javascript:ui_calendar(this);">
              <i2:img src="/cal_icon.gif" border="0" align="middle"/>
            </a>
            <xsl:apply-templates select="." mode="required-validator"/>
            <xsl:apply-templates select="." mode="data-type-validator"/>

          </td>
          <td  nowrap="yes">
            &#xA0;&#xA0;&#xA0;<i18n:text>To</i18n:text>:
            <input name="TO_{@InputName}" value="{@ToDate}" fieldtype="{@DataType}" size="{$size}"
              maxlength="{@MaxLength}" type="field" class="inputfieldIE" onchange="javascript:isValid_field_if_data(this);{$dateRangeValidationScript}"
              onkeyup="javascript:validation_onlyValidData()" containerId="{@containerId}">

              <!-- id -->
              <xsl:if test="string-length(@Id) > 0">
                <xsl:attribute name="id">
                  <xsl:value-of select="concat('TO_',@Id)"/>
                </xsl:attribute>
              </xsl:if>

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
            
            &#xA0;
            <a href="javascript:onLink()" onclick="javascript:ui_calendar(this);">
              <i2:img src="/cal_icon.gif" border="0" align="middle"/>
            </a>
            <xsl:apply-templates select="." mode="required-validator"/>
            <xsl:apply-templates select="." mode="data-type-validator"/>
            <xsl:apply-templates select="compare-validator" mode="fields"/>
            <xsl:apply-templates select="custom-validator" mode="fields"/>


          </td>
          <td  nowrap="yes">
          
      <!-- RA 5/5: put * if: field is editable AND displayText is blank -->
      <!-- WJD 5/6: Also show * beside field if it is in a table -->
      <xsl:if test="@Required = 'true' and ((string-length(@DisplayText) = 0) or $inTable)">
        <font color="red">&#xa0;*</font>
      </xsl:if>      

          </td>
        </tr>
      </table>
    </td>
  </xsl:template>

  <!--  unEditable - Content-->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_DATE_RANGE_ENTRY[@Editable = 'false']" mode="content">
    <td nowrap="yes" align="right">
      <xsl:apply-templates select="." mode="decorate_cell"/>
      <table cellspacing="4" cellpadding="0" border="0">
        <tr>
          <td  nowrap="yes">
            <i18n:date format="common"><xsl:value-of select="@FromDate"/></i18n:date>
          </td>
          <td  nowrap="yes">
            &#xA0;&#xA0;&#xA0;<i18n:text>To</i18n:text>:
           <i18n:date format="common"><xsl:value-of select="@ToDate"/></i18n:date>
          </td>
          <td  nowrap="yes">
          </td>
        </tr>
      </table>
    </td>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template match="FIELD_LEGEND" mode="layout_row">
    <xsl:apply-templates select="." mode="content"/>
  </xsl:template>

  <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template match="FIELD_LEGEND" mode="layout_column">
    <tr>
      <xsl:apply-templates select="." mode="content"/>
    </tr>
  </xsl:template>

  <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template match="FIELD_LEGEND" mode="content">
    <td>
      <table width="30px" height="15px" bgcolor="{@Color}" cellspacing="0" cellpadding="0">
        <tr>
          <td/>
        </tr>
      </table>
    </td>
    <td nowrap="yes">
      <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>
    </td>
    <td width="5%"></td>
  </xsl:template>

  <!-- **********************************************************************
   *********************************************************************** -->
  <xsl:template match="T_FIELD_HR[@CollapsableRow='true']" mode="content">
    <xsl:param name="rowSpan" select="@RowSpan"/>
    <xsl:param name="colSpan" select="@ColSpan"/>
    <xsl:param name="pos"/>
    <xsl:param name="containerId" select="@containerId"/>
    
    <td nowrap="yes" align="left" id="{@Id}">
      
      <!-- 1/24/2005 WJD - Removed to conform with i2 UI design library -->
      <!--
      <xsl:if test="$colSpan > 1">
        <xsl:attribute name="style">font-weight: bold</xsl:attribute>
      </xsl:if>
      -->
      <xsl:attribute name="align">
        <xsl:choose>
          <xsl:when test="string-length(@Align) > 0"><xsl:value-of select="@Align"/></xsl:when>
          <xsl:otherwise>left</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="valign">
        <xsl:choose>
          <xsl:when test="string-length(@VAlign) > 0"><xsl:value-of select="@VAlign"/></xsl:when>
          <xsl:otherwise>middle</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>      
      <xsl:apply-templates select="." mode="decorate_cell">
        <xsl:with-param name="rowSpan" select="$rowSpan"/>
        <xsl:with-param name="colSpan" select="$colSpan"/>
      </xsl:apply-templates>
      
      <a href="javascript:toggleCollapsableRows('{$containerId}','{@Id}', {@CollapseStartRow},{@RowCollapseSize})"><i2:img id="{concat($containerId,'.',@CollapseStartRow,'.TOGGLE_IMG')}" src="/minus_norgie.gif" border="0"/></a>&#xA0;
      
      <xsl:choose>
        <xsl:when test="@HeaderLink">
          <a href="{@HeaderLink}"><xsl:value-of select="@Value"/></a>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@Value"/>
          <xsl:if test="@Uom and @Value">
            &#xA0;(<xsl:value-of select="@Uom"/>)
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </td>
  </xsl:template>
  
</xsl:stylesheet>

