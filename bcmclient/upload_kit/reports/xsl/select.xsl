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
  <xsl:import href="../../../core/search/xsl/search.xsl"/>

  <xsl:output method="html"/>

  <!-- Page Content -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match = "RESPONSES" mode="content">

    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>

  </xsl:template>

  <!-- Container Content -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match = "RESPONSE" mode="container_content">
    <xsl:apply-templates select="SEARCH">
    </xsl:apply-templates>
    <xsl:call-template name="include_javascript_select_upload_status"/>
    <xsl:call-template name="include_javascript_select_item_resize"/>
  </xsl:template>


  <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template match="REPORTS" mode="container_content">


    <xsl:choose>
    <xsl:when test="count(REPORT) > 0">
    <i2:table>
       <i2:tr header="yes">
        <td nowrap="yes" align="center">
           
        </td>
        <td nowrap="yes">
          <i18n:text>Report ID</i18n:text>
        </td>
            <td nowrap="yes">
          <i18n:text>Document Type</i18n:text>
        </td>
            <td nowrap="yes">
          <i18n:text>Report Time</i18n:text>
        </td>
            <td width="22%" nowrap="yes">
          <i18n:text>Records Processed</i18n:text>
        </td>
            <td nowrap="yes">
          <i18n:text>Progress</i18n:text>
        </td>
        <td nowrap="yes">
          <i18n:text>Status</i18n:text>
        </td>
       </i2:tr>
          <xsl:apply-templates select="REPORT" />
        </i2:table>
   </xsl:when>
   <xsl:otherwise>
     <i18n:text>No upload reports available</i18n:text>
   </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="REPORT">
   <xsl:variable name="reportId">
    <xsl:value-of select="@ReportId" />
   </xsl:variable>
   <i2:tr>
      <td nowrap="yes" align="center">
        <input type="radio" name="ID" value="{$reportId}"/>
      </td>
      <td nowrap="yes">
        <a href="report_details.jsp?REPORT_ID={$reportId}" target="appFrame"><xsl:value-of select="$reportId"/></a>
      </td>
      <td nowrap="yes">
        <i18n:text><xsl:value-of select="TEMPLATE/@DisplayName"/></i18n:text>
      </td>
      <td nowrap="yes">
        <i18n:date><xsl:value-of select="@StartTime"/></i18n:date>
      </td>
      <td nowrap="yes">
        <xsl:value-of select="@Index"/>
      </td>
      <td nowrap="yes">
        <i18n:text><xsl:value-of select="@Progress"/></i18n:text>
      </td>
      <td nowrap="yes">
        <i18n:text><xsl:value-of select="@Status"/></i18n:text>
      </td>
   </i2:tr>
  </xsl:template>


  <!-- Form instruction -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="FORM" mode="instruction_area">
    <xsl:if test="/RESPONSES/RESPONSE/SUCCESS_MESSAGE/@Value">
      <xsl:call-template name="display_validation_area">
        <xsl:with-param name="pFormName" select="'search_form'"/>
        <xsl:with-param name="pAnyFieldIsRequired" select="count(FIELD[@Required = 'true']) > 0"/>
        <xsl:with-param name="pInstructionMessage" select="INSTRUCTION/@DisplayText"/>
        <xsl:with-param name="pSuccessMessage" select="/RESPONSES/RESPONSE/SUCCESS_MESSAGE/@Value"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- page.xsl Javascript -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="onLoad_js">
  function onLoad()
  {
    <xsl:call-template name="javascript_onLoad_search"/>
    <xsl:call-template name="javascript_onLoad_page"/>
   }
  </xsl:template>

  <!-- override from search.xsl -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="javascript_onLoad_search">
    <xsl:call-template name="javascript_onLoad_validation"/>
    <xsl:call-template name="javascript_resizeContainers"/>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
   <xsl:template name="onResize_js">
    function onResize()
    {
      <xsl:call-template name="javascript_onResize_search"/>
      <xsl:call-template name="javascript_onResize_page"/>
    }
  </xsl:template>


  <!-- Search.xsl Javascript -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="javascript_resizeContainers">
   resizeContainers_select_item();
  </xsl:template>


  <!-- Current.xsl Javascript -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="include_javascript_select_upload_status">
    <script>
    <![CDATA[
    function reprocessReports()
    {
        prevAction = document.result_form.action;
        if ( checkifAnyRadioSelected(result_form) == true )
        {
          document.result_form.target = "_self";
          document.result_form.action="../uploads/uploadcorrection/correction/reprocess.x2c";
          document.result_form.submit();
        }
        else
        {
          core_alert("PLEASE_SELECT_TRANSACTION");
        }
        document.result_form.action= prevAction;
   }

   function purgeReports()
      {
        prevAction = document.result_form.action;
        if ( checkifAnyRadioSelected(result_form) == true )
        {
        	var msg = "Purge will remove the selected Upload ID, Are you sure?";
        	var theButtonClicked = core_confirm(msg);
					if (theButtonClicked == 'yes')
					{
            document.result_form.target = "_self";
            document.result_form.action="../reports/purge/purge.x2c";
            document.result_form.submit();
          }
          else
          {
          	return;
          }
        }
        else
        {
            core_alert("PLEASE_SELECT_TRANSACTION");
        }
        document.result_form.action= prevAction;
      }

      function i2uiRowSelectionCallback(obj)
      {
        var status = getFieldValue(result_form,obj,'PROGRESS');
        var enableReprocessButton = false;
        var enablePurgeButton = false;

        if (status == 'Completed with gaps')
        {
					enablePurgeButton = true;
          enableReprocessButton = true;
        }

        if (status == 'Completed')
        {
        	enablePurgeButton = true;
        }

				if (status == 'Aborted')
				{
					enablePurgeButton = true;
				}

				if (enablePurgeButton)
				{
        	enableButton('purgeButton');
				}
				else
				{
					disableButton('purgeButton');
				}

        if (enableReprocessButton)
        {
          enableButton('reprocessButton');
        }
        else
        {
          disableButton('reprocessButton');
        }
      }

      /* support for row selector */
      var i2uiActiveRowSelector = null;
      var i2uiInvokeCallback = true;
      function i2uiToggleRowSelectionState(obj, originalstate, tableid, treecell, multiSelect)
      {
  // NS4 browser not supported
  if (document.layers != null)
    return;

  if (i2uiActiveRowSelector != null)
    obj = i2uiActiveRowSelector;
  else
  {
    // turn off any global selector
    var globalselector = document.getElementById(tableid+"_globalrowselector");
    if (globalselector != null)
      globalselector.checked = false;
  }

  // if single select, turn off previous row
  if (multiSelect == false)
  {
    // test for scrollable table
    var table = document.getElementById(tableid+"_data");
    if (table == null)
      table = document.getElementById(tableid);

    var len = table.rows.length;
    for (var i=0; i<len; i++)
    {
      if (table.rows[i].lastClassName != null)
      {
        table.rows[i].className = table.rows[i].lastClassName;
        if (table.rows[i].cells[0].childNodes &&
            table.rows[i].cells[0].childNodes.length > 0 &&
            table.rows[i].cells[0].childNodes[0].style != null)
          table.rows[i].cells[0].childNodes[0].style.backgroundColor = "";
        table.rows[i].lastClassName = null;
      }
    }
  }

  // find owning row
  var rowobj = obj;
  while (rowobj != null && rowobj.tagName != "TR")
  {
    if (rowobj.parentElement)
    {
      rowobj = rowobj.parentElement;
    }
    else
    {
      rowobj = rowobj.parentNode;
    }
  }
  if (rowobj != null)
  {
    rowobj.className = obj.checked?"rowHighlight":originalstate;
    rowobj.lastClassName = originalstate;
    rowobj.cells[0].childNodes[0].style.backgroundColor = "";
  }

  // handle treetable
  if (treecell != null &&
      treecell != '' &&
      i2uiActiveRowSelector == null)
  {
    var cellname = rowobj.cells[treecell].id.substring(9);
    var depth1 = Math.floor(cellname);
    var table = document.getElementById(tableid);
    var len = table.rows.length;
    for (var i=0; i<len; i++)
    {
      // locate desired row in table
      if (table.rows[i].cells[treecell].id == "TREECELL_"+cellname)
      {
        // now process rest of table with respect to located
        for (var j=i+1; j<len; j++)
        {
          var newcell = table.rows[j].cells[treecell].id.substr(9);
          var depth2 = Math.floor(newcell);
          if ((depth2 == depth1 + 10 || depth2 == depth1 + 15) ||
              (depth2 > depth1 + 5))
          {
            table.rows[j].cells[0].childNodes[0].checked = obj.checked;
            if (obj.checked)
            {
              table.rows[j].className = "rowHighlight";
              table.rows[j].cells[0].childNodes[0].style.backgroundColor = "";
            }
            else
            {
              var onclickhandler = table.rows[j].cells[0].childNodes[0].onclick+"!!!";
              var from = onclickhandler.indexOf("{");
              onclickhandler = onclickhandler.substring(from+1);
              var to = onclickhandler.lastIndexOf("}");
              onclickhandler = onclickhandler.substring(0,to);
              i2uiActiveRowSelector = table.rows[j].cells[0].childNodes[0];
              eval(onclickhandler);
              i2uiActiveRowSelector = null;
            }
          }
          if (depth2 <= depth1)
          {
            break;
          }
        }

        var handle = depth1 - 10;
        // now set partial state of all parents of selected node
        for (var j=i-1; j>-1; j--)
        {
          var newcell = table.rows[j].cells[treecell].id.substr(9);
          var depth2 = Math.floor(newcell);
          if (depth2 == handle || depth2 == handle-5)
          {
            var selectedcount = 0;
            var nonselectedcount = 0;
            for (var k=j+1; k<len; k++)
            {
              var newcell2 = table.rows[k].cells[treecell].id.substr(9);
              var depth3 = Math.floor(newcell2);
              if ((depth3 == depth2 + 10 || depth3 == depth2 + 15) ||
                  (depth3 > depth2 + 5))
              {
                if (table.rows[k].cells[0].childNodes[0].checked)
                  selectedcount++;
                else
                  nonselectedcount++;
              }
              if (depth3 <= depth2)
              {
                break;
              }
            }

            if (selectedcount > 0)
            {
              if (nonselectedcount > 0)
              {
                table.rows[j].cells[0].childNodes[0].checked=false;
                var onclickhandler = table.rows[j].cells[0].childNodes[0].onclick+"!!!";
                var from = onclickhandler.indexOf("{");
                onclickhandler = onclickhandler.substring(from+1);
                var to = onclickhandler.lastIndexOf("}");
                onclickhandler = onclickhandler.substring(0,to);
                i2uiActiveRowSelector = table.rows[j].cells[0].childNodes[0];
                eval(onclickhandler);
                i2uiActiveRowSelector = null;
                table.rows[j].cells[0].childNodes[0].style.backgroundColor = "#fff6a6";
              }
              else
              {
                table.rows[j].cells[0].childNodes[0].checked = true;
                table.rows[j].className = "rowHighlight";
                table.rows[j].cells[0].childNodes[0].style.backgroundColor = "";
              }
            }
            else
            {
              table.rows[j].cells[0].childNodes[0].checked=false;
              table.rows[j].cells[0].childNodes[0].style.backgroundColor = "";

              if (nonselectedcount > 0)
              {
              var onclickhandler = table.rows[j].cells[0].childNodes[0].onclick+"!!!";
              var from = onclickhandler.indexOf("{");
              onclickhandler = onclickhandler.substring(from+1);
              var to = onclickhandler.lastIndexOf("}");
              onclickhandler = onclickhandler.substring(0,to);
              i2uiActiveRowSelector = table.rows[j].cells[0].childNodes[0];
              eval(onclickhandler);
              i2uiActiveRowSelector = null;
              }
            }
            // look up one more level
            handle -= 10;
            if (handle < 0)
              break;
          }
        }

        break;
      }
    }
  }
  if (i2uiInvokeCallback)
    try{i2uiRowSelectionCallback(obj)}catch(e){}

 }
      function getFieldValue(form , radioObject, fieldName )
      {
       if (form == null) return true;

       var elemLen = form.elements.length;

       for( i = 0; i < elemLen; i++ )
       {
         if (radioObject == form.elements[i])
         {
           for( j = i+1; j < elemLen; j++ )
           {
             if (form.elements[j].name == fieldName)
             {
               return form.elements[j].value;
             }
           }
         }
       }
       return '';
    }

    function onLoad()
    {
     resizeTable(null, 46,250, 'container','40','40');
     onLoadSuper();
     resizeContainers_select_item();
     disableButton('purgeButton');
     disableButton('reprocessButton');
    }
  ]]>
    </script>
  </xsl:template>

  <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template name="include_javascript_select_item_resize">
  <script>

  <![CDATA[
  // Resizing All containers
    function resizeContainers_select_item()
    {
      parentContainer_id = 'container';
      parentContainerScroller_id = parentContainer_id + '_scroller';
      parentIsScrolling = false;

      table_id = 'result_form_table';
      table_container_id = 'result_form_container';
      search_form_container_id = 'search_form_container'

      // resize top level container
      i2uiResizeScrollableContainer(parentContainer_id,document.body.offsetHeight - 90, null, document.body.offsetWidth -40, true, 'yes');


      var width = document.body.offsetWidth - 45;
	    var height = document.body.scrollHeight - 250;

      // resize table   approx
      i2uiResizeScrollableArea(table_id, height, width - 15, null, null, null,null, null);
      i2uiResizeColumns(table_id);

      // if parent container is scrolling
      var obj = document.getElementById(parentContainerScroller_id);
      if(obj)
      {
        // subtract its scrollbar
        width = width- (obj.offsetWidth - obj.clientWidth) ;
        if ((obj.offsetWidth - obj.clientWidth) > 0)
        {
          parentIsScrolling = true;
        }

      }

     tablewidth = width-16; // for now

     // resize table
     i2uiResizeScrollableArea(table_id, height + 20, tablewidth + 15, null, null, null,null, null)
     i2uiResizeColumns(table_id);
     // resize the table container
     i2uiResizeScrollableContainer(table_container_id, document.body.offsetHeight - 20, null, width  , true, 'yes');

     // resize the search container
     i2uiResizeScrollableContainer(search_form_container_id,document.body.offsetHeight - 20, null, width  , true, 'yes');
     // resize top level container
     i2uiResizeScrollableContainer(parentContainer_id,document.body.offsetHeight - 20, null, document.body.offsetWidth -40, true, 'yes');
     return parentIsScrolling;
  }
  ]]>
  </script>

</xsl:template>


  <!-- **********************************************************************
  *********************************************************************** -->
</xsl:stylesheet>
