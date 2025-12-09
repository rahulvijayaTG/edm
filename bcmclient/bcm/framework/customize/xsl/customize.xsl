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
  <!-- Core -->
  <xsl:import href="../../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../../core/xsl/container.xsl"/>
  <xsl:import href="../../xsl/buttons.xsl"/>
  <xsl:output method="html"/>
 <!-- Page Content -->
  <!-- **********************************************************************
  *********************************************************************** -->  
   <xsl:template match = "RESPONSES" mode="content">
     <!--xsl:call-template name="include_javascript_tableeditor_filter"/-->
   <xsl:call-template name="JAVASCRIPT_TEMPLATE"/>
   <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
       <xsl:with-param name="content" select="RESPONSE"/>
     </xsl:apply-templates>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="container_content">
      <!-- Body -->
      <table id="top_table" border="0" cellpadding="0" cellspacing="0"  width="100%">
           <tr>
           <td width="100%"  height="100%">
           <xsl:call-template name="CUSTOMIZATION"/>
           </td>
           </tr>
      </table>
  </xsl:template>
<!-- **********************************************************************
    *********************************************************************** -->
    <xsl:template name="CUSTOMIZATION">
        <xsl:variable name="tableDisplayName">
          <xsl:value-of select="SORT_COLUMNS/@TableDisplayName"/>
        </xsl:variable>
        <xsl:variable name="tableName">
          <xsl:value-of select="SORT_COLUMNS/@TableName"/>
        </xsl:variable>
        <xsl:variable name="tableEditor">
          <xsl:choose>
        <xsl:when test="SORT_COLUMNS/@TableEditor">true</xsl:when>
        <xsl:otherwise>false</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="singleDot">.</xsl:variable>
        
        <FORM name="sort_columns_form" method="POST">
               <xsl:choose>
                  <xsl:when test="/RESPONSES/RESPONSE/PAGE and string-length(/RESPONSES/RESPONSE/PAGE/@Value) > 0 ">
                  <input type="hidden" name="SERVICE" value="{/RESPONSES/RESPONSE/SERVICE[1]/@Value}"/>
                  <input type="hidden" name="FORM_NAME" value="{/RESPONSES/RESPONSE/FORM_NAME/@Value}"/>
                  <input type="hidden" name="FROM_PAGE_FORM_NAME" value="{/RESPONSES/RESPONSE/FORM_NAME/@Value}"/>
                   <input type="hidden" name="DO_SEARCH" value="Yes"/>
                   <input type="hidden" name="PAGE" value="{/RESPONSES/RESPONSE/PAGE/@Value}"/>
                  </xsl:when>
                  <xsl:otherwise>
                  <input type="hidden" name="TABLE_NAME" value="{/RESPONSES/RESPONSE/TABLE_NAME[1]/@Value}"/>
                              <input type="hidden" name="SERVICE" value="{/RESPONSES/RESPONSE/SERVICE[1]/@Value}"/>
                              <input type="hidden" name="DIRECTORY" value="{/RESPONSES/RESPONSE/DIRECTORY[1]/@Value}"/>
                              <input type="hidden" name="FILE" value="{/RESPONSES/RESPONSE/FILE[1]/@Value}"/>
                  <input type="hidden" name="DO_SEARCH" value="Yes"/>
                  </xsl:otherwise>
            </xsl:choose> 
             <input type="hidden" name="ACTIVITY_ID" value="{/RESPONSES/RESPONSE/ACTIVITY_ID[1]/@Value}"/>
             <!--input type="hidden" name="FAV_ID" value="{/RESPONSES/RESPONSE/FAV_ID[1]/@Value}"/-->

            <i2:container id="customization" stretch="yes" >  
             <table id="top_table" border="0" cellpadding="0" cellspacing="0"  width="100%">
             <tr>
               <td width="100%"  height="100%">
              <xsl:call-template name="DISPLAY_CUSTOMIZATION"> 
                <xsl:with-param name= "tableName"   select="$tableName"/>
                <xsl:with-param name= "singleDot"   select="$singleDot"/>
                <xsl:with-param name= "tableEditor" select="$tableEditor"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td width="100%"  height="100%">
            <xsl:call-template name="MULTIPLE_SORT"> 
             <xsl:with-param name= "tableName"   select="$tableName"/>
             <xsl:with-param name= "singleDot"   select="$singleDot"/>
             <xsl:with-param name= "tableEditor" select="$tableEditor"/>
           </xsl:call-template>
            </td>
          </tr>
          </table>
          </i2:container>
         </FORM>
         </xsl:template>
        <!-- **********************************************************************
    *********************************************************************** -->
  <!-- DISPLAY_CUST tag contains Name and Sequence for tableEditor -->
  <!-- DISPLAY_CUST tag contains Document , Name and Sequence for queryForm -->
  
  
    <xsl:template name="DISPLAY_CUSTOMIZATION"> 
        <xsl:param name= "tableName"/>
        <xsl:param name= "singleDot"/>
        <xsl:param name= "tableEditor"/>
        
    <xsl:variable name="title">
            <b><i18n:text>Display Customization</i18n:text></b>
    </xsl:variable>
    <xsl:variable name="title1">
                <b><i18n:text>Available Fields</i18n:text></b>
    </xsl:variable>
    <xsl:variable name="title2">
                <b><i18n:text>Selected Fields</i18n:text></b>
    </xsl:variable>
    
    <i2:container id="display_container" inner="yes"  title="{$title}" stretch="yes" >   
    <!-- put here -->
    <table>
        <td width="40%">
           <table id="fields_available">
             <tr>
            <td nowrap="nowrap"  width="90%">
            <!-- To display the available fields -->
            <i2:container id="available_fields" inner="yes"  title="{$title1}" stretch="yes" > 
            <select name="fieldList"  onchange="" multiple="yes" size="10"  class="pulldownIE" tabIndex="" >                                
            <!--Table Editor Start -->
            
            <xsl:if test="count(/RESPONSES/RESPONSE/*/TABLE/DISPLAY_CUST)>0">
            
            <xsl:for-each select="SORT_COLUMNS/PROPERTY">
              <xsl:variable name="propertyName">
                <xsl:value-of select="@Name"/>
              </xsl:variable>
            
              <xsl:if test="count(/RESPONSES/RESPONSE/*/TABLE/DISPLAY_CUST/FIELD[@Name = $propertyName]) = 0">
            
                <xsl:variable name="DisplayName">               
	          <xsl:value-of select="@DisplayName"/>
	        </xsl:variable>
	                       		                    
		<xsl:call-template name="CUSTOMISATION_TEMPLATE"> 
		<xsl:with-param name= "tableName"   select="$tableName"/>
		<xsl:with-param name= "Name"   select="$propertyName"/>                    
		<xsl:with-param name= "DisplayName"   select="$DisplayName"/>
		<xsl:with-param name= "singleDot"   select="$singleDot"/>
		<xsl:with-param name= "tableEditor" select="$tableEditor"/>
		<xsl:with-param name= "selectedfield" select="-none-"/>
		</xsl:call-template>
	                      
	     </xsl:if>
	                   
	    </xsl:for-each>
	                 
	    </xsl:if>

            <!--Table Editor End -->
            <!--Query Form Start -->
            
            <xsl:if test="count(/RESPONSES/RESPONSE/*/FORM/DISPLAY_CUST)>0">
            
             <xsl:for-each select="SORT_COLUMNS/RESULT_PROPERTY">
	                
		   <xsl:variable name="propertyName2">
		    <xsl:value-of select="@Property"/>
		   </xsl:variable>
	                   
		   <xsl:if test="count(/RESPONSES/RESPONSE/*/FORM/DISPLAY_CUST/FIELD[@Name = $propertyName2 ]) = 0">
		   
	                <xsl:variable name="DisplayName">
	    		     <xsl:value-of select="@DisplayName"/>
	    		</xsl:variable>
	    		
	                <xsl:variable name="Document">
	    		    <xsl:value-of select="@Document"/>
	                </xsl:variable>         
	                               
	                <xsl:call-template name="CUSTOMISATION_TEMPLATE"> 
	                      <xsl:with-param name= "tableName"   select="$Document"/>
	                      <xsl:with-param name= "Name"   select="$propertyName2"/>		  
	                      <xsl:with-param name= "DisplayName"   select="$DisplayName"/>
	                      <xsl:with-param name= "singleDot"   select="$singleDot"/>
	                      <xsl:with-param name= "tableEditor" select="$tableEditor"/>
	                      <xsl:with-param name= "selectedfield" select="-none-"/>
	                </xsl:call-template>
	                    
	            </xsl:if>    

            </xsl:for-each>   
            
            </xsl:if>
            <!--Query Form End-->
            </select>
            </i2:container>
            </td>
            <td>
            </td>
            </tr>
        </table>
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
                 <i2:button id="onMoveDoubleRight" name="onMoveDoubleRight"  onclick="javascript:i2uiduallistboxmoveall(document.sort_columns_form.fieldList,document.sort_columns_form.selectedFieldList)">
                  &#xA0;
                  <i2:img src="/disabled_arrow_double_right.gif" align="bottom" border="0">
                  <i2:attribute name="alt">
                           <i18n:text>Select All Fields</i18n:text>
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
                      <i2:button id="onMoveRight" name="onMoveRight"  onclick="javascript:i2uiduallistboxmoveit(document.sort_columns_form.fieldList,document.sort_columns_form.selectedFieldList,document.sort_columns_form.fieldList.options.selected)">
                       &#xA0;
                       <i2:img src="/disabled_arrow_right.gif" align="bottom" border="0">
                         <i2:attribute name="alt">
                           <i18n:text>Select Selected Fields</i18n:text>
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
                      <i2:button id="onMoveLeft" name="onMoveLeft" onclick="javascript:i2uiduallistboxmoveitLeft(document.sort_columns_form.selectedFieldList,document.sort_columns_form.fieldList,document.sort_columns_form.selectedFieldList.options.selected)">
                       &#xA0;
                       <i2:img  src="/disabled_arrow_left.gif" align="bottom" border="0">
                         <i2:attribute name="alt">
                           <i18n:text>Unselect Selected Fields</i18n:text>
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
                       <i2:button id="onMoveDoubleLeft" name="onMoveDoubleLeft" onclick="javascript:i2uiduallistboxmoveallLeft(document.sort_columns_form.selectedFieldList,document.sort_columns_form.fieldList)">
                       &#xA0;
                       <i2:img src="/disabled_arrow_double_left.gif" align="bottom" border="0">
                         <i2:attribute name="alt">
                           <i18n:text>Unselect All Fields</i18n:text>
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
          <td width="40%">
        <table>
            <td>
            <table id="select_fields" >
                <tr>
                  <td nowrap="nowrap"  width="60%">
                    <i2:container id="selected_fields" inner="yes"  title="{$title2}" stretch="yes" > 
                <select name="selectedFieldList"  onchange="" multiple="yes" size="10"  class="pulldownIE" tabIndex="">
                <!-- when the user goes  back to Customize page again, the earlier process done remain saved-->                
                <!-- FOR TABLE EDITOR Start -->
                
               <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/TABLE/DISPLAY_CUST)>0">
          
                 <xsl:for-each select="/RESPONSES/RESPONSE/*/TABLE/DISPLAY_CUST/FIELD">
	                    
		   <xsl:variable name="propertyName">
		     <xsl:value-of select="@Name"/>
		   </xsl:variable>                
	                    
		   <xsl:if test="count(/RESPONSES/RESPONSE/SORT_COLUMNS/PROPERTY[@Name = $propertyName]) > 0">
	                      
	                       
		      <xsl:variable name="DisplayName">
	              <xsl:value-of select="/RESPONSES/RESPONSE/SORT_COLUMNS/PROPERTY[@Name =  $propertyName]/@DisplayName"/>
	              </xsl:variable>		
	                        
	    		     
	             <xsl:call-template name="CUSTOMISATION_TEMPLATE">         
			    <xsl:with-param name= "tableName"   select="$tableName"/>
			    <xsl:with-param name= "Name"   select="$propertyName"/>		  
			    <xsl:with-param name= "DisplayName"   select="$DisplayName"/>
			    <xsl:with-param name= "singleDot"   select="$singleDot"/>
			    <xsl:with-param name= "tableEditor" select="$tableEditor"/>
			    <xsl:with-param name= "selectedfield" select="-none-"/>
	           </xsl:call-template> 
	                        
	          </xsl:if>

               </xsl:for-each>  
               
            </xsl:if>
                <!-- FOR TABLE EDITOR End -->
                <!-- FOR FORM Start-->
                
            <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/FORM/DISPLAY_CUST)>0">
            
              <xsl:for-each select="/RESPONSES/RESPONSE/*/FORM/DISPLAY_CUST/FIELD">
	                
	       <xsl:variable name="propertyName2">
	       <xsl:value-of select="@Name"/>
	       </xsl:variable>

					<xsl:variable name="Document">
							   <xsl:value-of select="@Document"/>
					</xsl:variable> 
					
	       <xsl:if test="count(/RESPONSES/RESPONSE/SORT_COLUMNS/RESULT_PROPERTY[@Property = $propertyName2 and @Document=$Document]) > 0">
	                   
	        
	        <xsl:variable name="DisplayName">
	          <xsl:value-of select="/RESPONSES/RESPONSE/SORT_COLUMNS/RESULT_PROPERTY[@Property = $propertyName2 and @Document=$Document]/@DisplayName"/>
	        </xsl:variable>
	    
		        

	       <xsl:call-template name="CUSTOMISATION_TEMPLATE"> 
	        <xsl:with-param name= "tableName"   select="$Document"/>
	        <xsl:with-param name= "Name"   select="$propertyName2"/>		
	        <xsl:with-param name= "DisplayName"   select="$DisplayName"/>
	        <xsl:with-param name= "singleDot"   select="$singleDot"/>
	        <xsl:with-param name= "tableEditor" select="$tableEditor"/>
	        <xsl:with-param name= "selectedfield" select="-none-"/>
	      </xsl:call-template>
	      
	      </xsl:if>    
	      
	     </xsl:for-each>  
	     
	      </xsl:if>

                <!-- FOR FORM End-->
                <!-- when the user goes  to Customize page for the first time-->
                <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/*/DISPLAY_CUST)=0 ">
               	
		                <xsl:if test= "count(SORT_COLUMNS/PROPERTY)>0">
		                <xsl:for-each select="SORT_COLUMNS/PROPERTY">
		                
		                     <xsl:variable name="Name">
				     	  <xsl:value-of select="@Name"/>
		                     </xsl:variable>
		                     
		                      <xsl:variable name="DisplayName">
				     			<xsl:value-of select="@DisplayName"/>
				      </xsl:variable>
				
				
				     <xsl:call-template name="CUSTOMISATION_TEMPLATE"> 
				     <xsl:with-param name= "tableName"   select="$tableName"/>
				     <xsl:with-param name= "Name"   select="$Name"/>		     
				     <xsl:with-param name= "DisplayName"   select="$DisplayName"/>                  
				     <xsl:with-param name= "singleDot"   select="$singleDot"/>
				     <xsl:with-param name= "tableEditor" select="$tableEditor"/>
				     <xsl:with-param name= "selectedfield" select="-none-"/>
				     </xsl:call-template>
				 </xsl:for-each>
			       </xsl:if>  
			       
			       <xsl:if test= "count(SORT_COLUMNS/RESULT_PROPERTY)>0">
			       <xsl:for-each select="SORT_COLUMNS/RESULT_PROPERTY">
			       
				
				   <xsl:variable name="Document">
					<xsl:value-of select="@Document"/>
				   </xsl:variable>  
				   
				   <xsl:variable name="Property">
				   	<xsl:value-of select="@Property"/>		   
				   </xsl:variable>		
				    
				   <xsl:variable name="DisplayName">
				        <xsl:value-of select="@DisplayName"/>
				   </xsl:variable>
				   
				   <xsl:call-template name="CUSTOMISATION_TEMPLATE"> 
				     <xsl:with-param name= "tableName"   select="$Document"/>
				     <xsl:with-param name= "Name"   select="$Property"/>		     
				     <xsl:with-param name= "DisplayName"   select="$DisplayName"/>                  
				     <xsl:with-param name= "singleDot"   select="$singleDot"/>
				     <xsl:with-param name= "tableEditor" select="$tableEditor"/>
				     <xsl:with-param name= "selectedfield" select="-none-"/>
				   </xsl:call-template>
				   
				</xsl:for-each>    
				</xsl:if>  
		                   
		                 
		            </xsl:if>

                </select>
                </i2:container>
                </td>
                </tr>
                        </table>
            </td>
                 </table>
             </td>
          <td>
           <i2:button id="onMoveUp" name="onMoveUp" onclick="javascript:moveUp(document.sort_columns_form.selectedFieldList)">
            &#xA0;
            <i2:img  src="/disabled_arrow_up.gif" align="bottom" border="0">
              <i2:attribute name="alt">
            <i18n:text>Move up </i18n:text>
              </i2:attribute>
            </i2:img>
             &#xA0;&#xA0;
           </i2:button>
          </td>
          <td>
            <i2:button id="onMoveDown" name="onMoveDown" onclick="javascript:moveDown(document.sort_columns_form.selectedFieldList)">
            &#xA0;
            <i2:img src="/disabled_arrow_down.gif" align="bottom" border="0">
              <i2:attribute name="alt">
            <i18n:text>Move Down</i18n:text>
              </i2:attribute>
            </i2:img>
             &#xA0;
            </i2:button>
          </td>
          <tr>
          <td>&#xA0;</td>
                  </tr>
        <td width="20%">
        </td>
        </table>
    </i2:container>
    </xsl:template>
     <!-- **********************************************************************
    *********************************************************************** -->
    <xsl:template name="MULTIPLE_SORT">
            <xsl:param name= "tableName"/>
            <xsl:param name= "singleDot"/>
            <xsl:param name= "tableEditor"/>
            
         <xsl:variable name="title">
                   <b><i18n:text>Sort Customization</i18n:text></b>
        </xsl:variable>
        
        <script type="text/javascript">
        
	    function myFunction(sortdropDown)
	    {
	     var w =sortdropDown.selectedIndex;
	     var selected_text = sortdropDown.options[w].text;
	     //alert(selected_text);
	     return selected_text;
	    }
      </script>
      
      <!-- For seeting the sort-order when customize is clicked twice -->
      <xsl:variable name="firstsortorder">     
         <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY)>0">
         <xsl:value-of select="/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY/*[position()=1]/@Sort"/>
         </xsl:if>
         <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY)>0">
         <xsl:value-of select="/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY/*[position()=1]/@Sort"/>
         </xsl:if>
         <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY)=0 and count(/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY)=0">   
         <xsl:value-of select="'Ascending'"/> 
         </xsl:if>       
      </xsl:variable>
      <xsl:variable name="secondsortorder">     
         <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY)>0">
          <xsl:value-of select="/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY/*[position()=2]/@Sort"/>
          </xsl:if>
          <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY)>0">
          <xsl:value-of select="/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY/*[position()=2]/@Sort"/>
          </xsl:if>
          <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY)=0 and count(/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY)=0">   
          <xsl:value-of select="'Ascending'"/> 
          </xsl:if> 
      </xsl:variable>
      <xsl:variable name="thirdsortorder">     
          <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY)>0">
          <xsl:value-of select="/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY/*[position()=3]/@Sort"/>
          </xsl:if>
          <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY)>0">
          <xsl:value-of select="/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY/*[position()=3]/@Sort"/>
          </xsl:if>
          <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY)=0 and count(/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY)=0">   
          <xsl:value-of select="'Ascending'"/> 
          </xsl:if>
      </xsl:variable>
      <xsl:variable name="prefix">
       <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY)>0">
       <xsl:value-of select ="/RESPONSES/RESPONSE/SERVICE/TABLE/@Name" />     
       </xsl:if>
      </xsl:variable>
      <xsl:variable name="firstsortname">     
           <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY)>0">
           <xsl:value-of select="concat($prefix ,'.',name(/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY/*[position()=1]))"/>
           </xsl:if>
           <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY)>0">
           <xsl:value-of select="name(/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY/*[position()=1])"/>
           </xsl:if>
           <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY)=0 and count(/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY)=0">   
           <xsl:value-of select="'-Select-'"/> 
           </xsl:if>
      </xsl:variable>
      <xsl:variable name="secondsortname">     
          <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY)>0">
          <xsl:value-of select="concat($prefix ,'.',name(/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY/*[position()=2]))"/>
          </xsl:if>
          <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY)>0">
          <xsl:value-of select="name(/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY/*[position()=2])"/>
          </xsl:if>
          <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY)=0 and count(/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY)=0">   
          <xsl:value-of select="'-Select-'"/> 
          </xsl:if>
      </xsl:variable>
      <xsl:variable name="thirdsortname">     
           <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY)>0">
           <xsl:value-of select="concat($prefix ,'.',name(/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY/*[position()=3]))"/>
           </xsl:if>
           <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY)>0">
           <xsl:value-of select="name(/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY/*[position()=3])"/>
           </xsl:if>
           <xsl:if test="count(/RESPONSES/RESPONSE/SERVICE/TABLE/ORDER_BY)=0 and count(/RESPONSES/RESPONSE/SERVICE/FORM/ORDER_BY)=0">   
           <xsl:value-of select="'-Select-'"/> 
           </xsl:if>
      </xsl:variable>
       
         <i2:container id="sort_container" inner="yes"  title="{$title}" stretch="yes" >
            <p><xsl:value-of select="@TableDisplayName"/></p>
            <table id="top_table" border="0" cellpadding="0" cellspacing="0"  width="100%">
              <tr>
              <td nowrap="yes"><i18n:text>First  Sort</i18n:text> &#xA0;
              </td>
              <td nowrap="yes" >
               <select  name="firstsort" onchange="javascript:myFunction(this);">
                  <option>
                  <i18n:text>-Select-</i18n:text>
                  </option>
              
	        

                <xsl:if test= "count(SORT_COLUMNS/PROPERTY)>0">
                  
                <xsl:for-each select="SORT_COLUMNS/PROPERTY[PRESENTATION/SORTABLE/@Value = 'yes']">
                                    
			
		     <xsl:variable name="Name">
		     	  <xsl:value-of select="@Name"/>
		     </xsl:variable>
		     
		     
		     <xsl:variable name="DisplayName">
		     		<xsl:value-of select="@DisplayName"/>
	             </xsl:variable>
		
		
		     <xsl:call-template name="CUSTOMISATION_TEMPLATE"> 
		       <xsl:with-param name= "tableName"   select="$tableName"/>
		       <xsl:with-param name= "Name"   select="$Name"/>		      
                       <xsl:with-param name= "DisplayName"   select="$DisplayName"/>                  
                       <xsl:with-param name= "singleDot"   select="$singleDot"/>
                       <xsl:with-param name= "tableEditor" select="$tableEditor"/>
                       <xsl:with-param name= "selectedfield" select="$firstsortname"/>
                   </xsl:call-template>  
                   
                </xsl:for-each>   
                
                </xsl:if>  
                
                <xsl:if test= "count(SORT_COLUMNS/RESULT_PROPERTY)>0">
                
                <xsl:for-each select="SORT_COLUMNS/RESULT_PROPERTY[PRESENTATION/SORTABLE/@Value = 'yes']">
                
                   <xsl:variable name="Property">
		   	<xsl:value-of select="@Property"/>
		   </xsl:variable>
		   
                   <xsl:variable name="Document">
		   	<xsl:value-of select="@Document"/>
                   </xsl:variable> 
                   
                   <xsl:variable name="DisplayName">
		   		<xsl:value-of select="@DisplayName"/>
	           </xsl:variable>
                   
                   <xsl:call-template name="CUSTOMISATION_TEMPLATE"> 
		     <xsl:with-param name= "tableName"   select="$Document"/>
		     <xsl:with-param name= "Name"   select="$Property"/>		     
		     <xsl:with-param name= "DisplayName"   select="$DisplayName"/>                  
		     <xsl:with-param name= "singleDot"   select="$singleDot"/>
		     <xsl:with-param name= "tableEditor" select="$tableEditor"/>
		    <xsl:with-param name= "selectedfield" select="$firstsortname"/>
		   </xsl:call-template>
		
	       </xsl:for-each>       
               </xsl:if>       
                       
               </select>
          </td>            
              <td>
               <select name ="firstsort_order">
           <xsl:call-template name="SORT_ORDER">
           <xsl:with-param name="sortorder" select="$firstsortorder"/>
           </xsl:call-template>
           </select>
           </td>
               </tr>
               <tr>
                <TD nowrap="yes"><i18n:text>Second  Sort</i18n:text> &#xA0;</TD> 
                <td nowrap="yes" >
                <select  name="secondsort" onchange="javascript:myFunction(this);">
                 <option>
            <i18n:text>-Select-</i18n:text>
         </option>
         
        
		 
	 <xsl:if test= "count(SORT_COLUMNS/PROPERTY)>0">
		 
	 <xsl:for-each select="SORT_COLUMNS/PROPERTY[PRESENTATION/SORTABLE/@Value = 'yes']">

		 
		<xsl:variable name="Name">
		     <xsl:value-of select="@Name"/>
		</xsl:variable>
                 
                 
                 <xsl:variable name="DisplayName">
			    <xsl:value-of select="@DisplayName"/>
	         </xsl:variable>


		<xsl:call-template name="CUSTOMISATION_TEMPLATE"> 
		<xsl:with-param name= "tableName"   select="$tableName"/>
		<xsl:with-param name= "Name"   select="$Name"/>		      
		<xsl:with-param name= "DisplayName"   select="$DisplayName"/>                  
		<xsl:with-param name= "singleDot"   select="$singleDot"/>
		 <xsl:with-param name= "tableEditor" select="$tableEditor"/>
		<xsl:with-param name= "selectedfield" select="$secondsortname"/>
		</xsl:call-template>

	</xsl:for-each>       
	
	</xsl:if>       
		                          
		 		 
	<xsl:if test= "count(SORT_COLUMNS/RESULT_PROPERTY)>0">
		 		                 
	<xsl:for-each select="SORT_COLUMNS/RESULT_PROPERTY[PRESENTATION/SORTABLE/@Value = 'yes']">

	   <xsl:variable name="Property">
		<xsl:value-of select="@Property"/>
	   </xsl:variable>

	   <xsl:variable name="Document">
		<xsl:value-of select="@Document"/>
	   </xsl:variable> 

            <xsl:variable name="DisplayName">
	   	    <xsl:value-of select="@DisplayName"/>
	  </xsl:variable>


	   <xsl:call-template name="CUSTOMISATION_TEMPLATE"> 
	     <xsl:with-param name= "tableName"   select="$Document"/>
	     <xsl:with-param name= "Name"   select="$Property"/>		     
	     <xsl:with-param name= "DisplayName"   select="$DisplayName"/>                  
	     <xsl:with-param name= "singleDot"   select="$singleDot"/>
	     <xsl:with-param name= "tableEditor" select="$tableEditor"/>
	     <xsl:with-param name= "selectedfield" select="$secondsortname"/>
	   </xsl:call-template>
		 		
	 </xsl:for-each>
	</xsl:if>

                </select>          
                </td>
                <td>
        <select name ="secondsort_order">
               <xsl:call-template name="SORT_ORDER">
            <xsl:with-param name="sortorder" select="$secondsortorder"/>
                   </xsl:call-template>
           </select>
               </td>
               </tr>
               <tr>
               <TD nowrap="yes"><i18n:text>Third  Sort</i18n:text> &#xA0;</TD>
               <td nowrap="yes" >
               <select  name="thirdsort" onchange="javascript: myFunction(this);">
                <option>
                <i18n:text>-Select-</i18n:text>
            </option>
            
	   
		 
	   <xsl:if test= "count(SORT_COLUMNS/PROPERTY)>0">

	   <xsl:for-each select="SORT_COLUMNS/PROPERTY[PRESENTATION/SORTABLE/@Value = 'yes']">


		   <xsl:variable name="Name">
			  <xsl:value-of select="@Name"/>
		   </xsl:variable>
		   
		   <xsl:variable name="DisplayName">
		   	<xsl:value-of select="@DisplayName"/>
                   </xsl:variable>
	 	 
		   <xsl:call-template name="CUSTOMISATION_TEMPLATE"> 
			<xsl:with-param name= "tableName"   select="$tableName"/>
			<xsl:with-param name= "Name"   select="$Name"/>		      
			<xsl:with-param name= "DisplayName"   select="$DisplayName"/>                  
			<xsl:with-param name= "singleDot"   select="$singleDot"/>
			<xsl:with-param name= "tableEditor" select="$tableEditor"/>
			<xsl:with-param name= "selectedfield" select="$thirdsortname"/>
		   </xsl:call-template>  
		 
	 </xsl:for-each>   
		 
	 </xsl:if>  
		 
	  <xsl:if test= "count(SORT_COLUMNS/RESULT_PROPERTY)>0">
		 
	 <xsl:for-each select="SORT_COLUMNS/RESULT_PROPERTY[PRESENTATION/SORTABLE/@Value = 'yes']">
		 
	    <xsl:variable name="Property">
		<xsl:value-of select="@Property"/>
	    </xsl:variable>
		 
	    <xsl:variable name="Document">
		<xsl:value-of select="@Document"/>
	    </xsl:variable> 
	   
	    <xsl:variable name="DisplayName">
	   	<xsl:value-of select="@DisplayName"/>
	    </xsl:variable>
	   
	    <xsl:call-template name="CUSTOMISATION_TEMPLATE"> 
	     <xsl:with-param name= "tableName"   select="$Document"/>
	     <xsl:with-param name= "Name"   select="$Property"/>		     
	     <xsl:with-param name= "DisplayName"   select="$DisplayName"/>                  
	     <xsl:with-param name= "singleDot"   select="$singleDot"/>
	     <xsl:with-param name= "tableEditor" select="$tableEditor"/>
	     <xsl:with-param name= "selectedfield" select="$thirdsortname"/>
	   </xsl:call-template>
		 
         </xsl:for-each>  
         
	</xsl:if>       

            </select>
           </td>
               <td>
               <select name ="thirdsort_order">
                   <xsl:call-template name="SORT_ORDER">
                   <xsl:with-param name="sortorder" select="$thirdsortorder"/>
                   </xsl:call-template>
           </select>
           </td>
          </tr>
     </table>        
     </i2:container>
     </xsl:template>
   
    <!-- **********************************************************************
      *********************************************************************** -->
         <xsl:template name="SORT_ORDER">
          <xsl:param name="sortorder"/>
          <option>
          <xsl:if test="$sortorder = 'Ascending'">
             <xsl:attribute name="selected">selected</xsl:attribute>
          </xsl:if>
          <i18n:text>Ascending</i18n:text>
          </option>  
          <option>
           <xsl:if test="$sortorder = 'Descending'">
               <xsl:attribute name="selected">selected</xsl:attribute>
          </xsl:if>
          <i18n:text>Descending</i18n:text>
          </option>  
          </xsl:template>
          
    <!-- **********************************************************************
        *********************************************************************** -->  
           <!-- tableName contains tableName for tableEditor and Document for Queryform -->
	   <!-- Name is Name of tableEditor and property of Queryform -->
        
      <xsl:template name="CUSTOMISATION_TEMPLATE">      
        <xsl:param name= "tableName"/>
        <xsl:param name= "Name"/>        
	<xsl:param name= "DisplayName"/>
        <xsl:param name= "singleDot"/>
        <xsl:param name= "tableEditor"/>
        <xsl:param name= "selectedfield" />
        
       <xsl:variable name="name">
	    <xsl:value-of select="concat( $tableName , $singleDot ,  $Name)"/>                 
       </xsl:variable>

       <xsl:variable name="displayText">
	  <xsl:choose>
	  <xsl:when test=" $DisplayName">
	       <xsl:value-of select="concat( $tableName , $singleDot ,  $DisplayName)"/>
	  </xsl:when>
	  <xsl:otherwise>
	       <xsl:value-of select="concat( $tableName , $singleDot ,  $Name)"/>
	  </xsl:otherwise>
	  </xsl:choose>
       </xsl:variable>

       <!-- In case customize was clicked twice then sort customization will show previous selected value , for display customization the value of selected field is hard coded as -none- -->

       <option  value="{$name}">                 
	   <xsl:if test="$selectedfield=$name">
	      <xsl:attribute name="selected">selected</xsl:attribute>
	   </xsl:if>

	   <i18n:text>
	       <xsl:value-of select="$displayText"/>
	   </i18n:text>                  
       </option>

     </xsl:template>

<!-- **********************************************************************
      *********************************************************************** -->

   <xsl:template name="onLoad_js">
	function onLoad()
	{
	  //alert("hello");    
	  sort_available_fields();

	}
   </xsl:template>
      
  <!-- Javascript -->
  <!-- **********************************************************************
      *********************************************************************** -->
       <xsl:template name="JAVASCRIPT_TEMPLATE">
            <script>
      <![CDATA[      
      function onApplyAndReturn()
      {
            var  lenright = document.sort_columns_form.selectedFieldList.length;
            if(lenright == 0 || lenright == null)
            {
                core_alert("Please select atleast one field");
                return;
            }
         for (var i=0; i<lenright ; i++)
         {
          document.sort_columns_form.selectedFieldList.options[i].selected = true;
          //alert(document.sort_columns_form.selectedFieldList.options[i].text);
          // alert(document.sort_columns_form.selectedFieldList.options[i].value);
             }
            document.sort_columns_form.action="../customize/CustomizeView/sortdisplay.cmd";
            document.sort_columns_form.submit();
            
      }
      function back()
      {
           document.sort_columns_form.target="appFrame";
           document.sort_columns_form.action=omxContextPath+ "/bcm/framework/breadcrumb/controller/back.cmd";
           document.sort_columns_form.submit();
      }
      
   function sort_available_fields()
             {
             var availablefdlen = document.sort_columns_form.fieldList.length;
             var tempvar = new Array(availablefdlen);    
             var tempval = new Array(availablefdlen);     
      	    if(availablefdlen > 0)
      	      	 {
                     for (var l=0; l< availablefdlen; l++)
      		      {
      		       tempvar[l]   =  document.sort_columns_form.fieldList.options[l].text ;      		           		        
      		      }
      		      
      		     tempvar.sort(myCompare);
      		  
      		  for (var i=0; i< availablefdlen; i++)
      		      {
      		         for(var j=0 ;j<availablefdlen; j++)
      		         {
      		           if(tempvar[i] == document.sort_columns_form.fieldList.options[j].text)
      		            {
      		            //alert(tempvar[i]+'='+document.sort_columns_form.fieldList.options[j].text);
      		            tempval[i] = document.sort_columns_form.fieldList.options[j].value;
      		            //alert('value'+tempval[i]);
      		            }
      		          }    
      		  	
      		      }
      		      
      		   for (var k=0; k< availablefdlen; k++)
      		    {
      		    document.sort_columns_form.fieldList.options[k].text = tempvar[k];
      		    document.sort_columns_form.fieldList.options[k].value = tempval[k];      		  
      		    }
      		  
             } 
	}
	
      function myCompare(a, b) 
      {
        strA = a.toLowerCase();
        strB = b.toLowerCase();
        if (strA < strB) { return -1; }
        else {
          if (strA > strB) { return 1; }
          else { return 0; }
        }
      } 

       function i2uiduallistboxmoveitLeft(fromlistbox, tolistbox, picked)
       {
         i2uiduallistboxmoveit(fromlistbox, tolistbox, picked);
         sort_available_fields();     
       
       }
       
       
       function i2uiduallistboxmoveallLeft(fromlistbox, tolistbox)
       {       
         i2uiduallistboxmoveall(fromlistbox, tolistbox);
         sort_available_fields();       
       }
       
      function i2uiduallistboxmoveit(fromlistbox, tolistbox, picked)
      {
       if (picked == null)
       picked = fromlistbox.selectedIndex;
       //alert(picked);
       if(picked < 0)
       {
        core_alert("Please select atleast one  field");
        return;
       }
       if (picked >= 0)
       {
       var len = tolistbox.options.length;
       tolistbox.options.length++;
       tolistbox.options[len].text = fromlistbox.options[picked].text;
       tolistbox.options[len].value = fromlistbox.options[picked].value;
       fromlistbox.options[picked].selected = false;
       if (document.layers)
       {
         var len2 = fromlistbox.options.length;
         for (var i=picked; i<len2-1; i++)
         {
           fromlistbox.options[i].text     = fromlistbox.options[i+1].text;
           fromlistbox.options[i].value    = fromlistbox.options[i+1].value;
           fromlistbox.options[i].selected = fromlistbox.options[i+1].selected
         }
         if (len2 > 0)
           fromlistbox.options.length--;
       }
       else
       if (document.all)
       {
         // remove not available in Netscape 6.x
         fromlistbox.options.remove(picked);
       }
       else
       {
         fromlistbox.options[picked] = null;
       }

     }

       // process next selected option if multiple
       if (fromlistbox.selectedIndex >= 0)
       i2uiduallistboxmoveit(fromlistbox, tolistbox);
    }
       
       
    function i2uiduallistboxmoveall(fromlistbox, tolistbox)
       {
       
       while(fromlistbox.options.length > 0)
       {
       i2uiduallistboxmoveit(fromlistbox, tolistbox, 0);
       }
       
       }
    
    function moveUp(el) {     
         var idx = el.selectedIndex
          if (idx==-1) 
          {
            //alert("You must first select the item to reorder.")
            
          }  
          else
          {
            //var nxidx = idx+( bDir? -1 : 1)
            var nxidx = idx - 1
            if (nxidx<0) nxidx=el.length-1
            if (nxidx>=el.length) nxidx=0
            var oldVal = el[idx].value
            var oldText = el[idx].text
            el[idx].value = el[nxidx].value
            el[idx].text = el[nxidx].text
            el[nxidx].value = oldVal
            el[nxidx].text = oldText
            el.selectedIndex = nxidx
          } 
    }
    
    function moveDown(el) {     
        var idx = el.selectedIndex
         if (idx==-1)
         {
           //alert("You must first select the item to reorder.")
           
         }  
         else
         {
           //var nxidx = idx+( bDir? -1 : 1)
           var nxidx = idx + 1
           if (nxidx<0) nxidx=el.length-1
           if (nxidx>=el.length) nxidx=0
           var oldVal = el[idx].value
           var oldText = el[idx].text
           el[idx].value = el[nxidx].value
           el[idx].text = el[nxidx].text
           el[nxidx].value = oldVal
           el[nxidx].text = oldText
           el.selectedIndex = nxidx
         } 
    }
         
            
    ]]>
   </script>
</xsl:template>  
<!-- **********************************************************************
*********************************************************************** -->
</xsl:stylesheet>

