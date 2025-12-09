<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../framework/queryform/xsl/searchformfilter.xsl"/>
  <xsl:import href="../../context/xsl/context_header.xsl"/>
  <xsl:output method="html"/>
  <!-- Page Content -->
  <!-- **********************************************************************
       *********************************************************************** -->

  <xsl:template match="RESPONSES" mode="content">
  <xsl:call-template name="include_javascript_form"/>
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <xsl:call-template name="include_javascript_table_resize"/>
  </xsl:template>

  <!-- **********************************************************************
       *********************************************************************** -->
  <!-- Container Content -->
  <xsl:template match="RESPONSE" mode="container_content">
    <table id="(PAGE/@Value)" width="100%">
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
          <xsl:apply-templates select="SEARCH">
            <xsl:with-param name="formName" select="'result_form'"/>
          </xsl:apply-templates>
        </td>
      </tr>
    </table>
  </xsl:template>
  <!-- Javascript -->

  <xsl:template name="include_javascript_form">
      <script>
      var frAct = '<xsl:value-of select="/RESPONSES/RESPONSE/SAVE_ACTION/@Value"/>';

      function onClear()
              {
                 document.result_form.target="appFrame";
                 document.result_form.action="../framework/filter/controller/clearFilter.cmd";
                 clearFields(document.forms.result_form);
                 document.result_form.submit();
        }

    <![CDATA[
         function onEdit()
        {
          if(isOnlyOneSelected(document.result_form))
            {

            if(checkifAnySelected(document.result_form))
              {

                document.result_form.target="appFrame";
                document.result_form.method="POST";
                document.result_form.SAVE_ACTION.value="Edit";
                document.result_form.action="controller/display.cmd";
                //alert(document.result_form.SAVE_ACTION.value);
                document.result_form.submit();
              }
            else
              {
                core_alert("You must select an item to edit.")
              }
          }
          else
          {
          var mesg= "Please select only one row."
          core_alert(mesg);
           }
        }

     function onCopy()
             {
              if(isOnlyOneSelected(document.result_form))
                {
                 if(checkifAnySelected(document.result_form))
                 {

                     document.result_form.target="appFrame";
                     document.result_form.method="POST";
                     document.result_form.SAVE_ACTION.value="Copy";
                     document.result_form.action="controller/display.cmd";
                     document.result_form.submit();
                 }
                 else
                 {
                   core_alert("You must select an Item for copying.")
                   return;
                 }
               }
               else
               {
                  var mesg= "Please select only one row."
              core_alert(mesg);
               }

        }

    function onCreate()
        {
           document.result_form.target="appFrame";
           document.result_form.method="POST";
           document.result_form.SAVE_ACTION.value="Create";
           document.result_form.action="controller/display.cmd";
           document.result_form.submit();
        }


       function checkifAnySelected(form)
          {
               var count;
               var elementsLen = form.elements.length;
               var foundChecked = false;

               for(count = 0; count < elementsLen; count++)
               {
                 if( form.elements[count].type == "checkbox" && form.elements[count].checked == true  &&
                    form.elements[count].name != "SELECT_ALL"  ){
                     foundChecked = true;
                     break;
                  }
               }
               return foundChecked;
          }

       function clearFields(form)
       {
          var count;
          var elementsLen = form.elements.length;
          var foundChecked = false;

          for(count = 0; count < elementsLen; count++)
          {

             if( form.elements[count].type == "checkbox" ){
                form.elements[count].checked = false;
             }
            if( form.elements[count].type == "text" ){
                form.elements[count].value = '';
             }
             if(form.elements[count].type == "select-one")
             {
               form.elements[count].selectedIndex = 0;
             }
          }
        }
      ]]>

        function onDelete()
            {

              if (checkifAnySelected(document.result_form))
              {

                   if( core_confirm( "REMOVE_ROW") == 'yes' )
                     {
                       document.result_form.action="controller/deleteEntity.cmd";
                       document.result_form.target="appFrame";
                       document.result_form.submit();
                    }
                }
              else
               {
                 core_alert("<i18n:text>DELETE_ROW</i18n:text>");
               }

             }


          function massEdit()
          {
             massUpdateGlobal();
          }
        function onWhereUsed()
        {
          if(isOnlyOneSelected(result_form))
          {
                document.result_form.action="controller/whereUsed.cmd";
                document.result_form.target="appFrame";
                document.result_form.submit();
          }
          else
          {
              var mesg= "Please select only one row"
              core_alert(mesg);
          }
        }

  <![CDATA[
      function isOnlyOneSelected(form)
      {
            var count;
            var elementsLen = form.elements.length;
            var foundChecked = false;
            var counter = 0;
            for(count = 0; count < elementsLen; count++)
            {
                if((form.elements[count].type == "checkbox" || form.elements[count].type == "radio")&& form.elements[count].checked == true )
                {
                  counter++;
                  if(counter > 1)
                  {
                    foundChecked = false;
                    break;
                  }
                  else
                  {
                    foundChecked = true;
                  }
                }
            }
            return foundChecked;
       }
     ]]>


    </script>
  </xsl:template>

  <xsl:template name="include_javascript_table_resize">
    <script>
        <![CDATA[
            function resize_Containers()
                {
                //alert('first');
                  resizeScrollableTables();
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
    function IEEnterKey()
      {
          if(window.event.keyCode == 13)
              {
                  SetfocusSubmit(window.event.srcElement)
                      event.returnValue=false;
              }
      }

      ]]>
   </script>
  </xsl:template>
  <!-- ***************************************************************************
  ******************************************************************************* -->
</xsl:stylesheet>
