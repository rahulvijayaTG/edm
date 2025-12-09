<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  
  <xsl:import href="../../../bcm/context/xsl/context_header.xsl"/>
  <xsl:import href="../../../bcm/framework/queryform/xsl/searchformfilter.xsl"/>
  <xsl:output method="html"/>
 
  <!-- Page Content --> 
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="tabs">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <xsl:call-template name="include_javascript_table_resize"/>
    <xsl:call-template name="include_javascript_form"/>
  </xsl:template>
   
  <!-- **********************************************************************
       *********************************************************************** -->
  <!-- Container Content -->
  <xsl:template match="RESPONSE" mode="container_content">
    <table cellpadding="0" width="100%">
      <xsl:if test="count(SUCCESS_MESSAGE) &gt; 0">
        <tr>
            <td>                
                <xsl:apply-templates select="SUCCESS_MESSAGE"/>
            </td>
        </tr>
      </xsl:if>
      <xsl:if test="count(ERROR_MESSAGE) &gt; 0">
        <tr>
            <td>
                <xsl:apply-templates select="ERROR_MESSAGE"/>
            </td>
        </tr>
      </xsl:if>
      <tr>
        <td>
          <xsl:apply-templates select="ACTIVITY_SEARCH_FORM/SEARCH">
              <xsl:with-param name="formName" select="'result_form'"/>
          </xsl:apply-templates>
        </td>
      </tr>
    </table>
  </xsl:template>
  
 <!-- ***********************************************************************
  *********************************************************************** -->
  <xsl:template match="SUCCESS_MESSAGE">
    &#xA0;
      <i2:img src="/alert_green_static.gif" border="0" align="middle">
      <i2:attribute name="alt">
        <i18n:text>Success</i18n:text>
      </i2:attribute>
    </i2:img>
        &#xA0;
        <i18n:text>
      <xsl:value-of select="@Value"/>
    </i18n:text>
  </xsl:template>
  <xsl:template match="ERROR_MESSAGE">
    &#xA0;
      <i2:img src="/alert_static.gif" border="0" align="middle">
      <i2:attribute name="alt">
        <i18n:text>Error</i18n:text>
      </i2:attribute>
    </i2:img>
        &#xA0;
        <i18n:text>
      <xsl:value-of select="@Value"/>
    </i18n:text>
  </xsl:template>
  <!-- page.xsl Javascript -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="onLoad_js">
<![CDATA[
   function table_getObjectFromID(id)
  {
    var scrollable = true;
    if (document.getElementById(id+'_header') == null) scrollable = false;
    if (scrollable == true)
      return document.getElementById(id+'_data')
    else
      return document.getElementById(id)
  }

   function table_addLinkIfFieldHasValue(id, fieldNumber , fieldValue)
     {
		 
	    var tbl = table_getObjectFromID(id);
	    for (var i=1; i<tbl.rows.length; i++)
		{
		   var iCell=fieldNumber;
		       var val  =  tbl.rows[i].cells[1].innerText;
		       var id = null;
		       var checkbox = null;
		       try{
		       var checkbox = tbl.rows[i].cells[0].childNodes[0];
		        id = checkbox.value;
		       }catch(e){}
		       if (val != "" && val.indexOf("*") != 0 )
		       {
			var myAnchor = document.createElement("A");
			myAnchor.href="javascript:fieldAccessDetails('" + id + "');";
			var myImg = document.createElement("IMG");
			myImg.src =  omxContextPath + "/i2/images/related_property_search.gif";
			myImg.border="0"; myImg.alt = "Field Access Details";
			myAnchor.appendChild(myImg);
		        tbl.rows[i].cells[1].appendChild(myAnchor);
			}
}

       return true;
   }
  
    function fieldAccessDetails(id)
    {
      document.result_form.SELECTED_AUTH_SCOPE.value = id;
       document.result_form.action="user_activity_search/fieldAccessDetails.cmd";
       document.result_form.target="appFrame";
       document.result_form.submit();
    }
  ]]>
    function onLoad()
    {
      if (document.result_form.SELECTED_TAB.value == 'TABLE_EDITOR' ) 
      {
	 //alert("me");
	     table_addLinkIfFieldHasValue('result_form_table',1,null);
      }
      resize_Containers();
    }
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="onResize_js">
    function onResize()
    {
      /*resize_Containers(); */
    }
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_form">
    <script>
        <![CDATA[

    function showTab(ntype)
    {
            document.result_form.START_COUNT.value = "0";
        document.result_form.SELECTED_TAB.value = ntype;
        document.result_form.submit();
    }

        function SetfocusSubmit( target )
        {
            if(target.name == 'pagenum')
            {
                getRecords('jump');
            }
            else
            {
                dispatchSearch();
            }
        }

        function dispatchClear()
        {
          clearFields(result_form);
          dispatchSearch();
        }

        function dispatchSearch()
        {
          document.result_form.DO_SEARCH.value='Yes';
          document.result_form.START_COUNT.value=0;
          document.result_form.action="UserActivitySearch.jsp";
          document.result_form.submit();
        }

        function clearFields(form)
        {
          var count;
          var elementsLen = form.elements.length;
          var foundChecked = false;
          for(count = 0; count < elementsLen; count++)
          {
            if( form.elements[count].type == "checkbox" )
            {
              form.elements[count].checked = false;
            }
            if( form.elements[count].type == "text" )
            {
              form.elements[count].value = '';
            }
            if(form.elements[count].type == "select-one")
            {
              form.elements[count].selectedIndex = -1;
            }
          }
        }

        function trimFilterElements()
        {
            var elements = document.search_form.elements;
            var elementCount = elements.length;
            for (var i = 0; i < elementCount; i++) {
                elements[i].value = trimString(elements[i].value);
            }
        }

        function onSelect()
        {
            if ( checkifAnySelected(result_form) == true )
            {
                document.result_form.action="user_activity_search/addActivities.cmd";
                document.result_form.target="appFrame";
                document.result_form.submit();
            }else{
                core_alert("NO_SELECTION");
            }
        }
        function onSave()
        {
            if ( checkifAnySelected(result_form) == true )
            {
                document.result_form.RETURN.value="FALSE";
                document.result_form.action="user_activity_search/addActivities.cmd";
                document.result_form.target="appFrame";
                document.result_form.submit();
            }else{
                core_alert("NO_SELECTION");
            }
        }
        function onCancel()
        {
            document.result_form.action="user_role_details/display.cmd";
            document.result_form.target="appFrame";
            document.result_form.submit();
        }
       ]]>
  </script>
  </xsl:template>
  <!-- **********************************************************************
      *********************************************************************** -->
  <!-- Javascript -->
  <xsl:template name="include_javascript_table_resize">
    <script><![CDATA[
    function resize_Containers()
   {
    var table_id = 'result_form_table';
    var width = document.body.offsetWidth -5 ;
    var height = document.body.scrollHeight;
    // resize table   approx
    i2uiResizeScrollableArea(table_id, height, width-30, null, null, null,null, null);
    i2uiResizeScrollableContainer('result_form_container',document.body.offsetHeight-140, null, document.body.offsetWidth - 20, true, 'yes');

   }
  ]]>
  
        /*
        function jumpToPage(actionName, startCount, result_form, page_form)
        {
            var maxRows = 10;
//                  alert("user _sctivity search xsl.jumpToPage called ");
                    var nextCount = parseInt(startCount) + maxRows;
    //              alert('next count=' + nextCount );
                    var prevCount = 0;
                    if ( parseInt(startCount) > 0 )
                        prevCount = parseInt(startCount) - maxRows;
                
        //      alert('prevCount =' + prevCount );
                
                  if (startCount == null)
                      startCount=page_form.pagenum.value;
                
                    var pagenum= parseInt(startCount);  pagenum--;

            //    alert('pagenum =' + pagenum );
                
                    if (actionName == "jump")
                    {
                      if(( page_form.RECORD_COUNT.value == 0 || page_form.RECORD_COUNT.value &gt; pagenum*maxRows)  &amp;&amp; (pagenum+1&gt;0) &amp;&amp; (page_form.START_COUNT.value != pagenum*maxRows))
                      {
                          //result_form.reset();
                          result_form.DO_SEARCH.value='yes';
                          result_form.START_COUNT.value=pagenum*maxRows;
                          result_form.target="appFrame";
                          result_form.method="POST";
                          result_form.submit();
                        }
                        else
                  {
                    core_alert("<i18n:text>PAGINATION_ALERT</i18n:text>");
                  }
                    }
                }
                */
       </script>
  </xsl:template>
  <!-- **********************************************************************
      *********************************************************************** -->
</xsl:stylesheet>
