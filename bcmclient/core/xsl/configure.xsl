<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

  <xsl:import href="page.xsl"/>
  <xsl:import href="dualListBoxControl.xsl"/>

  <!-- Page Title -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="page_title">
    <i18n:text>Customize Table</i18n:text>
  </xsl:template>
 
  <xsl:template match="RESPONSE" mode="content">
    <script>
      <![CDATA[
      function apply()
      {
        var hasSelections =false;
        if (document.form.tolistbox.options.length >= 1)
        {
          for (var i = 0; i < document.form.tolistbox.options.length; i++)
          {
            document.form.tolistbox.options[i].selected = true;
            hasSelections = true;
          }
        }
        if (hasSelections == false)
        {
           btn = core_confirm("No columns are selected. Do you want to use the default settings?");
           if (btn == 'no') return;
        }

        document.form.action = "configure/apply.x2c"
        document.form.submit();
      }

      function onChange()
      {
        list = event.srcElement;
        document.form.description.value = list.options[list.selectedIndex].description;
         
         // Unselect all options on the other box
          if (list == document.form.fromlistbox)
        {
           for (var i = 0; i < document.form.tolistbox.options.length; i++)
          {
            document.form.tolistbox.options[i].selected = false;
          }
//            i2uiToggleButtonState('duallist_singleleft','disabled');
//            i2uiToggleButtonState('duallist_singleright','enabled');

        }
        else if (list == document.form.tolistbox)
        {
           for (var i = 0; i < document.form.fromlistbox.options.length; i++)
          {
            document.form.fromlistbox.options[i].selected = false;
          }
//            i2uiToggleButtonState('duallist_singleleft','enabled');
//            i2uiToggleButtonState('duallist_singleright','disabled');
          
        }
      }

      function onDblClick()
      {
        list = event.srcElement;
        if (list == document.form.fromlistbox)
        {
          i2uiduallistboxmoveit(document.form.fromlistbox,document.form.tolistbox)
        }
        else if (list == document.form.tolistbox)
        {
          i2uiduallistboxmoveit(document.form.tolistbox,document.form.fromlistbox)
        }
  //          i2uiToggleButtonState('duallist_singleleft','enabled');
//            i2uiToggleButtonState('duallist_singleright','enabled');

      }
    ]]>
    </script>


    <form name="form" method="POST">

      <input type="hidden" name="TABLE_ID" value="{TABLE_ID/@Value}"/>
      <input type="hidden" name="PAGE_ID" value="{PAGE_ID/@Value}"/>
      <input type="hidden" name="SYS_ID" value="{SYS_ID/@Value}"/>
      <input type="hidden" name="SYSTEM_LEVEL" value="{SYSTEM_LEVEL/@Value}"/>

      <i2:container editable="false" scrollable="no" width="100%" id="container">
        <i2:attribute name="title">
          <i18n:text>Customize Table</i18n:text>
        </i2:attribute>

        <table cellspacing="8" cellpadding="0">
          <tr>
            <td>
              <i2:table id="frombox">
                <tr class="tableColumnHeadings">
                  <td>
                    <i18n:text>Available Columns</i18n:text>
                  </td>
                </tr>
                <tr>
                  <td>
                    <select name="fromlistbox"
                      size="10" multiple="yes"
                      style="width:225px;
                      overflow:scroll;
                      scrollbar=yes"
                      onchange="javascript:onChange();"
                      ondblclick="javascript:onDblClick();"
                      >
                      <xsl:for-each select="TABLE/MASTER/FIELDS/FIELD">
                        <option value="{./@name}" description="FIELD.{./@name}.DESCRIPTION">
                          <i18n:text>
                            <xsl:value-of select="./@displayText"/>
                          </i18n:text>
                        </option>
                      </xsl:for-each>
                    </select>
                  </td>
                </tr>
              </i2:table>
            </td>
            <td>
              <xsl:call-template name="i2:uiduallistboxactionstemplate">
                <xsl:with-param name="firstbox">document.form.fromlistbox</xsl:with-param>
                <xsl:with-param name="secondbox">document.form.tolistbox</xsl:with-param>
              </xsl:call-template>
            </td>
            <td>
              <i2:table id="tobox">
                <tr class="tableColumnHeadings">
                  <td colspan="2">
                    <i18n:text>Displayed Columns</i18n:text>
                  </td>
                </tr>
                <tr class="editableArea">
                  <td>
                    <table cellspacing="0" cellpadding="0" border="0">
                      <tr>
                        <td>
                          <select name="tolistbox" size="10"
                            multiple="yes" style="width:225px; overflow:scroll;
                            scrollbar=yes"
                            onchange="javascript:onChange();"
                            ondblclick="javascript:onDblClick();"
                            >
                            <xsl:for-each select="TABLE/CFG/FIELDS/FIELD">
                              <option value="{./@name}" description="FIELD.{./@name}.DESCRIPTION">
                                <i18n:text>
                                  <xsl:value-of select="./@displayText"/>
                                </i18n:text>
                              </option>
                            </xsl:for-each>
                          </select>
                        </td>
                        <td>
                          <table cellspacing="4" cellpadding="4" border="0">
                            <tr>
                              <td>
                                <xsl:call-template name="i2:uiduallistboxordertemplate">
                                  <xsl:with-param name="list">document.form.tolistbox</xsl:with-param>
                                </xsl:call-template>
                              </td>
                            </tr>
                          </table>

                        </td>
                      </tr>
                    </table>

                  </td>

                </tr>
              </i2:table>
            </td>
          </tr>
          <!--<tr>
            <td colspan="3">
              <b>
                <i18n:text>Description of selected field</i18n:text>
              </b>
            </td>
          </tr>
          <tr>
            <td colspan="3">
              <textarea cols="75" name="description" class="textArea" onFocus="this.blur();"></textarea>
            </td>
          </tr>-->
          <!-- Remove this if uncommenting above-->
          <input type="hidden" name="description"/>
        </table>

        <i2:footer>
          <i2:buttonbar>
            <i2:button  onclick="javascript:onClose()">&#xA0;
              <i18n:text>Cancel</i18n:text>&#xA0;
            </i2:button>
            <i2:button    onclick="javascript:apply()">&#xA0;
              <i18n:text>Apply</i18n:text>&#xA0;
            </i2:button>
          </i2:buttonbar>
        </i2:footer>

      </i2:container>
    </form>
  </xsl:template>

   <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_onLoad">
    <script>
      function onLoad()
      {
        //centerPopup(580,330);
        onLoadSuper();//Page.xsl
      }
    </script>
  </xsl:template>

</xsl:stylesheet>
