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
  <xsl:template match="SEARCH" mode="layout">

    <!-- Javascript -->
    <xsl:call-template name="include_javascript_search"/>
    <xsl:call-template name="include_javascript_for_scrolling_search"/>
    <i2:javascript path="/calendar.js"></i2:javascript>

    <!--xsl:call-template name="include_javascript_validation">
    </xsl:call-template-->

    <xsl:variable name="cellspacing">
      <xsl:choose>
        <xsl:when test="@Type= 'Hidden'">0</xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
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
        <tr>
          <td>
            <xsl:choose>
              <xsl:when test="@Type= 'Hidden'">
              </xsl:when>
              <xsl:otherwise>
                <i2:container collapsable="{@Collapsable}" title="{$label}" scrollable="yes" inner="yes"  id="{@Id}">


                  <xsl:apply-templates select="VALIDATION" mode="validation_area"/>

                  <table border="0" cellpadding="0" cellspacing="0"  width="100%">
                  <tr>
                    <td valign="top" >
                      <xsl:apply-templates select="FIELDS" mode="layout"/>
                    </td>
                  </tr>
                  </table>

                  <i2:footer>
                    <xsl:apply-templates select="BUTTONS"/>
                  </i2:footer>

                </i2:container>
              </xsl:otherwise>
            </xsl:choose>

          </td>
        </tr>
    </table>

    <xsl:apply-templates select="script"/>

  </xsl:template>


  <!-- Popup -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="hide_i2uiPopupmenu">
    <i2:popupmenu name="sortOrder">
  	  <i2:popupmenuoption  url="javascript:sortOrder('Ascending')"><i2:attribute name="text"><i18n:text>Ascending</i18n:text></i2:attribute></i2:popupmenuoption>
	  	<i2:popupmenuoption  url="javascript:sortOrder('Descending')"><i2:attribute name="text"><i18n:text>Descending</i18n:text></i2:attribute></i2:popupmenuoption>
  	</i2:popupmenu>
  </xsl:template>


 <xsl:template name="include_javascript_search">

  <script>
  <![CDATA[

  // Pagination
function getRecords(actionName, startCount, search_form, page_form)
{
    jumpTo(actionName, startCount, document.form, document.form);
}

function setFocus()
{
  var elementsLen = document.form.elements.length;

  for(count = 0; count < elementsLen; count++)
  {
    if(
	    document.form.elements[count].type != "hidden"
      )
      {
        document.form.elements[count].focus();
        return;
      }
  }
}

function onKeyPress( target )
{

 if (target.disablePageKeyTapping == 'true') return;

  if (target.nodeName == 'INPUT' && target.name == 'pagenum')
  {
    getRecords('jump');
  }
  else if (target.nodeName == 'A')
  {
    target.click();
  }
  else
  {
     onSearch();
  }
}
function search_collapse()
{
  if (document.form.DO_SEARCH.value == 'Yes')
  i2uiCollapseContainer('search');
}

]]>
</script>
</xsl:template>



  <!-- **********************************************************************
        *********************************************************************** -->
    <xsl:template name="include_javascript_for_scrolling_search">
      <script>

        <![CDATA[
          i2uiManageTreeTableUserFunction = 'onClickNorgie';
          i2uiToggleContentUserFunction = 'onClickNorgie';

          function onClickNorgie(item, delta)
          {
            onResize();
          }

         function getContainerHeight(id)
         {
          container = document.getElementById(id);
          if (container == null)
            return 0;
          else
            return container.offsetHeight;
         }

         // Resizing All containers
          function ui_resize_search(addheight, addwidth)
          {
            table_id = 'table';
            table_container_id = 'table_container1';
            container_id = 'search'
            // width
            var width = document.body.clientWidth
                        - 14 // grey
                        - 14  // grey
                        -1 +6 + addwidth;

            // resize the form
            i2uiResizeScrollableContainer(container_id,document.body.offsetHeight - 20, null, width  , true, 'yes');

            // height
            var height = document.body.clientHeight
                         - 20  // page header
                         - 11  // grey
                         - getContainerHeight(container_id) // container
                         - 11 //grey
                         - 20 // table header
                         - 20 // table footer
                         - 58 // table title
                         - 3 //?? grey area
                         -20
                         + addheight
                         ;

            tablewidth = width-15 ; // scrollbar
            tableheight = Math.max(20, height); // min table height

           // resize the table
           i2uiResizeScrollableArea(table_id, tableheight, tablewidth, null, 20)
           i2uiResizeColumns(table_id);
      //     i2uiResizeScrollableContainer(table_container_id, document.body.offsetHeight - 20, null, width  , true, 'yes');

      //      test = document.getElementById('page_header');
      //      alert("page header " + test.offsetHeight );
      //      alert("document height " + document.body.offsetHeight );
      //      alert("search container Height " + getContainerHeight(search_form_container_id));
      //      alert("table container Height " + getContainerHeight(table_container_id));
      //
           return ;
        }
        ]]>


       </script>

    </xsl:template>
</xsl:stylesheet>
