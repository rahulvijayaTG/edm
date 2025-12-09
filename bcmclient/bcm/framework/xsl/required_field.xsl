<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:output method="html"/>

  <xsl:template name="include_form_validation_js">

  <script>

    function requiredFieldCheck(fromOnLoad)
    {
      var i, j;
      var requiredFieldMissing = 'false';
      var success = false ;
      var error = false ;

      <xsl:choose>
        <xsl:when test=" string-length(/RESPONSES/RESPONSE/SUCCESS_MESSAGE/@Value) &gt; 0 ">
          var success = true;
        </xsl:when>
        <xsl:when test=" string-length(/RESPONSES/RESPONSE/ERROR_MESSAGE/@Value) &gt; 0 ">
          var error = true;
        </xsl:when>
      </xsl:choose>


      var locstr = "";

      for( j = 0; j &lt; document.forms.length; j++)
      {
        var formName = document.forms[j];
        var elementsLen = formName.elements.length;

        for(i = 0; i &lt; elementsLen; i++)
        {
          var elem = document.forms[j].elements[i];
          var elemtype = elem.type;
          var elemName = elem.name;
          var elemValue = elem.value.trim();
          if(  elemValue.length ==  0)
          {
            //alert("lenth=0 " + elemName);
            elemValue = null;
          }
          var elemReq = elem.required;
          var elemDis = elem.disabled;
          var item = elemName + "_REQ";

		  if (elemReq == 'false') {
            var parent = elem.parentElement
            var childLen = parent.childNodes.length;
            if ( childLen &gt; 1)
            {
              for(k = 0; k &lt; childLen; k++)
              {
                if( parent.childNodes[k].id == item )
                {
				toggleItemVisibility(parent.childNodes[k], 'hide');
				}
			  }
			}
		  }
          if( elemReq == 'true' )
          {
            var parent = elem.parentElement
            //alert(parent.tagName);
            var childLen = parent.childNodes.length;
            if ( childLen &gt; 1)
            {
              for(k = 0; k &lt; childLen; k++)
              {
                if( parent.childNodes[k].id == item )
                {
                  //alert(fromOnLoad);

                  if ( fromOnLoad || elemValue || elemDis )
                  {
                    toggleItemVisibility(parent.childNodes[k], 'hide');
                  }
                  else if( (!elemDis) )
                  {
                    requiredFieldMissing = 'true';
                    toggleItemVisibility(parent.childNodes[k], 'show');
                  }

                  //alert(parent.childNodes[k].id);
                }
              }
            }
            else
            {
              if( parent.childNodes[1].id == item )
              {
                //alert(fromOnLoad);

                if ( fromOnLoad || elemValue || elemDis )
                {
                  toggleItemVisibility(parent.childNodes[k], 'hide');
                }
                else if( (!elemDis) )
                {
                  requiredFieldMissing = 'true';
                  toggleItemVisibility(parent.childNodes[k], 'show');
                }
              }
            }
          }
        }
      }

      if ( requiredFieldMissing == 'true')
      {
        i2uiToggleItemVisibility('denotes_required_field', 'hide');
        i2uiToggleItemVisibility('required_field_missing', 'show');
        i2uiToggleItemVisibility('success_message', 'hide');
        i2uiToggleItemVisibility('error_message', 'hide');
      }
      else if (success)
      {
        i2uiToggleItemVisibility('required_field_missing', 'hide');
        i2uiToggleItemVisibility('denotes_required_field', 'hide');
        i2uiToggleItemVisibility('success_message', 'show');
        i2uiToggleItemVisibility('error_message', 'hide');
      }
      else if (error)
      {
        i2uiToggleItemVisibility('required_field_missing', 'hide');
        i2uiToggleItemVisibility('denotes_required_field', 'hide');
        i2uiToggleItemVisibility('success_message', 'hide');
        i2uiToggleItemVisibility('error_message', 'show');
      }
      else
      {
        i2uiToggleItemVisibility('required_field_missing', 'hide');
        i2uiToggleItemVisibility('denotes_required_field', 'show');
        i2uiToggleItemVisibility('success_message', 'hide');
        i2uiToggleItemVisibility('error_message', 'hide');
      }
      //alert(locstr);
      return requiredFieldMissing;
    }

    function toggleItemVisibility(item,state)
    {
      if (item != null)
      {
        // setting display to none or "" can damage the DOM for
        // Netscape 6.  you may want to consider the visibility
        // attribute instead.
        if (state == null)
        {
          if (item.style.display == "none")
          {
            item.style.display = "";
            item.style.visibility = "visible";
          }
          else
          {
            item.style.display = "none";
          }
        }
        else
        {
          if (state == 'show')
          {
            item.style.display = "";
            item.style.visibility = "visible";
          }
          else
          {
            item.style.display = "none";
          }
        }
      }
    }
  </script>
</xsl:template>


<xsl:template name="display_instruction_area">
  <xsl:call-template name="include_form_validation_js"/>
  <xsl:call-template name="display_validation_messages"/>
</xsl:template>


<xsl:template name="display_validation_messages">


    <table border="0" id="required_field_missing" cellpadding="0" cellspacing="0" width="100%" class="instructionArea">
      <tr>
        <td align="left" valign="middle">
          &#xA0;<i2:img src="/alert_static_small.gif" alt="alert" border="0" align="middle"/>&#xA0;
        </td>
        <td align="left" valign="middle" width="100%">
          <i18n:text>Please fill in all the required fields before proceeding...</i18n:text>
        </td>
      </tr>
    </table>

    <table border="0" id="denotes_required_field" cellpadding="0" cellspacing="0" width="100%" class="instructionArea">
      <tr>
        <td align="left" width="100%">
          <font color="red">*</font>&#xA0;
          <i18n:text>denotes required field</i18n:text>
        </td>
      </tr>
    </table>

    <table border="0" id="success_message" cellpadding="0" cellspacing="0" width="100%" class="instructionArea">
      <tr>
        <td align="middle" valign="middle" width="5%">
          <i2:img src="/alert_green_static.gif" alt="Success" border="0" align="middle"/>
        </td>
        <td align="left" valign="middle" width="100%">
          <i18n:text><xsl:value-of select="/RESPONSES/RESPONSE/SUCCESS_MESSAGE/@Value"/></i18n:text>
        </td>
      </tr>
    </table>

    <table border="0" id="error_message" cellpadding="0" cellspacing="0" width="100%" class="instructionArea">
          <xsl:apply-templates select="/RESPONSES/RESPONSE/ERROR_MESSAGE"/>
    </table>

  </xsl:template>

   <xsl:template match="ERROR_MESSAGE">
     <tr>
       <td align="middle" valign="middle" width="5%">
         <i2:img src="/alert_static.gif" alt="Error" border="0" align="middle"/>
       </td>
       <td align="left" valign="middle" width="100%">
          <i18n:text><xsl:value-of select="@Value"/></i18n:text>
       </td>
     </tr>
  </xsl:template>


  <xsl:template name="display_alert_image">
    <xsl:param name="fieldName"/>
    <xsl:variable name="id" select="concat($fieldName, '_REQ')"/>
    &#xA0;<i2:img src="/alert_static_small.gif" id="{$id}" alt="Required Field" border="0" align="middle"/>
  </xsl:template>

  <xsl:template name="display_alert_mark">
    <font color="red">*</font>
  </xsl:template>

   <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="_ERRORS" mode="icon_tip">
    <xsl:for-each select="_ERROR">
      <xsl:variable name="alt">
        <i18n:text><xsl:value-of select="./@Value"/></i18n:text>
      </xsl:variable>
      &#xA0;<i2:img onclick="javascript:core_alert('{$alt}')" src="/alert_static_small.gif" alt="{$alt}" border="0" align="middle"/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>






