<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:import href="required_field.xsl"/>                   
 
  <xsl:output method="html"/>
 
  <xsl:template match="FORM">
    <xsl:call-template name="include_form_validation_js"/>

    <xsl:variable name="cellspacing">
      <xsl:choose>
        <xsl:when test="@Type= 'Hidden'">0</xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable> 
    <xsl:variable name="noOfCols">
      <xsl:choose>
        <xsl:when test="@NoOfCols"><xsl:value-of select="@NoOfCols"/></xsl:when>
        <xsl:otherwise>2</xsl:otherwise>
      </xsl:choose>
    </xsl:variable> 
            
    <!-- Form -->  
    <table  width="100%"   cellspacing="{$cellspacing}" cellpadding="0" border="0">
      <form name="{@Name}" method="{@method}" action="{@Action}" target="{@Target}">
        <tr>
          <td>
            <xsl:choose>
              <xsl:when test="@Type= 'Hidden'">
              </xsl:when>
              <xsl:otherwise>
              <i2:container inner="yes"  scrollable="yes" id="search_form_container"> 

              <!-- Form  Header Message -->
              <xsl:if test="count(INSTRUCTION) > 0 or @Validation = 'true'"> 
                <table border="0" cellpadding="0" cellspacing="1" width="100%" >
                  
                  <!-- General Ins -->
                  <xsl:if test="count(INSTRUCTION) > 0"> 
                    <tr>
                      <td>
                        <i18n:text><xsl:value-of select="INSTRUCTION/@DisplayText"/></i18n:text>
                      </td>
                    </tr>
                  </xsl:if> 

                  <!-- * denotes Required Field -->
                  <xsl:if test="@Validation = 'true'"> 
                    <tr>
                      <td>
                        <xsl:call-template name="display_validation_messages"/>
                      </td>
                    </tr>
                  </xsl:if> 
                </table>  
             </xsl:if> 
      
              <!-- Fields -->
              <table border="0" cellpadding="6" cellspacing="0">
                
                <!-- Simple Fields -->  
                <xsl:apply-templates select="FIELD[@Visibility = 'Simple' or string-length(@Visibility) =  0]">
                 <xsl:with-param name="noOfCols" select="$noOfCols"/>
                </xsl:apply-templates>
                <!-- Advanced Fields -->
                <xsl:if test="FIELD[@Name = 'SEARCH_TYPE']/@Value = 'Advanced'">
                  <xsl:apply-templates select="FIELD[@Visibility = 'Advanced']" >
                   <xsl:with-param name="noOfCols" select="$noOfCols"/>
                  </xsl:apply-templates>
                </xsl:if>
                
       
                <!-- Simple Search Toggle link -->
                <xsl:if test="count(FIELD[@Visibility = 'Simple' or string-length(@Visibility) =  0 ]) > 0">
                  <xsl:if test="FIELD[@Name = 'SEARCH_TYPE']/@Value != 'Simple'">
                    <tr>
                      <td colspan="2" nowrap="true">
                        <a class="text" href="javascript:onSimpleSearch();">
                          <i18n:text>Simple Search</i18n:text>
                        </a>
                      </td>
                    </tr>
                  </xsl:if>  
                </xsl:if>

                <!-- Advanced Search Toggle link -->
                 <xsl:if test="count(FIELD[@Visibility = 'Advanced']) > 0">
                  <xsl:if test="FIELD[@Name = 'SEARCH_TYPE']/@Value != 'Advanced'">
                    <tr>
                      <td colspan="2" nowrap="true">
                        <a class="text" href="javascript:onAdvancedSearch();">
                          <i18n:text>Advanced Search</i18n:text>
                        </a>
                      </td>
                    </tr>
                  </xsl:if>  
                </xsl:if>

              </table>
              
             <!-- Form Footer Message -->
              <xsl:if test="@Status = 'true'">
                <table border="0" cellpadding="0" cellspacing="1" width="100%" class="tableRow1">
                  <tr>
                    <xsl:choose>
                       <xsl:when test="STATUS/@Type = 'Success'">
                        <td align="right" width="100%">
                          <font color="green">
                          <i18n:text><xsl:value-of select="STATUS/@DisplayText"/> </i18n:text>
                          </font>
                        </td>
                      </xsl:when>
                      <xsl:when test="STATUS/@Type != 'Success'">
                        <td align="right" width="100%">
                          <font color="red">
                          <i18n:text><xsl:value-of select="STATUS/@DisplayText"/> </i18n:text>
                          </font>
                        </td>
                      </xsl:when>

                    </xsl:choose>
                  </tr>
                </table>  
              </xsl:if>  

              <!-- Footer -->
              <i2:footer>
                <xsl:apply-templates select="//SEARCH/FORM/BUTTONS"/>
              </i2:footer> 
              
            </i2:container>
              </xsl:otherwise>
            </xsl:choose>
            <!-- Container -->

            
            <!-- Hidden Fields -->
            <xsl:choose>
              <xsl:when  test="FIELD[@Name = 'SEARCH_TYPE']/@Value = 'Advanced'">
                <xsl:for-each select = "FIELD[@Type='Hidden' and (@Visibility = 'Advanced' or @Visibility = 'Simple' or string-length(@Visibility) =  0 or @Visibility = 'AdvancedOnly' )]">
                  <input name="{@Name}" type="hidden" value="{@Value}"/>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select = "FIELD[@Type='Hidden' and (@Visibility = 'Simple' or string-length(@Visibility) =  0 or @Visibility = 'SimpleOnly' )]">
                  <input name="{@Name}" type="hidden" value="{@Value}"/>
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
            
          </td>
        </tr>
      </form>
    </table>
    
  </xsl:template>
  
  
  <!--  Field -->
  <xsl:template match="FIELD">
  <xsl:param name="noOfCols"/>

    <xsl:if test="@Type != 'Hidden'">

      <xsl:if test="position() mod $noOfCols = 1">
        <xsl:text disable-output-escaping="yes">&lt;tr&gt;</xsl:text>
      </xsl:if>
  
  
      <xsl:if test="@Type != 'Links'">

      <!-- Field Label -->
      <td nowrap="yes">
          <xsl:if test="(@Type = 'Select' or @Type = 'MultiSelect') and @Size > 1">
            <xsl:attribute name="valign">top</xsl:attribute>
          </xsl:if>
          <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>

        <xsl:if test="string-length(@DisplayText) > 0">
          <xsl:if test="@Type != 'DateRange'">
            <xsl:value-of select="':'"/>
          </xsl:if>  
        </xsl:if>

        <!-- Required Field * -->
        <xsl:if test="@Required = 'true'">
          <font color="red">*</font>
       </xsl:if>   
      </td>
       </xsl:if>   
      
      <td nowrap="yes">
        <!-- Empty field -->
        <xsl:if test="@Type = 'Empty'">
        </xsl:if>       
        
        <!-- Text field -->
        <xsl:if test="@Type = 'Text'">
          <input fieldtype="{@Type}" name="{@Name}" value="{@Value}" type="field" class="inputfieldIE" size="17" required="{@Required}"/>
        </xsl:if>  

        
        <!-- Linked Field -->
        <xsl:if test="@Type = 'LinkedText'">
          <input fieldtype="{@Type}" name="{@Name}" value="{@Value}" type="field" class="inputfieldIE" size="30" maxlength="60"/><a href="{@Link}" target="{@TargetName}"><xsl:value-of select="@LinkName"/></a>
        </xsl:if>  

        <!-- Text Area field -->
        <xsl:if test="@Type = 'TextArea'">
          <textarea cols="{@Cols}" rows="{@Rows}" name="{@Name}" value="{@Value}"  required="{@Required}"/>
        </xsl:if>  
 
        <!-- Links -->
        <xsl:if test="@Type = 'Links'"><xsl:attribute name="colspan">2</xsl:attribute>
          <table border="0" cellpadding="0" cellspacing="15">
            <tr>

             <td align="left" nowrap="yes" valign="bottom"><i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>:</td>

               <!-- Links -->
              <xsl:for-each select="LINKS/LINK">
                <td>
                  <xsl:variable name="title"><i18n:text><xsl:value-of select="@DisplayText"/></i18n:text></xsl:variable>
  
  
                  <xsl:variable name="onclick">
                    <xsl:choose>
                      <xsl:when test="@Type = 'popup'">
                        javascript:popUpWindow('<xsl:value-of select="@OnClick"/>','<xsl:value-of select="@PopupName"/>')
                      </xsl:when>
                      <xsl:otherwise><xsl:value-of select="@OnClick"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:variable>

                  <a href="{$onclick}" title="{$title}">
                    <i18n:text><xsl:value-of select="$title"/></i18n:text>&#xA0;
                      <xsl:if test="IMAGE/@Src">
                        <i2:img src="{IMAGE/@Src}" width="16" height="16" border="0"/>
                      </xsl:if>
                  </a>
                  
                </td>
              </xsl:for-each>
            </tr>
          </table>
        </xsl:if>        

        <!-- Label  field -->
        <xsl:if test="@Type = 'Label'">
          <a class="text" href="{@OnClick}">
            <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>
          </a>
        </xsl:if>  
        
        <!-- Check box -->
        <xsl:if test="@Type = 'CheckBox'">
          <xsl:choose>
            <xsl:when test="@Value = @CheckedValue">
              <input name="{@Name}" value="{@CheckedValue}" checked="true" type="checkbox"/>
            </xsl:when>
            <xsl:otherwise>
              <input name="{@Name}" value="{@CheckedValue}" type="checkbox"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>  
        
        <!-- Number field --> 
        <xsl:if test="@Type = 'Number'">
          <table cellspacing="6" cellpadding="0" border="0">
          <tr><td valign="center" nowrap="yes">
          <select class="pulldown" name="{@Name}_MATCH_BY">
            <xsl:choose>
              <xsl:when test="@MatchBy = 'GREATER'">
                <option value="EQUAL">=</option>
                <option value="LESS">&lt;=</option>
                <option selected="true" value="GREATER">&gt;=</option>
              </xsl:when>
              <xsl:when test="@MatchBy = 'LESS'">
                <option value="EQUAL">=</option>
                <option selected="true" value="LESS">&lt;=</option>
                <option value="GREATER">&gt;=</option>
              </xsl:when>
              <xsl:otherwise>
                <option selected="true" value="EQUAL">=</option>
                <option value="LESS">&lt;=</option>
                <option value="GREATER">&gt;=</option>
              </xsl:otherwise>
            </xsl:choose>
          </select> 
          </td><td  valign="center" nowrap="yes">
          <input fieldtype="{@Type}" name="{@Name}" value="{@Value}" type="field" class="inputfieldIE" size="17" required="{@Required}"/>
          </td></tr></table>          
        </xsl:if>        

        <!-- Date field -->
        <xsl:if test="@Type = 'DateRange'">
        
          <xsl:variable name="fromDate">
            <i18n:date format="common"><xsl:value-of select="@Value1"/></i18n:date>
          </xsl:variable>

          <xsl:variable name="toDate">
           <i18n:date format="common"><xsl:value-of select="@Value2"/></i18n:date>
          </xsl:variable>
          <table cellspacing="6" cellpadding="0" border="0">
          <tr><td nowrap="yes">
          <i18n:text>from</i18n:text>:
          <input fieldtype="{@Type}" type="field" class="inputFieldIE" size="10" name="{@Name}_DS_DC" value="{$fromDate}" required="{@Required}"/>
          </td><td nowrap="yes" >          
          <A HREF="javascript:doNothing()" onclick="showCalendar(document.search_form.{@Name}_DS_DC);">
            <i2:img src="/cal_icon.gif" border="0" align="middle"/></A>  
          
          </td><td nowrap="yes">
          <i18n:text>to</i18n:text>:
          <input fieldtype="{@Type}" type="field" class="inputFieldIE" size="10" name="{@Name}_DE_DC" value="{$toDate}" required="{@Required}"/>
          </td><td nowrap="yes">          
          <A HREF="javascript:doNothing()" onclick="showCalendar(document.search_form.{@Name}_DE_DC);">
            <i2:img src="/cal_icon.gif" border="0" align="middle"/></A>
          </td></tr></table>
        </xsl:if>    
        
        <!-- Select field-->    
        <xsl:if test="@Type = 'Select'">
          <select  class="pulldown" name="{@Name}" onchange="{@OnChange}">
            <xsl:if test="@Size">
              <xsl:attribute name="size"><xsl:value-of select="@Size"/></xsl:attribute>
            </xsl:if>

            <xsl:choose><xsl:when test="@SelectAll = 'No'"></xsl:when>
              <xsl:otherwise>
                <option value=""><i18n:text>Select All</i18n:text></option>
              </xsl:otherwise></xsl:choose>
            <xsl:apply-templates select="OPTION"/>
          </select> 
        </xsl:if>    

        <!-- Multi-Select field-->    
        <xsl:if test="@Type = 'MultiSelect'">
          <select class="pulldown" MULTIPLE="yes" name="{@Name}" onchange="{@OnChange}">
            <xsl:if test="@Size">
              <xsl:attribute name="size"><xsl:value-of select="@Size"/></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="OPTION"/>
          </select> 
        </xsl:if>    
        
            
        <xsl:if test="@Type = 'Phone'">
          (<input fieldtype="{@Type}" name="{concat(@Name,'_AREA_CODE')}" value="{@Value1}" type="field" class="inputfieldIE" size="3" maxlength="{@MaxLength}"/>)&#xA0;<input fieldtype="{@Type}" name="{concat(@Name,'_LOCAL_NUM_1')}" value="{@Value2}" type="field" class="inputfieldIE" size="3" maxlength="{@MaxLength1}"/>&#xA0;-&#xA0;<input fieldtype="{@Type}" name="{concat(@Name,'_LOCAL_NUM_2')}" value="{@Value3}" type="field" class="inputfieldIE" size="4" maxlength="{@MaxLength2}"/>
        </xsl:if>  
            

        <!-- Required Field ! -->
        <xsl:if test="@Required = 'true'">
          &#xA0;<i2:img id="{@Name}_REQ" src="/alert_static_small.gif" border="0"/>
       </xsl:if>   
        
      </td>
      
      <td width="5%"></td>
      <xsl:if test="position() mod $noOfCols = 0 or position() = last()">
        <xsl:text disable-output-escaping="yes">&lt;/tr&gt;</xsl:text>        
      </xsl:if>
      
    </xsl:if>
    
  </xsl:template>
  
  
  <!-- Option -->
  <xsl:template match="OPTION">
    
    <xsl:choose>
      <xsl:when test="./@Id and ./@Value" >
        <xsl:choose>
          <xsl:when test="../@Value = ./@Id">
            <option selected="yes" value="{./@Id}"><i18n:text><xsl:value-of select="./@Value"/></i18n:text></option>
          </xsl:when>
          <xsl:otherwise>
            <option  value="{./@Id}"><i18n:text><xsl:value-of select="./@Value"/></i18n:text></option>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when> 
     <xsl:when test="./@Id and string-length(./@Value) = 0" >
        <xsl:choose>
          <xsl:when test="../@Value = ./@Id">
            <option selected="yes" value="{./@Id}"><i18n:text><xsl:value-of select="./@Id"/></i18n:text></option>
          </xsl:when>
          <xsl:otherwise>
            <option  value="{./@Id}"><i18n:text><xsl:value-of select="./@Id"/></i18n:text></option>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when> 
     <xsl:when test="./@Value and string-length(./@Id) = 0" >
        <xsl:choose>
          <xsl:when test="../@Value = ./@Value">
            <option selected="yes" value="{./@Value}"><i18n:text><xsl:value-of select="./@Value"/></i18n:text></option>
          </xsl:when>
          <xsl:otherwise>
            <option value="{./@Value}"><i18n:text><xsl:value-of select="./@Value"/></i18n:text></option>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when> 
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>






