<?xml version="1.0" standalone='no'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:import href="footer.xsl"/>

  <xsl:variable name="maxlen">30</xsl:variable>  

 
  <!-- Wizard -->                
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="CONTAINER" mode="wizard">        
    <xsl:param name="content"/>

    <!-- Current Step -->
    <xsl:variable name="currentStepNo">
      <xsl:for-each select="STEP">
        <xsl:if test="(@Selected = 'true') and (string-length(./@Selected) != 0)">
          <xsl:value-of select="position()"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    
    <!-- Total Steps -->
    <xsl:variable name="noOfSteps" select="count(STEP)"/>
    
    
    <!-- Title (Step 1 of 5) -->
    <xsl:variable name="title">
      <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>: 
      <xsl:choose>
        <xsl:when test="STEP[ @Summary = 'true']">
          <i18n:text>View Summary</i18n:text>
        </xsl:when>
        <xsl:otherwise>
          <i18n:text><xsl:value-of select="STEP[ @Selected = 'true']/@DisplayText"/></i18n:text>
          (<i18n:text arg0="{$currentStepNo}" arg1="{$noOfSteps}">Step {0} of {1}</i18n:text>)<!-- TODO i18n -->
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <!-- Main Container -->
    <i2:container title="{$title}" scrollable="yes" id="container">
      <input type="hidden" name="WIZARD_CURRENT_STEP" value="{STEP[ @Selected = 'true']/@Name}"/>
      
      <table border="0" cellpadding="0" cellspacing="0" width="100%" height="50%">
        <tr>
          
          
          <!-- Wizard Steps -->
          <td id="wizard_steps" valign="top" align="left" width="17%">
            <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
              <tr class="wizardPanel" height="100%">
                <td valign="top" class="shadow">
                  
                  <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <xsl:apply-templates select="STEP">
                      <xsl:with-param name="currentStepNo" select="$currentStepNo"/>
                      <xsl:with-param name="noOfSteps" select="$noOfSteps"/>
                    </xsl:apply-templates>                                
                    <!-- Empty to maintain size -->

                   <tr>
                     <td colspan="2" width="48" valign="top" nowrap="true">
          <!--  
      &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;
          -->
                   </td>
                    </tr>
<!--
                    <tr><td><a href="javascript:i2uiToggleItemVisibility('wizard_steps','hide');onResize();">Hide</a></td></tr>
-->

                  </table>
                  
                </td>
              </tr>
            </table>
          </td>
          
          <!-- Content -->                  
          <td height="100%" width="75%" valign="top">
            <xsl:apply-templates select="$content" mode="container_content"/>  
          </td>
        </tr>
      </table>
      
      <!-- Footer --> 
      <xsl:apply-templates select="STEP[@Selected = 'true']" mode="footer"/>

    </i2:container>

  </xsl:template>
  
  
    
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="STEP">       
    <xsl:param name="currentStepNo"/>
    <xsl:param name="noOfSteps"/>
    
    
    <xsl:variable name="position">
      <xsl:value-of select="position()"/>
    </xsl:variable>
    
    <xsl:variable name="type">
      <!-- If  current step -->    
      <xsl:if test="$position = $currentStepNo">
        <xsl:text>current</xsl:text>
      </xsl:if>
          
      <!-- If  future step -->    
      <xsl:if test="$position &gt; $currentStepNo">
        <xsl:text>incomplete</xsl:text>
      </xsl:if>
          
      <!-- If  past step -->    
      <xsl:if test="$position &lt; $currentStepNo">
        <xsl:text>complete</xsl:text>
      </xsl:if>
    </xsl:variable>          
    
    <xsl:call-template name="wizard_step_image">
      <xsl:with-param name="type" select="$type"/>
      <xsl:with-param name="position" select="$position"/>
      <xsl:with-param name="noOfSteps" select="$noOfSteps"/>
    </xsl:call-template>
    
    
  </xsl:template>
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name ="wizard_step_image">
    <xsl:param name="type"/>
    <xsl:param name="position"/>
    <xsl:param name="noOfSteps"/>
    <xsl:param name="selected"/>
    
    <!-- Step Class -->
    <xsl:variable name="class">
      <xsl:choose>
        <xsl:when test="$type = 'current'">
          <xsl:text>wizardStepSelected</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>wizardStep</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <!-- Step -->
    <tr class="{$class}">
      <!-- Step Icons -->
      <td width="10" valign="top" nowrap="true">
        <xsl:choose>
          <!-- First Step -->
          <xsl:when test="$position = 1">
            <i2:img border="0" src="/step_first_{$type}.gif" align="top"></i2:img>
          </xsl:when>
          <!-- In Between Step -->
          <xsl:when test="($position &gt; 1) and ($position &lt; $noOfSteps)">
            <i2:img border="0" src="/step_inbetwn_{$type}.gif" align="top"></i2:img>
          </xsl:when>
          <!-- Last Step -->
          <xsl:otherwise>
            <i2:img border="0" src="/step_last_{$type}.gif" align="top"></i2:img>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <!-- Step Label -->
      
      <xsl:variable name="text">
        <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>      
      </xsl:variable>

        <xsl:variable name="truncatedText">      
        <xsl:choose>
          <xsl:when test="string-length($text) > $maxlen">
            <xsl:value-of select="concat(substring($text,0,$maxlen -3), '...')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$text"/>
          </xsl:otherwise>
        </xsl:choose>  
      </xsl:variable>

      <td nowrap="true">
        <xsl:value-of select="$truncatedText"/>&#xA0;<!-- Already i18 -->
      </td>
    </tr>
    
  </xsl:template>
  
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="splitString">
    <xsl:param name="string" select="''" />
    <xsl:param name="pattern" select="' '" />
    <xsl:choose>
      <xsl:when test="contains($string, $pattern)">
        <xsl:if test="not(starts-with($string, $pattern))">
          <xsl:call-template name="splitString">
            <xsl:with-param name="string" select="substring-before($string, $pattern)" />
            <xsl:with-param name="pattern" select="$pattern" />
          </xsl:call-template>
        </xsl:if>
        <xsl:call-template name="splitString">
          <xsl:with-param name="string" select="substring-after($string, $pattern)" />
          <xsl:with-param name="pattern" select="$pattern" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <token><xsl:value-of select="$string" /></token>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- ********************************************************************** 
       *********************************************************************** -->

  <!-- Javascript -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="javascript_resizeWizard">  
    i2uiResizeScrollableContainer('container',document.body.offsetHeight - 90, null, document.body.offsetWidth -20, true, 'yes');
  </xsl:template>
       
  
</xsl:stylesheet> 

