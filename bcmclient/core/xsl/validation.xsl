<?xml version="1.0" standalone='no'?>
  
<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:output method="html"/>
  
  <!-- Requirement for validation
  The input field and the alert img should be present in same <TD></TD> 
  -->
  
  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
   <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="display_instruction_area">  
    <xsl:param name="pFormName"/>
    <xsl:param name="pInstructionMessage"/>
    <xsl:param name="pSuccessMessage" select="/RESPONSES/RESPONSE/SUCCESS_MESSAGE/@Value"/>
    <xsl:param name="pErrorMessage" select="/RESPONSES/RESPONSE/ERROR_MESSAGE/@Value"/>
    <xsl:param name="pFieldErrorMessage"/>

    <xsl:param name="pAnyFieldIsRequired" select="'true'"/>
    <xsl:param name="pAnyFieldHasErrors" select="'false'"/>
    <xsl:param name="pAnyFieldHasInformation" select="'false'"/>
      
    
    <xsl:call-template name="display_validation_area">  
      <xsl:with-param name="pFormName" select="$pFormName"/>
      <xsl:with-param name="pInstructionMessage" select="$pInstructionMessage"/>
      <xsl:with-param name="pSuccessMessage" select="$pSuccessMessage"/>
      <xsl:with-param name="pErrorMessage" select="$pErrorMessage"/>
      <xsl:with-param name="pFieldErrorMessage" select="$pFieldErrorMessage"/>
      <xsl:with-param name="pAnyFieldIsRequired" select="$pAnyFieldIsRequired"/>
      <xsl:with-param name="pAnyFieldHasErrors" select="$pAnyFieldHasErrors"/>
      <xsl:with-param name="pAnyFieldHasInformation" select="$pAnyFieldHasInformation"/>
    </xsl:call-template>
  </xsl:template>  
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="display_validation_area">  
    <xsl:param name="pFormName"/>
    <xsl:param name="pInstructionMessage"/>
    <xsl:param name="pSuccessMessage"/>
    <xsl:param name="pErrorMessage"/>
    <xsl:param name="pFieldErrorMessage"/>
    <xsl:param name="pAnyFieldIsRequired" select="'true'"/>
    <xsl:param name="pAnyFieldHasErrors" select="'false'"/>
    <xsl:param name="pAnyFieldHasInformation" select="'false'"/>
    
    
    <xsl:call-template name="include_javascript_validation">
      <xsl:with-param name="pFormName" select="$pFormName"/>
    </xsl:call-template>
    
    <xsl:call-template name="display_validation_messages">  
      <xsl:with-param name="pFormName" select="$pFormName"/>
      <xsl:with-param name="pInstructionMessage" select="$pInstructionMessage"/>
      <xsl:with-param name="pSuccessMessage" select="$pSuccessMessage"/>
      <xsl:with-param name="pErrorMessage" select="$pErrorMessage"/>
      <xsl:with-param name="pFieldErrorMessage" select="$pFieldErrorMessage"/>
      <xsl:with-param name="pAnyFieldIsRequired" select="$pAnyFieldIsRequired"/>
      <xsl:with-param name="pAnyFieldHasErrors" select="$pAnyFieldHasErrors"/>
      <xsl:with-param name="pAnyFieldHasInformation" select="$pAnyFieldHasInformation"/>
    </xsl:call-template>
    
  </xsl:template>
  
  
   <!-- Javascript  --> 
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="javascript_onLoad_validation">  
    <xsl:param name="pFormName"/>
  </xsl:template>
  
  <!-- ********************************************************************** 
     *********************************************************************** -->  
  <xsl:template name="include_javascript_validation">  
    
    <script>
// Set Focus
  <![CDATA[

function validation_setFocusOnInstructionArea()
{
  var obj = document.getElementById('instruction_area');
  if (obj != null)
    obj.focus();        
}
    
 ]]>
    function isFormValid(formName)
    {
      var ifError = validate(formName);

      if (ifError) 
      {
          onResize();
          validation_setFocusOnInstructionArea();
          return false;
      }  
      else 
        return true;
    }
    
    // This is deprecated use isFormValid instead();
    function requiredFieldCheck(onLoad)
    {
      if (onLoad) return 'true';
      if (validate(onLoad, false)) return 'true'
      else
        return 'false';
    }

    function validation_clearImages(formName)
    {
      validate(formName, true);
    }

    function validation_turnOffRequired(oForm)
    {
      var elem = oForm.elements.length;
      for(i = 0; i &lt; elem; i++)
      {
        if ( 
              oForm.elements[i].required != null &amp;&amp; 
              (oForm.elements[i].required == true  ||
              oForm.elements[i].required == 'true')  

            )
        {
          oForm.elements[i].required = false;
        } 
      }
    }
    
    function validate(pFormName , clearAllImages)
    {
    
      // This function enables 
      //  1)Instruction Messages 
      //  2)Field Alert Icons (if a required field is missing)
      
      var i, j;
      
      var anyRequiredFieldIsMissing = false;
      
      var anyFieldHasErrors = false ;
      var anyFieldHasErrors_new = false ;
      
      var anyFieldIsRequired = false ;

      var formName = pFormName;
      if (clearAllImages == null) clearAllImages = false;
      
      // for each form
      for( j = 0; j &lt; document.forms.length; j++)
      {
        var formObj = document.forms[j];
        var currentformName = formObj.name;
        // if form name is passed
        // do validation for that 
        // else do for all forms
        if (pFormName != null &amp;&amp; pFormName != "")
        {

          if (currentformName != pFormName)
            continue;
        }
        
        var elementsLen = formObj.elements.length;
        
        // for each element in the form
        for(i = 0; i &lt; elementsLen; i++)
        {
          var elem = document.forms[j].elements[i];
          var elemtype = elem.type;
          var fieldtype = elem.fieldtype;

          var elemName = elem.name;
          var elemValue = trimString(elem.value);
          var elemIsRequired = elem.required ;
          if (elemIsRequired == 'true')
          elemIsRequired = true;
          if (elemIsRequired == 'false')
            elemIsRequired = false;

          var elemDis = elem.disabled;
          var elemHasErrors = false;
          var elemHasErrors_new = false;          
          var elemHasInvalidDate = false;
          var elemHasInvalidNumber = false;
          
//          alert(objectToString(elem));
          if (elem.validationmsg != null) 
          {
//            alert(elemName + "has Error" );
            anyFieldHasErrors = true;
            elemHasErrors = true;
          }  
          if (elem.required == true || elem.required == 'true') 
          {
        //    alert(elemName + "is Required" );
            anyFieldIsRequired = true;
          }  

          // the icon - Required{!}          
          var item = elemName + "_REQ";
          var errorIcon = elemName + "_ERR";

          // Numeric Check - Start::
          if (fieldtype == "Number")
          {
              // remove any ,
              var elemValueWithoutFormating;
              if (elemValue != "")
                elemValueWithoutFormating = parseInt(elemValue.replace(/[,\.]+/g, ""));
  
              if ( elemValue != "" &amp;&amp; isNaN(elemValueWithoutFormating) )
              {
                anyFieldHasErrors_new = true;
                elemHasErrors_new = true;
                elemHasInvalidNumber = true;               
              }
          }
          // Numeric Check - End.
          
          // Date Check - Start::
          if( ((fieldtype == "DateRange") || (fieldtype == "Date")) &amp;&amp;
                elemValue != "" &amp;&amp; page_dateFormat != "")
          { 
            if ( isDate(elemValue, page_dateFormat) == false )
            {
              anyFieldHasErrors_new = true;
              elemHasErrors_new = true;
              elemHasInvalidDate = true;
            }
          }
          // Date Check - End.
      
          
          // START -  Enable/Disable Alert Icons [!] if element is required or has errors;
          if( 1 == 1)
          {
            //alert("  elemname = " + elemName + "  elemValue = " + elemValue + "  elemID = " + elem.id + " elemdis = " + elemDis);

            //  Sibling relationship of input and img is used to relate them via parent
                        
            // get the parent of input field ( TD )
            var parent = elem.parentElement

            // locate the alert img for that element within the same parent (TD)
            var childLen = parent.childNodes.length;
           //alert("childLen " +childLen);
            if ( childLen &gt; 1)
            {
              // for each child of (TD)
              for(k = 0; k &lt; childLen; k++)
              {
                
                // if this is the alert img 
//                alert("item" + item);
                if( parent.childNodes[k] &amp;&amp; parent.childNodes[k].id &amp;&amp; (parent.childNodes[k].id == item || parent.childNodes[k].id == errorIcon)  )
                            
                {
                 if (parent.childNodes[k].id == item )
                 { 
                 // if elem has no value 
                  if((elemIsRequired==true) &amp;&amp; (!elemValue)  &amp;&amp; (!elemDis) &amp;&amp; (clearAllImages == false))
                  {
//                   alert(elemName + "is Required And is missing" );
                    anyRequiredFieldIsMissing = true;
                    toggleItemVisibility(parent.childNodes[k], 'show');
                  }
                   else
                  {
                   toggleItemVisibility(parent.childNodes[k], 'hide');
                  }

                   }
                  if (parent.childNodes[k].id == errorIcon)
                  {
                  if (elemHasErrors_new)
                  {
                    toggleItemVisibility(parent.childNodes[k], 'show');
                    
                    if (elemHasInvalidNumber == true)
                    {
                      parent.childNodes[k].alt = "Invalid Number";                    
                    }  
                    if (elemHasInvalidDate == true)
                    {
                      parent.childNodes[k].alt = "<i18n:text>Date must be in the format of</i18n:text> " + page_dateFormat_i18n;                    
                    }  
                  }
                  else
                  {
                    toggleItemVisibility(parent.childNodes[k], 'hide');

                  }
                  }

                  //alert(parent.childNodes[k].id);
                }
              }
            }
            // same for TD having only one child
            else
            {
              if( parent.childNodes[0].id == item )
              {
               // if elem has no value 
                if(( elemIsRequired == true) &amp;&amp; (!elemValue)  &amp;&amp; (!elemDis) &amp;&amp; (clearAllImages == false) )
                {
                  anyRequiredFieldIsMissing = true;
                  toggleItemVisibility(parent.childNodes[k], 'show');
                }
                else
                {
                 toggleItemVisibility(parent.childNodes[k], 'hide');
                }
              }
              
              
            }
          }
        }

     //  field required  instruction
      if ( anyFieldIsRequired == true)
      {
         msg = 'denotes_required_field' + currentformName;


         i2uiToggleItemVisibility(msg, 'show');
         i2uiToggleItemVisibility('instruction_area', 'show');

      }
      
      //  field required  error
      if ( anyRequiredFieldIsMissing == true &amp;&amp; clearAllImages == false)
      {
         msg = 'required_field_missing' + currentformName;
         i2uiToggleItemVisibility(msg, 'show');
         i2uiToggleItemVisibility('instruction_area', 'show');
         
         msg = 'error_message' + currentformName;
         i2uiToggleItemVisibility(msg, 'hide');
         msg = 'success_message' + currentformName;
         i2uiToggleItemVisibility(msg, 'hide');
        
      }
      else
      {
         msg = 'required_field_missing' + currentformName;
         i2uiToggleItemVisibility(msg, 'hide');
      }
      
      if(anyRequiredFieldIsMissing == false) 
      {
      // field error
      if ((anyFieldHasErrors || anyFieldHasErrors_new) &amp;&amp; clearAllImages == false)
    
      {           
         msg = 'field_error_message' + currentformName;
         i2uiToggleItemVisibility(msg, 'show');
         i2uiToggleItemVisibility('instruction_area', 'show');
         
      }
      else
      {

        msg = 'field_error_message' + currentformName;
        i2uiToggleItemVisibility(msg, 'hide');
        
      }

      if (clearAllImages == true)
      {
         msg = 'error_message' + currentformName;
         i2uiToggleItemVisibility(msg, 'hide');
         msg = 'success_message' + currentformName;
         i2uiToggleItemVisibility(msg, 'hide');
      }
     }

      }
     // END -  Enable Alert Icon [!] if element is required and is missing;


      return (anyRequiredFieldIsMissing || anyFieldHasErrors_new);
    }
    
    // Overrided from u2uitaglig.js 
    // difference is object is passed insted of string
    function toggleItemVisibility(item,state)
    {
      if (item != null)
      {
        // setting display to none or "" can damage the DOM for
        // Netscape 6.  you may want to consider the visibility 
        // attribute instead.  
        if (state == null)
        {
          if (item.style.display == "none")
          {
            item.style.display = "";
            item.style.visibility = "visible";
          }
          else
          {
            item.style.display = "none";
          }
        }
        else
        {
          if (state == 'show')
          {
            item.style.display = "";
            item.style.visibility = "visible";
          }
          else
          {
            item.style.display = "none";
          }
        }
      }
    }

  </script>

  <script>
  <![CDATA[
      /* 
          This disables a row if one of the field has some value 
          Note that all hidden fields are also disabled.
          Probably assumes check box is first element on the row
      
      */
      function validation_disableCheckBoxIfFieldHasValue(form , checkBoxName, fieldName , fieldValue)
      {
       if (form == null) return true;
        var elemLen = form.elements.length;
        
        for( i = 0; i < elemLen; i++ )
        {
          // process each row
          if(
              form.elements[i].name == checkBoxName 
            )
            {
              var rowDisabled=false;
              // locate the  constraint field
              for( j = i+1; j < elemLen; j++ )
              {
                if (form.elements[j].name == fieldName )
                {
                  
                  if (fieldValue == form.elements[j].value) 
                  {
                      // disabled
                      rowDisabled=true;
                      form.elements[i].disabled = true;
                  }
                  break; // break and go to the next row
                }
               }
                
// START Disable all fields in the row
                if (rowDisabled == true)
                {
                  for( j1 = i+1; j1 < j; j1++ )
                  {
                    if (form.elements[j1].name == fieldName ) break;
                    // disable
                    form.elements[j1].disabled = true;
                  }
                }
// END                
                
               
            } 
          } 
          return true;
      }
      
   
    function isValid_compare_numeric_helper(value1, value2 , op)
    {
      value1 = parseInt(value1.replace(/[,\.]+/g, ""));
      value2 = parseInt(value2.replace(/[,\.]+/g, ""));

      if ( value1 == "" || isNaN(value1) )
      {
      	return false;
      }
        
      //check whether the ship qty is greater than the scheduled qty
      if ( op == ">" && ( parseInt(eval(value1)) > parseInt(eval(value2))) )
      {
      	return true;
      }
      if ( op == "<=" && ( parseInt(eval(value1)) <= parseInt(eval(value2))) )
      {
      	return true;
      }

      if ( op == "<" && ( parseInt(eval(value1)) < parseInt(eval(value2))) )
      {
      	return true;
      }
      if ( op == "==" && (  parseInt(eval(value1)) == parseInt(eval(value2))) )
      {
      	return true;
      }
      return false;
    }

    function isValid_compare_numeric(oForm, field1, field2, op , errorLevel,errorMsg)
      {
        
        if (eval("oForm" + field1 == null) || eval("oForm" + field2 == null) ) return true;
        
        var isValid = true;
        var showIcon = (errorLevel == null || errorLevel != 'soft');
        
      	var num = (String) (eval("oForm." + field1 + ".length"))
      	if ( num > 1 )
      	{
      		for ( i=0; i<num; i++ )
      		{
              value1 = (String) (eval("oForm." + field1 + "[i].value"));
              value2 = (String)( eval("oForm." + field2 + "[i].value"));
              if  (isValid_compare_numeric_helper(value1,value2, op) == false)
              {
                
                if (showIcon == true)
                {

                eval("toggleItemVisibility(oForm." + field1 + "_ERR[i],'show')");
                eval("oForm." + field1 + "_ERR[i].alt = errorMsg");
                }

                 isValid = false;
              }
      		 }
      	}
      	else if ( num == 1 )
      	{
              value1 = (String) (eval("oForm." + field1 + ".value"));
              value2 = (String)( eval("oForm." + field2 + ".value"));
              if  (isValid_compare_numeric_helper(value1,value2, op) == false)
              {
              if (showIcon == true)
                {
                 eval("toggleItemVisibility(oForm." + field1 + "_ERR,'show')");
                eval("oForm." + field1 + "_ERR[i].alt = errorMsg");

                } 
                 isValid = false;
              }
      		
      	}
        if (isValid == false && showIcon == true)
        {
          msg = 'field_error_message' + oForm.name;
          i2uiToggleItemVisibility(msg, 'show');
          i2uiToggleItemVisibility('instruction_area', 'show');
        }
      	return isValid;
      }

      function validation_areWildCardsEntered(oForm, field,  errorMsg)
      {
          str = (String) (eval("oForm." + field + ".value"));
          var m = str.match(/[\*,%]+/g); // regex for e-mail 
          if (m)
          { 
            eval("toggleItemVisibility(oForm." + field + "_REQ,'show')");
            eval("oForm." + field + "_REQ.alt = errorMsg");
            msg = 'field_error_message' + oForm.name;
            i2uiToggleItemVisibility(msg, 'show');
            i2uiToggleItemVisibility('instruction_area', 'show');
            
            return false;
          }
          return true;
      }
      
      
    function isValid_compare_numeric_field_with_value(oForm, field1, value, op , errorLevel, errorMsg)
      {
        
        
        var isValid = true;
        var showIcon = (errorLevel == null || errorLevel != 'soft');
        
      	var num = (String) (eval("oForm." + field1 + ".length"))
      	if ( num > 1 )
      	{
      		for ( i=0; i<num; i++ )
      		{
              value1 = (String) (eval("oForm." + field1 + "[i].value"));
              value2 = value;

              if  (isValid_compare_numeric_helper(value1,value2, op) == false)
              {
                
                if (showIcon == true)
                {

                eval("toggleItemVisibility(oForm." + field1 + "_ERR[i],'show')");
                eval("oForm." + field1 + "_ERR[i].alt = errorMsg");
                }

                 isValid = false;
              }
      		 }
      	}
      	else if ( num == 1 )
      	{
              value1 = (String) (eval("oForm." + field1 + ".value"));
              value2 = value;

              if  (isValid_compare_numeric_helper(value1,value2, op) == false)
              {
              if (showIcon == true)
                {
                 eval("toggleItemVisibility(oForm." + field1 + "_ERR,'show')");
                 eval("oForm." + field1 + "_ERR.alt = errorMsg");

                } 
                 isValid = false;
              }
      		
      	}
        if (isValid == false && showIcon == true)
        {
          msg = 'field_error_message' + oForm.name;
          i2uiToggleItemVisibility(msg, 'show');
          i2uiToggleItemVisibility('instruction_area', 'show');
        }
      	return isValid;
      }

 function validation_AreRowsWithSameFieldSelected(form , checkBoxName, fieldName)
      {
        if (form == null) return true;

        var fieldValue = null;

        var elemLen = form.elements.length;
        
        for( i = 0; i < elemLen; i++ )
        {
          // process each row
          if(
              form.elements[i].name == checkBoxName &&
              form.elements[i].checked == true
            )
            {
              // locate the  constraint field
              for( j = i+1; j < elemLen; j++ )
              {
                if (form.elements[j].name == fieldName )
                {
                  if ( fieldValue == null )
                  {
                    fieldValue =  form.elements[j].value;
                  }  
                  if (fieldValue != form.elements[j].value) 
                  {
                    return false;
                  }
                  break; // break and go to the next row
                }
              }  
            } 
          } 
          return true;
      }

    function isValid_compare_date_helper(date1, date2 , op)
    {
      if ( trimString(date1) == ""  )
      {
      	return true;
      }
      if ( trimString(date2) == ""  )
      {
      	return true;
      }

        
      if ( op == ">" && ( getDateFromFormat(date1,page_dateFormat) > getDateFromFormat(date2,page_dateFormat)) )
      {
      	return true;
      }
      if ( op == "<=" && ( getDateFromFormat(date1,page_dateFormat) <= getDateFromFormat(date2,page_dateFormat)) )
      {
      	return true;
      }

      if ( op == "<" && ( getDateFromFormat(date1,page_dateFormat) < getDateFromFormat(date2,page_dateFormat)) )
      {
      	return true;
      }
      if ( op == "==" && ( getDateFromFormat(date1,page_dateFormat) == getDateFromFormat(date2,page_dateFormat)) )
      {
      	return true;
      }
      return false;
    }

    function isValid_compare_date(oForm, field1, field2, op , errorLevel,errorMsg)
      {
        
        if (eval("oForm" + field1 == null) || eval("oForm" + field2 == null) ) return true;
        
        var isValid = true;
        var showIcon = (errorLevel == null || errorLevel != 'soft');
        
      	var num = (String) (eval("oForm." + field1 + ".length"))
      	if ( num > 1 )
      	{
      		for ( i=0; i<num; i++ )
      		{
              value1 = (String) (eval("oForm." + field1 + "[i].value"));
              value2 = (String)( eval("oForm." + field2 + "[i].value"));
              if  (isValid_compare_date_helper(value1,value2, op) == false)
              {
                
                if (showIcon == true)
                {

                eval("toggleItemVisibility(oForm." + field1 + "_ERR[i],'show')");
                eval("oForm." + field1 + "_ERR[i].alt = errorMsg");
                }

                 isValid = false;
              }
      		 }
      	}
      	else if ( num == 1 || (eval("oForm." + field1) != null))
      	{
              value1 = (String) (eval("oForm." + field1 + ".value"));
              value2 = (String)( eval("oForm." + field2 + ".value"));
              if  (isValid_compare_date_helper(value1,value2, op) == false)
              {
              if (showIcon == true)
                {
                 eval("toggleItemVisibility(oForm." + field1 + "_ERR,'show')");
                eval("oForm." + field1 + "_ERR.alt = errorMsg");

                } 
                 isValid = false;
              }
      		
      	}
        if (isValid == false && showIcon == true)
        {
          msg = 'field_error_message' + oForm.name;
          i2uiToggleItemVisibility(msg, 'show');
          i2uiToggleItemVisibility('instruction_area', 'show');
        }
      	return isValid;
      }
      
 ]]>
    </script>
  
  </xsl:template>
  
  
  
  <!-- Validation Messages -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="display_validation_messages">  
    <xsl:param name="pFormName"/>
    <xsl:param name="pAnyFieldIsRequired" select="'true'"/>
    <xsl:param name="pAnyFieldHasErrors" select="'false'"/>
    <xsl:param name="pAnyFieldHasInformation" select="'false'"/>
    
    <xsl:param name="pInstructionMessage"/>
    <xsl:param name="pSuccessMessage"/>
    <xsl:param name="pErrorMessage"/>
    <xsl:param name="pFieldErrorMessage"/>
    
    
    <table width="100%" border="0"  cellspacing="3" cellpadding="1" class="instructionsArea" id="instruction_area">
      
      <xsl:if test="string-length($pInstructionMessage) > 0">
            <xsl:call-template name="display_form_instruction_message">
              <xsl:with-param name="pFormName" select="$pFormName"/>
              <xsl:with-param name="pMessage" select="$pInstructionMessage"/>
            </xsl:call-template>
      </xsl:if>
      
      <xsl:if test="$pAnyFieldHasInformation = 'true'">
            <xsl:call-template name="display_field_information_message">
              <xsl:with-param name="pFormName" select="$pFormName"/>
            </xsl:call-template>
      </xsl:if>
      
      
      <xsl:if test="$pAnyFieldIsRequired = 'true'">
            <xsl:call-template name="display_field_required_message">
              <xsl:with-param name="pFormName" select="$pFormName"/>
            </xsl:call-template>
      </xsl:if>
      
          <xsl:call-template name="display_field_missing_message">
            <xsl:with-param name="pFormName" select="$pFormName"/>
          </xsl:call-template>
      
            <xsl:call-template name="display_field_error_message">
              <xsl:with-param name="pFormName" select="$pFormName"/>
              <xsl:with-param name="pMessage" select="$pFieldErrorMessage"/>
              <xsl:with-param name="pAnyFieldHasErrors" select="$pAnyFieldHasErrors"/>

            </xsl:call-template>
   
      
      <xsl:if test="string-length($pSuccessMessage) > 0">
            <xsl:call-template name="display_form_success_message">
              <xsl:with-param name="pFormName" select="$pFormName"/>
              <xsl:with-param name="pMessage" select="$pSuccessMessage"/>
            </xsl:call-template>
      </xsl:if>
      
      <xsl:if test="string-length($pErrorMessage) > 0">
            <xsl:call-template name="display_form_error_message">
              <xsl:with-param name="pFormName" select="$pFormName"/>
              <xsl:with-param name="pMessage" select="$pErrorMessage"/>
            </xsl:call-template>
      </xsl:if>
      
    </table>
  </xsl:template>
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="display_field_required_message">  
    <xsl:param name="pFormName"/>
            <tr id="denotes_required_field{$pFormName}">
              <td  align="center">
                 <font color="red">*</font> 
              </td>
              <td width="100%">
                <i18n:text>denotes required field</i18n:text>
              </td>
            </tr>
  </xsl:template>
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="display_field_missing_message">  
    <xsl:param name="pFormName"/>
    <!-- Please fill ... -->
            <tr id="required_field_missing{$pFormName}"  style="display:none">
              <td align="center">
                <i2:img src="/alert_static_small.gif" border="0" align="middle" >
                  <i2:attribute name="alt"><i18n:text>alert</i18n:text></i2:attribute>
                </i2:img>
              </td>
              <td width="100%">
               <i18n:text>Please fill in all required fields before proceeding...</i18n:text>
              </td>
            </tr>
    
  </xsl:template>
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="display_field_error_message">  
    <xsl:param name="pFormName"/>
    <xsl:param name="pMessage"/>
    <xsl:param name="pAnyFieldHasErrors" select="'false'"/>
    
            <tr id="field_error_message{$pFormName}">
              <xsl:choose>
                <xsl:when test="$pAnyFieldHasErrors = 'true'">
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="style">display:none</xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>
                   <td align="center">
                <i2:img src="/alert_static_small.gif" alt="Error" border="0" align="middle"/>
              </td>
              <td width="100%">
                <xsl:choose>
                  <xsl:when test="string-length($pMessage) >0">
                    <i18n:text><xsl:value-of select="$pMessage"/></i18n:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <i18n:text>Information is invalid. Please correct and submit again.</i18n:text>
                  </xsl:otherwise>
                </xsl:choose>                  
              </td>
            </tr>
    
  </xsl:template>
  

  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="display_field_information_message">  
    <xsl:param name="pFormName"/>
            <tr id="field_information_message{$pFormName}">
              <td align="center">
                <i2:img src="/information_sml.gif" border="0">
                  <i2:attribute name="alt"><i18n:text>Information</i18n:text></i2:attribute>
                </i2:img>
              </td>
              <td width="100%">
                <i18n:text>For more details about a control click information icon.</i18n:text>
              </td>
            </tr>
    
  </xsl:template>

  
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="display_form_success_message">  
    <xsl:param name="pFormName"/>
    <xsl:param name="pMessage" select="/RESPONSES/RESPONSE/SUCCESS_MESSAGE/@Value"/>
    
            <tr id="success_message{$pFormName}" >
              <td align="center">
                <i2:img src="/alert_green_static.gif" border="0" align="middle">
                  <i2:attribute name="alt"><i18n:text>Success</i18n:text></i2:attribute>
                </i2:img>
              </td>
              <td width="100%">
                <i18n:text><xsl:value-of select="$pMessage"/></i18n:text>
              </td>
            </tr>
    
  </xsl:template>
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="display_form_instruction_message">  
    <xsl:param name="pFormName"/>
    <xsl:param name="pMessage"/>
    
            <tr  id="instruction_message{$pFormName}" >
              <td colspan="2">
                <i18n:text><xsl:value-of select="$pMessage"/></i18n:text>
              </td>
            </tr>
  </xsl:template>

  <!-- ********************************************************************** 
     *********************************************************************** -->
   <xsl:template name="display_form_error_message">  
    <xsl:param name="pFormName"/>
    <xsl:param name="pMessage" select="/RESPONSES/RESPONSE/ERROR_MESSAGE/@Value"/>

            <tr id="error_message{$pFormName}">
              <td align="center">
                <i2:img src="/alert_static_small.gif" border="0" align="middle">
                  <i2:attribute name="alt"><i18n:text>Error</i18n:text></i2:attribute>
                </i2:img>  
              </td>
              <td width="100%">
                <i18n:text><xsl:value-of select="$pMessage"/></i18n:text>
              </td>
            </tr>
  </xsl:template>


  
  <!-- Field Required  Icon [!]-->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="display_alert_image">  
    <xsl:param name="fieldName"/>
    
    <xsl:variable name="id" select="concat($fieldName, '_REQ')"/>  
    &#xA0;<i2:img src="/alert_static_small.gif" id="{$id}" alt="Required Field" border="0" align="middle" hidden="yes"/>
    
  </xsl:template>

  <xsl:template name="display_required_field_alert">  
    <xsl:param name="fieldName"/>
    
    <xsl:variable name="id" select="concat($fieldName, '_REQ')"/>  
    &#xA0;<i2:img src="/alert_static_small.gif" id="{$id}" alt="Required Field" border="0" align="middle" hidden="yes"/>
    
  </xsl:template>

  
  
  
  <!-- Field Required - Red * [*] -->
  <!-- ********************************************************************** 
     *********************************************************************** -->  
  <xsl:template name="display_alert_mark">  
    <font color="red">*</font>
  </xsl:template>

  <xsl:template name="display_required_field_indicator">  
    <font color="red">*</font>
  </xsl:template>


  <!-- Field Error - Icon {!} -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="display_field_error_alert">  
    <xsl:param name="fieldName"/>
    <xsl:param name="pError"/>

    <xsl:variable name="id" select="concat($fieldName, '_ERR')"/>  
    
      <xsl:variable name="alt">
        <i18n:text><xsl:value-of select="$pError"/></i18n:text>
      </xsl:variable>  
      &#xA0;<i2:img onclick="javascript:core_alert('{$alt}')" id="{$id}" src="/alert_static_small.gif" alt="{$alt}" border="0" align="middle"/>           
  
  </xsl:template>
  
   <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="_ERRORS" mode="icon_tip">
    <xsl:for-each select="_ERROR">
      <xsl:variable name="alt">
        <i18n:text><xsl:value-of select="./@Value"/></i18n:text>
      </xsl:variable>  
      &#xA0;<i2:img onclick="javascript:core_alert('{$alt}')" src="/alert_static_small.gif" alt="{$alt}" border="0" align="middle"/>           
    </xsl:for-each>
  </xsl:template>
  
<!-- ********************************************************************** 
     *********************************************************************** -->     
</xsl:stylesheet>