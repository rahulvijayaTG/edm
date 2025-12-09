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
  <xsl:variable name="maxlen">21</xsl:variable>
    <!--**************************************************
  *********************************************************************** -->
  <xsl:template name="MEMBER_HIEARCHY_PARENT">
    <xsl:variable name="title">
      <b><i18n:text>Child Members</i18n:text></b>
      <xsl:if test="/RESPONSES/RESPONSE/parent_mem_name">
        <xsl:variable name="i18nmemName"><i18n:text><xsl:value-of select="/RESPONSES/RESPONSE/parent_mem_name/@Value"/></i18n:text></xsl:variable>
        <xsl:variable name="truncatedText">
          <xsl:choose>
            <xsl:when test="string-length($i18nmemName) > $maxlen">
              <xsl:value-of select="concat(substring($i18nmemName,0,$maxlen -3), '...')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$i18nmemName"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:text>&#xA0;:&#xA0;</xsl:text><xsl:value-of select="$truncatedText"/>
      </xsl:if>
    </xsl:variable>
<form name="AssignedMemForm" method="POST">
    <input type="hidden" name="START_MEMBER_HIERARCHY" value="{/RESPONSES/RESPONSE/START_MEMBER_HIERARCHY/@Value}"/>
    <input type="hidden" name="HierarchyId" value="{/RESPONSES/RESPONSE/HierarchyId/@Value}"/>
    <input type="hidden" name="LevelId" value="{/RESPONSES/RESPONSE/LevelId/@Value}"/>
    <input type="hidden" name="parent_mem_name" value="{/RESPONSES/RESPONSE/parent_mem_name/@Value}"/>
    <input type="hidden" name="parent_mem_id" value="{/RESPONSES/RESPONSE/parent_mem_id/@Value}"/>

    <input type="hidden" name="refresh_child" value="TRUE"/>

    <input type="hidden" name="assigned_mem_ids"/>

    <input type="hidden" name="unassigned_mem_ids"/>

    <input type="hidden" name="RECORD_COUNT" value="{$totalRecordCount}"/>
    <input type="hidden" name="START_COUNT" value="{$startAtRow}"/>
    <input type="hidden" name="MAX_ROWS" value="{$maxRows}"/>

  <table>
      <td width="90%">
            <i2:container id="child_container"  title="{$title}"  inner="yes"  stretch="yes" width="100%">
                     <table>
                         <td>
                             <table>
                               <tr>
                                   <td align="left">
                                       <input fieldtype="text" name="AC_SRCH" value="{/RESPONSES/RESPONSE/AC_SRCH/@Value}" required="true" tabIndex="" type="field" class="inputfieldIE" size="17"/>
                                  </td>
                                   <td align="left">
                                        <xsl:call-template name="mdmButton">
                                            <xsl:with-param name="onclick" select="'javascript:onSearch();'"/>
                                            <xsl:with-param name="text" select="'Search'"/>
                                        </xsl:call-template>
                                   
                                        <!--i2:button id="button1" name="button1" onclick="javascript:onSearch()">
                                            &#xA0;&#xA0;<i18n:text>Search</i18n:text>&#xA0;&#xA0;</i2:button-->
                                  </td>
                               </tr>
                              </table>
                              <table id="filter_tab" >
                                <tr>
                                       <td nowrap="nowrap"  width="60%">

                                         <select name="assigendChildList"  onchange="javascript:populate_field_properties(this);" multiple="yes" size="10"  class="pulldownIE" tabIndex="">
                                           <!--<option value="">aaa</option>
                                           <option value="">bbb</option>
                                           <option value="">ccc</option>
                                           <option value="">ddd</option>
                                           <option value="">eee</option>-->
                                            <xsl:apply-templates select="/RESPONSES/RESPONSE/RESPONSE/MemberRelations"/>
                                            
                                            <!-- <xsl:apply-templates select="/RESPONSES/RESPONSE/RESPONSE/MemberHierarchy"/> -->
<!--
                                           <option value="">&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;</option>
-->
                                         </select>
                                       </td>
                                       <td>

                                       </td>
                                   </tr>
                              </table>
                         </td>
                     </table>
              <i2:footer>
                  <i2:pagingcontrol currentPage="{$currentPage}" recordsPerPage="{number($maxRows)}" totalRecords="{number($totalRecordCount)}"/>
              </i2:footer>
         </i2:container>
      </td>
      <td>
          <table>
            <tr>
              <td>&#xA0;</td>
            </tr>
            <tr>
              <td>&#xA0;</td>
            </tr>
            <tr>
              <td>
               <i2:button id="onMoveDoubleRight" name="onMoveDoubleRight"  onclick="javascript:onMoveDoubleRight()">
                &#xA0;
                <i2:img src="/disabled_arrow_double_right.gif" align="bottom" border="0">
                  <i2:attribute name="alt">
                    <i18n:text>Unassign All Members</i18n:text>
                  </i2:attribute>
                </i2:img>
                 &#xA0;
               </i2:button>
              </td>
            </tr>
            <tr>
                <td>&#xA0;</td>
            </tr>
            <tr>
              <td>
               <i2:button id="onMoveRight" name="onMoveRight"  onclick="javascript:onMoveRight()">
                &#xA0;
                <i2:img src="/disabled_arrow_right.gif" align="bottom" border="0">
                  <i2:attribute name="alt">
                    <i18n:text>Unassign Selected Members</i18n:text>
                  </i2:attribute>
                </i2:img>
                 &#xA0;&#xA0;
               </i2:button>
              </td>
            </tr>
            <tr>
                <td>&#xA0;</td>
            </tr>
            <tr>
              <td>
               <i2:button id="onMoveLeft" name="onMoveLeft" onclick="javascript:onMoveLeft()">
                &#xA0;
                <i2:img  src="/disabled_arrow_left.gif" align="bottom" border="0">
                  <i2:attribute name="alt">
                    <i18n:text>Assign Selected Members</i18n:text>
                  </i2:attribute>
                </i2:img>
                 &#xA0;&#xA0;
               </i2:button>
              </td>
            </tr>
            <tr>
                <td>&#xA0;</td>
            </tr>
            <tr>
              <td>
                <i2:button id="onMoveDoubleLeft" name="onMoveDoubleLeft" onclick="javascript:onMoveDoubleLeft()">
                &#xA0;
                <i2:img src="/disabled_arrow_double_left.gif" align="bottom" border="0">
                  <i2:attribute name="alt">
                    <i18n:text>Assign All Members</i18n:text>
                  </i2:attribute>
                </i2:img>
                 &#xA0;
                </i2:button>
              </td>
            </tr>
            <tr>
              <td>&#xA0;</td>
            </tr>
          </table>
   </td>
 </table>
</form>

  </xsl:template>
   <!--**************************************************
  *********************************************************************** -->
  <xsl:template match="MemberHierarchy">
     <option id="{NodeId/@Value}">
      <i18n:text><xsl:value-of select="Name/@Value"/></i18n:text>
     </option>
  </xsl:template>
  
  <xsl:template match="MemberRelations">
    <!-- <option id="{NodeId/@Value}"> -->
     <!-- <option id="{NodeId/@Value}">  -->
     <option id="{memberID/@Value}">
              <i18n:text><xsl:value-of select="Name/@Value"/></i18n:text>
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
    
    var maxRows="<xsl:value-of select="$maxRows"/>";
    var confirmMesg="<i18n:text>Do you want to  save your changes?</i18n:text>";

     var hash;
     var orig_hash;

      function onLoad()
      {

         hash = new Hashtable();
         orig_hash = new Hashtable();


        <!-- <xsl:for-each select="/RESPONSES/RESPONSE/RESPONSE/MemberHierarchy"> -->
         <xsl:for-each select="/RESPONSES/RESPONSE/RESPONSE/MemberRelations">
           hash.put("<xsl:value-of select="memberID/@Value"/>","<xsl:value-of select="Name/@Value"/>");
           orig_hash.put("<xsl:value-of select="memberID/@Value"/>","<xsl:value-of select="Name/@Value"/>");
        </xsl:for-each>


      }
     function onSearch() {
      document.AssignedMemForm.START_COUNT.value  = "0";
      document.AssignedMemForm.action = "memberHierarchy_child.jsp";
      document.AssignedMemForm.submit();
      }
   <![CDATA[

      var selectedChildOptions = 0 ;

      function populate_field_properties ( columnSelector ) {

         var len = columnSelector.options.length;
         selectedChildOptions = 0 ;

         for( i = 0 ; i < len ; i++) {
              if(columnSelector.options[i].selected)
                 selectedChildOptions++;
         }
         //alert( selectedChildOptions);
      }

    function onMoveLeft()
      {

       var selectedUnAssignedChildOptions = top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.selectedUnAssignedChildOptions;
       //alert("selectedUnAssignedChildOptions=" + selectedUnAssignedChildOptions);
       if ( selectedUnAssignedChildOptions < 1 )
        {
            core_alert( "SELECT_MEMBER_ALERT");
           return;
        }

      doLeftCalculations();

      //render
      renderUnAssignedChildCombo();
      top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.selectedUnAssignedChildOptions = 0;


      }
    function onMoveDoubleLeft()
      {

       var unAssigendChildList = top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.document.UnAssignedMemForm.unAssigendChildList;
       var len = unAssigendChildList.options.length;


         for( i = 0 ; i < len ; i++) {

              unAssigendChildList.options[i].selected = 'true' ;

         }

      doLeftCalculations();

      //render
      renderUnAssignedChildCombo();
      top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.selectedUnAssignedChildOptions = 0;


      }

    function doLeftCalculations()
    {
            var unAssignedChildLen =   top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.document.UnAssignedMemForm.unAssigendChildList.options.length;
            //alert('unAssignedChildLen'+unAssignedChildLen);

             for( i = 0 ; i < unAssignedChildLen ; i++) {


                  if(top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.document.UnAssignedMemForm.unAssigendChildList.options[i].selected) {

                     var selectedOptionName = top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.document.UnAssignedMemForm.unAssigendChildList.options[i].text;
                     //alert('selectedOptionName'+selectedOptionName);   
                     var selectedOptionId = top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.document.UnAssignedMemForm.unAssigendChildList.options[i].id;
                     //alert('selectedOptionId'+selectedOptionId);   

                     // check if key already there in childs ( then dont do anything)
                     if((hash != null) && (!hash.isEmpty()) && (! hash.containsKey(selectedOptionId)))
                     {
                     // populate this in this childframe combo
                      var lenL = document.AssignedMemForm.assigendChildList.options.length;
                      //alert("lenL=" + lenL);
                      document.AssignedMemForm.assigendChildList.options[lenL] = new Option();
                      document.AssignedMemForm.assigendChildList.options[lenL].id = selectedOptionId;
                      document.AssignedMemForm.assigendChildList.options[lenL].text = selectedOptionName;

                      //add into the current hashtable
                      hash.put(selectedOptionId,selectedOptionName);

                      //nullify this in other frame
                      var unassigned_hash = top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.hash;
                      //alert("before removing unassigned_hash=" + unassigned_hash.toString());
                      //alert("removing key = " + selectedOptionId) ;
                      //remove from right combo
                      unassigned_hash.remove(selectedOptionId);
                      //alert("after removing unassigned_hash=" + unassigned_hash.toString());
                     }

                  }
             }

    }
    
    function restore()
    {

            var tmp = new Hashtable();            
            var keys = orig_hash.keys();
            for(j = 0;j < orig_hash.size() ; j++) {
              tmp.put(keys[j], orig_hash.get(keys[j]));
            }  
            hash = tmp;

            renderChildCombo();    
    }
    
    
    function onMoveRight()
      {
       //alert("Coming in onRight");
       //alert("selectedChildOptions=" + selectedChildOptions);
       if ( selectedChildOptions < 1 )
        {
           core_alert( "SELECT_MEMBER_ALERT");
           return;
        }

      doRightCalculation();

      renderChildCombo() ;
      selectedChildOptions = 0;

      }

      function onMoveDoubleRight()
        {
        //alert("selectedChildOptions=" + selectedChildOptions);
       var assigendChildList = document.AssignedMemForm.assigendChildList;
       var len = assigendChildList.options.length;


         for( i = 0 ; i < len ; i++) {

              assigendChildList.options[i].selected = 'true' ;

         }

        doRightCalculation();

        renderChildCombo() ;
        selectedChildOptions = 0;
        }

     function doRightCalculation (){
        //alert("doRightCalculation=");
             var childLen =   document.AssignedMemForm.assigendChildList.options.length;

              for( i = 0 ; i < childLen ; i++) {
		   //alert("In childLen < 0 loop");
                   if(document.AssignedMemForm.assigendChildList.options[i].selected) {


                      var selectedOptionName = document.AssignedMemForm.assigendChildList.options[i].text;
                      //alert("selectedOptionName is " +selectedOptionName);
                      var selectedOptionId = document.AssignedMemForm.assigendChildList.options[i].id;
		      //alert("selectedOptionId is " +selectedOptionId);
		      //alert(top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.document.UnAssignedMemForm.unAssigendChildList.options.length);
                      // populate this in unassigned frame combo
                      //get the length of right combo
                      var lenR = top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.document.UnAssignedMemForm.unAssigendChildList.options.length;
                      //alert("length of right combo=" + lenR);

                      //add this option in right combo
                      top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.document.UnAssignedMemForm.unAssigendChildList.options[lenR] = new Option();
                      top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.document.UnAssignedMemForm.unAssigendChildList.options[lenR].id = selectedOptionId;
                      top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.document.UnAssignedMemForm.unAssigendChildList.options[lenR].text = selectedOptionName;


                      //remove in the current left hashtable
                      //alert("removing from current child hash key=" + selectedOptionId);
                      hash.remove(selectedOptionId);
                      
                      
                      //add in the right side hashtable
                       //alert("adding from current unassigned child hash key=" + selectedOptionId);
                       var unassigned_hash = top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.hash;
                       unassigned_hash.put(selectedOptionId,selectedOptionName);

                   }
              }


     }
     function renderChildCombo (){

       //alert("rendering child Combo " + hash.toString() ) ;
       // get the values array
       var curr_array_values = hash.values();
       var curr_array_keys = hash.keys();
       var len = hash.size();
       document.AssignedMemForm.assigendChildList.length = len;
       for( i = 0 ; i <len ; i++) {

        document.AssignedMemForm.assigendChildList.options[i] =  new Option() ;
        document.AssignedMemForm.assigendChildList.options[i].id =  curr_array_keys[i];
        document.AssignedMemForm.assigendChildList.options[i].text =  curr_array_values[i];

       }
      // set the hidden fields  in this form

       //alert("hash=" + hash.toString());
     }

     function renderUnAssignedChildCombo (){

       //alert("renderUnAssignedChildCombo " ) ;
       // get the current hash from right frame
       var unassigned_hash = top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.hash;
       //alert("renderUnAssignedChildCombo " + unassigned_hash.toString()) ;
       // get the key values array
       var curr_array_values = unassigned_hash.values();
       var curr_array_keys = unassigned_hash.keys();

       //alert("un assigned combo values" +       curr_array_values );

       var len = unassigned_hash.size();

       top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.document.UnAssignedMemForm.unAssigendChildList.length = len;

       for( i = 0 ; i <len ; i++) {

       top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.document.UnAssignedMemForm.unAssigendChildList.options[i] =  new Option() ;
       top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.document.UnAssignedMemForm.unAssigendChildList.options[i].id =  curr_array_keys[i] ;
       top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.document.UnAssignedMemForm.unAssigendChildList.options[i].text =  curr_array_values[i] ;

       }
      // set the hidden fields  in this form

       //alert("unassigned_hash=" + unassigned_hash.toString());
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
          if(page_form == null)  page_form = document.AssignedMemForm;

          if(result_form == null)  result_form = document.AssignedMemForm;

          top.i2ui_shell_content.appFrame.content_new.footer.calculateNetChange();


          if(document.AssignedMemForm.assigned_mem_ids.value != ""
             ||  document.AssignedMemForm.unassigned_mem_ids.value != ""
             )
          {
           // alert("document.AssignedMemForm.assigned_mem_ids.value=" + document.AssignedMemForm.assigned_mem_ids.value);
           //  alert("document.AssignedMemForm.unassigned_mem_ids.value=" + document.AssignedMemForm.unassigned_mem_ids.value);
           if(core_confirm( confirmMesg ) == 'yes' )
            top.i2ui_shell_content.appFrame.content_new.footer.onSave( );
           else //revert the changes
           {

            top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.restore();
            renderUnAssignedChildCombo();
            hash = orig_hash;
            renderChildCombo();
            //alert('unassigned_orig_hash'+top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.orig_hash);
            //alert('unassigned_hash'+top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_unassignedChild.hash);           
            
            
           }
          }
            jumpToPage(actionName, startCount, result_form, page_form);
      }

        function jumpToPage(actionName, startCount, result_form, page_form)
      {
          //alert("hello");
          //alert("actionName="+actionName);
          //alert("startCount="+startCount);
         // alert("result_form="+result_form);
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
                result_form.target="memberHierarchy_child";
                result_form.action="memberHierarchy_child.jsp";
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

