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
      <b><i18n:text>Unassigned Members</i18n:text></b>
    </xsl:variable>
   <form name="UnAssignedMemForm" method="POST">
    <input type="hidden" name="HierarchyId" value="{/RESPONSES/RESPONSE/HierarchyId/@Value}"/>
    <input type="hidden" name="LevelId" value="{/RESPONSES/RESPONSE/LevelId/@Value}"/>
    <input type="hidden" name="refresh_child" value="TRUE"/>

    <input type="hidden" name="RECORD_COUNT" value="{$totalRecordCount}"/>
    <input type="hidden" name="START_COUNT" value="{$startAtRow}"/>
    <input type="hidden" name="MAX_ROWS" value="{$maxRows}"/>

    <i2:container id="unassignedchild_container"  title="{$title}"  inner="yes"  stretch="yes">
          <table>
            <tr>
           </tr>
            <tr>
                <td align="left">
                    <input fieldtype="text" name="UC_SRCH" value="{/RESPONSES/RESPONSE/UC_SRCH/@Value}" required="true" tabIndex="" type="field" class="inputfieldIE" size="17"/>
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

                  <select multiple="yes"  onchange="javascript:populate_field_properties(this);"  size="10" class="pulldownIE" name="unAssigendChildList" tabIndex="">
                    <!--<option value="">aaa</option>
                    <option value="">bbb</option>
                    <option value="">ccc</option>
                    <option value="">ddd</option>
                    <option value="">eee</option>-->
                    <xsl:apply-templates select="/RESPONSES/RESPONSE/RESPONSE/Member"/>
<!--
                    <option value="">&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;</option>
-->
                  </select>
                </td>

            </tr>
       </table>
      <i2:footer>

          <i2:pagingcontrol currentPage="{$currentPage}" recordsPerPage="{number($maxRows)}" totalRecords="{number($totalRecordCount)}"/>


      </i2:footer>

    </i2:container>
   </form>

  </xsl:template>
   <!--**************************************************
  *********************************************************************** -->
  <xsl:template match="Member">
     <option id="{ID/@Value}">
      <i18n:text><xsl:value-of select="NAME/@Value"/></i18n:text>
     </option>
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

      var hash;
      var orig_hash;
      var maxRows="<xsl:value-of select="$maxRows"/>";
      var confirmMesg="<i18n:text>Do you want to  save your changes?</i18n:text>";

      function onLoad()
      {

         hash = new Hashtable();
         orig_hash = new Hashtable();

        <xsl:for-each select="/RESPONSES/RESPONSE/RESPONSE/Member">
           hash.put("<xsl:value-of select="ID/@Value"/>","<xsl:value-of select="NAME/@Value"/>");
           orig_hash.put("<xsl:value-of select="ID/@Value"/>","<xsl:value-of select="NAME/@Value"/>");
        </xsl:for-each>

        //alert("hash=" + hash.toString() ) ;

      }
     function onSearch() {
       document.UnAssignedMemForm.START_COUNT.value  = "0";
       document.UnAssignedMemForm.action = "memberHierarchy_unassignedChild.jsp";
       document.UnAssignedMemForm.submit();

      }
   <![CDATA[

     var   selectedUnAssignedChildOptions = 0;

      function populate_field_properties ( columnSelector ) {

         var len = columnSelector.options.length;
         // reset the value
        selectedUnAssignedChildOptions = 0 ;


         for( i = 0 ; i < len ; i++) {

              if(columnSelector.options[i].selected)
                 selectedUnAssignedChildOptions++;
         }

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

         
          if(page_form == null || page_form == 'null')  page_form = document.UnAssignedMemForm;

          if(result_form == null || result_form == 'null')  result_form = document.UnAssignedMemForm;
         top.i2ui_shell_content.appFrame.content_new.footer.calculateNetChange();
            
        if(top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.assigned_mem_ids.value != ""
           ||  top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.unassigned_mem_ids.value != ""
           )
        {

          if(core_confirm( confirmMesg ) == 'yes' )
            top.i2ui_shell_content.appFrame.content_new.footer.onSave( );
           else //revert the changes
           {
            top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.restore();
            hash = orig_hash;
            top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.renderUnAssignedChildCombo();
           }

          }
          jumpToPage(actionName, startCount, result_form, page_form);
      }
      
    function restore()
    {

            var tmp = new Hashtable();            
            var keys = orig_hash.keys();
            for(j = 0;j < orig_hash.size() ; j++) {
              tmp.put(keys[j], orig_hash.get(keys[j]));
            }  
            hash = tmp;
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
                result_form.target="memberHierarchy_unassignedChild";
                result_form.action="memberHierarchy_unassignedChild.jsp";
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

