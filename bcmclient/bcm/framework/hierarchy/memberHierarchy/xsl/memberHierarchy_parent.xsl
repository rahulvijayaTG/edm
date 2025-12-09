<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:xalan="http://xml.apache.org/xalan"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                exclude-result-prefixes="xalan"
                version="1.0">

 <xsl:import href="../../../../../core/xsl/mdm_buttons.xsl"/>
  <xsl:output method="html"/>

  <!-- Page Content -->
   <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="RESPONSES">

      <!-- Body -->
      <table id="top_table" border="0" cellpadding="0" cellspacing="0"  width="100%">
          <td width="40%" >
            <xsl:call-template name="MEMBER_HIEARCHY_PARENT"/>
           </td>
      </table>
     <xsl:call-template name="include_javascript_memberHierarchy"/>
  </xsl:template>

    <!--**************************************************
  *********************************************************************** -->
  <xsl:template name="MEMBER_HIEARCHY_PARENT">
    <xsl:variable name="title">
      &lt;b&gt;<i18n:text>Members At Current  Level</i18n:text>&lt;/b&gt;
    </xsl:variable>
<form name="ParentMemForm" method="POST">
    <input type="hidden" name="parent_mem_name"/>
    <input type="hidden" name="parent_mem_id"/>
    <input type="hidden" name="show_child"/>
    <input type="hidden" name="go_down"/>
    <input type="hidden" name="go_up"/>
    <input type="hidden" name="HierarchyId" value="{/RESPONSES/RESPONSE/HierarchyId/@Value}"/>
    <input type="hidden" name="LevelId" value="{/RESPONSES/RESPONSE/LevelId/@Value}"/>
    <input type="hidden" name="isLeaf" value="{/RESPONSES/RESPONSE/IS_LEAF/@Value}"/>

    <input type="hidden" name="RECORD_COUNT" value="{$totalRecordCount}"/>
    <input type="hidden" name="START_COUNT" value="{$startAtRow}"/>
    <input type="hidden" name="MAX_ROWS" value="{$maxRows}"/>

    <i2:container id="parent_container"  title="{$title}"  inner="yes"  stretch="yes">
      <i2:header>
        <table border="0" cellpadding="2" cellspacing="0" width="100%">
          <tr>
           <xsl:if test="count(/RESPONSES/RESPONSE/PARENT_HIERARCHY/PARENT) > 0">
            <td align="right">
              <a href="javascript:getMembersOneLevelUp()">
                <xsl:variable name="txtAltAttr">
                  <i18n:text>Go One Level Up</i18n:text>
                </xsl:variable>
                <i2:img src="/upld_avail.gif" alt="{$txtAltAttr}" border="0"/>
              </a>
            </td>
           </xsl:if>
           <xsl:if test="/RESPONSES/RESPONSE/IS_LEAF/@Value = 'FALSE'">
            <td align="right">&#xA0;
              <a href="javascript:getMembersOneLevelDown()">
                <xsl:variable name="txtAltAttr">
                  <i18n:text>Go One Level Down</i18n:text>
                </xsl:variable>
                <i2:img src="/dnld_avail.gif" alt="{$txtAltAttr}" border="0"/>
              </a>
            </td>
           </xsl:if>    
          </tr>
        </table>
      </i2:header>
          <table>
            <tr>
           </tr>
            <tr>
                <td align="left">
                    <input fieldtype="text" name="P_SRCH" value="{/RESPONSES/RESPONSE/P_SRCH/@Value}" required="true" tabIndex="" type="field" class="inputfieldIE" size="17"/>
               </td>
                <td align="left">
                    <xsl:call-template name="mdmButton">
                        <xsl:with-param name="onclick" select="'javascript:onSearch();'"/>
                        <xsl:with-param name="text" select="'Search'"/>
                    </xsl:call-template>
                
                    <!--i2:button id="button1" name="button1" onclick="javascript:onSearch()">&#xA0;&#xA0;<i18n:text>Search</i18n:text>&#xA0;&#xA0;</i2:button-->
               </td>
            </tr>
          </table>
       <table id="filter_tab" >
         <tr>
                <td nowrap="nowrap"  width="100%">

                  <select size="10" onchange="javascript:populate_field_properties(this);" class="pulldownIE" name="parentList" tabIndex="">
                    <!--<option value="">AA</option>
                    <option value="">BB</option>
                    <option value="">CC</option>
                    <option value="">DD</option>
                    <option value="">EE</option>-->
                    <xsl:apply-templates select="/RESPONSES/RESPONSE/RESPONSE/MemberRelations"/>
                    <!-- <xsl:apply-templates select="/RESPONSES/RESPONSE/RESPONSE/MemberHierarchy"/> -->
<!--
                    <option value="">&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;</option>
-->
                  </select>
                </td>

            </tr>
       </table>
      <i2:footer>


                    <table cellspacing="0" cellpadding="0" width="100%"  border="0">
                        <td>
                           <i2:pagingcontrol currentPage="{$currentPage}" recordsPerPage="{number($maxRows)}" totalRecords="{number($totalRecordCount)}"/>
                        </td>
                        <td align="right">
                            <xsl:call-template name="mdmButton">
                                <xsl:with-param name="onclick" select="'javascript:showAssignUnAssignChild();'"/>
                                <xsl:with-param name="text" select="'Show Child'"/>
                            </xsl:call-template>
                            <!--i2:button id="button1" name="button1" onclick="javascript:showAssignUnAssignChild()">&#xA0;<i18n:text>Show Child</i18n:text>&#xA0;</i2:button-->
                        </td>
                    </table>

      </i2:footer>

    </i2:container>
</form>
</xsl:template>
   <!--**************************************************
  *********************************************************************** -->
  <xsl:template match="MemberHierarchy">
     <xsl:choose>
         <xsl:when test="/RESPONSES/RESPONSE/one_level_up_parent_id/@Value = NodeId/@Value ">
             <option selected="yes" name="{NodeId/@Value}" Value="{NodeId/@Value}">
                <i18n:text><xsl:value-of select="Name/@Value"/></i18n:text>
             </option>
             <script>
                document.ParentMemForm.parent_mem_id.value = '<xsl:value-of select="NodeId/@Value"/>';
                document.ParentMemForm.parent_mem_name.value = '<xsl:value-of select="Name/@Value"/>';
             </script>
         </xsl:when>
         <xsl:otherwise>
             <option name="{NodeId/@Value}" Value="{NodeId/@Value}">
                <i18n:text><xsl:value-of select="Name/@Value"/></i18n:text>
             </option>
         </xsl:otherwise>
     </xsl:choose>

  </xsl:template>
  
  
  <xsl:template match="MemberRelations">
       <xsl:choose>
           <xsl:when test="/RESPONSES/RESPONSE/one_level_up_parent_id/@Value = memberID/@Value ">
               <option selected="yes" name="{NodeId/@Value}" Value="{memberID/@Value}">
                  <i18n:text><xsl:value-of select="Name/@Value"/></i18n:text>
               </option>
               <script>
                  document.ParentMemForm.parent_mem_id.value = '<xsl:value-of select="memberID/@Value"/>';
                  document.ParentMemForm.parent_mem_name.value = '<xsl:value-of select="Name/@Value"/>';
               </script>
           </xsl:when>
           <xsl:otherwise>
               <option name="{NodeId/@Value}" Value="{memberID/@Value}">
                  <i18n:text><xsl:value-of select="Name/@Value"/></i18n:text>
               </option>
           </xsl:otherwise>
       </xsl:choose>
  
    </xsl:template>
  
   <!--**************************************************
     
  ************************** PAGINATION *************************************** -->
    <xsl:variable name="maxRows">
        <xsl:choose>
            <xsl:when test="/RESPONSES/RESPONSE/MAX_ROWS/@Value">
                <xsl:value-of select="/RESPONSES/RESPONSE/MAX_ROWS/@Value"/>
            </xsl:when>
            <xsl:otherwise>10</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="totalRecordCount">
        <xsl:choose>
            <xsl:when test="/RESPONSES/RESPONSE/TOTAL_RECORD_COUNT/@Value">
                <xsl:value-of select="/RESPONSES/RESPONSE/TOTAL_RECORD_COUNT/@Value"/>
            </xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="startAtRow">
        <xsl:choose>
            <xsl:when test="/RESPONSES/RESPONSE/START_COUNT/@Value">
                <xsl:value-of select="/RESPONSES/RESPONSE/START_COUNT/@Value"/>
            </xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="currentPage"><xsl:value-of select="ceiling(($startAtRow+1) div $maxRows)"/></xsl:variable>

    <xsl:variable name="endPage">
    <xsl:choose>
      <xsl:when test="$totalRecordCount = '1000000000000000'"><i18n:text>UnKnown</i18n:text>
      </xsl:when>
      <xsl:otherwise><xsl:value-of select="ceiling($totalRecordCount div $maxRows)"/></xsl:otherwise>
    </xsl:choose>
    </xsl:variable>

<!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template name="include_javascript_memberHierarchy">
  <script>
    var maxRows="<xsl:value-of select="$maxRows"/>";
   <![CDATA[

      function onSearch(){
        document.ParentMemForm.START_COUNT.value  = "0";
        document.ParentMemForm.target="memberHierarchy_parent";
        document.ParentMemForm.action="memberHierarchy_parent.jsp";
        document.ParentMemForm.submit();
      }

      function getMembersOneLevelDown(){
        var parent_mem_id = trimString(document.ParentMemForm.parent_mem_id.value);
        //alert("parent_mem_id=" + parent_mem_id);
        if (parent_mem_id == null || parent_mem_id == "" )
        {
           core_alert( "SELECT_ONE_PARENT_MEMBER_ALERT");
           return;
        }
        document.ParentMemForm.target="appFrame";
        document.ParentMemForm.go_down.value = 'TRUE';
        document.ParentMemForm.show_child.value = 'FALSE';
        //alert("document.ParentMemForm.go_down.value=" + document.ParentMemForm.LevelId.value);
        document.ParentMemForm.action="memberHierarchyController/getMembersOneLevelDown.cmd";
        document.ParentMemForm.submit();
      }

      function getMembersOneLevelUp(){
        document.ParentMemForm.target="appFrame";
        document.ParentMemForm.go_up.value = 'TRUE';
        document.ParentMemForm.go_down.value = 'FALSE';
        document.ParentMemForm.show_child.value = 'FALSE';
        document.ParentMemForm.action="memberHierarchyController/getMembersOneLevelUp.cmd";
        document.ParentMemForm.submit();
      }

      function showAssignUnAssignChild()
      {

        var parent_mem_id = trimString(document.ParentMemForm.parent_mem_id.value);
        //alert("parent_mem_id=" + parent_mem_id);
        if (parent_mem_id == null || parent_mem_id == "" )
        {
           core_alert( "SELECT_ONE_PARENT_MEMBER_ALERT");
           return;
        }
       document.ParentMemForm.show_child.value = 'TRUE';
       loadChild();
       loadUnassignedChild();

      }

      function loadChild(){
        document.ParentMemForm.target="memberHierarchy_child";
        document.ParentMemForm.action="memberHierarchyController/displayChild.cmd";
        document.ParentMemForm.submit();
      }

      function loadUnassignedChild(){
        document.ParentMemForm.target="memberHierarchy_unassignedChild";
        document.ParentMemForm.action="memberHierarchyController/displayUnAssignedChild.cmd";
        document.ParentMemForm.submit();
      }

      function populate_field_properties ( columnSelector ) {
          //alert("populate_field_properties=" +    columnSelector );

           var selected_column_name = columnSelector[columnSelector.selectedIndex].value;
           var selected_column_displayname = columnSelector[columnSelector.selectedIndex].text;

           //alert("parent_mem_id=" + selected_column_name);
           //alert("parent_mem_name=" + selected_column_displayname);

        document.ParentMemForm.parent_mem_id.value = selected_column_name;
        document.ParentMemForm.parent_mem_name.value = selected_column_displayname;
      }
     function onLoad(){
       //var one_level_up_parent_id =   '<xsl:value-of select="/RESPONSES/RESPONSE/one_level_up_parent_id/@Value"/>';
       //alert( "one_level_up_parent_id=" + one_level_up_parent_id);
       //document.AssignedMemForm.parentList.options[one_level_up_parent_id].selected = 'true' ;

      }
    function IEEnterKey()
    {
        if(window.event.keyCode == 13)
            {
                SetfocusSubmit(window.event.srcElement)
                    event.returnValue=false;
            }
    }
function SetfocusSubmit( target )
{
  if(target.name == 'pagenum')
  {
    getRecords('jump');
  }
  else
  {
    onSearch();
  }
}
      // Pagination
      function getRecords(actionName, startCount, result_form, page_form)
      {

          if(page_form == null)  page_form = document.ParentMemForm;

          if(result_form == null)  result_form = document.ParentMemForm;

          jumpToPage(actionName, startCount, result_form, page_form);
      }

        function jumpToPage(actionName, startCount, result_form, page_form)
      {
          //alert("hello");
          //alert("actionName="+actionName);
          //alert("startCount="+startCount);
          //alert("result_form="+result_form);
         //alert("page_form="+page_form);
          var nextCount = parseInt(startCount) + maxRows;
          var prevCount = 0;

          if ( parseInt(startCount) > 0 )
              prevCount = parseInt(startCount) - maxRows;

          if (startCount == null)
            startCount=page_form.pagenum.value;

          var pagenum= parseInt(startCount);  pagenum--;

          if (actionName == "jump")
          {
            if(( page_form.RECORD_COUNT.value == 0 || page_form.RECORD_COUNT.value > pagenum*maxRows)  && (pagenum+1>0) && (page_form.START_COUNT.value != pagenum*maxRows))
            {
                result_form.reset();
                //by anish
                result_form.START_COUNT.value=pagenum*maxRows;
                result_form.target="memberHierarchy_parent";
                result_form.action="memberHierarchy_parent.jsp";
                result_form.submit();
              }
          else
          {
            core_alert("PAGINATION_ALERT");
          }
           }
      }

  ]]>

  </script>
  </xsl:template>
<!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>

