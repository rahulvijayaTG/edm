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
  <xsl:template match="TREE_CONTROL" mode="top">
    <!-- xsl:apply-templates select="." mode="layout"/-->
    <!-- xsl:copy-of select="*"/ -->
    
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="TREE_CONTROL" mode="layout">
   <xsl:variable name="blank_image"><i2:imgPath src="/blank.png"/></xsl:variable>
   <xsl:variable name="I_image"><i2:imgPath src="/I.png"/></xsl:variable>
   
   <xsl:variable name="T_image"><i2:imgPath src="/T.png"/></xsl:variable>
   <xsl:variable name="Tplus_image"><i2:imgPath src="/Tplus.png"/></xsl:variable>
   <xsl:variable name="Tminus_image"><i2:imgPath src="/Tminus.png"/></xsl:variable>
   
   <xsl:variable name="L_image"><i2:imgPath src="/L.png"/></xsl:variable>
   <xsl:variable name="Lplus_image"><i2:imgPath src="/Lplus.png"/></xsl:variable>   
   <xsl:variable name="Lminus_image"><i2:imgPath src="/Lminus.png"/></xsl:variable>

  
  <xsl:variable name="expandImage">
    <xsl:choose>
      <xsl:when test="@expandImage"><i2:imgPath src="{@expandImage}"/></xsl:when>
      <xsl:otherwise><i2:imgPath src="/plus_norgie.gif"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
      
  <xsl:variable name="collapseImage">
    <xsl:choose>
      <xsl:when test="@collapseImage"><i2:imgPath src="{@collapseImage}"/></xsl:when>
      <xsl:otherwise><i2:imgPath src="/minus_norgie.gif"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="leafImage">
    <xsl:choose>
      <xsl:when test="@leafImage"><i2:imgPath src="{@leafImage}"/></xsl:when>
      <xsl:otherwise><i2:imgPath src="/tree_bullet.gif"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
           	                             

  <xsl:variable name="selectedNodeId" select="@SELECTED_NODE_ID"/>
        
        <xsl:variable name="thisId">  
                <xsl:choose>
            	<xsl:when test="@Id">
      	    		<xsl:value-of select="@id"/>
      	        </xsl:when>
      	      	<xsl:otherwise>
      	      		<xsl:value-of select="'tree1'"/>
      	      	</xsl:otherwise>
      	      </xsl:choose>
        </xsl:variable>
    
        <xsl:variable name="width">
            <xsl:choose>
              <xsl:when test="@Width">
                <xsl:value-of select="@Width"/>
              </xsl:when>
              <xsl:otherwise>100%</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
    
          <xsl:variable name="height">
          <xsl:choose>
            <xsl:when test="@Height">
    	            <xsl:value-of select="@Height"/>
    	          </xsl:when>
    	      <xsl:otherwise>100%</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          
          		<table cellpadding="0" cellspacing="0" valign="top">
          		<tr valign="top"><td valign="top"> 
          		               
                         <!-- Container -->
                        <i2:container id="tree_root_{@Id}" inner="yes">
          
                          <!-- Title -->
                          <i2:attribute name="title">
                            <b><i18n:text><xsl:value-of select="@DisplayText"/></i18n:text></b>
                          </i2:attribute>
                          <table id="tree_{@Id}"><tr><td>
          		<xsl:apply-templates select="TREE_NODE" mode="layout">
          		  <xsl:with-param name="expandImage" select="$expandImage"/>
          		  <xsl:with-param name="collapseImage" select="$collapseImage"/>
          		  <xsl:with-param name="leafImage" select="$leafImage"/>
          		  <xsl:with-param name="blank_image" select="$blank_image"/>
          		  <xsl:with-param name="I_image" select="$I_image"/>
          		  <xsl:with-param name="T_image" select="$T_image"/>
          		  <xsl:with-param name="Tplus_image" select="$Tplus_image"/>
          		  <xsl:with-param name="Tminus_image" select="$Tminus_image"/>
          		  <xsl:with-param name="L_image" select="$L_image"/>
          		  <xsl:with-param name="Lplus_image" select="$Lplus_image"/>
          		  <xsl:with-param name="Lminus_image" select="$Lminus_image"/>
          		  <xsl:with-param name="checkboxEnabled" select="@checkBoxEnabled"/>
          		  <xsl:with-param name="selectedNodeId" select="$selectedNodeId"/>
          		</xsl:apply-templates>
          		</td></tr></table>
                        </i2:container>
                        </td></tr>
              </table>
		
  
  </xsl:template>


<!-- Hierarchy -->
  <!-- **********************************************************************
  *********************************************************************** -->
<xsl:template name="hierarchy">
  <xsl:param name="blank_image"/>
  <xsl:param name="I_image"/>
  <xsl:param name="T_image"/>
  <xsl:param name="Tplus_image"/>
  <xsl:param name="Tminus_image"/>
  <xsl:param name="L_image"/>
  <xsl:param name="Lplus_image"/>
  <xsl:param name="Lminus_image"/>

 <xsl:for-each select="ancestor::TREE_NODE">
  <xsl:choose>
   <xsl:when test="following-sibling::node()">
    <img src="{$I_image}"/>
   </xsl:when>
   <xsl:otherwise>
    <img src="{$blank_image}"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:for-each>
 <xsl:choose>
  <xsl:when test="count(*) > 0">
   <xsl:choose>
    <xsl:when test="following-sibling::*">
     <img src="{$Tplus_image}" _open="{$Tminus_image}" _closed="{$Tplus_image}">
      <xsl:attribute name="ID"><xsl:value-of select="concat('stateImage',@id)"/></xsl:attribute>
     </img>
    </xsl:when>
    <xsl:otherwise>
     <img src="{$Lplus_image}" _open="{$Lminus_image}" _closed="{$Lplus_image}">
      <xsl:attribute name="ID"><xsl:value-of select="concat('stateImage',@id)"/></xsl:attribute>
     </img>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:when>
  <xsl:otherwise>
   <xsl:choose>
    <xsl:when test="following-sibling::node()">
     <img src="{$T_image}"/>
    </xsl:when>
    <xsl:otherwise>
     <img src="{$L_image}"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

 
<!-- Tree Folder Node -->
  <!-- **********************************************************************
  *********************************************************************** -->
<xsl:template match="TREE_NODE" mode="layout">
  <xsl:param name="expandImage" />
  <xsl:param name="collapseImage" />
  <xsl:param name="leafImage" />
  <xsl:param name="blank_image"/>
  <xsl:param name="I_image"/>
  <xsl:param name="T_image"/>
  <xsl:param name="Tplus_image"/>
  <xsl:param name="Tminus_image"/>
  <xsl:param name="L_image"/>
  <xsl:param name="Lplus_image"/>
  <xsl:param name="Lminus_image"/>
  <xsl:param name="checkboxEnabled"/>
  <xsl:param name="selectedNodeId"/>

<div onclick="window.event.cancelBubble = true;clickNode(this);" >
   <xsl:choose>
	  <xsl:when test="@nodeType='folder'">
 		<xsl:attribute name="image"><xsl:value-of select="$expandImage"/></xsl:attribute>
 		<xsl:attribute name="imageOpen"><xsl:value-of select="$collapseImage"/></xsl:attribute>	        
	        <xsl:attribute name="open">false</xsl:attribute>
	   </xsl:when>
	   <xsl:otherwise>
 		<xsl:attribute name="image"><xsl:value-of select="$leafImage"/></xsl:attribute>
 		<xsl:attribute name="imageOpen"><xsl:value-of select="$leafImage"/></xsl:attribute>	        
	        <xsl:attribute name="open">never</xsl:attribute>
	    </xsl:otherwise>
	</xsl:choose>
	        <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
	        <xsl:attribute name="STYLE">
	  <xsl:choose>
	  	<xsl:when test="@rootNode='false'">
	  		<xsl:value-of select="'display:none;cursor:hand;'"/>
	  	</xsl:when>
	  	<xsl:otherwise>
	  	         <xsl:value-of select="'cursor:hand;'"/>
	  	</xsl:otherwise>
	        </xsl:choose>    
	         	
	         	             
       </xsl:attribute>
         <table border="0" cellspacing="0" cellpadding="0">
           <tr>
         <td>
          <xsl:call-template name="hierarchy">   
		  <xsl:with-param name="blank_image" select="$blank_image"/>
		  <xsl:with-param name="I_image" select="$I_image"/>
		  <xsl:with-param name="T_image" select="$T_image"/>
		  <xsl:with-param name="Tplus_image" select="$Tplus_image"/>
		  <xsl:with-param name="Tminus_image" select="$Tminus_image"/>
		  <xsl:with-param name="L_image" select="$L_image"/>
		  <xsl:with-param name="Lplus_image" select="$Lplus_image"/>          		  
		  <xsl:with-param name="Lminus_image" select="$Lminus_image"/>
          </xsl:call-template>
          
         </td>
             <td valign="middle">
               <xsl:variable name="imgSrc">
                 <xsl:choose>
	     	   <xsl:when test="@nodeType='folder'">
	             <xsl:value-of select="$expandImage"/>
	           </xsl:when>
	     	   <xsl:otherwise>
	     	     <xsl:value-of select="$leafImage"/>
	     	   </xsl:otherwise>
	     	 </xsl:choose>
	       </xsl:variable>

               <img border="0" id="image" src="{$imgSrc}"/>
             </td>
             <td valign="middle" nowrap="true" onmouseover="this.style.color = 'red'; this.style.fontWeight = 'bold';" onmouseout="this.style.color = 'black'; this.style.fontWeight = 'normal';" style="padding-left: 7px;font-family: Verdana;font-size: 11px;font-color: black;">
             
             <xsl:if test="$checkboxEnabled = 'true'">
               <INPUT type="CheckBox" name="{@id}" value="{@DisplayText}">
                 <xsl:if test="$selectedNodeId = @id">
                   <xsl:attribute name="checked">true</xsl:attribute>
                 </xsl:if>
               </INPUT>
             </xsl:if>
             
	      <a href="{@url}"><b><i18n:text><xsl:value-of select="@DisplayText"/></i18n:text></b></a> 
             </td>
           </tr>
         </table>
               
       <xsl:apply-templates select="TREE_NODE" mode="layout">
	  <xsl:with-param name="expandImage" select="$expandImage"/>
	  <xsl:with-param name="collapseImage" select="$collapseImage"/>
	  <xsl:with-param name="leafImage" select="$leafImage"/>
	  <xsl:with-param name="blank_image" select="$blank_image"/>
	  <xsl:with-param name="I_image" select="$I_image"/>
	  <xsl:with-param name="T_image" select="$T_image"/>
	  <xsl:with-param name="Tplus_image" select="$Tplus_image"/>
	  <xsl:with-param name="Tminus_image" select="$Tminus_image"/>
	  <xsl:with-param name="L_image" select="$L_image"/>
	  <xsl:with-param name="Lplus_image" select="$Lplus_image"/>
	  <xsl:with-param name="Lminus_image" select="$Lminus_image"/>	  
	  <xsl:with-param name="checkboxEnabled" select="$checkboxEnabled"/>
	  <xsl:with-param name="selectedNodeId" select="$selectedNodeId"/>
	</xsl:apply-templates>
	
  </div>
 </xsl:template>

</xsl:stylesheet>
