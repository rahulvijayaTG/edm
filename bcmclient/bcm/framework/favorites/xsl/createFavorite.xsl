<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
 
  <!-- Core -->
  <xsl:import href="../../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../../core/xsl/container.xsl"/>
  <xsl:import href="../../xsl/buttons.xsl"/>
  <xsl:output method="html"/>
 
   <xsl:template match = "RESPONSES" mode="content">

     <!--xsl:call-template name="include_javascript_tableeditor_filter"/-->
   <xsl:call-template name="include_javascript"/>
     
   <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
       <xsl:with-param name="content" select="RESPONSE"/>
     </xsl:apply-templates>
  </xsl:template>

  <!-- **********************************************************************
      *********************************************************************** -->
    <xsl:template match="RESPONSE" mode="container_content">
      <!--xsl:call-template name="display_instruction_area"/-->
          <xsl:call-template name="favoritePage"/>
  </xsl:template>      
  
    <!-- **********************************************************************
      *********************************************************************** -->
    
    <xsl:template name="favoritePage">
    
    <form name="favorites_form" method="post">
        <table cellspacing="0" cellpadding="0" border="0">
        <tr>
            <td  style="padding:8px;">
                <table cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td width="10%" align="left" nowrap="yes"> 
                        &#160;<i18n:text>Name:</i18n:text> &#160;
                    </td>
                    <td align="left" nowrap="yes">
                      <input fieldtype="text" id="favnametxt" name="favnametxt" type="field" class="inputfieldIE" size="17"/>
                    </td>
                </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td  style="padding:8px;" nowrap="yes">
                <i2:table id="favoritetable" scrollablerows="yes" scrollablecolumns="yes"> 
                    <i2:tr header="yes">
                        <th nowrap="yes" align="left">
                            &#160;<i18n:text>Add To Folder</i18n:text>
                        </th>
                    </i2:tr>
                    <xsl:apply-templates select="Folder|Favorite"/>
                </i2:table>
            </td>
        </tr>
        </table>
        <!--input type="hidden" name="selected_name" value="{/RESPONSES/RESPONSE/selected_name/@Value}"/>
        <input type="hidden" name="selected_id" value="{/RESPONSES/RESPONSE/selected_id/@Value}"/>
        <input type="hidden" name="selected_cell_id" value="{/RESPONSES/RESPONSE/selected_cell_id/@Value}"/>
        <input type="hidden" name="isFolder" value="{/RESPONSES/RESPONSE/isFolder/@Value}"/-->
        <input type="hidden" name="selected_name" value=""/>
        <input type="hidden" name="selected_id" value=""/>
        <input type="hidden" name="selected_cell_id" value=""/>
        <input type="hidden" name="isFolder" value=""/>

        <input type="hidden" name="PAGE" value="{/RESPONSES/RESPONSE/PAGE/@Value}"/>
        <input type="hidden" name="FORM_NAME" value="{/RESPONSES/RESPONSE/FORM_NAME/@Value}"/>
        <input type="hidden" name="TABLE_NAME" value="{/RESPONSES/RESPONSE/TABLE_NAME/@Value}"/>
        <input type="hidden" name="SERVICE" value="{/RESPONSES/RESPONSE/SERVICE[1]/@Value}"/>
        <input type="hidden" name="SERVICE" value="{/RESPONSES/RESPONSE/SERVICE[1]/@Value}"/>
        <input type="hidden" name="IS_UPDATE" value="{/RESPONSES/RESPONSE/IS_UPDATE[1]/@Value}"/>
    </form>
    </xsl:template>     
    
    <xsl:template match="Folder|Favorite">
        <xsl:param name="currentdepth" select="0"/>
        <xsl:variable name="quote">'</xsl:variable>
        <xsl:variable name="equote">\'</xsl:variable>
        <xsl:variable name="onmouseover">javascript:i2uiSetMenuCoords(this,event)</xsl:variable>
        <xsl:variable name="x" select="$currentdepth * 10"/>
        <xsl:variable name="nodePosition">
            <xsl:value-of select="count(preceding::Folder|ancestor::Folder|preceding::Favorite|ancestor::Favorite)+1"/>
        </xsl:variable>
        <xsl:variable name="onclickhandler">
            <xsl:value-of select="concat('javascript:handleFavoriteTreeNodeClick(',$quote, @Name, $quote, ',',$quote,@Id, $quote, ',',$quote,'favoritetable_',$x,'.',$nodePosition,$quote, ',',$quote, @IsFolder, $quote, ')')"/>
        </xsl:variable>
        <xsl:variable name="handler">
            <xsl:value-of select="concat('javascript:handleFavoriteTreeNodeClick(',$equote, @Name, $equote, ',',$equote,@Id, $equote, ',',$equote,'favoritetable_',$x,'.',$nodePosition,$equote, ',',$equote, @IsFolder, $equote, ')')"/>            
        </xsl:variable>
        <xsl:variable name="href"><xsl:value-of select="concat('javascript:i2uiTreeTableAction(',$quote,'favoritetable_',$x,'.',$nodePosition,$quote,');',$onclickhandler)"/></xsl:variable>
        <xsl:variable name="imgid"><xsl:value-of select="concat('FOLDERIMG_',@Id)"/></xsl:variable>
        <i2:tr>
            <i2:treecell depth="{$currentdepth}" onclick="{$handler}">
                <xsl:choose>
                    <xsl:when test="./@IsFolder='yes'">
                        <i2:img id="{$imgid}" src="/folder_open.gif" border="0" align="top"/> &#160;            
                    </xsl:when>
                </xsl:choose>
                <a onmouseover="{$onmouseover}" href="{$href}" name="{./@Name}">                 
                   <i18n:text>
                    <xsl:value-of select="@Name"/>
                   </i18n:text>
                </a>
                
            </i2:treecell>
        </i2:tr>    
        <xsl:apply-templates>
            <xsl:with-param name="currentdepth" select="$currentdepth+1"/>
        </xsl:apply-templates>
    
    </xsl:template>
    
      <xsl:template name="onLoad_js">   
        function onLoad()
        {
        resize_Containers();
        }
      </xsl:template>
      <!-- **********************************************************************
           *********************************************************************** -->
      <xsl:template name="onResize_js">
        function onResize()
        {
        <xsl:call-template name="javascript_onResize_page"/>
        resize_Containers();
        }
      </xsl:template>

    

<xsl:template name="include_javascript">
    <script language="javascript">
    <![CDATA[
        function handleFavoriteTreeNodeClick(favName, favId, nodeId, isFolder)
        {
            //alert("Clicked Node Name: "+favName);
            //alert("Clicked Node Id: "+favId);
            //alert("Clicked i2 nodeName: "+nodeId);
            document.favorites_form.selected_name.value = favName;
            document.favorites_form.selected_id.value = favId;
            document.favorites_form.selected_cell_id.value = nodeId;
            document.favorites_form.isFolder.value = isFolder;
            if ((favId != null) && (favId !='') && favId.length >0)
            {
                //document.favorites_form.createFolder.disabled=true;
                //alert('disable create new folder btn');
            }
            else
            {
                //document.favorites_form.createFolder.disabled=false;
                //alert('enable create new folder btn');
            }
        }
        
        

        function handlefavoritetreeaction(table, relatedtable, action, scrolltop, name)
        {
         if (name != null && name != 'undefined')
         alert("user altered state of treecell item '"+name+"'");
         if (table == 'favoritetable')
         { 
               var width = document.body.offsetWidth - 45;
               var height = document.body.offsetHeight - 250;

               var cmd="i2uiResizeScrollableArea('favoritetable',"+height+","+width+",null,null,null,1)";
               setTimeout(cmd, 10);
         }
        }

            
        function  resize_Containers()
        {
              var width = document.body.offsetWidth - 45;
              var height = document.body.offsetHeight - 250;

            i2uiResizeScrollableArea('favoritetable',height,width, null, null, null, 1);
            i2uiManageTreeTableUserFunction = 'handlefavoritetreeaction';
            i2uiCollapseTreeTable('favoritetable',10,null,0); 
        }
        
        function doNothing()
        {
        
        }
        
        function createFolder()
        {
            /*
            var selectedFolderName = document.favorites_form.selected_name.value;
            var selectedFolderId = document.favorites_form.selected_id.value;
            var selectedCellId = document.favorites_form.selected_cell_id.value;
            var newfolderName = document.favorites_form.favnametxt.value;
            var isFolder = document.favorites_form.isFolder.value;
            if (isFolder!='yes')
            {
                core_alert("Select a folder");
                return;
            }
            */

           var favnametxt = document.favorites_form.favnametxt.value;
           if (favnametxt.length == 0)
           {
                core_alert('Enter the name of the folder to be created');
                return;
           }
           
           var isFolder = document.favorites_form.isFolder.value;
           var selectedCellId = document.favorites_form.selected_cell_id.value;
           
           var from = selectedCellId.indexOf("_");
           var to = selectedCellId.indexOf(".");
           var level = selectedCellId.substring(from+1, to);
           if (isFolder=='yes')
           {
                  level = parseInt(level) + 10;
                
           }
           if (from == -1 || to == -1 || level=="")
           {
                level = 10;           
           }
           var isAlreadyExists = isNameAlreadyExists(favnametxt, level, 'no');
           var comfirmMsg = "Name Already Exists. Enter a different Name"; 
           if (isAlreadyExists == true)
           {
                core_alert(comfirmMsg);
                return;
           }           
            
           document.favorites_form.target="appFrame";
           document.favorites_form.action="controller/createFolder.cmd";
           displayBusyBox();
           document.favorites_form.submit();
        }
        
      function onCancel()
         {
           document.favorites_form.target="appFrame";
           document.favorites_form.action=omxContextPath+ "/bcm/framework/breadcrumb/controller/back.cmd";
           document.favorites_form.submit();
        }
        
        function onSaveAndReturn()
        {
           
            /*var isFolder = document.favorites_form.isFolder.value;
            if (isFolder!='yes')
            {
                core_alert("Select a folder");
                return;
            } */ 
            
            
           var favnametxt = document.favorites_form.favnametxt.value;
           if (favnametxt.length == 0)
                      {
                           core_alert('Enter the name of the favorite to be saved');
                           return;
           }
           var isFolder = document.favorites_form.isFolder.value;
           var selectedCellId = document.favorites_form.selected_cell_id.value;
           
           var from = selectedCellId.indexOf("_");
           var to = selectedCellId.indexOf(".");
           var level = selectedCellId.substring(from+1, to);
           if (isFolder=='yes')
           {
                  level = parseInt(level) + 10;
                
           }
           if (from == -1 || to == -1 || level=="")
           {
                level = 10;           
           }
           var isAlreadyExists = isNameAlreadyExists(favnametxt, level, 'yes');
           var comfirmMsg = "Name Already Exists. Do you want to override?"; 
           if (isAlreadyExists == true)
           {
                if( core_confirm( comfirmMsg ) == 'yes' )
                {
                       document.favorites_form.IS_UPDATE.value = 'yes';
                       document.favorites_form.target="appFrame";
                       document.favorites_form.action="controller/updateFavorite.cmd";
                       displayBusyBox();
                       document.favorites_form.submit();
                       var reload = "parent.navFrame.location.reload()";
                       setTimeout(reload, 100);
                }
                else
                {
                    return;
                }
           }
           else
           {
               
               document.favorites_form.target="appFrame";
               document.favorites_form.action="controller/saveFavorite.cmd";
               displayBusyBox();
               document.favorites_form.submit();
               var reload = "parent.navFrame.location.reload()";
               setTimeout(reload, 100);
              
           }    

        }
        
        function isNameAlreadyExists(name, level, isfav)
        {
            tagList = document.getElementsByTagName("span");
            if (tagList != null)
            {

                var len = tagList.length;
                var currentName, currentId;
                var currentImg, imgId;
                var aList, imgList;
                for(var i=0; i<len; i++)
                {
                    currentId = tagList[i].id;
                    aList = tagList[i].getElementsByTagName("a");
                    alen = aList.length;
                    
                    imgList = tagList[i].getElementsByTagName("img");
                    imglen = imgList.length;
                    
                    isFolder = 'no';
                    if (imglen != null)
                    {
                        for(var k=0; k<imglen; k++)
                        {
                           imgId = imgList[k].id;
                           var from = imgId.indexOf("FOLDERIMG_");
                           if (from == 0)
                           {
                               isFolder = "yes";
                               break;
                           }
                               /*
                               var to = imgId.indexOf(".");
                               var currentLevel = currentId.substring(from+1, to);
                               if ( level == currentLevel)
                               {
                                    return true;
                                }
                                */
                        }
                    
                    }
                    
                    if (alen != null)
                    {
                        for(var j=0; j<alen; j++)
                        {
                            currentName = aList[j].name;
                            if (currentName == name)
                            {
                               var from = currentId.indexOf("_");
                               var to = currentId.indexOf(".");
                               var currentLevel = currentId.substring(from+1, to);
                               if ( level == currentLevel)
                               {
                                    if (isfav != isFolder)
                                        return true;
                                }

                            }
                        }
                    }
                }
                return false;
            }
        }
        
            
            ]]>
    </script>

</xsl:template>
    
</xsl:stylesheet>    
