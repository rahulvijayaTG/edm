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
    
 
  <xsl:output method="html"/>
  
  <!-- ********************************************************************** 
  *********************************************************************** -->  
  <xsl:template match="HEADER_CONTEXT">
   <i2:container>
    <xsl:if test="SUPPLY_CHAIN">
       <table > 
          <xsl:apply-templates select="SUPPLY_CHAIN"/>
       </table>
    </xsl:if>
    <xsl:if test="ROUTING">
       <table > 
          <xsl:apply-templates select="ROUTING"/>
       </table>
    </xsl:if>
    <xsl:if test="OPERATION">
       <table > 
          <xsl:apply-templates select="OPERATION"/>
       </table>
    </xsl:if>
		<xsl:if test="BOR">
       <table > 
          <xsl:apply-templates select="BOR"/>
       </table>
    </xsl:if>
    <xsl:if test="RESALT">
       <table >
          <xsl:apply-templates select="RESALT"/>
       </table>
    </xsl:if>
     <xsl:if test="RESOURCE">
          <xsl:apply-templates select="RESOURCE"/>
    </xsl:if>
     <xsl:if test="LOCATION">
          <xsl:apply-templates select="LOCATION"/>
    </xsl:if>
     <xsl:if test="DL">
          <xsl:apply-templates select="DL"/>
    </xsl:if>
    <i2:footer/>
    </i2:container>

  </xsl:template>
  <!-- ********************************************************************** 
  *********************************************************************** -->  
  <xsl:template match="SUPPLY_CHAIN">
     <tr>
      <td nowrap="nowrap" >
        &#xA0;
        <i18n:text>Item Name
        </i18n:text>
        <xsl:text>:</xsl:text>
      </td>
      <td nowrap="nowrap" > 
      &#xA0;<xsl:value-of select="itemName/@Value"/>
     </td>
      <td nowrap="nowrap" >
        &#xA0;
        <i18n:text>Produced Location
        </i18n:text>
        <xsl:text>:</xsl:text>
      </td>
      <td nowrap="nowrap"> 
      &#xA0;<xsl:value-of select="locationName/@Value"/>
    </td>
     </tr>
     <tr>
      <td nowrap="nowrap" >
        &#xA0;
        <i18n:text>SC Name
        </i18n:text>
        <xsl:text>:</xsl:text>
      </td>
      <td nowrap="nowrap" > 
      &#xA0;
      <xsl:value-of select="name/@Value"/>
     </td>
      <td nowrap="nowrap" >
        &#xA0;
        <i18n:text>Priority
        </i18n:text>
        <xsl:text>:</xsl:text>
      </td>
      <td nowrap="nowrap"> 
      &#xA0;
      <i18n:number><xsl:value-of select="priority/@Value"/></i18n:number>
     </td>
       <td nowrap="nowrap" >
           &#xA0;
           <i18n:text>Consumed Location
           </i18n:text>
           <xsl:text>:</xsl:text>
         </td>
         <td nowrap="nowrap">
         &#xA0;<xsl:value-of select="consumedLocationID/@Value"/>
       </td>
     </tr>
     <xsl:if test="BOM/name">
     <tr>
      <td nowrap="nowrap">
        &#xA0;
        <i18n:text>Bom
        </i18n:text>
        <xsl:text>:</xsl:text>
      </td>
      <td nowrap="nowrap" align="left"> 
      &#xA0;<xsl:value-of select="BOM/name/@Value"/>                             
     </td>
     </tr>  
     </xsl:if>  
  </xsl:template>

  
  <!-- ********************************************************************** 
  *********************************************************************** -->  
  <xsl:template match="OPERATION">
     <tr>
      <td nowrap="nowrap" >
        &#xA0;
        <b>
        <i18n:text>Operation Name
        </i18n:text>
        <xsl:text>:</xsl:text>
        </b>
      </td>
      <td nowrap="nowrap"> 
      &#xA0;<xsl:value-of select="name/@Value"/>
     </td>
      <!--td nowrap="nowrap" width="25%">
        &#xA0;
        <b>
        <i18n:text>Description
        </i18n:text>
        <xsl:text>:</xsl:text>
        </b>
      </td>
      <td nowrap="nowrap" width="25%"> 
      &#xA0;<xsl:value-of select="OPERATION_DESC/@Value"/>
     </td-->
     </tr>      
  </xsl:template>
  <!-- ********************************************************************** 
  *********************************************************************** -->  
  <xsl:template match="ROUTING">
     <tr>
      <td nowrap="nowrap">
        &#xA0;
        <b>
        <i18n:text>Routing Name
        </i18n:text>
        <xsl:text>:</xsl:text>
        </b>
      </td>
      <td nowrap="nowrap" align="left"> 
      &#xA0;<xsl:value-of select="name/@Value"/>                             
     </td>
       <xsl:if test="string-length(description/@Value) > 0 ">
        <td nowrap="nowrap">
          &#xA0;
          <b>
          <i18n:text>Description
          </i18n:text>
          <xsl:text>:</xsl:text>
          </b>
        </td>
        <td nowrap="nowrap" align="left"> 
        &#xA0;<xsl:value-of select="description/@Value"/>                             
       </td>
       </xsl:if>
     </tr>    
  </xsl:template>
  <!-- ********************************************************************** 
  *********************************************************************** -->   
	  <xsl:template match="BOR">
     <tr>
      <td nowrap="yes">
        &#xA0;
        <b>
        <i18n:text>BOR 
        </i18n:text>
        <xsl:text>:</xsl:text>
        </b>
      </td>
      <td nowrap="yes"> 
      &#xA0;<xsl:value-of select="name/@Value"/>                             
     </td>
     <td nowrap="yes">
       &#xA0;
       <b>
       <i18n:text>Description
       </i18n:text>
       <xsl:text>:</xsl:text>
       </b>
     </td>
     <td nowrap="yes">
      &#xA0;<xsl:value-of select="description/@Value"/>
     </td>

     </tr>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
	  <xsl:template match="RESALT">
     <tr>
      <td nowrap="yes">
        &#xA0;
        <b>
        <i18n:text>Resource Alternate
        </i18n:text>
        <xsl:text>:</xsl:text>
        </b>
      </td>
      <td nowrap="yes">
      &#xA0;<xsl:value-of select="name/@Value"/>
     </td>
     </tr>
  </xsl:template>
<!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="RESOURCE">
   <table>
     <tr>
      <td nowrap="nowrap">
        &#xA0;
        <b>
        <i18n:text>Resource Name
        </i18n:text>
        <xsl:text>:</xsl:text>
        </b>
      </td>
      <td nowrap="nowrap" align="left">
      &#xA0;<xsl:value-of select="name/@Value"/>
     </td>
       <xsl:if test="string-length(description/@Value) > 0 ">
        <td nowrap="nowrap">
          &#xA0;
          <b>
          <i18n:text>Description
          </i18n:text>
          <xsl:text>:</xsl:text>
          </b>
        </td>
        <td nowrap="nowrap" align="left">
        &#xA0;<xsl:value-of select="description/@Value"/>
       </td>
       </xsl:if>
     </tr>
    </table>
  </xsl:template>
 <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="LOCATION">
   <table>
     <tr>
      <td nowrap="nowrap">
        &#xA0;
        <b>
        <i18n:text>Location Name
        </i18n:text>
        <xsl:text>:</xsl:text>
        </b>
      </td>
      <td nowrap="nowrap" align="left">
      &#xA0;<xsl:value-of select="name/@Value"/>
     </td>
       <xsl:if test="string-length(description/@Value) > 0 ">
        <td nowrap="nowrap">
          &#xA0;
          <b>
          <i18n:text>Description
          </i18n:text>
          <xsl:text>:</xsl:text>
          </b>
        </td>
        <td nowrap="nowrap" align="left">
        &#xA0;<xsl:value-of select="description/@Value"/>
       </td>
       </xsl:if>
     </tr>
    </table>
  </xsl:template>
<!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="DL">
   <table>
     <tr>
      <td nowrap="nowrap">
        &#xA0;
        <b>
        <i18n:text>Distribution Lane Name
        </i18n:text>
        <xsl:text>:</xsl:text>
        </b>
      </td>
      <td nowrap="nowrap" align="left">
      &#xA0;<xsl:value-of select="name/@Value"/>
     </td>
       <xsl:if test="string-length(description/@Value) > 0 ">
        <td nowrap="nowrap">
          &#xA0;
          <b>
          <i18n:text>Description
          </i18n:text>
          <xsl:text>:</xsl:text>
          </b>
        </td>
        <td nowrap="nowrap" align="left">
        &#xA0;<xsl:value-of select="description/@Value"/>
       </td>
       </xsl:if>
     </tr>
    </table>
  </xsl:template>

  </xsl:stylesheet>

