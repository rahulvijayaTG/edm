<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">


  <xsl:import href="../../../core/xsl/form.xsl"/>
  <xsl:import href="../../../core/xsl/table.xsl"/>
  <xsl:import href="../../../core/xsl/buttons.xsl"/>
   
   
  <xsl:output method="html"/>


<!-- ********************************************************************** 
     *********************************************************************** -->
  <xsl:template match="SEARCH">

    <!-- Javascript -->
    <xsl:call-template name="include_javascript_search"/>
    
    <!-- Search Form -->
     <xsl:apply-templates select="FORM"/>
       
    <!-- Search Error --> 
    <xsl:apply-templates select="REPORT/_ERROR"/>
      
    <!-- Search Report --> 
 
    <xsl:apply-templates select="REPORT/TABLE"/>

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
  <i2:javascript path="/search.js"></i2:javascript>
  <script>
  
  <![CDATA[

  // Searching
  function onSearch()
  {
    if ( validate_search() == true )
        {
            document.search_form.START_COUNT.value=0;
            document.search_form.DO_SEARCH.value='Yes';
            document.search_form.submit();
        }
         else
          onResize();
  }

  // Saving Search
  function onSaveSearch()
  {
    if ( validateSaveSearch() == true )
        {
            document.search_form.action=omxContextPath + '/core/search/controller/saveInSession.x2c';
            document.search_form.submit();
        }
        else
          onResize();

  }
  
  // Form Validations
  function validateSaveSearch()
  {
    var count;
    var elementsLen = document.search_form.elements.length;
    var foundFilledField = false;
    var msg = "";
    
    for(count = 0; count < elementsLen; count++)
        {
            if( 
               document.search_form.elements[count].type !="hidden" &&
               document.search_form.elements[count].value != "" )
                {
                    foundFilledField = true;break;
                }
        }
    if (foundFilledField == false)
        {
            msg += "Please specify search criteria";
            
            return false;
        }
    return validate_search();
  }


  function validate_search()
  {
    var bIsFormValid = isFormValid('search_form') ;
    return   bIsFormValid;
  }
]]>
</script>
</xsl:template>

  
  <!-- Javascript -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="javascript_onLoad_search">  
      <xsl:call-template name="javascript_onLoad_validation"/>
      setFocus();
      <xsl:call-template name="javascript_resizeContainers"/>
  </xsl:template>
  
  
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="javascript_onResize_search">  
      <xsl:call-template name="javascript_resizeContainers"/>
      onResizeSuper();  
  </xsl:template>

  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="javascript_resizeContainers">  
  </xsl:template>

  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="javascript_resizeTables">  
    <xsl:param name="pWidth" select="'42'"/>
    <xsl:param name="pHeight" select="'100'"/>
    <xsl:param name="pParentContainerId" select="'container'"/>

    <xsl:param name="ptlcWidth" select="'20'"/>
    <xsl:param name="ptlcHeight" select="'105'"/>

    resizeTable(null, <xsl:value-of select="$pWidth"/>,<xsl:value-of select="$pHeight"/>, '<xsl:value-of select="$pParentContainerId"/>','<xsl:value-of select="$ptlcWidth"/>','<xsl:value-of select="$ptlcHeight"/>');
  </xsl:template>
  


  <!-- Search Error -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template match = "_ERROR">

    <table  width="100%"   cellspacing="1" cellpadding="0" border="0">
      <tr>
        <td>
          <!-- Title --> 
          <xsl:variable name="title">
            &lt;b&gt;<i18n:text>Search Error</i18n:text>&lt;/b&gt;:&#xA0;&lt;i&gt;<xsl:value-of select="@Description"/>   
          </xsl:variable>
            
          <i2:container inner="yes" title="{$title}">
          </i2:container> 
        </td>
      </tr>
    </table>
  </xsl:template>

<!-- ********************************************************************** 
     *********************************************************************** -->

 <!-- ********************************************************************** 
      *********************************************************************** -->
  <xsl:template name="include_javascript_search_resize_form_table">
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
    function resizeContainers(addheight, addwidth)
    {
      table_id = 'result_form_table';
      table_container_id = 'result_form_container';
      container_id = 'search_form_container'
      // width
      var width = document.body.clientWidth
                  - 11 // grey
                  - 11  // grey
                  -1 + addwidth;

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

      tablewidth = width-16-1; // scrollbar
      tableheight = Math.max(20, height); // min table height

     // resize the table
     i2uiResizeScrollableArea(table_id, tableheight, tablewidth, null, 20)
     i2uiResizeColumns(table_id);
     i2uiResizeScrollableContainer(table_container_id, document.body.offsetHeight - 20, null, width  , true, 'yes');

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
