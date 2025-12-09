<?xml version="1.0" standalone='no'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../framework/queryform/xsl/searchformfilter.xsl"/>

  <xsl:output method="html"/>

  <xsl:variable name="page" select="/RESPONSES/RESPONSE/PAGE"/>
  <xsl:variable name="single_quote">'</xsl:variable>
  <xsl:variable name="sel_tab">
    <xsl:if test="string-length(/RESPONSES/RESPONSE/SELECTED_TAB/@Value) = 0">
      <xsl:value-of select="'HIERARCHY'"/>
    </xsl:if>
    <xsl:if test="string-length(/RESPONSES/RESPONSE/SELECTED_TAB/@Value) &gt; 0">
      <xsl:value-of select="/RESPONSES/RESPONSE/SELECTED_TAB/@Value"/>
    </xsl:if>
  </xsl:variable>

  <xsl:template match="RESPONSES" mode="content">
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <xsl:call-template name="include_javascript_table"/>
    <xsl:call-template name="include_javascript_table_resize"/>
  </xsl:template>


<xsl:template match="RESPONSE" mode="container_content">
     <xsl:call-template name="display_instruction_area"/>
  <table hieght="5%" border="0">
    <tr>
     <td>
     </td>
     </tr>
  </table>
  <xsl:choose>
   <xsl:when test="$sel_tab ='HIERARCHY'">
    <i2:tabbedcontainer>
          <i2:tabset id="tabs_container" field="grey">
            <i2:tab name="Hierarchy" selected="Yes" onclick="javaScript:showTab('HIERARCHY')">Hierarchy
            </i2:tab>
            <i2:tab name="Attributes" selected="No" onclick="javaScript:showTab('ATTRIBUTES')">Attributes
            </i2:tab>
          </i2:tabset>
      <xsl:call-template name="get_entity_table"/>
      <i2:footer>
        <i2:buttonbar aligncontents="right">
           <i2:button emphasized="yes" onclick="javascript:onClear()"><i18n:text>Clear All Hierarchy</i18n:text>&#xA0;&#xA0;</i2:button>
        </i2:buttonbar>
          </i2:footer>
    </i2:tabbedcontainer>
    </xsl:when>
    <xsl:otherwise>
    <i2:tabbedcontainer>
      <i2:tabset id="tabs_container" field="grey">
        <i2:tab name="Hierarchy" selected="No" onclick="javaScript:showTab('HIERARCHY')">Hierarchy
        </i2:tab>
        <i2:tab name="Attributes" selected="Yes" onclick="javaScript:showTab('ATTRIBUTES')">Attributes
        </i2:tab>
      </i2:tabset>
      <xsl:call-template name="get_entity_table"/>
      <i2:footer>
          <i2:buttonbar aligncontents="right">
            <i2:button emphasized="yes" onclick="javascript:onClear()"><i18n:text>Clear All</i18n:text>&#xA0;&#xA0;</i2:button>
        </i2:buttonbar>
          </i2:footer>
    </i2:tabbedcontainer>
    </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="get_entity_table">
   <form name="result_form" method="POST">
     <input type="hidden" name="SELECTED_TAB" Value="{$sel_tab}"/>
     <input type="hidden" name="PAGE" Value="{$page/@Value}"/>
     <input type="hidden" name="FROM_COLUMN" Value=""/>
     <input type="hidden" name="REFERRED_TABLE" Value=""/>
     <input type="hidden" name="REFERRED_COLUMN" Value=""/>
     <input type="hidden" name="SERVICE" Value="BCMMasterService"/>
     <input type="hidden" name="FROM_TABLE" Value=""/>
     <input type="hidden" name="TABLE_NAME" Value=""/>
     <input type="hidden" name="FORM_NAME" Value="{//RESPONSES/RESPONSE/FORM_NAME/@Value}"/>
     <input type="hidden" name="SAVE_ACTION" Value="{//RESPONSES/RESPONSE/SAVE_ACTION/@Value}"/>

  <table id="entity_table" width="100%" border="0">
    <tr>
     <td>
       <xsl:apply-templates select="ENTITY_DETAILS">
     	  <xsl:with-param name="formName" select="'result_form'"/>
          <xsl:with-param name="element" select="//RESPONSES/RESPONSE/ENTITY_DETAILS"/>
       </xsl:apply-templates>
     </td>
   </tr>
   <tr><td colspan="4">
     <hr/></td>
   </tr>
   <tr>
     <td>
     <xsl:choose>
      <xsl:when test="$sel_tab ='HIERARCHY'">
	    <xsl:apply-templates select="ATTRIBUTE_DETAILS">
	      <xsl:with-param name="formName" select="'result_form'"/>
	      <xsl:with-param name="element" select="//RESPONSES/RESPONSE/ATTRIBUTE_DETAILS/HIERARCHY_ATTRIBUTES"/>
	      <xsl:with-param name="elementMetaData" select="//RESPONSES/RESPONSE/ATTRIBUTE_DETAILS/HIERARCHY_ATTRIBUTES"/>
	      <xsl:with-param name="cellpadding" select="5"/>
	      <xsl:with-param name="cellspacing" select="5"/>
	    </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="ATTRIBUTE_DETAILS">
	      <xsl:with-param name="formName" select="'result_form'"/>
	      <xsl:with-param name="element" select="//RESPONSES/RESPONSE/ATTRIBUTE_DETAILS/NON_HIERARCHY_ATTRIBUTES"/>
	      <xsl:with-param name="elementMetaData" select="//RESPONSES/RESPONSE/ATTRIBUTE_DETAILS/NON_HIERARCHY_ATTRIBUTES"/>
	      <xsl:with-param name="cellpadding" select="5"/>
	      <xsl:with-param name="cellspacing" select="5"/>
        </xsl:apply-templates>
      </xsl:otherwise>
     </xsl:choose>
     </td>
    </tr>

   </table>
   </form>
 </xsl:template>

  <xsl:template match="ENTITY_DETAILS">
    <xsl:param name="element"/>



<table width="50%" height="100%" cellspacing="2" cellpadding="2" border="0">
   <xsl:for-each select="$element/PROPERTY">
     <xsl:variable name="currentProperty" select="."/>
     <xsl:choose>
       <xsl:when test="$currentProperty/@Hidden='no'">
        <tr>
           <td nowrap="nowrap" align="left">&#xA0;
	     <xsl:value-of select="$currentProperty/@DisplayName"/><xsl:text>:</xsl:text>
	     <xsl:if test="$currentProperty/@Required and $currentProperty/@Required='yes'">
		  <xsl:call-template name="display_alert_mark"/>
	     </xsl:if>
           </td>
           <td align="left">
             <xsl:choose>
               <xsl:when test="$currentProperty/@Editable='no'">
                   <input type="field" name="{$currentProperty/@Name}" id="{$currentProperty/@Name}"  value="{$currentProperty/@Value}" class="inputfieldIE" maxlength="32" tabIndex="" size="27" disabled="true">
                     <xsl:if test="$currentProperty/@Required and  $currentProperty/@Required='yes' ">
		       <xsl:attribute name="required"><xsl:value-of select="'true'"/></xsl:attribute>
		     </xsl:if>
                   </input>
                 </xsl:when>
                 <xsl:otherwise>
                    <input type="field" name="{$currentProperty/@Name}" id="{$currentProperty/@Name}" value="{$currentProperty/@Value}" class="inputfieldIE" maxlength="32" tabIndex="" size="27">
                       <xsl:if test="$currentProperty/@Required and  $currentProperty/@Required='yes' ">
                           <xsl:attribute name="required"><xsl:value-of select="'true'"/></xsl:attribute>
                       </xsl:if>
                       <xsl:if test="$currentProperty/@Type='int'">
                           <xsl:attribute name="onkeyup">
                              <xsl:value-of select="'javaScript:onlyValidCharacters(/[0123456789.,\u0020\u00A0]/);'"/>
                           </xsl:attribute>
                       </xsl:if>
                     </input>
                  </xsl:otherwise>
             </xsl:choose>
             <xsl:if test="$currentProperty/@Refers and $currentProperty/@Editable='yes'">
               <A HREF="{concat('javascript:onGotoSelectForeignKey(', $single_quote, $currentProperty/@Name, $single_quote, ',', $single_quote, $currentProperty/@Refers, $single_quote,  ',',$single_quote, $currentProperty/@ReferredColumn, $single_quote, ',',$single_quote, $currentProperty/@Document, $single_quote, ');')} ">

                  <i2:img src="/pop_up_window.gif" border="0" align="bottom"/>
               </A>
             </xsl:if>
             <xsl:choose>
               <xsl:when test="($currentProperty/@Required and  $currentProperty/@Required='yes') and not($currentProperty/@HasError and  $currentProperty/@HasError='yes')">
                  <xsl:call-template name="display_alert_image">
                    <xsl:with-param name="fieldName" select="$currentProperty/@Name"/>
                  </xsl:call-template>
               </xsl:when>
               <xsl:when test="$currentProperty/@HasError and  $currentProperty/@HasError='yes'">
                  <xsl:variable name="err_message">
		       <xsl:choose>
			  <xsl:when test="string-length($currentProperty/@Value) &gt; 0">
			      <xsl:value-of select="$currentProperty/@ErrDescr"/>
			  </xsl:when>
			  <xsl:otherwise>
			      <xsl:value-of select="'Required Field11'"/>
			  </xsl:otherwise>
			</xsl:choose>
   	          </xsl:variable>
   	          <xsl:call-template name="display_alert_image_onvalidate">
			  <xsl:with-param name="fieldName" select="concat($currentProperty/@Name,'_ERR')"/>
			  <xsl:with-param name="fieldErr" select="$err_message"/>
                  </xsl:call-template>
                </xsl:when>
             </xsl:choose>
           </td>
        </tr>
       </xsl:when>
       <xsl:otherwise>
	 <input type="hidden" name="{$currentProperty/@Name}" id="{$currentProperty/@Name}"  value="{$currentProperty/@Value}" class="inputfieldIE" maxlength="32" tabIndex="" size="27" disabled="true"/>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:for-each>
    </table>
  </xsl:template>

<xsl:template match="ATTRIBUTE_DETAILS">
    <xsl:param name="noOfColumns" select="2"/>
    <xsl:param name="cellpadding" select="0"/>
    <xsl:param name="cellspacing" select="0"/>
    <xsl:param name="element"/>
    <xsl:param name="elementMetaData"/>

        <table width="100%" height="100%" cellspacing="{$cellspacing}" cellpadding="{$cellpadding}" border="0">
          <xsl:call-template name="doLayout">
            <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
            <xsl:with-param name="elementCount" select="count($element/*)"/>
            <xsl:with-param name="element" select="$element"/>
            <xsl:with-param name="elementMetaData" select="$elementMetaData"/>
           </xsl:call-template>
        </table>

</xsl:template>

<xsl:template name="doLayout">
    <xsl:param name="startingPosition" select="0"/>
    <xsl:param name="noOfColumns"/>
    <xsl:param name="elementCount"/>
    <xsl:param name="element"/>
    <xsl:param name="elementMetaData"/>
    <tr>
    <xsl:choose>
      <xsl:when test="$elementMetaData">

          <xsl:for-each select="$elementMetaData/PROPERTY[position() &gt; $startingPosition and position() &lt; $startingPosition + $noOfColumns + 1]">
            <xsl:call-template name="render_row">
              <xsl:with-param name="currentProperty" select="$element"/>
              <xsl:with-param name="startingPosition" select="$startingPosition"/>
              <xsl:with-param name="endPosition" select="$startingPosition + 1"/>
            </xsl:call-template>
          </xsl:for-each>

        </xsl:when>
        <xsl:otherwise>

          <xsl:for-each select="$element/*[position() &gt; $startingPosition and position() &lt; $startingPosition + $noOfColumns + 1]">
          <xsl:call-template name="render_row">
        <xsl:with-param name="currentProperty" select="$element"/>
        <xsl:with-param name="startingPosition" select="$startingPosition"/>
        <xsl:with-param name="endPosition" select="$startingPosition + 1"/>
          </xsl:call-template>
          </xsl:for-each>
        </xsl:otherwise>
    </xsl:choose>
    </tr>


    <xsl:if test="$startingPosition + $noOfColumns &lt; $elementCount">
      <xsl:call-template name="doLayout">
        <xsl:with-param name="startingPosition" select="$startingPosition + $noOfColumns"/>
        <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
        <xsl:with-param name="elementCount" select="$elementCount"/>
        <xsl:with-param name="element" select="$element"/>
        <xsl:with-param name="elementMetaData" select="$elementMetaData"/>
      </xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:template name="render_row">
  <xsl:param name="currentProperty"/>
  <xsl:param name="startingPosition"/>
  <xsl:param name="endPosition"/>
  <xsl:variable name="currentProperty" select="."/>
  <script>
    //alert("'<xsl:value-of select="$startingPosition"/>'")
   // alert("'<xsl:value-of select="$currentProperty/@Name"/>'")
    //alert("'<xsl:value-of select="$currentProperty/@Sequence"/>'")
  </script>
  <xsl:if test="$currentProperty/@Hidden = 'no'">
     <td nowrap="nowrap">
       <xsl:value-of select="$currentProperty/@DisplayName"/>
       <xsl:if test="$currentProperty/@Required and $currentProperty/@Required='yes'">
               <xsl:call-template name="display_alert_mark"/>
       </xsl:if>
     </td>
     <td align="left">
        <xsl:choose>
            <xsl:when test="$currentProperty/@Editable='no'">
                <input type="field" name="{$currentProperty/@Name}" id="{$currentProperty/@Name}"  value="{$currentProperty/@Value}" class="inputfieldIE" maxlength="32" tabIndex="" size="27" disabled="true">
                  <xsl:if test="$currentProperty/@Required and  $currentProperty/@Required='yes' ">
            <xsl:attribute name="required"><xsl:value-of select="'true'"/></xsl:attribute>
          </xsl:if>
           </input>
            </xsl:when>
            <xsl:otherwise>
               <input type="field" name="{$currentProperty/@Name}" id="{$currentProperty/@Name}" value="{$currentProperty/@Value}" class="inputfieldIE" maxlength="32" tabIndex="" size="27">
                  <xsl:if test="$currentProperty/@Required and  $currentProperty/@Required='yes' ">
                        <xsl:attribute name="required"><xsl:value-of select="'true'"/></xsl:attribute>
                    </xsl:if>
                  <xsl:if test="$currentProperty/@Type='int'">
                    <xsl:attribute name="onkeyup">
                      <xsl:value-of select="'javaScript:onlyValidCharacters(/[0123456789.,\u0020\u00A0]/);'"/>
                    </xsl:attribute>
                  </xsl:if>
                </input>
            </xsl:otherwise>
        </xsl:choose>
       <xsl:if test="$currentProperty/@Refers and $currentProperty/@Editable='yes'">
            <A HREF="{concat('javascript:onGotoSelectForeignKey(', $single_quote, $currentProperty/@Name, $single_quote, ',', $single_quote, $currentProperty/@Refers, $single_quote,  ',',$single_quote, $currentProperty/@ReferredColumn, $single_quote, ',',$single_quote, $currentProperty/@Document, $single_quote, ');')} ">

           <i2:img src="/pop_up_window.gif" border="0" align="bottom"/>
         </A>
       </xsl:if>
       <xsl:choose>
         <xsl:when test="($currentProperty/@Required and  $currentProperty/@Required='yes') and not($currentProperty/@HasError and  $currentProperty/@HasError='yes')">
             <xsl:call-template name="display_alert_image">
               <xsl:with-param name="fieldName" select="$currentProperty/@Name"/>
             </xsl:call-template>
         </xsl:when>
         <xsl:when test="$currentProperty/@HasError and  $currentProperty/@HasError='yes'">
             <xsl:variable name="err_message">
	       <xsl:choose>
		  <xsl:when test="string-length($currentProperty/@Value) &gt; 0">
		      <xsl:value-of select="$currentProperty/@ErrDescr"/>
		  </xsl:when>
		  <xsl:otherwise>
		      <xsl:value-of select="'Required Field11'"/>
		  </xsl:otherwise>
	        </xsl:choose>
	      </xsl:variable>
	      <xsl:call-template name="display_alert_image_onvalidate">
		  <xsl:with-param name="fieldName" select="concat($currentProperty/@Name,'_ERR')"/>
		  <xsl:with-param name="fieldErr" select="$err_message"/>
              </xsl:call-template>
         </xsl:when>
        </xsl:choose>
       </td>
     </xsl:if>

</xsl:template>
<xsl:template name="display_alert_image_onvalidate">
    <xsl:param name="fieldName"/>
    <xsl:param name="fieldErr"/>
    <xsl:variable name="err">
      <i18n:text><xsl:value-of select="$fieldErr"/></i18n:text>
    </xsl:variable>
    <xsl:variable name="id" select="$fieldName"/>
      &#xA0;<i2:img src="/alert_static_small.gif" id="{$id}" alt="{$err}" border="0" align="middle"/>
</xsl:template>
<xsl:template name="onLoad_js">
        function onLoad()
        {
          requiredFieldCheck(true);
        }
    </xsl:template>
  <xsl:template name="include_javascript_table">
    <script>
    var currenttab='<xsl:value-of select="$sel_tab"/>';
    <![CDATA[
    function showTab(ntype)
    {
      document.result_form.target="appFrame";
      document.result_form.method="POST";
      document.result_form.SELECTED_TAB.value = ntype;
      //document.result_form.name.value=document.result_form.name_REQ.value;
      document.result_form.action="controller/display.cmd";
      document.result_form.submit();
    }

    function onGotoSelectForeignKey(fromColumn, referredTable, referredColumn, fromTable)
      {
        document.result_form.target="appFrame";
        document.result_form.FROM_COLUMN.value= fromColumn;
        document.result_form.REFERRED_TABLE.value= referredTable;
        document.result_form.REFERRED_COLUMN.value= referredColumn;
        document.result_form.FROM_TABLE.value= fromTable;
        document.result_form.TABLE_NAME.value= fromTable;
        //document.result_form.name.value=document.result_form.name_REQ.value;
        document.result_form.method="POST";
        document.result_form.action="controller/getParentLevelMembers.cmd";
        document.result_form.submit();
      }

     function onCreate()
          {
                var error = "false";
                var count ;

                error = requiredFieldCheck();
                if (error == 'false')
                {
                   document.result_form.target="appFrame";
                   document.result_form.method="POST";
                   document.result_form.SELECTED_TAB.value=currenttab;
                 //  document.result_form.name.value=document.result_form.name_REQ.value;
                   document.result_form.action="controller/createEntity.cmd";
                   document.result_form.submit();
                }
          }


        function clearFields(form)
         {
        var count;
        var elementsLen = form.elements.length;
        var foundChecked = false;

        for(count = 0; count < elementsLen; count++)
        {
          if(!form.elements[count].disabled)
          {
            if( form.elements[count].type == "checkbox" ){
              form.elements[count].checked = false;
              //alert ('set '+form.elements[count].name);
               }
             if( form.elements[count].type == "text" ){
              form.elements[count].value = '';
              //alert ('set '+form.elements[count].name);
               }
          }
             }
           }
           function onClear()
            {
                 document.result_form.target="appFrame";
                 clearFields(document.forms.result_form);
            }


        function onClose()
        {
          document.result_form.action="npiItemDetails.jsp";
          document.result_form.submit();
        }


        function onRevert()
      {
        //document.result_form.name.value=document.result_form.name_REQ.value;
        document.result_form.action="controller/revertChanges.cmd";
        document.result_form.submit();
          }

        ]]>
    </script>
   </xsl:template>

 <xsl:template name="include_javascript_table_resize">
     <script><![CDATA[



   function IEEnterKey()
   {

   }

     function SetfocusSubmit( target )
     {

     }

   ]]></script>
  </xsl:template>

</xsl:stylesheet>