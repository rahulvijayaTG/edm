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
          <td>
            <xsl:call-template name="MEMBER_HIEARCHY_FOOTER"/>
           </td>
      </table>
     <xsl:call-template name="include_javascript_memberHierarchy"/>
  </xsl:template>

    <!--**************************************************
  *********************************************************************** -->
  <xsl:template name="MEMBER_HIEARCHY_FOOTER">
   <i2:container>
    <i2:header>
       <i2:buttonbar>

                    <xsl:call-template name="mdmButton">
                        <xsl:with-param name="onclick" select="'javascript:onCancel();'"/>
                        <xsl:with-param name="text" select="'Cancel'"/>
                    </xsl:call-template>

                    <!--i2:button id="button1" name="button1" onclick="javascript:onCancel()">&#xA0;&#xA0;<i18n:text>Cancel</i18n:text>&#xA0;&#xA0;</i2:button-->
                    <i2:buttonbardivider/>

                    <xsl:call-template name="mdmButton">
                        <xsl:with-param name="onclick" select="'javascript:onSave();'"/>
                        <xsl:with-param name="text" select="'Save'"/>
                    </xsl:call-template>
                    <!--i2:button id="button1" name="button1" onclick="javascript:onSave()">&#xA0;&#xA0;<i18n:text>Save</i18n:text>&#xA0;&#xA0;</i2:button-->

                    <xsl:call-template name="mdmButton">
                        <xsl:with-param name="onclick" select="'javascript:onSaveAndReturn();'"/>
                        <xsl:with-param name="text" select="'Save And Return'"/>
                        <xsl:with-param name="emphasized" select="'yes'"/>
                    </xsl:call-template>
                    <!--i2:button id="button2" name="button2" onclick="javascript:onSaveAndReturn()">&#xA0;&#xA0;<i18n:text>Save And Return</i18n:text>&#xA0;&#xA0;</i2:button-->
      </i2:buttonbar>
    </i2:header>
   </i2:container>

  </xsl:template>
<!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template name="include_javascript_memberHierarchy">
  <script>
   <![CDATA[

      function calculateNetChange() {
      //alert(" calculateNetChange ");

      var orig_hash = top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.orig_hash;
      var current_hash = top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.hash;

      //alert("orig_hash=" + orig_hash.toString() + " orig_size=" +  orig_hash.size() + "   current_hash=" + current_hash.toString() + " current_size=" +  current_hash.size() );

      var orig_size =  orig_hash.size();
      var orig_keys =  orig_hash.keys();

      var current_size =  current_hash.size();
      var current_keys =  current_hash.keys();

      var child_added = "";
      var child_removed = "";



    // if orig_hashtable is empty ::: all curr_keys are added
        
     if(orig_size == 0) {
        for(j = 0;j < current_size ; j++) {
          var curr_key =  current_keys[j];
          child_added +=   curr_key + '#' ;
        }
     }
     else {
        
        // if curr key is present in orig.. no change  ...
        // if curr key is not present in orig then this curr key is added

        for(j = 0;j < current_size ; j++) {

           var curr_key =  current_keys[j];
                
           //alert("for loop curr_key=" + curr_key);
           //alert("for loop orig_hash.containsKey=" + orig_hash.containsKey(curr_key));

               if(orig_hash.containsKey(curr_key)){
                }
               else{
                       child_added +=   curr_key + '#' ;
                       //alert("for loop child_added=" + child_added);
                }

         }
    }
              
// if orig_key is not present in the curr_hash keys ... means it is removed
              
      for( i = 0; i < orig_size ; i++) {
        var orig_key =  orig_keys[i];
          if(! current_hash.containsKey(orig_key)){
             child_removed +=   orig_key + '#' ;
           }

      }


    //alert("orig_size=" + orig_size);
    //alert("before 0 orig size child_added=" + child_added);
    

     //alert("child_added=" + child_added);
     //alert("child_removed=" + child_removed);


      top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.assigned_mem_ids.value =  child_added ;
      top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.unassigned_mem_ids.value =  child_removed ;

      }
      function onCancel()
      {
        calculateNetChange();
        top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.target="appFrame";
        top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.action = "searchMemberHierarchy.jsp?MODE=START";
        top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.submit();
      }
      function onSaveAndReturn()
      {
        calculateNetChange();
        top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.target="appFrame";
        top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.action = "memberHierarchyController/saveAndReturn.cmd";
        top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.submit();
      }
      function onSave ( ) {
        //alert("on save in one go");
        
        calculateNetChange();
        


       // if mode is start and if the length of parent options are = 0 load the parent frame too
       if(top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.START_MEMBER_HIERARCHY.value == 'YES')
       {
         //if the length of parent options are = 0 load the parent frame too
          var parentLen =   top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_parent.document.ParentMemForm.parentList.options.length;
          //alert("parent length on startup=" + parentLen);
          top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.START_MEMBER_HIERARCHY.value = '';
          //if(parentLen == 0)
             refreshParentForBootStrap();
             
             
       }
       else {
               top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.target="memberHierarchy_childs";
               top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.action = "memberHierarchyController/save.cmd";
               top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.submit();
        }
       
      }
      
      
      
      
      
      
      
      

      function onSaveOLD ( ) {

       // load the whole page in case of no parent member present
       //TODO::

       calculateNetChange();

       // if some condition
       assignChid();

      // for (var i=0; i<5000; i++)
      // {
      // }

      // if some condition
       unAssignChild();

      // for (var i=0; i<500; i++)
      // {
      // }

       // if mode is start load the parent member frame too
       if(top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.START_MEMBER_HIERARCHY.value == 'YES')
       {
          top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.START_MEMBER_HIERARCHY.value = '';
          refreshParentForBootStrap();
       }


      }
     function assignChid() {
      top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.target="memberHierarchy_child";
      top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.action = "memberHierarchyController/assignedMembers.cmd";
      top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.submit();
      }
     function unAssignChild() {

        //refresh the unassigned child frame  , pass the show child var so that the same levels children can be shown
        top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.target="memberHierarchy_unassignedChild";
        top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.action = "memberHierarchyController/unAssignedMembers.cmd";
        top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.submit();

      }
     function refreshParentForBootStrap() {
               top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.target="content";
               top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.action = "memberHierarchyController/reloadParentAndChilds.cmd";
               top.i2ui_shell_content.appFrame.content_new.content.memberHierarchy_childs.memberHierarchy_child.document.AssignedMemForm.submit();
      }
  ]]>
  </script>
  </xsl:template>

<!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>

