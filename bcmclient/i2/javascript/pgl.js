/* pgl controls js */


function isV1( )
{
  if( window._pglV2 )
    return false;
  return true;
}
function isV2( )
{
  if( window._pglV2 )
    return true;
  return false;
}

// collapse rows for two tables
function toggleCollapsableRows(tableId, cellId, startRow, numRows)
{
  var shouldContinue = toggleCollapsableRowsSingleTable(tableId + "_syncslave_data", startRow, numRows, cellId );
  
  if( !shouldContinue )
  {
    return;
  }
  
  shouldContinue = toggleCollapsableRowsSingleTable(tableId + "_syncmaster_data", startRow, numRows );
  
  if( !shouldContinue )
  {
    return;
  }
  
  var imgId = tableId + "." + startRow + ".TOGGLE_IMG";  
  var img = document.getElementById( imgId );
  
  if( img != null )
  {
    var src = img.src;
    var lastSlash = src.lastIndexOf( "/" );
    var path = src.substring( 0, lastSlash );
    var imgName = src.substring( lastSlash+1 );
    
    if( imgName.indexOf( "minus" ) != -1 )
    {
      img.src = path + "/plus_norgie.gif";
    }
    else
    {
      img.src = path + "/minus_norgie.gif";
    }
    
  }
  else  
  {
    //alert( "toggle img is null" );
  }
  
  
  onResize();
}

// MAB: collapse a single table
function toggleCollapsableRowsSingleTable(tableId, startRow, numRows, cellId)
{
  var targetTable = document.getElementById( tableId );
  
  if( targetTable == null )
  {
    //alert( "toggleRows targetTable '" + tableId + "' is null" );
    return false;
  }
 
  startRow = startRow+1; // leave this row
  var endRow = startRow+numRows;
  var toggledAny = false;
  var didCollapse = false;

  for( i=startRow; i < endRow; i++ )
  {
    if( i >= targetTable.rows.length )
    {
      break;
    }

    var row = targetTable.rows[i];
    
    if( row.collapseLock != null && row.collapseLock != startRow )
    {
      // for nested collapsable field groups, don't touch rows already collapsed by someone else
      //alert( "lock held by " + row.collapseLock +": exiting" );
      continue;
    }
    
    //alert( "row.collapseLock = " + row.collapseLock );
            
    if (row.style.display == "none") // currently collapsed, do expand
    {
      row.style.display = "";
      row.style.visibility = "visible";      
      row.collapseLock = null; // clear lock      
      didCollapse = false;
    }
    else // currently expanded, do collapse
    {
      row.style.display = "none";
      row.collapseLock = startRow; // set lock      
      didCollapse = true;
    }
    
    toggledAny = true;
  }
  
  if( toggledAny )
  {    
    for( i=0; i < targetTable.rows.length; i++ )
    {
      var row = targetTable.rows[i];
      var firstCell = row.cells[0];
      
      if( i==(targetTable.rows.length-1) && firstCell.innerHTML == '&nbsp;' && row.cells.length == 1 )
      {
        // mab: ie is adding an extra row is showing up -- it's not in the view->source!        
        targetTable.deleteRow(i);
        // note: this will get called every time because ie doesn't really delete the row!
      }
    }
    
    var collapsedLastRow = (targetTable.rows.length == endRow);
    
    if( collapsedLastRow && cellId != null )
    {
      var lastDot = cellId.lastIndexOf( "." );
      
      if( lastDot != -1 )
      {
        var parentCellId = cellId.substring( 0, lastDot );
        var adjSize = didCollapse ? 0 - numRows : numRows;
        fixRowSpanAfterToggleCollapse( parentCellId, adjSize );
      }
    }    
  }
  
  return toggledAny;
}

function fixRowSpanAfterToggleCollapse( cellId, adjSize ) // adjSize can be pos (expand) or neg (collapse)
{
  
  while( cellId != null && cellId.length > 0 )
  {
    var cell = document.getElementById( cellId + "_td" );
    
    if( cell != null )
    {
      cell.rowSpan += adjSize;        
    }

    var lastDot = cellId.lastIndexOf( "." );
    cellId = (lastDot != -1) ? cellId.substring( 0, lastDot ) : null;  
  }
}

// dummy method, will be overriden
function autoCollapseRows()
{
  executeJavascripts();
}

var jsFunctions = new Array();

function registerJavascript(js)
{
  jsFunctions[jsFunctions.length] = js;
}

function executeJavascripts()
{
  for(var i=0; i<jsFunctions.length; i++)
  {
    eval(jsFunctions[i]);
  }
}

function onTab( tabId, containerId )
{
  var alertPrefix = "onTab(): ";
  var form = document.forms['form' ];
  
  if( form != null )
  {
    var selectedStep = containerId + "_SELECTED_STEP";      
    var selectedStepId = containerId + "_STEP_ID";
    
    for( i=0; i < form.elements.length; i++ )
    {
      var input = form.elements[i];
      
      if( input.name == selectedStep )
      {
        input.value = tabId;           
      }
      else if( input.name == selectedStepId )
      {
        input.value = tabId;           
      }
      else if( input.name == 'BUTTON_ID' )
      {
        input.value = 'SYS_TAB';
      }
      else if( input.name == 'START_COUNT' )
      {
        input.value = 0;
      }
      else if( input.name == 'SYS_ID' )
      {      
        if( form.PAGE_SYS_ID != null )
        {
          input.value = form.PAGE_SYS_ID.value;
        }
      }
    }       
        
    form.submit();
  }
  else
  {
    alertPrefix + alert( 'no form!' );
  }
}

// Page Group js
function onLoad()
{
  onLoadSuper();
  scrollHelper();
  autoCollapseRows(); // may be empty (default impl)
}

function onResize()
{
  onResizeSuper();
  scrollHelper();
}

function hideRenderingMessage()
{
  var all = document.all;
  all.busy_box.style.display = 'none';
  all.busy_box_msg.style.display = '';
  all.busy_box_render.style.display = 'none';
}

function setPageVisibility( visibility )
{
  document.all.body_table.style.visibility = visibility;
}

function showBody()
{
  hideRenderingMessage( );
  setPageVisibility( 'visible' );
  onLoad( );
}

//Caching the images for run-time switching
var ui_filter_disabled_image = new Image();
ui_filter_disabled_image.src = "i2/images/clearfield_disabled.gif";

var ui_filter_enabled_image = new Image();
ui_filter_enabled_image.src = "i2/images/clearfield.gif";

//Table Filter Functions
function ui_switch_image(filterObject,imgObject )
{
  if ( filterObject.length > 0 )
  {
    imgObject.src = ui_filter_enabled_image.src;
  }
  else
  {
    imgObject.src = ui_filter_disabled_image.src;
  }
}


function ui_clear( filterObject,imgObject )
{
  filterObject.value="";
  ui_switch_image(filterObject.value,imgObject );
  return;
}

function ui_switch_image_date_range(fromFilterObjectValue, toFilterObjectValue, imgObject )
{
  if ( ( fromFilterObjectValue.length > 0 ) || ( toFilterObjectValue.length > 0 ) )
  {
    imgObject.src = ui_filter_enabled_image.src;
  }
  else
  {
    imgObject.src = ui_filter_disabled_image.src;
  }
}


function ui_clear_date_range( fromFilterObject, toFilterObject, imgObject )
{
  fromFilterObject.value="";
  toFilterObject.value="";
  ui_switch_image_date_range( fromFilterObject.value, toFilterObject.value, imgObject );
  return;
}


//--------------------------------------------------------

    // Validation js - Start::
    var validation_areas = new Array();
    function validation_areas_add(id)
    {
        var i = validation_areas.length;
        validation_areas[i] = new Array();
        validation_areas[i][0] = id;
        validation_areas[i][1] = document.getElementById('instruction_area_'+id);
    }

    function validation_setFocusOnInstructionArea()
      {

        var obj = document.getElementById('instruction_area');
        if (obj != null)
          obj.focus();
        else
        {
           for(var i = 0 ; i< validation_areas.length;i++)
           {
             if (validation_instructionAreaHasErrorMessages(validation_areas[i][0]))
             {
              validation_areas[i][1].focus(); return;
             }
           }
        }
      }
      function getInstructionArea(formName)
      {
          var obj = document.getElementById('instruction_area_'+formName);
          return obj;
      }
      function validation_alert(id)
      {
         validation_instruction_area_show_alert(id);
         onResize();
      }
      function isValid_area(id,pObj)
      {
        var obj = pObj;  if (id != null) obj = document.getElementById(id);
        var isValid  = true;
        isValid =  isValid_area_worker(obj);
        validation_instruction_area_show_alert(id);
        if (isValid == false)
        {
          onResize();
          validation_setFocusOnInstructionArea();
        }
        return isValid;
      }
      function isValid_area_worker(obj)
      {
       // if (obj == null)  return true;
        var isValid = true;

        // if it is an array
        if (typeof(obj.length) == "number")
        {
          for (i = 0; i < obj.length; i++)
          {
            isValid = (isValid_area(null,obj[i]) && isValid);
          }
        }
        // if it is an element
        else if (obj.tagName == "INPUT" || obj.tagName == "TEXTAREA" || obj.tagName == "SELECT")
        {
           isValid = (isValid_field(null,obj) && isValid);
        }
        // if it is any object
        else
        {
          //alert(obj.children.length);
           var i;
           for (i = 0; i < obj.children.length; i++)
           {
            isValid = (isValid_area(null,obj.children[i]) && isValid);
           }
        }

        return isValid;
      }

      function isValid_page()
      {
        var isValidPage = true;
        var j = 0;
        for( j = 0; j < document.forms.length; j++)
        {
          var oForm = document.forms[j];
          isValidPage = (isValid_form(oForm) && isValidPage)
        }

        return isValidPage;
      }

      function isValid_form(oForm)
      {
        var isValidForm = true;
        var i=0;
        for(i = 0; i < oForm.elements.length; i++)
        {

          isValidField =  isValid_field(null,oForm.elements[i]);
          isValidForm = (isValidForm && isValidField);
        }
        validation_instruction_area_show_alert(oForm.name);

        if (isValidForm == false)
        {

          onResize();
          validation_setFocusOnInstructionArea();
        }
        return isValidForm;
     }

      function isValid_field(id,obj)
      {
        if (id != null) obj = document.getElementsByName(id);
        //alert(objectToString(obj));
        //alert(typeof(obj.length));
        var isValid= true;

        // if it is an array
        if (typeof(obj.length) == "number")
        {
          for (i = 0; i < obj.length; i++)
          {
            isValid = (isValid_field_worker(obj[i]) && isValid);
          }
        }
        // if it is an element
        else if (obj.tagName == "INPUT" || obj.tagName == "TEXTAREA" || obj.tagName == "SELECT")
        {
           isValid = (isValid_field_worker(obj) && isValid);
        }
        return isValid;
      }

      function isValid_field_worker(oField)
      {
      if (oField == null) return;
                    //alert(oField);
        var isValidField= true;
        if (oField.disabled) return true;
        if (oField != null && oField.type != null && oField.type == 'hidden') return true;

        var parent = oField.parentElement
        var childLen = parent.childNodes.length;
        var k;

        if ( childLen >= 1)
        {
          for(k = 0; k < childLen; k++)
          {

            fieldValidator =  parent.childNodes[k];
            if (fieldValidator.nodeName == 'SPAN')
            {
              if (isValidField == false)
              {
                validator_clear(fieldValidator);
              }
              else if (isValidField == true)
              {
                isValidField = (validator_validate(fieldValidator,  oField ) && isValidField);
              }
            }
          }
        }
        return isValidField;
      }
      function isValid_field_if_data(oField)
      {
        validation_clearFieldErrors(oField);
        return true;
//      turning off in place validation
//        if (trimString(oField.value) == "") return;
//
//        var  isvalid =    isValid_field(null,oField);
//        if (isvalid == false) onResize();
//        return                          isvalid;
      }

      function validator_validate(oFieldValidator,  oField)
      {
        var before = oFieldValidator.isValid;
        if (oFieldValidator.type == 'required-validator')
        {
          oFieldValidator.isValid = isValid_required_worker(oField);
          return validator_show_alert(oFieldValidator, oField, before);
        }
        else
        if (oFieldValidator.type == 'data-type-validator')
        {
          oFieldValidator.isValid = isValid_data_type_worker(oField);
          return validator_show_alert(oFieldValidator,oField, before);
        }
        else if (oFieldValidator.type == 'valid-range-validator')
        {
          oFieldValidator.isValid = isValid_number_range_worker(oField);
          return validator_show_alert(oFieldValidator,oField, before);
        }
        else if (oFieldValidator.type == 'compare-validator')
        {
          withFieldValue = validator_compare_getWithFieldValue(oFieldValidator,oField);
          oFieldValidator.isValid = isValid_compare_worker(oField.value,withFieldValue,oFieldValidator.operator, oField.fieldtype);

          return validator_show_alert(oFieldValidator,oField, before);
        }
        else if (oFieldValidator.type == 'custom-validator')
               {
                 fn =   oFieldValidator.validationFunction;
                 if (typeof(fn) == "string") {eval("fn = " + fn + ";");}
                 oFieldValidator.isValid = fn(oFieldValidator,oField);
                 return validator_show_alert(oFieldValidator,oField, before);
               }


        return true;
      }

      function validator_compare_getWithFieldValue(oFieldValidator,oField)
      {
        // TODO need a js base mechanism to get fieldValue instead of depending on .oField.row
         oForm = oField.form;
         withField = eval("oForm."+oFieldValidator.withField);
         if (withField.length == null)
         {
           return withField.value;
         }
         else
         {
           return withField[oField.row].value;
         }
      }

      function validator_clear(oFieldValidator)
      {
        toggleItemVisibility(oFieldValidator,'hide');
      }

      function validator_show_alert(oFieldValidator, oField, before)
      {
          if ( oFieldValidator.isValid == true)
          {
            if(typeof before == 'boolean' && before == false)
              validation_removeMessageIfLast(oFieldValidator.shownMsg, oField.containerId);
            toggleItemVisibility(oFieldValidator,'hide');
            return true;
          }

          if (oFieldValidator.severity == 'WARNING')
          {
              btn = core_confirm(oFieldValidator.message);
              if (btn == 'ok')
              {
                return true;
               }
               else return false;
          }
          else
          {

            toggleItemVisibility(oFieldValidator,'show');
            if (oFieldValidator.message != null)
             {
              if (oField.fieldtype == 'Date' && oFieldValidator.type == 'data-type-validator')
              {
               msg  = validaton_getInvalidDateMsg();
               validation_addMessage(oFieldValidator.shownMsg = msg, oField.containerId, before);
              }
              else if (oField.fieldtype == 'DateTime' && oFieldValidator.type == 'data-type-validator')
              {
               msg  = validaton_getInvalidDateTimeMsg();
               validation_addMessage(oFieldValidator.shownMsg = msg, oField.containerId, before);
              }
              else
                validation_addMessage(oFieldValidator.shownMsg = oFieldValidator.message, oField.containerId, before);
            }
            validator_set_message(oFieldValidator, oField);

            validator_notify_instruction_area(oFieldValidator,oField);
            return false;
          }
          return false;
      }

     function validator_set_message(oFieldValidator, oField)
      {

        var imgchild = null;
        var msgchild = null;

        var childLen = oFieldValidator.childNodes.length;
        var k =0;
        for(k = 0; k < childLen; k++)
        {
          var child = null;
          child =  oFieldValidator.childNodes[k];

          if (child.nodeName == 'IMG')
          {
            imgchild = child;
          }
          if (child.nodeName == 'DIV')
          {
            msgchild = child;
          }

        }

        if (oFieldValidator.type == 'compare-validator')
        {
            var    withFieldValue;
            withFieldValue = validator_compare_getWithFieldValue(oFieldValidator,oField);
            // TODO i18n
            imgchild.alt = "should be " + "OPERATOR."+oFieldValidator.operator + " " +  withFieldValue;
            if (msgchild != null) msgchild.innerHTML = imgchild.alt;
        }
        else
         if (oFieldValidator.type == 'custom-validator')
        {
          imgchild.alt = oFieldValidator.message;
           if (msgchild != null) msgchild.innerHTML = '' ;// imgchild.alt;
        }
        else
         if (oFieldValidator.type == 'data-validator')
        {
        }
      }

      function validator_notify_instruction_area(oFieldValidator, oField)
      {
        ia = getInstructionArea(oField.containerId);
        if (ia == null)
        {
          return;
        }
        if (oFieldValidator.type == 'compare-validator')
        {
          //ia.anyFieldHasUIErrors = true;
        }
        else if (oFieldValidator.type == 'custom-validator')
        {
          //ia.anyFieldHasUIErrors = true;
        }

        else
        if (oFieldValidator.type == 'required-validator')
        {
          ia.anyFieldIsMissing = true;
        }
        else
        if (oFieldValidator.type == 'data-type-validator')
        {
          //ia.anyFieldHasUIErrors = true;
        }

        validation_instruction_area_show_alert(oField.containerId);
      }

      function isValid_required(elem)
      {
        return    isValid_required_worker(elem);
      }
      function isEntered(elem)
      {
        return    isValid_required_worker(elem);
      }
      function isNotEntered(elem)
      {
        return    !(isValid_required_worker(elem));
      }

      function isValid_required_worker(elem)
      {
        if (elem.required == false || elem.disabled) return true;
          else return (trimString(elem.value) != "");
      }

      function isValid_data_type_worker(elem)
      {
         elemValue = trimString(elem.value);

        // Numeric Check - Start::
        if ( elem.fieldtype == "Number" || elem.fieldtype == 'Currency' )
  {
    var re = new RegExp(/^[0-9 ,.-]*$/);
    if(elemValue != "" && !elemValue.match(re))
    {
      return false
    }
    else return true;
        }
        // Numeric Check - End.

        // Date Check - Start::
        if( (( elem.fieldtype == "DateRange") || ( elem.fieldtype == "Date"))
           && elemValue != ""
           && page_dateFormat != "")
        {
          if ( isDate(elemValue, page_dateFormat) == false )
          {
            return false;
          }
          return true;
        }
        if( ( elem.fieldtype == "DateTime") && elemValue != "" && page_dateTimeFormat != "")
        {
          if ( isDate(elemValue, page_dateTimeFormat) == false )
          {
            //TODO :: the padded time should be in the current format
            var elemValueWithTime = elemValue + ' 00:00:00';
            if ( isDate(elemValueWithTime, page_dateTimeFormat) == true )
            {
              elem.value = elemValueWithTime;
              return true;
            }
            return false;
          }
          return true;
        }
        // Date Check - End.

        return true;
       }

      function isValid_number_range_worker(numericInput)
      {
        var value = numericInput.value.trim() == "" ? null : numericInput.value;
        var minValue = new Number(numericInput.minValue);
        var maxValue = new Number(numericInput.maxValue);

        var msg = null;
        if (value == null)
        {
        }
        else if (value < minValue)
        {
          fieldValidator = getRangeValidator(numericInput);
          msg = fieldValidator.minMessage;
          fieldValidator.message = msg;
          var validatorImg = getRangeImg(fieldValidator);
          if (validatorImg != null)
          {
            validatorImg.alt = msg;
          }
          return false;
        }
        else if (value > maxValue)
        {
          fieldValidator = getRangeValidator(numericInput);
          msg = fieldValidator.maxMessage;
          var validatorImg = getRangeImg(fieldValidator);
          if (validatorImg != null)
          {
            validatorImg.alt = msg;
          }
          fieldValidator.message = msg;
          return false;
        }
        return true;
     }


      function isValid_compare_worker(value1, value2, op, type)
      {

        if (type == 'Date')
          return isValid_compare_worker_date(value1, value2 , op)
        else if (type == 'Number')
        {
          return isValid_compare_worker_numeric(value1, value2, op)
        }
      }

      function isValid_compare_worker_date(date1, date2 , op)
      {
        if ( trimString(date1) == ""  )
        {
          return true;
        }
        if ( trimString(date2) == ""  )
        {
          return true;
        }

        if ( op == "GREATER" && ( getDateFromFormat(date1,page_dateFormat) > getDateFromFormat(date2,page_dateFormat)) )
        {
          return true;
        }
        if ( op == "GREATER_EQUAL" && ( getDateFromFormat(date1,page_dateFormat) >= getDateFromFormat(date2,page_dateFormat)) )
        {
          return true;
        }

        if ( op == "LESS" && ( getDateFromFormat(date1,page_dateFormat) < getDateFromFormat(date2,page_dateFormat)) )
        {
          return true;
        }
        if ( op == "LESS_EQUAL" && ( getDateFromFormat(date1,page_dateFormat) <= getDateFromFormat(date2,page_dateFormat)) )
        {
          return true;
        }

        if ( op == "EQUAL" && ( getDateFromFormat(date1,page_dateFormat) == getDateFromFormat(date2,page_dateFormat)) )
        {
          return true;
        }
        return false;
      }


      function isValid_compare_worker_numeric(value1, value2 , op)
      {
        value1 = parseInt(value1.replace(/[,\.]+/g, ""));
        value2 = parseInt(value2.replace(/[,\.]+/g, ""));

        if ( value1 == "" || isNaN(value1) )
        {
          return false;
        }

        //check whether the ship qty is greater than the scheduled qty
        if ( op == "GREATER" && ( parseInt(eval(value1)) > parseInt(eval(value2))) )
        {
          return true;
        }
        if ( op == "GREATER_EQUAL" && ( parseInt(eval(value1)) >= parseInt(eval(value2))) )
        {
          return true;
        }

        if ( op == "LESS_EQUAL" && ( parseInt(eval(value1)) <= parseInt(eval(value2))) )
        {
          return true;
        }

        if ( op == "LESS" && ( parseInt(eval(value1)) < parseInt(eval(value2))) )
        {
          return true;
        }
        if ( op == "EQUAL" && (  parseInt(eval(value1)) == parseInt(eval(value2))) )
        {
          return true;
        }
        return false;
      }

     function validation_turnOff(oForm)
     {
        var length = oForm.elements.length;
        for(i = 0; i  < length; i++)
        {
          oForm.elements[i].validate = false;
        }
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

    function validation_instruction_area_show_alert(formName)
    {
        ia = getInstructionArea(formName);
         if (ia == null)
        {
            ia = getInstructionArea('form'); if (ia == null) return;
         }

        var childLen = ia.rows.length;
        if ( childLen >= 1)
        {
          var k = 0;
          for(k = 0; k < childLen; k++)
          {
            oMessage =  ia.rows[k];
            if(oMessage.instructionType == 'required_field_missing')
            {
               if(ia.anyFieldIsMissing == true)
               {
                  toggleItemVisibility(oMessage, 'show');
                  toggleItemVisibility(ia, 'show');

//                  msg = 'error_message' + formName;
  //                i2uiToggleItemVisibility(oMessage, 'hide');
    //              msg = 'success_message' + formName;
      //            i2uiToggleItemVisibility(oMessage, 'hide');
               }
               else
               {
                  toggleItemVisibility(oMessage, 'hide');
               }
            }
            else if (oMessage.instructionType == 'denotes_required_field')
            {
              if ( ia.anyFieldIsRequired == true)
              {
                toggleItemVisibility(oMessage, 'show');
                toggleItemVisibility(ia, 'show');
              }
            }
            else if (oMessage.instructionType == 'field_error_message')
            {
                if ((ia.anyFieldHasUIErrors))
                {
                  toggleItemVisibility(oMessage, 'show');
                  toggleItemVisibility(ia, 'show');
                }
                else
                {
                  toggleItemVisibility(oMessage, 'hide');
                }
            }

          }
        }
      }

    /* Clears all error messages from instruction area*/
    function validation_clearMessages(id)
    {
        ia = getInstructionArea(id);
        if (ia == null) return;

        ia.anyFieldHasUIErrors = false;
        ia.anyFieldIsMissing = false;

        var childLen = ia.rows.length;
        if ( childLen >= 1)
        {
          var k = 0;
          for(k = 0; k < childLen; k++)
          {
            oMessage =  ia.rows[k];
            if(oMessage.instructionType == 'custom_error_message' ||
            oMessage.instructionType == 'field_error_message' ||
            oMessage.instructionType == 'required_field_missing'
            )
            {
              toggleItemVisibility(oMessage, 'hide');
            }
          }
        }
      }

      /* Add  a Custom Error Message to the instruction area */
      function validation_addMessage(msg,id, increment)
      {
          ia = getInstructionArea(id);
          if (ia == null) return;
          if (validation_isMessageShown(msg,id, increment) == true)
          {
            return;
          }
          oTR = ia.insertRow();
          oTR.instructionType='custom_error_message';
          oTD = oTR.insertCell();
          var htm= "<img src=" + omxContextPath + "/i2/images/alert_static_small.gif" + " alt='Error' border='0' align='middle'>";

          oTD.innerHTML =   htm;

          oTD = oTR.insertCell();
          oTD.width="100%"
          oTD.innerHTML = msg
          oTR.errorCount = 1;
        }

        function validation_instructionAreaHasErrorMessages(id)
        {
          ia = getInstructionArea(id);
          if (ia == null) return;
          var childLen = ia.rows.length;
          if ( childLen >= 1)
          {
            var k = 0;
            for(k = 0; k < childLen; k++)
            {
              oMessageRow =  ia.rows[k];
              if (oMessageRow.instructionType == 'custom_error_message' || oMessageRow.instructionType == 'required_field_missing' )
              {
                if (oMessageRow.style.display != 'none')
                {
                  return true;
                }
              }
            }
          }
          return false;
        }

       function validation_isMessageShown(msg, id, increment)
       {
          ia = getInstructionArea(id);
          if (ia == null) return false;

          var childLen = ia.rows.length;
          if ( childLen >= 1)
          {
            var k = 0;
            for(k = 0; k < childLen; k++)
            {
              oMessageRow =  ia.rows[k];
            if (oMessageRow.cells[1] == null) continue;
        if (oMessageRow.cells[1].innerHTML == msg)
    {
      if(increment)
        ++oMessageRow.errorCount;
      toggleItemVisibility(oMessageRow, 'show');
      return true;
    }
            }
          }
          return false;
  }

    function validation_removeMessage(msg, id)
       {
          ia = getInstructionArea(id);
          if (ia == null) return false;

          var childLen = ia.rows.length;
          if ( childLen >= 1)
          {
            var k = 0;
            for(k = 0; k < childLen; k++)
            {
              oMessageRow =  ia.rows[k];

        if (oMessageRow.cells[1].innerHTML == msg)
    {
      --oMessageRow.errorCount;
      toggleItemVisibility(oMessageRow, 'hide');
      return true;
    }
            }
          }
          return false;
  }

    function validation_removeMessageIfLast(msg, id)
       {
          ia = getInstructionArea(id);
          if (ia == null) return false;

          var childLen = ia.rows.length;
          if ( childLen >= 1)
          {
            var k = 0;
            for(k = 0; k < childLen; k++)
            {
              oMessageRow =  ia.rows[k];

        if (oMessageRow.cells[1].innerHTML == msg)
    {
      if(--oMessageRow.errorCount > 0)
        return false;
      toggleItemVisibility(oMessageRow, 'hide');
      return true;
    }
            }
          }
          return false;
  }

    // Field Functions start::
     function validation_noWildCards(validator, field)
     {
        if(validation_areWildCardsEntered(field) == false )
          return true;
        else
        {
          validator.message="Wild Cards are not Allowed.";
          return false;
        }
      }
      function validation_areWildCardsEntered(oField)
      {
        str = (String) (oField.value);
        if (str == null) return false;
        var m = str.match(/[\*,%]+/g); // regex for wildcards
        if (m)
        {
          return true;
        }
        return false;
      }
      // Field Functions End.

     // Selection Validations - Start::
     function validation_AreRowsWithSameFieldSelected(form , checkBoxName, fieldName, operator, severity, message)
     {
      if (form == null) return true;

      isValid = true;
      var fieldValue = null;
      var elemLen = form.elements.length;
      var i = 0;
      for( i = 0; i < elemLen; i++ )
      {
        // process each row
        if(   form.elements[i].name == checkBoxName &&
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
                isValid = false;
              }
              break; // break and go to the next row
            }
          }
        }
      }
      //isValid = true;

      if ( isValid == false && severity == 'STOP')
      {
        core_alert(message); return false;
      }
      else if ( isValid == false && severity == 'WARNING')
      {
        var btn = core_confirm(message);
        if (btn == 'ok') return true; else return false;
      }
      else return true;

    }
    // Selection Validations - End.


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

    function validation_onlyValidData()
    {
      var oField = event.srcElement;
      var oFieldName = oField.name;
      var oFieldLength = parseInt(oFieldName.length) -1;
      var oFieldLastChar = oFieldName.substr(parseInt(oFieldLength),1);
      // Now allowing Negative
      if ( oField.fieldtype == 'Number' )
        validCharacters = /[-0123456789., ]/;
      else if (oField.fieldtype == 'Currency')
        validCharacters  = /[0123456789.,]/;
      else return;
         validation_onlyValidCharacters(validCharacters);
      }

   function validation_onlyValidCharacters(validCharacters)
    {
        var bChanged = false;

        var oField = event.srcElement;
        var sField = oField.value;
        var nStringLen = sField.length;
        var sValidField = "";

        for(var x = 0; x < nStringLen; x++)
        {
          var cChar = sField.charAt(x);
          if(cChar.search(validCharacters) != -1)
          {
            sValidField += cChar;
          }
          else
          {
            bChanged = true;
          }
        }

        if(bChanged)
        {
          oField.value = sValidField;
        }
    }



    function validation_clearFieldErrors(obj)
    {
      var isValid = true;
      
      // if it is an array
      if (typeof(obj.length) == "number")
      {
        for (i = 0; i < obj.length; i++)
        {
          isValid = (validation_clearFieldErrors_worker(obj[i]) && isValid);
        }
      }
      // if it is an element
      else if (obj.tagName == "INPUT" || obj.tagName == "TEXTAREA" || obj.tagName == "SELECT")
      {

         isValid = (validation_clearFieldErrors_worker(obj) && isValid);
      }

      return isValid;
    }

    function validation_clearFieldErrors_worker(oField)
    {
      if (oField == null) return;

      if (oField.disabled) return true;
      if (oField != null && oField.type != null && oField.type == 'hidden') return true;

      var parent = oField.parentElement
      if (parent.nodeName== "SELECT") parent = parent.parentElement;
      var childLen = parent.childNodes.length;
      var k;

      if ( childLen >= 1)
      {
        for(k = 0; k < childLen; k++)
        {
          fieldValidator =  parent.childNodes[k];
          if (fieldValidator.nodeName == 'SPAN' || fieldValidator.nodeName == 'IMG'  )
          {
              validator_clear(fieldValidator);
              //validation_removeMessage(fieldValidator.message, oField.containerId);
          }
        }
      }
      return ;
    }

    function validation_tableHasRows( id)
    {
        var obj = document.getElementById(id+'_data');
        if (obj == null) return false;
        var noOfRows = obj.rows.length;
        if (noOfRows >0 ) return true ;
        else return false;
    }

    function validaton_getInvalidDateMsg()
    {
        return "<i18n:text>Invalid Date or Date Format</i18n:text>";
    }
    function validaton_getInvalidDateTimeMsg()
    {
        return "<i18n:text>Invalid Date Time or Date Time Format</i18n:text>";
    }
    // Validation js - End::

    // Key Tapping - Start::
    browserName = navigator.appName;

    if (browserName == "Netscape")
    {
      document.captureEvents(Event.KEYPRESS);
      document.onkeypress=NetEnterKey;
    }
    else
    {
      if (browserName.indexOf("Explorer") >= 0)
      {
        document.onkeypress=IEEnterKey;
        //document.onkeydown=IEEnterKey;
      }
    }

    function IEEnterKey()
    {
      // if enter key
      if(window.event.keyCode == 13)
      {
        if (window.event.srcElement.onclick != null)
        {
          event.returnValue=true;
        }
        else
        {
          if ( window.event.srcElement.type != "textarea" )
          {
            event.returnValue = onKeyPress(window.event.srcElement)
    //      event.returnValue=false;
          }
        }
      }
      // if backspace
      if (window.event.keyCode==8)
      {
        if (window.event.srcElement.isTextEdit == false)
          event.returnValue=false;
      }
    }

    function NetEnterKey(e)
    {
      key = e.which;
      if(key == 13)
      {
        onKeyPress( e.target )
        return false;
      }
    }

    function onKeyPress( target )
    {
      if (target.disablePageKeyTapping == 'true') return;
      if (target.nodeName == 'INPUT' && target.name == 'pagenum')
      {
        getRecords('jump');
        return false;
      }
      return true;
    }
    // Key Tapping - End::

    // Page.xsl js - Start::
    function initFrameToggleGif(path)
    {
      if(window == null ) return;
      if(window.frameElement == null ) return;
      if(window.frameElement.parentNode == null ) return;

      var frameCol = window.frameElement.parentNode.cols;

      if ( frameCol.charAt(0) == "0")
      {
        if (document.all)
        {
        document.header.toggle.alt = "Show Navigation Frame";
        document.header.toggle.src = omxContextPath + "/i2/images/expand.gif";
        }
      }
      else
      {
        if (document.all)
        {
        document.header.toggle.alt = "Hide Navigation Frame";
        document.header.toggle.src = omxContextPath + "/i2/images/collapse.gif";
        }
      }
    }

    function togglenav(path)
    {
      if(window == null ) return;
      if(window.frameElement == null ) return;
      if(window.frameElement.parentNode == null ) return;

      var frameCol = window.frameElement.parentNode.cols;

      if ( frameCol.charAt(0) == "0")
      {
        if (document.all)
        {
          document.header.toggle.alt = "Hide Navigation Frame";
          document.header.toggle.src = omxContextPath + "/i2/images/collapse.gif";
          window.frameElement.parentNode.cols="170,*";
          tabShow = 0;
          return;
        }
      }
      else
      {
        if (document.all)
        {
          document.header.toggle.alt = "Show Navigation Frame";
          document.header.toggle.src = omxContextPath + "/i2/images/expand.gif";
          window.frameElement.parentNode.cols="0%,100%";
          tabShow = 1;
        }
      }
    }

    // Form Submit
     function submitForm(formName, action, target)
     {
       var formObj = eval('document.' + formName);
       formObj.action = action;
       if (target != null)
       {
         formObj.target = target;
       }
       formObj.submit();
     }

     // Pagination
    function getRecords(actionName, startCount,tableElement)
    {
      var page_form = null;
      var search_form = null;
      if(page_form == null)  page_form = document.form;
      if(search_form == null)  search_form = document.form;
      jumpTo(actionName, startCount, search_form, page_form,tableElement);
    }
    function jumpTo(actionName, startCount, search_form, page_form,tableElement)
    {
      var maxRows = 10;
      if ( tableElement != null && tableElement != "" )
      {
        var maxRowElement = tableElement + "_MAX_ROWS";
        if (page_form[maxRowElement] != null)  maxRows = page_form[maxRowElement].value;
        var recCountElement =  tableElement + "_RECORD_COUNT";
        var recCount = page_form[recCountElement].value;
        var startCountElement = tableElement + "_pagenum";
        var bstartCount= page_form[startCountElement].value;
        var pageStartCountValue = page_form[tableElement + "_START_COUNT"].value;
      }
      else
      {
        if (page_form.MAX_ROWS != null)  maxRows = page_form.MAX_ROWS.value;
        var bstartCount= page_form.pagenum.value;
        var recCount = page_form.RECORD_COUNT.value;
        var pageStartCountValue = page_form.START_COUNT.value;
      }
      var nextCount = parseInt(startCount) + maxRows;
      var prevCount = 0;
      if ( parseInt(startCount) > 0 )
      prevCount = parseInt(startCount) - maxRows;
      if (startCount == null)
        startCount= bstartCount;
      var pagenum= parseInt(startCount);  pagenum--;
      if (actionName == "jump")
      {
        if( (  recCount  == 0 || recCount  > pagenum*maxRows)  &&  (pagenum+1>0) )
        // Commenting this condition because it doesnt work if we click the pagination button
        // quickly twice or more times - eQ :: 533549
        // the START_COUNT value in the form is already set to a different value which
        // makes the subsequent clicks not to work
        // && (pageStartCountValue != pagenum*maxRows) )
        {
          //search_form.reset();
          if ( tableElement == null || tableElement == "" )
          search_form.START_COUNT.value=pagenum*maxRows;
          else
          {
            var sfStartCount = tableElement + "_START_COUNT";
            search_form[sfStartCount].value = pagenum*maxRows;

          }
          search_form.submit();
        }
      }
    }

    function disableButtons()
    {
      var buttons = document.all.tags('TABLE');
      for (var i=0; i < buttons.length; i++)
      {
          if (buttons[i].className == "buttonBorder")
          {
              if (buttons[i].id != "")
              {
                  disableButton(buttons[i].id);
              }
          }
       }
       return;
    }
    function disableButton(id)
    {
      i2uiToggleButtonState( id, 'disabled');
      return;
    }
    function enableButton(id)
    {
      i2uiToggleButtonState( id, 'enabled');
      return;
    }
    function collapseNavArea()
    {
      if( top.i2ui_shell_content == null ) // MAB: on notes popup was getting null for this.
      {
          scrollHelper();
          return false;      
      }
      
      var frameCol = window.frameElement.parentNode.cols;
      if ( frameCol.charAt(0) == "1")
      {
          togglenav('');
          return true;
      }
      else
      {
          scrollHelper();
          return false;
      }
    }

    var resizerequest = null;
    function page_onResize()
    {
      if (resizerequest != null)
          clearTimeout(resizerequest);
      setTimeout("onResize()",100);
    }
    function page_submitAsXML(val)
    {
      if (val == null) val = 'true';
      document.form.SUBMIT_AS_XML.value = val;
    }
    // Page.xsl js - End::

    // Search.xsl js - Start::
    // Searching
      function onSearch()
      {
        validation_clearMessages('search');
        if ( validate_search() == true )
            {
                disableButton('search_button');
                document.form.START_COUNT.value=0;
                try
                {
                  document.form.SORT_ORDER.disabled=true;
                  document.form.SORT_BY.disabled=true;
                } catch(e){}
                document.form.DO_SEARCH.value='Yes';
                document.form.BUTTON_ID.value="search_button";
                document.form.submit();
            }
            else
            {
              validation_alert('search');
            }
      }
      
      function onExportSearch()
      {
        var prevAction = document.form.action;
        
        if ( validate_search() == true )
        {
          document.form.START_COUNT.value = 0;
          document.form.DO_SEARCH.value = 'Yes';
          document.form.NO_OF_ROWS.value = page_maxRowsExportable;
          document.form.MAX_ROWS.value = page_maxRowsExportable;
          document.form.action = omxContextPath + '/SearchDownloadServlet';
          document.form.BUTTON_ID.value = "search_button";
          document.form.submit();
        }

        //reset form action and values
        document.form.action = prevAction;
        document.form.reset();
      }      


      function onSearchSubmitXML()
      {
        validation_clearMessages('search');
        if ( validate_search() == true )
        {
          disableButton('search_button');
          document.form.SUBMIT_AS_XML.value='true';
          document.form.START_COUNT.value=0;
          document.form.DO_SEARCH.value='Yes';
          try
          {
            document.form.SORT_ORDER.disabled=true;
            document.form.SORT_BY.disabled=true;
          } catch(e){}
          document.form.BUTTON_ID.value="search_button";
          document.form.submit();
        }
        else
        {
          validation_alert('search');
        }
      }

      function onChangeSearchResultsBy(action, asXML)
      {
        validation_clearMessages('search');
        var validate = false;
        if (document.form.DO_SEARCH.value == 'Yes')
        validate = true;
        var valid = true;
        if (validate) valid = validate_search();
        if (valid)
        {
          disableButton('search_button');
          document.form.action = action;
          document.form.START_COUNT.value=0;
           document.form.SUBMIT_AS_XML.value=asXML;
           try
           {
             document.form.SORT_ORDER.disabled=true;
             document.form.SORT_BY.disabled=true;
           } catch(e){}
          document.form.submit();
        }
        else
        {
          validation_alert('search');
        }
      }

      // Saving Search
      function onSaveSearch( newsearch )
      {
        if ( validate_search() == true )
            {
                var x = newsearch ? '&NEW_SEARCH=true' : '';                
                disableButton('save_search_button');
                document.form.action=omxContextPath + '/core/search/controller/saveInSession.x2c?RETURN_ADDR=' + document.URL + x;
                document.form.BUTTON_ID.value="save_search_button";
                document.form.submit();
            }
            else
            {
              validation_alert('search');
            }

      }
    // Advanced Search
    function onAdvancedSearch()
    {
      disableButton('more_options_button');
      document.form.VISIBILITY.value='Advanced';
      document.form.submit();
    }

    // Simple Search
    function onSimpleSearch()
    {
    disableButton('fewer_options_button');
        document.form.VISIBILITY.value='Simple';
        document.form.submit();
    }

    function validate_search()
    {
        var bIsFormValid = isValid_search();
        return   bIsFormValid;
    }
    // Search.xsl js - End::

function HTTP( )
{
  this.object = null;

  this.init = function init( )
  {
    if (document.all)
    {
      var prefixes = [ 'MSXML2.XMLHTTP.4.0','MSXML2.XMLHTTP.3.0','MSXML2.XmlHttp','Microsoft.XmlHttp','MSXML.XmlHttp','MSXML3.XmlHttp' ];
      var l = prefixes.length;
      for( var i=0; i < l; ++i) 
      {
        try 
        {
          this.object = new ActiveXObject( prefixes[ i ] );
          return;
        }
        catch (e){};
      }
      alert( 'Sorry, your browser can not handle this request' );
    }
    else
    {
      try 
      {
        this.object = new XMLHttpRequest( );
      } 
      catch (e) 
      {
        alert( 'Sorry, your Netscape browser can not handle this request' );
      }
    }
  }

  this.getPost = function f( gp, url, callback, results, headername, headervalue, postdata )
  {
    if( this.object == null )
      this.init( );
    var object = this.object;
    var http = this;
    try
    {
      if( callback ){
        object.open( gp, url, true );
        object.onreadystatechange = function cb( ){
          if( object.readyState == 4 )
            callback( http );
        };
      }
      else
        object.open( gp, url, false );
      object.setRequestHeader( 'accept-encoding', 'gzip, deflate' );
      if( headername != null && headervalue != null )
        object.setRequestHeader( headername, headervalue );
      object.setRequestHeader( 'pragma', 'no-cache' );
      object.setRequestHeader( 'cache-control', 'no-store, must-revalidate, private' );
      object.setRequestHeader( 'If-Modified-Since', 'Tue, 11 Jul 2000 17:23:51 GMT' );
      var xml = results == 'xml';
      if( xml )
        object.setRequestHeader( 'Content-type', 'text/xml' );
      if( gp == 'POST' ){
        object.setRequestHeader( 'Content-type', 'application/x-www-form-urlencoded' );
        object.send( postdata );
      }
      else
        object.send( null );
      if( callback )
        return;
      if( xml )
        return this.getXML( );
      return this.getText( );
    }
    catch( e ){
      alert( 'Error in get is ' + e.number + ' ' + e.description + ' ' + e.message );
    }
  }

  this.get = function f( url, callback, results, headername, headervalue )
  {
    return this.getPost( 'GET', url, callback, results, headername, headervalue, null );
  }

  this.post = function f( url, callback, results, postdata, headername, headervalue )
  {
    return this.getPost( 'POST', url, callback, results, headername, headervalue, postdata );
  }

  this.getText = function getText( )
  {
    return this.object.responseText;
  }

  this.getXML = function getXML( )
  {
    return this.object.responseXML;
  }

  this.getHeaders = function getHeaders( )
  {
    return this.object.getAllResponseHeaders( );
  }

  this.request = function request( request, service, callback, params, results )
  {
    var s = omxContextPath + '/start.x2ps?REQUEST=' + request;
    if( service )
      s += '&SERVICE_NAME=' + service;
    if( params )
      s += '&' + params;
    return this.get( s, callback, results );
  }

  this.submit = function f( button, params )
  {
    var x = 'BUTTON_ID=' + button + '&SYS_ID=' + document.form.SYS_ID.value + '&PAGE=' + document.form.PAGE.value;
    if( params )
      x += '&' + params;
    return this.post( omxContextPath + '/view.x2ps', null, 'text', x );
  }
}

var _xmlCreator;

function getXMLCreator( )
{
  if( _xmlCreator == null )
    _xmlCreator = new ActiveXObject( 'Microsoft.XMLDOM' );
  return _xmlCreator
}

var _scrollBarSize = 0;

function getScrollBarSize( s )
{
  if( _scrollBarSize > 0 )
    return _scrollBarSize;
  _scrollBarSize = s.offsetHeight - s.clientHeight;
  if( _scrollBarSize > 0 )
    return _scrollBarSize;
  _scrollBarSize= s.offsetWidth - s.clientWidth;
  if( _scrollBarSize > 0 )
    return _scrollBarSize;
  return 16;
}

function alignRowHeights( dataitem, headeritem )
{
  var dataItemRows = dataitem.rows;
  var headerItemRows = headeritem.rows;
  var len = headerItemRows.length;
  var hha = new Array( );
  var dha = new Array( );
  for( var i = 0; i < len; ++i ){
    var hh = headerItemRows[ i ].clientHeight;
    var hd = dataItemRows[ i ].clientHeight;
    var h = Math.max( hh, hd );
    if( h != hh )
      hha[ i ] = h;
    if( h != hd )
      dha[ i ] = h;
  }
  for( i = 0; i < len; ++i ){
    var h = hha[ i ];
    if( h > 0 )
      headerItemRows[ i ].height = h;
    h = dha[ i ];
    if( h > 0 )
      dataItemRows[ i ].height = h;
  }
}

function minimizeColumnWidths( dataitem, headeritem, sboffset )
{
  var dataItemRow0Cells = dataitem.rows[ 0 ].cells;
  var headerItemRows = headeritem.rows;
  var lastheaderrowNbr = headerItemRows.length - 1;
  var lastheaderrow = headerItemRows[ lastheaderrowNbr ];
  var lastHeaderRowCells = lastheaderrow.cells;
  var len = lastHeaderRowCells.length;
  var hws = new Array( );
  var dws = new Array( );
  var resizeRow = lastheaderrow.resizeRow == 'true';
  if( resizeRow ){
    lastheaderrow.style.display = '';
    var c = lastheaderrowNbr;
    while( --c >= 0 ){
      var cells = headerItemRows[ c ].cells;
      var l = cells.length;
      while( --l >= 0 ){
        var t = cells[ l ];
        t.width = '';
        if( t.wrap )
          t.removeAttribute( 'noWrap' );
      }
    }
  }
  dataitem.style.width = 5 * len;
  headeritem.style.width = 5 * len;
  for( i = 0; i < len; ++i )
  {
    var hc = lastHeaderRowCells[ i ];
    hc.width = '';
    var dc = dataItemRow0Cells[ i ];
    dc.width = '';
    if( hc.wrap ){
      hc.removeAttribute( 'noWrap' );
      dc.removeAttribute( 'noWrap' );
    }
  }
  for( i = 0; i < len; ++i )
  {
    var hc = lastHeaderRowCells[ i ];
    w1 = hc.offsetWidth;
    w2 = dataItemRow0Cells[ i ].offsetWidth;
    w3 = Math.max( w1, w2 );

    if( hc.wrap ){
      hws[ i ] = w3;
      dws[ i ] = w3;
    }
    else{
    if( w1 != w3 )
      hws[ i ] = w3;
    if( w2 != w3 )
      dws[ i ] = w3;
  }
  }
  for( i = 0; i < len; ++i )
  {
    var hc = lastHeaderRowCells[ i ];
    var dc = dataItemRow0Cells[ i ];
    if( hc.wrap ){
      hc.noWrap = true;
      dc.noWrap = true;
    }
    var w = hws[ i ];
    if( w > 0 )
      hc.width = w;
    w = dws[ i ];
    if( w > 0 )
      dc.width = w;
  }
  if( headeritem.useWidths == 'true' ){
    for( i = 0; i < len; ++i )
    {
      var w = lastHeaderRowCells[ i ].preferredWidth;
      if( w && w.indexOf( '%' ) > 0 )
        break;
    }
    var usePercentages = i < len;
    if( usePercentages ){
      headeritem.style.width = '';
      if( sboffset > 0 )
        headeritem.style.width = headeritem.offsetWidth - sboffset;
    }
    var p = 0;
    for( i = 0; i < len; ++i )
    {
      var c = lastHeaderRowCells[ i ];
      var w = c.preferredWidth;
      if( w ){
        c.removeAttribute( 'width' );
        c.style.width = w;
        if( !usePercentages || w.indexOf( '%' ) < 0 )
          dataItemRow0Cells[ i ].width = w;
        dws[ p++ ] = i;
      }
    }
    for( i = 0; i < p; ++i )
    {
      var t = dws[ i ];
      var hw = lastHeaderRowCells[ t ].offsetWidth;
      var dc = dataItemRow0Cells[ t ];
      if( dc.offsetWidth > hw )
        dc.width = hw;
    }
    var shrink = false;
    for( i = 0; i < p; ++i )
    {
      var t = dws[ i ];
      var hc = lastHeaderRowCells[ t ];
      var dw = dataItemRow0Cells[ t ].offsetWidth;
      if( hc.offsetWidth < dw ){
        hc.style.width = dw;
        if( hc.offsetWidth > dw )
          shrink = true;
      }
    }
    if( shrink )
      headeritem.style.width = 5 * len;
    for( i = 0; i < len; ++i )
    {
      w1 = dataItemRow0Cells[ i ].offsetWidth;
      w2 = lastHeaderRowCells[ i ].offsetWidth;
      w3 = Math.max( w1, w2 );
      if( c.preferredWidth )
        hws[ i ] = w3;
      else
        hws[ i ] = 0;
      if( w1 != w3 )
        dws[ i ] = w3;
      else
        dws[ i ] = 0;
    }
    headeritem.style.width = headeritem.offsetWidth;
    for( i = 0; i < len; ++i )
    {
      var w = hws[ i ];
      if( w > 0 )
        lastHeaderRowCells[ i ].width = w;
      w = dws[ i ];
      if( w > 0 )
        dataItemRow0Cells[ i ].width = w;
    }
  }
  if( resizeRow ){
    var c = lastheaderrowNbr;
    while( --c >= 0 ){
      var cells = headerItemRows[ c ].cells;
      var l = cells.length;
      while( --l >= 0 ){
        var t = cells[ l ];
        t.width = t.offsetWidth;
        if( t.wrap )
          t.noWrap = true;
      }
    }
    lastheaderrow.style.display = 'none';
  }
}

function stretchColumnWidths( dataitem, headeritem, available )
{
  var dataItemRow0Cells = dataitem.rows[ 0 ].cells;
  var headerItemRows = headeritem.rows;
  var lastheaderrowNbr = headerItemRows.length - 1;
  var lastheaderrow = headerItemRows[ lastheaderrowNbr ];
  var lastHeaderRowCells = lastheaderrow.cells;
  var len = lastHeaderRowCells.length;
  var resizeRow = lastheaderrow.resizeRow == 'true';
  if( resizeRow ){
    lastheaderrow.style.display = '';
    var c = lastheaderrowNbr;
    while( --c >= 0 ){
      var cells = headerItemRows[ c ].cells;
      var l = cells.length;
      while( --l >= 0 ){
        var t = cells[ l ];
        t.width = '';
        if( t.wrap )
          t.removeAttribute( 'noWrap' );
      }
    }
  }
  if( headeritem.useWidths == 'true' ){
    var current = 0;
    var less = 0;
    for( var i = 0; i < len; ++i ){
      var hcell = lastHeaderRowCells[ i ];
      if( hcell.preferredWidth )
        continue;
      current += dataItemRow0Cells[ i ].offsetWidth;
    }
    if( current == 0 )
      return;
    for( i = 0; i < len; ++i ){
      var hcell = lastHeaderRowCells[ i ];
      if( hcell.preferredWidth )
        continue;

      var cell = dataItemRow0Cells[ i ];
      var w2 = cell.offsetWidth;
      var w3 = w2 * available / current;
      var wf = Math.floor( w3 );
      less += w3 - wf;
      if( less >= 1 ){
        ++wf;
        --less;
      }
      var w = w2 + wf;
      cell.width = w;
      hcell.width = w;
    }
  }
  else{
  var current = 0;
  var less = 0;
  for( var i = 0; i < len; ++i )
    current += dataItemRow0Cells[ i ].offsetWidth;
  if( current == 0 )
    return;
  for( i = 0; i < len; ++i ){
    var cell = dataItemRow0Cells[ i ];
    var w2 = cell.offsetWidth;
    var w3 = w2 * available / current;
    var wf = Math.floor( w3 );
    less += w3 - wf;
    if( less >= 1 ){
      ++wf;
      --less;
    }
    var w = w2 + wf;
    cell.width = w;
    lastHeaderRowCells[ i ].width = w;
  }
}
  if( resizeRow ){
    var c = lastheaderrowNbr;
    while( --c >= 0 ){
      var cells = headerItemRows[ c ].cells;
      var l = cells.length;
      while( --l >= 0 ){
        var t = cells[ l ];
        t.width = t.offsetWidth;
        if( t.wrap )
          t.noWrap = true;
      }
    }
    lastheaderrow.style.display = 'none';
  }
}

var _noResizeCount = 0;
var _alltables = null;
var _needResize = false;
var _needMinimize = isV1( );
var _resetHeight = _needMinimize;
var _firstTable;
var _shrinkTable;
useGeneratedScrollHelper = false;

function InvertTable( 
  tbl, syncslave, syncslaveHeader, syncslaveData, syncmaster, syncmasterHeader, syncmasterData, 
  scroller, headerScroller, syncslaveScroller )
{
  alignRowHeights( syncmasterData, syncslaveData );

  this.resetHeight = function( )
  {
    var s = scroller.style;
    s.height = '';
    s.overflowY = 'hidden';
    syncslaveScroller.style.height = '';
    this.hasVerticalScroller = false;
  }

  this.minimizeWidth = function( )
  {
    var s = scroller.style;
    s.width = 20;
    var hs = headerScroller.style;
    hs.width = 20;
  }

  this.reset = function( )
  {
    var s = scroller.style;
    s.width = '';
    headerScroller.style.width = '';
  }

  this.normalWidths = function( )
  {
    var vs = this.hasVerticalScroller ? getScrollBarSize( scroller ) : 0;
    minimizeColumnWidths( syncmasterData, syncmasterHeader, vs );
    if( vs > 0 && scroller.offsetHeight > syncmasterData.offsetHeight ){
      this.resetHeight( );
      minimizeColumnWidths( syncmasterData, syncmasterHeader, 0 );
    }
  }

  this.resizeWidths = function( container, totalAvailWidth )
  {
    var w = container.availableWidth( ) - totalAvailWidth;
    if( w <= 0 ){
      w = scroller.parentNode.clientWidth - syncmasterData.offsetWidth;
      if( this.hasVerticalScroller )
        w -= getScrollBarSize( scroller );
      if( w > 0 )
        stretchColumnWidths( syncmasterData, syncmasterHeader, w - 1 );
      scroller.style.overflowX = 'hidden';
      return false;
    }
    var s = scroller.style;
    var dw = syncmasterData.offsetWidth - w - 1;
    var hw = dw;
    if( this.hasVerticalScroller ){
      var sb = getScrollBarSize( scroller );
      dw += sb;
      syncslaveScroller.style.height = scroller.offsetHeight - sb;
    }
    s.width = dw;
    headerScroller.style.width = hw;
    s.overflowX = 'scroll';
    return true;
  }

  this.shrinkHeight = function( shrink, force )
  {
    var h = scroller.offsetHeight - shrink;
    if( h >= 100 || force && h > 0 ){
      this.hasVerticalScroller = true;
      var s = scroller.style;
      s.height = h;
      s.overflowY = 'scroll';
      syncslaveScroller.style.height = h;
      return true;
    }
    return false;
  }

  this.saveScrollPos = function( )
  {
    this.scrollLeft = scroller.scrollLeft;
    this.scrollTop = scroller.scrollTop;
  }

  this.restoreScrollPos = function( )
  {
    scroller.scrollLeft = this.scrollLeft;
    scroller.scrollTop = this.scrollTop;
  }

  this.saveScrollPos( );
}

function FreezeTable( 
  tbl, syncslave, syncslaveHeader, syncslaveData, syncmaster, syncmasterHeader, syncmasterData, 
  scroller, headerScroller, syncslaveScroller, syncslaveHeaderScroller )
{
  alignRowHeights( syncmasterHeader, syncslaveHeader );
  alignRowHeights( syncmasterData, syncslaveData );

  this.resetHeight = function( )
  {
    var s = scroller.style;
    s.height = '';
    s.overflowY = 'hidden';
    s = syncslaveScroller.style;
    s.height = '';
    s.overflowX = 'hidden';
    this.hasVerticalScroller = false;
  }

  this.minimizeWidth = function( )
  {
    var s = scroller.style;
    s.width = 20;
    var hs = headerScroller.style;
    hs.width = 20;
  }

  this.reset = function( )
  {
    scroller.style.width = '';
    headerScroller.style.width = '';
    syncslaveScroller.style.width = '';
    syncslaveHeaderScroller.style.width = '';
  }

  this.normalWidths = function( )
  {
    var vs = this.hasVerticalScroller ? getScrollBarSize( scroller ) : 0;
    minimizeColumnWidths( syncmasterData, syncmasterHeader, vs );
    minimizeColumnWidths( syncslaveData, syncslaveHeader, vs );
    if( vs > 0 && scroller.offsetHeight > syncmasterData.offsetHeight && syncslaveScroller.offsetHeight > syncslaveData.offsetHeight ){
      this.resetHeight( );
      minimizeColumnWidths( syncmasterData, syncmasterHeader, 0 );
      minimizeColumnWidths( syncslaveData, syncslaveHeader, 0 );
    }
  }

  this.resizeWidths = function( container, totalAvailWidth )
  {
    var w = container.availableWidth( ) - totalAvailWidth;
    if( w <= 0 ){
      w = scroller.parentNode.clientWidth - syncmasterData.offsetWidth;
      if( this.hasVerticalScroller )
        w -= getScrollBarSize( scroller );
      if( w > 0 )
        stretchColumnWidths( syncmasterData, syncmasterHeader, w - 1 );
      scroller.style.overflowX = 'hidden';
      syncslaveScroller.style.overflowX = 'hidden';
      return false;
    }
    var s = scroller.style;
    var dw = syncmasterData.offsetWidth - w - 1;
    var hw = dw;
    if( this.hasVerticalScroller )
      dw += getScrollBarSize( scroller );
    s.width = dw;
    headerScroller.style.width = hw;
    s.overflowX = 'scroll';
    return true;
  }

  this.shrinkHeight = function( shrink, force )
  {
    var h = scroller.offsetHeight - shrink;
    if( h >= 100 || force && h > 0 ){
      this.hasVerticalScroller = true;
      var s = scroller.style;
      s.height = h;
      s.overflowY = 'scroll';
      s = syncslaveScroller.style;
      s.height = h;
      s.overflowX = 'scroll';
      return true;
    }
    return false;
  }

  this.saveScrollPos = function( )
  {
    this.scrollLeft = scroller.scrollLeft;
    this.scrollTop = scroller.scrollTop;
  }

  this.restoreScrollPos = function( )
  {
    scroller.scrollLeft = this.scrollLeft;
    scroller.scrollTop = this.scrollTop;
  }
  
  this.saveScrollPos( );
}

function DraggableTable( 
  tbl, syncslave2, syncslave2Header, syncslave2Data, syncslave, syncslaveHeader, syncslaveData, 
  syncmaster, syncmasterHeader, syncmasterData, scroller, headerScroller, syncslaveScroller, 
  syncslave2Scroller, syncslave2HeaderScroller, draggerImg )
{
  alignRowHeights( syncmasterHeader, syncslaveHeader );
  alignRowHeights( syncmasterHeader, syncslave2Header );
  alignRowHeights( syncslaveHeader, syncslave2Header );
  alignRowHeights( syncmasterData, syncslaveData );
  alignRowHeights( syncmasterData, syncslave2Data );
  alignRowHeights( syncslaveData, syncslave2Data );
  draggerImg.style.cursor = 'move';
  draggerImg.ondragenter = function( ){ draggable.dragEnter( ); };
  draggerImg.ondrag = function( ){ draggable.drag( ); };

  this.resetHeight = function( )
  {
    var s = scroller.style;
    s.height = '';
    s.overflowY = 'hidden';
    syncslaveScroller.style.height = '';
    syncslave2Scroller.style.height = '';
    this.hasVerticalScroller = false;
  }

  this.minimizeWidth = function( )
  {
    var s = scroller.style;
    s.width = 20;
    var hs = headerScroller.style;
    hs.width = 20;
  }

  this.reset = function( )
  {
    scroller.style.width = '';
    headerScroller.style.width = '';
    syncslave2HeaderScroller.style.width = '';
    syncslave2Scroller.style.width = '';
  }

  this.normalWidths = function( )
  {
    var vs = this.hasVerticalScroller ? getScrollBarSize( scroller ) : 0;
    minimizeColumnWidths( syncslave2Data, syncslave2Header, vs );
    minimizeColumnWidths( syncmasterData, syncmasterHeader, vs );
    if( vs > 0 && scroller.offsetHeight > syncmasterData.offsetHeight && syncslave2Scroller.offsetHeight > syncslave2Data.offsetHeight ){
      this.resetHeight( );
      minimizeColumnWidths( syncmasterData, syncmasterHeader, 0 );
      minimizeColumnWidths( syncslaveData, syncslaveHeader, 0 );
    }
  }

  this.resizeWidths = function( container, totalAvailWidth )
  {
    var sw = syncslave2.width;
    if( isNaN( sw ) )
      sw = eval( syncslave2.id + '_width' );
    var s2 = syncslave2Scroller.style;
    s2.width = sw;
    syncslave2HeaderScroller.style.width = sw;
    sw -= syncslave2Data.clientWidth;
    if( sw > 0 )
      stretchColumnWidths( syncslave2Data, syncslave2Header, sw - 1 );
    w = container.availableWidth( ) - totalAvailWidth;
    var s = scroller.style;
    if( w > 0 || sw < 0 ){
      s.overflowX = 'scroll';
      s2.overflowX = 'scroll';
      if( this.hasVerticalScroller )
        syncslaveScroller.style.overflowX = 'scroll';
      else
        syncslaveScroller.style.overflowX = 'hidden';
    }
    else{
      s.overflowX = 'hidden';
      s2.overflowX = 'hidden';
      syncslaveScroller.style.overflowX = 'hidden';
    }
    if( w <= 0 ){
      w = scroller.parentNode.clientWidth - syncmasterData.offsetWidth;
      if( this.hasVerticalScroller )
        w -= getScrollBarSize( scroller );
      if( w > 0 )
        stretchColumnWidths( syncmasterData, syncmasterHeader, w - 1 );
      return false;
    }
    var dw = syncmasterData.offsetWidth - w - 1;
    var hw = dw;
    if( this.hasVerticalScroller )
      dw += getScrollBarSize( scroller );
    s.width = dw;
    headerScroller.style.width = hw;
    return true;
  }

  this.shrinkHeight = function( shrink, force )
  {
    var h = scroller.offsetHeight - shrink;
    if( h >= 80 || force && h > 0 ){ 
      this.hasVerticalScroller = true;
      var s = scroller.style;
      s.height = h;
      s.overflowY = 'scroll';
      syncslave2Scroller.style.height = h;
      s = syncslaveScroller.style;
      s.height = h;
      s.overflowX = 'scroll';
      return true;
    }
    return false;
  }

  this.saveScrollPos = function( )
  {
    this.scrollLeft = scroller.scrollLeft;
    this.scrollTop = scroller.scrollTop;
    this.scrollLeft2 = syncslave2Scroller.scrollLeft;
    this.scrollTop2 = syncslave2Scroller.scrollTop;
  }

  this.restoreScrollPos = function( )
  {
    scroller.scrollLeft = this.scrollLeft;
    scroller.scrollTop = this.scrollTop;
    syncslave2Scroller.scrollLeft = this.scrollLeft2;
    syncslave2Scroller.scrollTop = this.scrollTop2;
  }

  var draggable = this;

  this.drag = function( )
  {
    var pos = event.clientX;
    var w = this.startWidth - this.startPos + pos;
    var aw = tbl.offsetWidth;
    if( w > 30 && w < aw - syncslave.offsetWidth - 30 ){
      syncslave2.width = w;
      this.reset( );
      this.normalWidths( );
      this.resizeWidths( this, aw );
    }
  }

  this.dragEnter = function( )
  {
    this.startPos = event.clientX;
    this.startWidth = syncslave2.offsetWidth;
  }

  this.availableWidth = function( )
  {
    return tbl.offsetWidth;
  }

  this.saveScrollPos( );
}

function Table( tbl, header, data, scroller, headerScroller )
{
  this.resetHeight = function( )
  {
    var s = scroller.style;
    s.height = '';
    s.overflowY = 'hidden';
    this.hasVerticalScroller = false;
  }

  this.minimizeWidth = function( )
  {
    var s = scroller.style;
    s.width = 20;
    var hs = headerScroller.style;
    hs.width = 20;
  }

  this.reset = function( )
  {
    scroller.style.width = '';
    headerScroller.style.width = '';
  }

  this.normalWidths = function( measureTable, totalAvailWidth )
  {
    var vs = this.hasVerticalScroller ? getScrollBarSize( scroller ) : 0;
    minimizeColumnWidths( data, header, vs );
    if( vs > 0 && scroller.offsetHeight > data.offsetHeight ){
      this.resetHeight( );
      minimizeColumnWidths( data, header, 0 );
    }
  }

  this.resizeWidths = function( container, totalAvailWidth )
  {
    var w = container.availableWidth( ) - totalAvailWidth;
    if( w <= 0 ){
      w = scroller.parentNode.clientWidth - data.offsetWidth;
      if( this.hasVerticalScroller )
        w -= getScrollBarSize( scroller );
      if( w > 0 )
        stretchColumnWidths( data, header, w - 1 );
      scroller.style.overflowX = 'hidden';
      return false;
    }
    var s = scroller.style;
    var dw = data.offsetWidth - w - 1;
    var hw = dw;
    if( this.hasVerticalScroller )
      dw += getScrollBarSize( scroller );
    s.width = dw;
    headerScroller.style.width = hw;
    s.overflowX = 'scroll';
    return true;
  }

  this.shrinkHeight = function( shrink, force )
  {
    var h = scroller.offsetHeight - shrink;
    if( h >= 80 || force && h > 0 ){
      this.hasVerticalScroller = true;
      var s = scroller.style;
      s.height = h;
      s.overflowY = 'scroll';
      return true;
    }
    return false;
  }

  this.saveScrollPos = function( )
  {
    this.scrollLeft = scroller.scrollLeft;
    this.scrollTop = scroller.scrollTop;
  }

  this.restoreScrollPos = function( )
  {
    scroller.scrollLeft = this.scrollLeft;
    scroller.scrollTop = this.scrollTop;
  }

  this.saveScrollPos( );
}

function Tabset( tbl )
{
  this.resetHeight = function( )
  {
  }

  this.minimizeWidth = function( )
  {
  }

  this.reset = function( )
  {
  }

  this.normalWidths = function( )
  {
  }

  this.resizeWidths = function( container, totalAvailWidth )
  {
    resizeTabsetScroller( tbl, container.scrollWidth( ) );
  }

  this.shrinkHeight = function( shrink, force )
  {
    return false;
  }

  this.availableWidth = function( )
  {
  }

  this.saveScrollPos = function( )
  {
  }

  this.restoreScrollPos = function( )
  {
  }
}

function Container( tbl, scroller, parent )
{
  this.tables = new Array( );

  this.clear = function( )
  {
    if( scroller )
      scroller.removeAttribute( 'containerIndex' );
  }

  this.resetHeight = function( )
  {
    if( scroller ){
      var s = scroller.style;
      s.height = '';
      s.overflowY = 'hidden';
    }
    this.hasVerticalScroller = false;
  }

  this.minimizeWidth = function( )
  {
    if( scroller ){
      var s = scroller.style;
      s.width = 20;
    }
  }

  this.reset = function( )
  {
    if( scroller )
      scroller.style.width = '';
  }

  this.normalWidths = function( )
  {
  }

  this.resizeWidths = function( container, totalAvailWidth )
  {
    if( scroller ){
      var s = scroller.style;
      var w = container.availableWidth( ) - totalAvailWidth;
      if( w > 0 ){
        if( this.hasVerticalScroller )
          w -= getScrollBarSize( scroller );
        s.width = scroller.scrollWidth - w;
        s.overflowX = 'scroll';
      }
      else
        s.overflowX = 'hidden';
    }
  }

  this.shrinkHeight = function( shrink, force )
  {
   var h = scroller.offsetHeight - shrink;
    if( h >= 300 || force && h > 0 ){
      var s = scroller.style;
      s.height = h;
      s.overflowY = 'scroll';
      this.hasVerticalScroller = true;
      return true;
    }
    return false;
  }

  this.availableWidth = function( )
  {
    if( this.hasVerticalScroller )
      return parent.clientWidth - getScrollBarSize( scroller );
    return parent.clientWidth;
  }

  this.add = function( t )
  {
    var x = this.tables;
    x[ x.length ] = t;
    t.container = this;
  }

  this.saveScrollPos = function( )
  {
    if( scroller ){
      this.scrollLeft = scroller.scrollLeft;
      this.scrollTop = scroller.scrollTop;
    }
  }

  this.restoreScrollPos = function( )
  {
    if( scroller ){
      scroller.scrollLeft = this.scrollLeft;
      scroller.scrollTop = this.scrollTop;
    }
  }

  this.scrollWidth = function( )
  {
    if( scroller )
      return scroller.scrollWidth;
    return -1;
  }

  this.saveScrollPos( );
}

function addToContainer( tbl, t, containers )
{
  var p = tbl.parentNode;
  while( p ){
    var i = p.containerIndex;
    if( i >= 0 ){
      containers[ i ].add( t );
      return;
    }
    p = p.parentNode;
  }
  containers[ 0 ].add( t );
}

function resizeContainer( container, aw )
{
  var tables = container.tables;
  var l = tables.length;
  for( var j = 0; j < l; ++j ){
    var t = tables[ j ];
    t.reset( );
    t.normalWidths( );
    t.resizeWidths( container, aw );
  }
  for( var j = 0; j < l; ++j ){
    var c = tables[ j ];
    if( c.tables )
      resizeContainer( c, c.availableWidth( ) );
  }
}

function shrinkHeight( container, shrink, force )
{
  var tables = container.tables;
  var l = tables.length;
  var j = l;
  while( --j >= 0 ){
    var c = tables[ j ];
    if( c.tables && shrinkHeight( c, shrink, false ) )
      return true;
  }
  while( --l >= 0 ){
    var t = tables[ l ];
    if( t.shrinkHeight( shrink, force ) ){
      if( document.body.clientHeight < _firstTable.offsetHeight )
        t.resetHeight( );
      else{
        _shrinkTable = t;
        return true;
      }
    }
  }
}

function getTableChild( tbl, r, c, tag )
{
  var rows = tbl.rows;
  if( rows.length <= r )
    return null;
  var cells = rows[ r ].cells;
  if( cells.length <= c )
    return null;
  var children = cells[ c ].children;
  var l = children.length;
  for( var i = 0; i < l; ++i ){
    var child = children[ i ];
    var t = child.tagName;
    if( t == tag )
      return child;
    if( t != '!' )
      return null;
  }
  return null;
}

function getScrollerData( s )
{
  return s.children[ 0 ];
}

function scrollHelper( )
{
  if( _noResizeCount > 0 ){
    _needResize = true;
    return;
  }
  _needResize = false;
  if( _alltables == null ){
    var tables = document.getElementsByTagName( "TABLE" );
    var noOfTables = tables.length;

    var firstTable = isV2( ) ? 1 : 0;
    _alltables = new Array( );
    _alltables[ 0 ] = new Container( null, null, _firstTable = tables[ firstTable ] );
    var ignoreTo = null;
    for( var j = firstTable; j < noOfTables; j++ )
    {
      var tbl = tables[ j ];
      if( ignoreTo ){
        if( ignoreTo == tbl )
          ignoreTo = null;
        continue;
      }
      if( !isTableVisible( tbl ) )
        continue;
      if( tbl.id == 'tabs_container' ){
        var t = new Tabset( tbl );
        _alltables[ _alltables.length ] = t;
        addToContainer( tbl, t, _alltables );
      }
      if( tbl.className == 'shadow' ){
        var scroller = getTableChild( tbl, 1, 0, 'DIV' );
        if( scroller ){
          var i = _alltables.length;
          scroller.containerIndex = i;
          var t = new Container( tbl, scroller, scroller.parentNode );
          _alltables[ i ] = t;
          addToContainer( tbl, t, _alltables );
        }
        continue;
      }
      var tbl0 = getTableChild( tbl, 0, 0, 'TABLE' );
      if( tbl0 == null ){
        var headerScroller = getTableChild( tbl, 0, 0, 'DIV' );
        if( headerScroller == null )
          continue;
        var masterScroller = getTableChild( tbl, 1, 0, 'DIV' );
        if( masterScroller == null )
          continue;

        var header = getScrollerData( headerScroller );
        var data = getScrollerData( masterScroller );
        var t = new Table( tbl, header, data, masterScroller, headerScroller );
        _alltables[ _alltables.length ] = t;
        addToContainer( tbl, t, _alltables );
        ignoreTo = data;
        continue;
      }
      if( tbl.id == 'tabs_container' ){
        var scroller = getTableChild( tbl0, 1, 0, 'DIV' );
        if( scroller == null )
          continue;
        var id = scroller.id;
        if( id == 'tabs_container_description_scroller' || id == 'tabs_container_scroller' ){
          var i = _alltables.length;
          scroller.containerIndex = i;
          var t = new Container( tbl, scroller, scroller.parentNode );
          _alltables[ i ] = t;
          addToContainer( tbl, t, _alltables );
        }
      }

      var tbl2 = getTableChild( tbl, 0, 2, 'TABLE' );
      if( tbl2 == null ){
        var syncslave = tbl0;
        var slaveHeaderScroller = getTableChild( syncslave, 0, 0, 'DIV' );
        if( slaveHeaderScroller == null ){
          var syncslaveHeader = getTableChild( syncslave, 0, 0, 'TABLE' );
          if( syncslaveHeader == null ){
            var syncmaster = getTableChild( tbl, 0, 1, 'TABLE' );
            if( syncmaster == null )
              continue;
            var sid = syncslave.id;
            var mid = syncmaster.id;
            var si = sid.indexOf( '_syncslave' );
            var mi = mid.indexOf( '_syncmaster' );
            if( isV2( ) && si > 0 && mi > 0 && si == sid.length - 10 && mi == mid.length - 11 )
              alignRowHeights( syncmaster, syncslave );
            continue;
          }
          var syncslaveScroller = getTableChild( syncslave, 1, 0, 'DIV' );
          if( syncslaveScroller == null )
            continue;
          var syncslaveData = getScrollerData( syncslaveScroller );

          var syncmaster = getTableChild( tbl, 0, 1, 'TABLE' );
          if( syncmaster == null )
            continue;

          var headerScroller = getTableChild( syncmaster, 0, 0, 'DIV' );
          if( headerScroller == null )
            continue;
          var masterScroller = getTableChild( syncmaster, 1, 0, 'DIV' );
          if( masterScroller == null )
            continue;

          var syncmasterHeader = getScrollerData( headerScroller );
          var syncmasterData = getScrollerData( masterScroller );
          var t = new InvertTable(
              tbl, syncslave, syncslaveHeader, syncslaveData, syncmaster, syncmasterHeader, syncmasterData, 
              masterScroller, headerScroller, syncslaveScroller );
          _alltables[ _alltables.length ] = t;
          addToContainer( tbl, t, _alltables );
          ignoreTo = syncmasterData;
          continue;
        }
        var slaveScroller = getTableChild( syncslave, 1, 0, 'DIV' );
        if( slaveScroller == null )
          continue;
        var syncmaster = getTableChild( tbl, 0, 1, 'TABLE' );
        if( syncmaster == null )
          continue;

        var headerScroller = getTableChild( syncmaster, 0, 0, 'DIV' );
        if( headerScroller == null )
          continue;
        var masterScroller = getTableChild( syncmaster, 1, 0, 'DIV' );
        if( masterScroller == null )
          continue;

        var masterScroller = getTableChild( syncmaster, 1, 0, 'DIV' );
        if( masterScroller == null )
          continue;

        var syncslaveHeader = getScrollerData( slaveHeaderScroller );
        var syncslaveData = getScrollerData( slaveScroller );
        var syncmasterHeader = getScrollerData( headerScroller );
        var syncmasterData = getScrollerData( masterScroller );
        t = new FreezeTable(
          tbl, syncslave, syncslaveHeader, syncslaveData, syncmaster, syncmasterHeader, syncmasterData, 
          masterScroller, headerScroller, slaveScroller, slaveHeaderScroller );
        _alltables[ _alltables.length ] = t;
        addToContainer( tbl, t, _alltables );
        ignoreTo = syncmasterData;
        continue;
      }
      var syncslave2 = tbl0;
      var slave2HeaderScroller = getTableChild( syncslave2, 0, 0, 'DIV' );
      if( slave2HeaderScroller == null )
        continue;
      var slave2Scroller = getTableChild( syncslave2, 1, 0, 'DIV' );
      if( slave2Scroller == null )
        continue;
      var syncslave = getTableChild( tbl, 0, 1, 'TABLE' );
      if( syncslave == null )
        continue;

      var syncslaveHeader = getTableChild( syncslave, 0, 0, 'TABLE' );
      if( syncslaveHeader == null )
        continue;
      var slaveScroller = getTableChild( syncslave, 1, 0, 'DIV' );
      if( slaveScroller == null )
        continue;

      var syncmaster = tbl2;
      var headerScroller = getTableChild( syncmaster, 0, 0, 'DIV' );
      if( headerScroller == null )
        continue;
      var masterScroller = getTableChild( syncmaster, 1, 0, 'DIV' );
      if( masterScroller == null )
        continue;

      var draggerImg = getTableChild( syncslaveHeader, 0, 0, 'IMG' );
      if( draggerImg == null )
        continue;

      var syncslave2Header = getScrollerData( slave2HeaderScroller );
      var syncslave2Data = getScrollerData( slave2Scroller );
      var syncslaveData = getScrollerData( slaveScroller );
      var syncmasterHeader = getScrollerData( headerScroller );
      var syncmasterData = getScrollerData( masterScroller );

      var t = new DraggableTable( 
        tbl, syncslave2, syncslave2Header, syncslave2Data, syncslave, syncslaveHeader, syncslaveData, syncmaster, syncmasterHeader, syncmasterData, 
        masterScroller, headerScroller, slaveScroller, slave2Scroller, slave2HeaderScroller, draggerImg );
      _alltables[ _alltables.length ] = t;
      addToContainer( tbl, t, _alltables );
      ignoreTo = syncmasterData;
    }
  }
  else{
    var l = _alltables.length;
    while( --l >= 0 )
      _alltables[ l ].saveScrollPos( );
  }
  var noOfTables = _alltables.length;
  for( var j = 0; j < noOfTables; ++j ){
    var c = _alltables[ j ].clear;
    if( c )
      c( );
  }
  if( _resetHeight ){
    for( var j = 0; j < noOfTables; ++j )
      _alltables[ j ].resetHeight( );
    _resetHeight = false;
  }
  if( _shrinkTable ){
    _shrinkTable.resetHeight( );
    _shrinkTable = null;
  }
  if( _needMinimize ){
    for( var j = 0; j < noOfTables; ++j )
      _alltables[ j ].minimizeWidth( );
  }
  var shrink = _firstTable.offsetHeight - document.body.clientHeight;
  if( shrink > 0 )
    shrinkHeight( _alltables[ 0 ], shrink, true );
  resizeContainer( _alltables[ 0 ], document.body.clientWidth );
  shrink = _firstTable.offsetHeight - document.body.clientHeight;
  if( shrink > 0 ){
    if( _shrinkTable ){
      _shrinkTable.resetHeight( );
      shrink = _firstTable.offsetHeight - document.body.clientHeight;
      if( shrink > 0 )
        _shrinkTable.shrinkHeight( shrink, true );
    }
    else
      shrinkHeight( _alltables[ 0 ], shrink, true );
  }
  for( var j = 0; j < noOfTables; ++j )
    _alltables[ j ].restoreScrollPos( );
  _needMinimize = true;
}

function alignTableColumns( sourceId, targetId, reverse )
{
  var sd = document.getElementById( sourceId + '_syncmaster_data' );
  if( sd ){
    if( sd.offsetWidth > 0 ){
      var th = document.getElementById( targetId + '_syncmaster_header' );
      var td = document.getElementById( targetId + '_syncmaster_data' );
      var sc = sd.rows[ 0 ].cells;
      var hc = th.rows[ 0 ].cells;
      var dc = td.rows[ 0 ].cells;
      var l = sc.length;
      if( reverse ){
        var sh = document.getElementById( sourceId + '_syncmaster_header' ).rows[ 0 ].cells;
        for( var i = 0; i < l; ++i ){
          var w = sc[ i ].offsetWidth;
          var rw = dc[ i ].offsetWidth;
          if( rw > w )
            w = rw;
          hc[ i ].style.width = w;
          dc[ i ].style.width = w;
          sh[ i ].style.width = w;
          sc[ i ].style.width = w;
        }
      }
      else{
        for( var i = 0; i < l; ++i ){
          var w = sc[ i ].offsetWidth;
          hc[ i ].style.width = w;
          dc[ i ].style.width = w;
        }
      }
    }
  }
  else{
    sd = document.getElementById( sourceId + '_syncmaster' );
    if( sd.offsetWidth > 0 ){
      var td = document.getElementById( targetId + '_syncmaster' );
      var sc = sd.rows[ 0 ].cells;
      var dc = td.rows[ 0 ].cells;
      var l = sc.length;
      for( var i = 0; i < l; ++i ){
        var w = sc[ i ].offsetWidth;
        if( reverse ){
          var rw = dc[ i ].offsetWidth;
          if( rw > w )
            w = rw;
          sc[ i ].style.width = w;
        }
        dc[ i ].style.width = w;
      }
    }
  }
}

function disableResize( )
{
  ++_noResizeCount;
}

function enableResize( )
{
  if( --_noResizeCount == 0 && _needResize )
    scrollHelper( );
}

function isTableVisible( tbl )
{
  if( tbl.style.display == 'none' )
    return false;
  return true;
}

function openerWindow( )
{
  if( opener )
    return opener;
  if( typeof( dialogArguments ) == 'undefined' )
    return window;
  return dialogArguments;
}

function getTabUrl( tab )
{
  var x = document.getElementById( 'PAGE_NAME' ).value + '.' + tab;
  var p = parent;
  if( p == window )
    return openerWindow( )[ 'opener_' + x ];
  return p[ 'parent_' + x ];
}

function switchWorkflowTab( tab, workflow, service, params )
{
  var url = getTabUrl( tab );
  var p = new Object( );
  if( params )
    url += '&' + params;
  var i = url.indexOf( '?' );
  if( i < 0 )
    i = url.indexOf( '&' );
  var u;
  if( i > 0 ){
    u = url.substring( 0, i++ );
    for(;;){
      var a = url.indexOf( '=', i );
      var n = url.indexOf( '&', i );
      if( n < 0 ){
        if( a < 0 )
          p[ url.substring( i ) ] = '';
        else
          p[ url.substring( i, a ) ] = url.substring( a + 1 );
        break;
      }
      if( a < 0 || n < a )
        p[ url.substring( i, n ) ] = '';
      else if( a < n )
        p[ url.substring( i, a ) ] = url.substring( a + 1, n );
      i = n + 1;
    }
  }
  else
    u = url;
  if( workflow )
    p[ 'START_WORKFLOW' ] = workflow;
  if( service )
    p[ 'SERVICE_NAME' ] = service;
  url = u;
  var first = true;
  for( var x in p ){
    url += first ? '?' : '&';
    first = false;
    var t = p[ x ];
    url += x;
    if( t.length > 0 )
      url += '=' + t;
  }
  var lpm = disablePageLeaveMessage( );
  getAction( url );
  if( lpm )
    enablePageLeaveMessage( );
}

function saveTabUrl( tab, url )
{
  var x = document.getElementById( 'PAGE_NAME' ).value + '.' + tab;
  var p = parent;
  if( p == window )
    openerWindow( )[ 'opener_' + x ] = url;
  else
    p[ 'parent_' + x ] = url;
}

function getInvertTableInputIndex( t )
{
  var td = t.parentNode;
  return td.cellIndex;
}

function setStyle( t, n, s )
{
  if( n ){
    var l;
    if( typeof( n ) == 'object' && ( l = n.length ) >= 0 ){
      t = t.style;
      for( var i = 0; i < l; ++i )
        t[ n[ i ] ] = s[ i ];
    }
    else if( s )
      t.style[ n ] = s;
    else
      t.style.removeAttribute( n );
  }
  else
    t.removeAttribute( 'style' );
}

var _pageActivity = 0;
var _pageTimeout = 1000000000;
var _lastActivity = new Date( );

function pageActivity( )
{
  ++_pageActivity;
}

function showDialog( url, width, height, resizeable )
{
  var resize = resizeable ? ';resizable:yes' : '';
  return showModalDialog( url, window, 'dialogWidth:' + width + 'px;dialogheight:' + height + 'px;status:no;unadorned:yes;help:no' + resize );
}

function closeDialog( value )
{
  returnValue = value;
  window.close( );
  return false;
}

function showTimeoutMessage( )
{
  var rc = showDialog( omxContextPath + '/core/alert/controller/display.x2c?MESSAGE=SESSION_TIMEOUT_MESSAGE&TYPE=warning&CLOSE_TIMEOUT=60000', 350, 150 );
  if( rc == 'timeout' ){
    disablePageLeaveMessage( );
    submitAction( 'Log Out', omxContextPath + '/core/login/controller/logout.x2c?FROM=timeout' );
  }
  else
    pageActivity( );
}

function timeoutCallback( )
{
  var d = new Date( );
  if( _pageActivity ){
    _pageActivity = 0;
    _lastActivity = d;
  }
  else if( _lastActivity.getTime( ) < d.getTime( ) - _pageTimeout * 1000 + 90000 )
    showTimeoutMessage( );
  setTimeout( timeoutCallback, 5000 );
}

function getPageTimeoutCallback( http )
{
  var xml = http.getXML( );
  if( isErrorResponse( xml ) )
    return;
  _pageTimeout = getValueAttribute( getChild( "SESSION_TIMEOUT", xml.firstChild ) );
}

function getPageTimeout( )
{
  var http = new HTTP( );
  var r = http.request( "getSessionTimeout", "HTTP_SESSION", getPageTimeoutCallback );
}

function enablePageTimeout( )
{
  var tables = document.getElementsByTagName( "TABLE" );
  var tbl = null;
  var l = tables.length;
  for( var i = 1; i < l; ++i ){
    tbl = tables[ i ];
    if( isOuterContainer( tbl ) )
      break;
  }
  tbl.onmousemove = pageActivity;
  tbl.onkeydown = pageActivity;
  getPageTimeout( );
  setTimeout( timeoutCallback, 5000 );
}

var _showPageLeaveMessage = true;

function setLeavePageMessage( msg, conditionFunc )
{
  document.body.onbeforeunload = function onUnload( ){ 
    if( _showPageLeaveMessage && conditionFunc( ) ){
      event.returnValue = msg;
      if( i2uiCurrentTab )
        i2uiToggleTab( i2uiCurrentTabset, '', i2uiCurrentTab );
    }
    else
      event.cancelBubble = true;
  }
}

function enablePageLeaveMessage( )
{
  _showPageLeaveMessage = true;
}

function disablePageLeaveMessage( )
{
  var r = _showPageLeaveMessage;
  _showPageLeaveMessage = false;
  return r;
}

function setButtonAttributeById( id, attribute, value )
{
  var btn = document.getElementById( id );
  btn[ attribute ] = value;
}

function submitAction( button, action, sysId )
{
  disableButtons( );
  var f = document.form;
  if( action == null )
    action = 'view.x2ps';
  var old;
  var sid = f.SYS_ID;
  if( sysId ){
    old = sid.value;
    sid.value = sysId;
  }
  f.BUTTON_ID.value = button;
  f.action = action;
  f.submit( );
  if( sysId )
    sid.value = old;
  return false;
}

function getAction( action )
{
  disableButtons( );
  var l = window.location;
  l.href = action;
}

function int( v )
{
  return parseInt( v );
}

function double( v )
{
  return parseFloat( v );
}

function ceiling( v )
{
  return Math.ceil( toDouble( v ) );
}

function floor( v )
{
  return Math.floor( toDouble( v ) );
}

function toDouble( v )
{
  var t = typeof( v );
  if( t == 'number' )
    return v;
  if( t != 'string' )
    v = '' + v;
  return parseFloat( v.replace( /[,]+/g, '' ) );
}

function minDouble( x, y )
{
  x = toDouble( x );
  y = toDouble( y );
  if( x > y )
    return y;
  return x;
}

function maxDouble( x, y )
{
  x = toDouble( x );
  y = toDouble( y );
  if( x > y )
    return x;
  return y;
}

function modFunction( x, y )
{
  return toDouble( x ) % toDouble( y );
}

function DecimalFormat( s )
{
  if( s == null || s == '' )
    s = page_numberFormat;
  var d = s.indexOf( '.' ) + 1;
  var l = s.length;
  if( d > 0 ){
    var x = d;
    while( x < l && s.charAt( x ) == '0' )
      ++x;
    this.minDecimals = x - d;
    x = l - d;
    this.maxDecimals = x;
    var a = '0.';
    while( --x >= 0 )
      a += '0';
    a += '5';
    this.roundAdd = parseFloat( a );
    l = d - 1;
  }
  else{
    this.roundAdd = 0.5;
    this.minDecimals = 0;
    this.maxDecimals = 0;
  }
  var x = l;
  var g = -1;
  var t = 0;
  var f = true;
  while( --x >= 0 ){
    var c = s.charAt( x );
    if( c == ',' ){
      if( g < 0 )
        g = l - x - 1;
    }
    else if( c == '0' ){
      if( f )
        ++t;
    }
    else if( c == '#' )
      f = false;
    else
      break;
  }
  if( x > 0 )
    this.prefix = s.substring( 0, x );
  this.minTens = t;
  this.grouping = g;
  this.groupingChar = ','; // how to get this right?

  this.format = function format( s )
  {
    var v = toDouble( s );
    if( isNaN( v ) )
      return formatNaN( v );
    if( !isFinite( v ) )
      return formatInfinity( v );
    if( v < 0 )
      v -= this.roundAdd;
    else
      v += this.roundAdd;
    s = '' + v;
    var i = s.indexOf( '.' );
    if( i < 0 )
      i = s.length;
    else{
      var l = i + this.maxDecimals;
      var e = i + this.minDecimals;
      while( l > e && s.charAt( l ) == '0' )
        --l;
      if( l == i )
        s = s.substring( 0, l );
      else
        s = s.substring( 0, l + 1 );
    }
    var g = this.grouping;
    if( g >= i || v < 0 && g + 1 >= 0 )
      return s;
    var gc = this.groupingChar;
    var t = g;
    while( --i > 0 ){
      if( --g == 0 )
        s = s.substring( 0, i ) + gc + s.substring( i );
    }
    return s;
  }
}

function formatNaN( v )
{
  return 'NaN';
}

function formatInfinity( v )
{
  return v > 0 ? 'Infinity' : '-Infinity';
}

function formatNumber( n, f )
{
  var fs = '_fs' + f;
  var formatter = this[ fs ];
  if( formatter == null ){
    formatter = new DecimalFormat( f );
    this[ fs ] = formatter;
  }
  return formatter.format( n );
}

function strlen( v )
{
  if( v == null )
    return 0;
  if( typeof( v ) == 'string' )
    return v.length;
  v = '' + v;
  return v.length;
}

function stringToDate( date )
{
  var i = date.indexOf( ' ' );
  if( i > 0 )
    date = date.substring( 0, i );
  return getDateFromFormat( date + ' 00:00:00', 'M/d/yyyy HH:mm:ss' )
}

function incrDateByDays( date, days )
{
  var d = stringToDate( date ) + days * 24 * 60 * 60 * 1000 + 2 * 60 * 60 * 1000;
  return formatDate( _formatDate( new Date( d ), 'xs:date' ), 'MM/dd/yyyy' );
}

function dateCompare( x, y )
{
  x = stringToDate( x );
  y = stringToDate( y );
  if( x > y )
    return 1;
  else if( y > x )
    return -1;
  return 0;
}

function isEmptyValue( s )
{
  return s == null || typeof( s ) == 'string' && s == '' || s == '&nbsp;' || typeof( s ) == 'number' && isNaN( s );
}

function addValueRange( array, name, from, to, postfix )
{
  if( postfix )
    name += postfix;
  var f = eval( 'get_' + name + '_WithIndex' );
  var sum = 0;
  while( from < to ){
    sum += toDouble( f( from ) );
    ++from;
  }
  return sum;
}

function averageValue( array, name, from, to, count, postfix )
{
  if( postfix )
    name += postfix;
  var f = eval( 'get_' + name + '_WithIndex' );
  var c = 0;
  var sum = 0;
  while( from < to && count > 0 ){
    var v = f( from );
    if( !isNaN( v ) ){
      sum += toDouble( v );
      ++c;
    }
    ++from;
    --count;
  }
  if( c > 0 )
    return sum / c;
  return 'x' - 0;
}

function isValidValue( )
{
  var l = arguments.length;
  var v = arguments[ 0 ];
  for( var i = 1; i < l; ++i )
    if( arguments[ i ] == v )
      return true;
  return false;
}

function getFirstChild( xml )
{
  return xml.firstChild;
}

function getChild( name, xml )
{
  var children = xml.childNodes;
  var l = children.length;
  for( var i = 0; i < l; ++i ){
    var c = children[ i ];
    if( c.nodeName == name )
      return c;
  }
  return null;
}

function getValueAttribute( xml )
{
  var a = xml.attributes;
  var l = a.length;
  while( --l >= 0 ){
    var x = a[ l ];
    if( x.name == 'Value' )
      return x.value;
  }
  return null;
}

function getAttribute( name, xml )
{
  var a = xml.attributes;
  if( a ){
    var l = a.length;
    while( --l >= 0 ){
      var x = a[ l ];
      if( x.name == name )
        return x.value;
    }
  }
  return null;
}

function isErrorResponse( xml )
{
  var c = xml.firstChild;
  return c == null || getAttribute( 'Status', c ) == 'Error';
}

function addChangeHighlight( name, index )
{
  var remove;
  if( index >= 0 ){
    var s = eval( 'set_' + name + '_StyleWithIndex' );
    s( index, 'backgroundColor', 'orange' );
    remove = 'removeChangeHighlight( \'' + name + '\', ' + index + ' )';
  }
  else{
    var s = eval( 'set_' + name + '_Style' );
    s( 'backgroundColor', 'orange' );
    remove = 'removeChangeHighlight( \'' + name + '\' )';
  }
  setTimeout( remove, 15000 );
}

function removeChangeHighlight( name, index )
{
  if( index >= 0 ){
    var s = eval( 'set_' + name + '_StyleWithIndex' );
    s( index, 'backgroundColor', null );
  }
  else{
    var s = eval( 'set_' + name + '_Style' );
    s( 'backgroundColor', null );
  }
}

function updateNewValues( xml, postfixCallback, highlight )
{
  xml = xml.firstChild;
  var children = xml.childNodes;
  var l = children.length;
  var i = 0;
  var postfix = '';
  var changed = false;
  while( i < l ){
    var child = children[ i++ ];
    var name = child.nodeName;
    var value = getValueAttribute( child );
    if( name == 'UPDATE_NBR' ){
      var set = eval( 'set_UPDATE_NBR' + postfix );
      set( value );
    }
    else if( name == 'UPDATE_ID' ){
      if( postfixCallback )
        postfix = postfixCallback( value );
    }
    else if( name == 'UPDATE_ARRAY' ){
      var data = child.childNodes;
      var dl = data.length;
      for( var j = 0; j < dl; ++j ){
        var values = data[ j ].childNodes;
        var vl = values.length;
        for( var x = 0; x < vl; ++x ){
          child = values[ x ];
          name = child.nodeName;
          value = getValueAttribute( child );
          var get = eval( 'get_' + name + postfix + '_WithIndex' );
          var set = eval( 'set_' + name + postfix + '_WithIndex' );
          var old = get( j );
          set( j, value );
          if( highlight && old != get( j ) ){
            addChangeHighlight( name + postfix, j );
            changed = true;
          }
        }
      }
    }
    else{
      var get = eval( 'get_' + name + postfix );
      var set = eval( 'set_' + name + postfix );
      var old = get( );
      set( value );
      if( highlight && old != get( ) ){
        addChangeHighlight( name + postfix );
        changed = true;
      }
    }
  }
  return changed;
}

function hideTableColumn( tbl, i )
{
  tbl.children[ 0 ].children[ i ].style.display = 'none';
}

function showTableColumn( tbl, i )
{
  tbl.children[ 0 ].children[ i ].style.display = '';
}

var _configuredTableId;
var _configuredTableConfigurationId;
var _configuredTablePostfixed;
var _configuredTablePostfixFlag = new function f( ) { };

function getConfiguredTableId( )
{
  return _configuredTableId;
}

function getConfiguredTableConfigurationId( )
{
  return _configuredTableConfigurationId;
}

function getConfiguredTableConfiguration( )
{
  return eval( 'tableConfiguration_' + _configuredTableId + '( )' );
}

function isConfiguredTablePostfixed( )
{
  return _configuredTablePostfixed;
}

function setConfiguredTablePostfixed( tableId, flag )
{
  _configuredTablePostfixFlag[ tableId ] = flag;
}

var _configureTableButtonIds = new Object( );

function setConfigureTableButtonId( tableId, buttonId )
{
  _configureTableButtonIds[ tableId ] = buttonId;
}

function ui_configureTableV2( tableId, buttonId )
{
  if( buttonId == null )
    buttonId = _configureTableButtonIds[ tableId ];
  if( buttonId == null )
    buttonId = 'SYS_RELOAD';
  _configuredTableId = tableId;
  _configuredTableConfigurationId = eval( 'tableConfigurationId_' + tableId + '( )' );
  _configuredTablePostfixed = _configuredTablePostfixFlag[ tableId ] == true;
  var d = new Date( );
  var x = showDialog( omxContextPath + '/start.x2ps?SERVICE_NAME=BPE_UI&POPUP=true&START_WORKFLOW=ConfigureTable&DUMMY=' + d.getTime( ), 750, 400 );
  var sid = document.form.SYS_ID;
  if( x == 'submit' ) 
  {
    if( sid != null )
      setTimeout( function (){ submitAction( buttonId ); }, 1 );
    else
      history.go(0);
  }
}

function getInvertTableHeaderWidthById( tableId )
{
  var tbl = document.getElementById( tableId + '_syncslave' );
  return tbl.offsetWidth;
}

function setInvertTableHeaderWidthById( tableId, width )
{
  var tbl = document.getElementById( tableId + '_syncslave' );
  tbl.style.width = width;
}

function getInvertTableDataWidthById( tableId )
{
  var tbl = document.getElementById( tableId + '_syncmaster' );
  return tbl.offsetWidth;
}

function setInvertTableDataWidthById( tableId, width )
{
  var tbl = document.getElementById( tableId + '_syncmaster' );
  tbl.style.width = width;
}

function setInvertScroller( id, func )
{
  var s = getInvertScroller( id );
  s.onscroll = func;
}

function getInvertScroller( id )
{
  if( false && isV2( ) )
    return document.getElementById( id + '_div' );
  return document.getElementById( id + '_syncmaster_scroller' );
}

function getScrollerTableId( scroller )
{
  var id = scroller.id;
  return id.substring( 0, id.length - 20 );
}

function invertScroll( scroller, left, top )
{
  if( top >= 0 )
    scroller.scrollTop = top;
  else
    top = scroller.scrollTop;
  if( left >= 0 )
    scroller.scrollLeft = left;
  else
    left = scroller.scrollLeft;
  if( false && isV2( ) )
    return;
  var id = getScrollerTableId( scroller );
  var x = document.getElementById( id + '_syncmaster_header_scroller' );
  x.scrollTop = top;
  x.scrollLeft = left;
  x = document.getElementById( id + '_syncslave_scroller' );
  x.scrollTop = top;
}

function invertScrollById( id )
{
  invertScroll( getInvertScroller( id ) );
}

function getScrollerLeft( scroller )
{
  return scroller.scrollLeft;
}

function getScrollerTop( scroller )
{
  return scroller.scrollTop;
}

function getContentToggler( tableId )
{
  if( isV2( ) )
    return document.getElementById( tableId ).rows[ 0 ].cells[ 0 ].children[ 0 ];
  return document.getElementById( tableId ).rows[ 0 ].cells[ 0 ].children[ 0 ].rows[ 0 ].cells[ 0 ].children[ 0 ];
}

function setCollapseTogglerByTableId( tableId, func )
{
  var img = getContentToggler( tableId );
  img.onclick = func;
}

function setCollapseToggler( obj, func )
{
  obj.onclick = func;
}

function isCollapsed( tbl )
{
  return tbl.rows[ 1 ].parentNode.style.display == 'none';
}

function toggleContent( obj )
{
  i2uiToggleContent( obj, 2 );
  var t = getContentTogglerTable( obj );
  return isCollapsed( t );
}

function getContentTogglerTable( obj )
{
  return obj.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
}

var _toggleCollapsableRowsCallback = true;

function toggleCollapsableRowsCallback( tableId, imgPostfix )
{
}

function toggleCollapsableRowsV2( img )
{
  var td = img.parentNode;
  var skip = td.skip;
  var rc = td.collapseRowCount;
  var tr = td.parentNode;
  var src;
  var hidden = td.children[ 0 ];
  var change;
  var state = tr.collapsed;

  if( state == 'true' ){
    tr.collapsed = 'false';
    hidden.value = 'false';
    src = 'minus_norgie.gif';
    change = 1;
  }
  else{
    tr.collapsed = 'true';
    hidden.value = 'true';
    src = 'plus_norgie.gif';
    change = -1;
  }

  var s = img.src;
  var i = s.lastIndexOf( '/' );
  if( i < 0 )
    img.src = src;
  else
    img.src = s.substring( 0, i + 1 ) + src;
  var tbl = tr.parentNode.parentNode;
  var mtbl = null;
  var rows = tbl.rows;
  var id = tbl.id;
  var i = id.indexOf( '_syncslave_data' );
  var mrows = null;
  var drows = null;

  if( i > 0 ){
    id = id.substring( 0, i );
    mtbl = document.getElementById( id + '_syncmaster_data' );
    mrows = mtbl.rows;
  }
  else{
    i = id.indexOf( '_syncslave' );
    if( i > 0 ){
      id = id.substring( 0, i );
      mrows = document.getElementById( id + '_syncmaster' ).rows;
    }
    else
    {
      //added for freeze table
      i = id.indexOf( '_data' );
      if( i > 0 ){
        id = id.substring( 0, i );
        dragTableId = id.substring( 0, i-1 );
        if ( document.getElementById( dragTableId + '_data' ) != null )
        {
          drows = document.getElementById( dragTableId + '_data' ).rows;
        }
        if ( document.getElementById( id + '_freeze_syncmaster_data' ) != null )
        {
          mrows = document.getElementById( id + '_freeze_syncmaster_data' ).rows;
        }
      }
    }
  }
  
  var trIndex = tr.rowIndex;
  if (skip > 1)
  {
    trIndex += skip - 1;
  }

  while( --rc >= 0 ){
    var r = rows[ ++trIndex ];
    var l = r.lvl -= change;
    var display = l > 0 ? 'none' : '';
    r.style.display = display;
    if( mrows )
      mrows[ trIndex ].style.display = display;
    if( drows )
      drows[ trIndex ].style.display = display;
  }
  if( _toggleCollapsableRowsCallback ){
    _toggleCollapsableRowsCallback = false;
    toggleCollapsableRowsCallback( id, img.id.substring( id.length ) );
    _toggleCollapsableRowsCallback = true;
  }
  if( mtbl )
    alignRowHeights( mtbl, tbl );
  onResize( );
}

function toggleCollapsableRowsByImgId( id )
{
  toggleCollapsableRowsV2( document.getElementById( id ) );
}

function toggleCollapsableRowsByImgName( name )
{
  var treeCellImgs = document.getElementsByName( name );
  for (k = 0; k < treeCellImgs.length; k++)
  {
    toggleCollapsableRowsV2(treeCellImgs[k]);
  }
}

function getDropdownById( id )
{
  return document.getElementById( id );
}

function dropdownEmptyOption( )
{
  return new Option( '                                                       ', 0 );
}

function dropdownFixWidth( dd )
{
  var x = dd.options;
  x[ x.length ] = dropdownEmptyOption( );
  setTimeout( function f( ){ dropdownDeleteEmpty( dd ) }, 0 );
}

function dropdownDeleteEmpty( dd )
{
  var e = dropdownEmptyOption( );
  var x = dd.options;
  var l = x.length;
  while( --l >= 0 ){
    if( x[ l ].value == e.value )
      x[ l ] = null;
  }
}

function dropdownAddOption( dd, id, text )
{
  var x = dd.options;
  var y = new Option( text, id );
  x[ x.length ] = y;
  return y;
}

function dropdownCopyAll( from, to, attr, condf )
{
  var fl = from.length;
  var tl = to.length;
  if( condf ){
    var fl = from.length;
    var tl = to.length;
    var l = 0;
    for( var i = 0; i < fl; ++i ){
      var f = from[ i ];
      if( condf( f ) ){
        var o = new Option( f.text, f.value );
        copyOptionAttributes( o, f, attr );
        to[ tl ] = o;
        to[ tl++ ].selected = true;
        from[ i ] = null;
        --i;
        --fl;
      }
    }
  }
  else{
    for( var i = 0; i < fl; ++i ){
      var f = from[ i ];
      var o = new Option( f.text, f.value );
      copyOptionAttributes( o, f, attr );
      to[ tl ] = o
      to[ tl++ ].selected = true;
    }
    from.length = 0;
  }
}

function dropdownCopySelected( from, to )
{
  from = from.options;
  to = to.options;
  var fl = from.length;
  var tl = to.length;
  for( var i = 0; i < fl; ++i ){
    var f = from[ i ];
    if( f.selected ){
      to[ tl ] = new Option( f.text, f.value );
      to[ tl++ ].selected = true;
    }
  }
  dropdownDeleteSelected( from );
}

function dropdownCopySelectedBlocks( from, to, attr, condf )
{
  from = from.options;
  to = to.options;
  var fl = from.length;
  var tl = to.length;
  var copy = false;
  for( var i = 0; i < fl; ++i ){
    var f = from[ i ];
    if( condf( f ) ){
      if( f.selected ){
        var o = new Option( f.text, f.value );
        copyOptionAttributes( o, f, attr );
        to[ tl ] = o;
        to[ tl++ ].selected = true;
        copy = true;
      }
      else
        copy = false;
    }
    else if( copy ){
      var o = new Option( f.text, f.value );
      copyOptionAttributes( o, f, attr );
      to[ tl++ ] = o;
    }
  }
  dropdownDeleteSelectedBlocks( from, condf );
}

function dropdownDeleteSelected( dd )
{
  var x = dd.options;
  var l = x.length;
  while( --l >= 0 )
    if( x[ l ].selected )
      x[ l ] = null;
}

function dropdownDeleteSelectedBlocks( dd, condf )
{
  var x = dd.options;
  var l = x.length;
  var i = 0;
  var remove = false;
  while( i < l ){
    var o = x[ i ];
    if( condf( o ) ){
      if( x[ i ].selected ){
        x[ i ] = null;
        remove = true;
        --l;
      }
      else{
        remove = false;
        ++i;
      }
    }
    else if( remove ){
      x[ i ] = null;
      --l;
    }
    else
      ++i;
  }
}

function dropdownClearAll( dd )
{
  var x = dd.options;
  var l = x.length;
  while( --l >= 0 )
    x[ l ].selected = false;
}

function dropdownAnySelected( dd, condf )
{
  var x = dd.options;
  var l = x.length;
  while( --l >= 0 ){
    var o = x[ l ];
    if( o.selected && ( condf == null || condf( o ) ) )
      return true;
  }
  return false;
}

function copyOptionStyle( to, from )
{
  var fs = from.style;
  var ts = to.style;
  var t = fs.color;
  if( t )
    ts.color = t
  t = from.backgroundColor;
  if( t )
    ts.backgroundColor = t;
}

function copyOptionAttributes( to, from, attr )
{
  if( attr ){
    if( typeof( attr ) == 'object' ){
      var c = attr.length;
      while( --c >= 0 ){
        var z = attr[ c ];
        to[ z ] = from[ z ];
      }
    }
    else 
      to[ attr ] = from[ attr ];
  }
}

function dropdownMoveUp( dd, attr, condf )
{
  var v = dd.options;
  var l = v.length;
  var e = 0;
  var t = null;
  for( var i = 0; i <= l; ++i ){
    var x = i < l ? v[ i ] : null;
    if( x && x.selected && ( condf == null || condf( x ) ) ){
      var p = i - 1;
      var o = new Option( x.text, x.value );
      o.selected = true;
      copyOptionStyle( o, x );
      copyOptionAttributes( o, x, attr );
      v[ p ] = o;
    }
    else{
      if( t && e < i ){
        var o = new Option( t.text, t.value );
        copyOptionStyle( o, t );
        copyOptionAttributes( o, t, attr );
        v[ i - 1 ] = o;
      }
      t = x;
      e = i + 1;
    }
  }
}

function dropdownMoveDown( dd, attr, condf )
{
  var v = dd.options;
  var l = v.length;
  var e = 0;
  var t = null;
  while( l-- >= 0 ){
    var x = l < 0 ? null : v[ l ];
    if( x && x.selected && ( condf == null || condf( x ) ) ){
      var p = l + 1;
      var o = new Option( x.text, x.value );
      copyOptionStyle( o, x );
      copyOptionAttributes( o, x, attr );
      o.selected = true;
      v[ p ] = o;
    }
    else{
      if( t && e > l ){
        var o = new Option( t.text, t.value );
        copyOptionStyle( o, t );
        copyOptionAttributes( o, t, attr );
        v[ l + 1 ] = o;
      }
      t = x;
      e = l - 1;
    }
  }
}

function dropdownMoveUpBlocks( dd, attr, condf )
{
  var v = dd.options;
  var l = v.length;
  var array = new Array( );
  var from = 0;
  var to = 0;
  var upto = 0;
  var move = false;
  for( var i = 0; i < l; ++i ){
    var x = v[ i ];
    var bl = condf( x );
    if( bl <= 0 ){
      if( bl == 0 && x.selected ){
        array[ to++ ] = x;
        move = true;
      }
      else{
        while( from < upto )
          array[ to++ ] = v[ from++ ];
        if( move )
          from = i;
        move = false;
        upto = i + 1;
      }
    }
    else if( move )
      array[ to++ ] = x;
    else
      ++upto;
  }
  while( from < l )
    array[ to++ ] = v[ from++ ];
  for( var i = 0; i < l; ++i ){
    var t = array[ i ];
    var o = new Option( t.text, t.value );
    copyOptionStyle( o, t );
    copyOptionAttributes( o, t, attr );
    if( t.selected )
      o.selected = true;
    v[ i ] = o;
  }
}

function dropdownMoveDownBlocks( dd, attr, condf )
{
  var v = dd.options;
  var l = v.length;
  var array = new Array( );
  var from = 0;
  var to = 0;
  var upto = 0;
  var move = true;
  for( var i = 0; i < l; ++i ){
    var x = v[ i ];
    var bl = condf( x );
    if( bl <= 0 ){
      if( bl == 0 && x.selected ){
        move = false;
        upto = i + 1;
      }
      else{
        if( move ){
          while( from < upto )
            array[ to++ ] = v[ from++ ];
          ++from;
        }
        array[ to++ ] = x;
        move = true;
      }
    }
    else if( move ){
      if( from >= upto )
        ++from;
      array[ to++ ] = x;
    }
    else
      ++upto;
  }
  while( from < l )
    array[ to++ ] = v[ from++ ];
  for( var i = 0; i < l; ++i ){
    var t = array[ i ];
    var o = new Option( t.text, t.value );
    copyOptionStyle( o, t );
    copyOptionAttributes( o, t, attr );
    if( t.selected )
      o.selected = true;
    v[ i ] = o;
  }
}

function dropdownSelectAll( dd )
{
  var x = dd.options;
  var l = x.length;
  while( --l >= 0 )
    x[ l ].selected = true;
}

function dropdownGetPostData( dd, all )
{
  var s = null;
  var id = dd.name;
  var x = dd.options;
  var l = x.length;
  for( var i = 0; i < l; ++i ){
    var t = x[ i ];
    if( all || t.selected ){
      t = id + '=' + t.value;
      if( s )
        s += '&' + t;
      else
        s = t;
    }
  }
  return s;
}

function toggleOnClickButtonImg( buttonImg, state, active, inactive )
{
  if( buttonImg.disabled ){
    if( state == 'disabled' )
      return;
    buttonImg.removeAttribute( 'disabled' );
    buttonImg.style.cursor = 'hand';
    var td = buttonImg.parentNode.parentNode;
    td.className = 'buttonText';
    td.id = 'buttonRegular';
    td.parentNode.parentNode.parentNode.className = 'buttonBorder';
    if( active )
      buttonImg.src = buttonImg.src.replace(/[/][^/]*$/, '/' + active );
  }
  else{
    if( state == 'enabled' )
      return;
    buttonImg.disabled = true;
    buttonImg.style.cursor = '';
    var td = buttonImg.parentNode.parentNode;
    td.className = 'buttonTextDisabled';
    td.id = 'buttonDisabled';
    td.parentNode.parentNode.parentNode.className = 'buttonBorderDisabled';
    if( inactive )
      buttonImg.src = buttonImg.src.replace(/[/][^/]*$/, '/' + inactive );
  }
}

var _callStepScrollCallback = true;

function stepScrollCallback( tableId, current, count, length, step )
{
}
 
function stepScrollButtonStates( tableId, current, count, length )
{
  var state = current > 0 ? 'enabled' : 'disabled';
  toggleOnClickButtonImg( document.getElementById( tableId + '_STEP_FIRST' ), state, 'page_to_beginning.gif', 'page_to_beginning_inact.gif' );
  toggleOnClickButtonImg( document.getElementById( tableId + '_STEP_PREV' ), state, 'previous_active.gif', 'previous_inactive.gif' );
  state = current < length - count ? 'enabled' : 'disabled';
  toggleOnClickButtonImg( document.getElementById( tableId + '_STEP_NEXT' ), state, 'next_active.gif', 'next_inactive.gif' );
  toggleOnClickButtonImg( document.getElementById( tableId + '_STEP_LAST' ), state, 'page_to_end.gif', 'page_to_end_inact.gif' );
}

function stepScrollFirst( tableId )
{
  var start = document.getElementById( tableId + '_STEP_START' );
  var count = document.getElementById( tableId + '_STEP_COUNT' );
  var tbl = document.getElementById( tableId + '_syncmaster' );
  var s = start.value;
  var c = parseInt( count.value );
  var l = tbl.rows[ 0 ].cells.length
  while( --s >= 0 ){
    hideTableColumn( tbl, s + c );
    showTableColumn( tbl, s );
  }
  start.value = 0;
  stepScrollButtonStates( tableId, s, c, l );
  if( _callStepScrollCallback ){
    _callStepScrollCallback = false;
    stepScrollCallback( tableId, s, c, l, 'first' );
    _callStepScrollCallback = true;
  }
}

function stepScrollPrevious( tableId )
{
  var start = document.getElementById( tableId + '_STEP_START' );
  var count = document.getElementById( tableId + '_STEP_COUNT' );
  var tbl = document.getElementById( tableId + '_syncmaster' );
  var s = --start.value;
  var c = parseInt( count.value );
  var l = tbl.rows[ 0 ].cells.length
  hideTableColumn( tbl, s + c );
  showTableColumn( tbl, s );
  stepScrollButtonStates( tableId, s, c, l );
  if( _callStepScrollCallback ){
    _callStepScrollCallback = false;
    stepScrollCallback( tableId, s, c, l, 'previous' );
    _callStepScrollCallback = true;
  }
}

function stepScrollNext( tableId )
{
  var start = document.getElementById( tableId + '_STEP_START' );
  var count = document.getElementById( tableId + '_STEP_COUNT' );
  var tbl = document.getElementById( tableId + '_syncmaster' );
  var s = ++start.value;
  var c = parseInt( count.value );
  var l = tbl.rows[ 0 ].cells.length
  hideTableColumn( tbl, s - 1 );
  showTableColumn( tbl, s + c - 1 );
  stepScrollButtonStates( tableId, s, c, l );
  if( _callStepScrollCallback ){
    _callStepScrollCallback = false;
    stepScrollCallback( tableId, s, c, l, 'next' );
    _callStepScrollCallback = true;
  }
}

function stepScrollLast( tableId )
{
  var start = document.getElementById( tableId + '_STEP_START' );
  var count = document.getElementById( tableId + '_STEP_COUNT' );
  var tbl = document.getElementById( tableId + '_syncmaster' );
  var s = parseInt( start.value );
  var c = parseInt( count.value );
  var l = tbl.rows[ 0 ].cells.length
  var e = l - c;
  while( s < e ){
    hideTableColumn( tbl, s );
    showTableColumn( tbl, s + c );
    ++s;
  }
  start.value = e;
  stepScrollButtonStates( tableId, s, c, l );
  if( _callStepScrollCallback ){
    _callStepScrollCallback = false;
    stepScrollCallback( tableId, s, c, l, 'last' );
    _callStepScrollCallback = true;
  }
}

function stepScroll( tableId, step )
{
  if( step == 'first' )
    stepScrollFirst( tableId );
  else if( step == 'previous' )
    stepScrollPrevious( tableId );
  else if( step == 'next' )
    stepScrollNext( tableId );
  else if( step == 'last' )
    stepScrollLast( tableId );
}

function getPageNameByWindow( w )
{
  return w.document.form.PAGE_NAME.value;
}

function getInvertTableInputIndex( t )
{
  var td = t.parentNode;
  var r = td.parentNode;
  var cells = r.cells;
  var l = cells.length;
  while( --l >= 0 )
    if( cells[ l ] == td )
      return l;
  return -1;
}

function getTableInputIndex( t )
{
  var tr = t.parentNode.parentNode;
  var tbl = tr.parentNode;
  while( tbl.tagName != 'TABLE' )
    tbl = tbl.parentNode;
  var offset = -1;
  var id = tbl.id;
  var x = id.length;
  if( x > 5 && id.substring( x - 5 ) == '_data' ){
    var p = tbl.parentNode;
    if( p && p.tagName == 'DIV' )
      offset = 0;
  }
  var rows = tbl.rows;
  var l = rows.length;
  while( --l >= 0 )
    if( rows[ l ] == tr )
      return l + offset;
  return -1;
}

function stripHTMLTags( v )
{
  if( typeof( v ) == 'string' && ( z = v.indexOf( '<' ) ) >= 0 ){
    for(;;){
      var e = v.indexOf( '>', z );
      if( z > 0 )
        v = v.substring( 0, z ) + ' ' + v.substring( e + 1 );
      else
        v = v.substring( e + 1 );
      z = v.indexOf( '<', z );
      if( z < 0 )
        break;
    }
  }
  return v;
}

function replaceValues( v, vs )
{
  if( typeof( v ) == 'string' ){
    var o = v;
    var l = vs.length;
    for( var i = 0; i < l; i += 2 )
      v = v.replace( vs[ i ], vs[ i + 1 ] );
    if( o == v )
      return v;
  }
  return v;
}

function isColumnExcluded( c, cs )
{
  if( cs == null )
    return false;
  var l = cs.length;
  while( --l >= 0 )
    if( c == cs[ l ] )
      return true;
  return false;
}

function tableToXML( tableId, postfix, rootName, nodeName, full, stripHTML, replaceVs )
{
  var c = getXMLCreator( );
  var xml = c.createElement( rootName );
  var rc = new Array( );
  var rcn = new Array( );
  var rcdn = new Array( );
  var rcti = new Array( );
  if( postfix == null )
    postfix = '';
  else
    postfix = '' + postfix;
  var pfLen = postfix.length;
  var configuration = eval( 'tableConfiguration_' + tableId + postfix )( );
  var l = configuration.length - 4;
  for( var i = 0; i < l; i += 4 ){
    var v = configuration[ i + 2 ];
    if( v >= 0 || full ){
      var n = configuration[ i ];
      rc[ rc.length ] = eval( 'get_' + n + '_WithIndex' );
      if( pfLen > 0 )
        n = n.substring( 0, n.length - pfLen );
      rcn[ rcn.length ] = n;
      rcdn[ rcdn.length ] = configuration[ i + 1 ];
      rcti[ rcti.length ] = eval( 'get_' + n + '_TableIndex' )( );
    }
  }
  var rcl = rc.length;
  var cid = eval( 'tableContainerId_' + tableId + postfix )( );
  var tdf = eval( 'getTD_' + cid );
  var l = eval( 'tableLength_' + cid )( );
  for( var i = 0; i < l; ++i ){
    var node = c.createElement( nodeName );
    xml.appendChild( node );
    for( var j = 0; j < rcl; ++j ){
      var n = c.createElement( rcn[ j ] );
      var dn = rcdn[ j ];
      if( stripHTML ){
        dn = dn.replace( /\[:/, '<' )
        dn = dn.replace( /:\]/, '>' )
        if( replaceVs )
          dn = replaceValues( dn, replaceVs );
        dn = stripHTMLTags( dn );
      }
      n.setAttribute( 'Name', dn );
      var v = rc[ j ]( i );
      if( replaceVs )
        v = replaceValues( v, replaceVs );
      if( stripHTML )
        v = stripHTMLTags( v );
      n.setAttribute( 'Value', isEmptyValue( v ) ? '' : v );
      var ti = rcti[ j ];
      if( ti >= 0 ){
        var td = tdf( ti, i );
        var st = td.style.cssText;
        if( st.length > 0 )
          n.setAttribute( 'Style', st );
      }
      node.appendChild( n );
    }
  }
  return xml;
}

function tableToXMLByRows( tableId, postfix, full, stripHTML, replaceVs, excludedColumns )
{
  var c = getXMLCreator( );
  var xml = c.createElement( 'ROWS' );
  if( postfix == null )
    postfix = '';
  else
    postfix = '' + postfix;
  var pfLen = postfix.length;
  var cid = eval( 'tableContainerId_' + tableId + postfix )( );
  var tdf = eval( 'getTD_' + cid );
  var tl = eval( 'tableLength_' + cid )( );
  var configuration = eval( 'tableConfiguration_' + tableId + postfix )( );
  var l = configuration.length - 4;
  for( var i = 0; i < l; i += 4 ){
    var v = configuration[ i + 2 ];
    if( v >= 0 || full ){
      var n = configuration[ i ];
      if( pfLen > 0 )
        n = n.substring( 0, n.length - pfLen );
      if( isColumnExcluded( n, excludedColumns ) )
        continue;
      var node = c.createElement( 'ROW' );
      xml.appendChild( node );
      node.setAttribute( 'Name', n );
      var dn = configuration[ i + 1 ];
      if( stripHTML ){
        dn = dn.replace( /\[:/, '<' )
        dn = dn.replace( /:\]/, '>' )
        if( replaceVs )
          dn = replaceValues( dn, replaceVs );
        dn = stripHTMLTags( dn );
      }
      node.setAttribute( 'DisplayText', dn );
      var df = eval( 'get_' + n + postfix + '_WithIndex' );
      var ti = eval( 'get_' + n + postfix + '_TableIndex' )( );
      for( var j = 0; j < tl; ++j ){
        var n = c.createElement( 'CELL' );
        node.appendChild( n );
        var v = df( j );
        if( replaceVs )
          v = replaceValues( v, replaceVs );
        if( stripHTML )
          v = stripHTMLTags( v );
        n.setAttribute( 'Value', isEmptyValue( v ) ? '' : v );
        if( ti >= 0 ){
          var td = tdf( ti, j );
          var st = td.style.cssText;
          if( st.length > 0 )
            n.setAttribute( 'Style', st );
        }
      }
    }
  }
  return xml;
}

function addToXML( ids, postfix, xml )
{
  var c = getXMLCreator( );
  if( postfix == null )
    postfix = '';
  else
    postfix = '' + postfix;
  if( typeof( ids ) == 'string' ){
    var n = c.createElement( ids );
    var v = eval( 'get_' + ids + postfix )( );
    n.setAttribute( 'Value', isEmptyValue( v ) ? '' : v );
    xml.appendChild( n );
  }
  else{
    var l = ids.length;
    for( var i = 0; i < l; ++i ){
      var t = ids[ i ];
      var n = c.createElement( t );
      var v = eval( 'get_' + t + postfix )( )
      n.setAttribute( 'Value', isEmptyValue( v ) ? '' : v );
      xml.appendChild( n );
    }
  }
}

function showExcelDocument( name, windowName )
{
  if( windowName == null )
    windowName = 'excel';
  var s = omxContextPath;
  if( name )
    s += '/' + name;
  else
    s += '/ExcelServlet';
  s += '?EXCEL_DOWNLOAD=TRUE&StreamName=cpm_xsl_transform_result';
  return window.open( s, windowName, 'menubar=yes, scrollbars=yes, resizable=yes' );
}

function VariableContainer( )
{
}

var _variables = new VariableContainer( );

function test_date_range(from,to,datatype)
{
  var x = document.getElementsByName(from);
  var y = document.getElementsByName(to);
  var fromDate = x[0].value;
  var toDate = y[0].value;

  var bValid = "true";
  
  //check for errors
  if (!isValid_field(from,null) || !isValid_field(to,null))
  {
    bValid = "false";
  }
  
  if ( bValid == "true" )
  {
    if( typeof(window['isValid_search']) == 'function' )
    {
      validation_clearMessages('search');
      if ( validate_search('search') == false )
      {
        validation_alert('search');
        bValid = "false";
      }  
    }
  }
  
  if ( bValid == "true" )
  {
    if(toDate != null && trimString(toDate) != '' && fromDate != null && trimString(fromDate) != '')
    {
      var dateFormat = datatype == 'DateTime' ? datatype : null;

      var result = datecompare(fromDate, dateFormat, toDate, dateFormat);
      if(result > 0)
      {
        core_alert('From Date greater than To Date');
        y[0].value = x[0].value;
      }
    }
  }
  else
  {
    onResize();
    return;
  }
}


/* Use for number range validation */
function validRange(numericInput)
{
  var value = numericInput.value.trim() == "" ? null : new Number(numericInput.value);
  var minValue = new Number(numericInput.minValue);
  var maxValue = new Number(numericInput.maxValue);
  var msg = null;
  if (value == null)
  {
    msg = "No value present.";
    clearRangeError(numericInput);
  }
  else if (isNaN(value))
  {
    msg = "Invalid Number.";
    displayRangeError(numericInput, msg);
  }
  else if (value < minValue)
  {
    fieldValidator = getRangeValidator(numericInput);
    msg = fieldValidator.minMessage;
    displayRangeError(numericInput, msg);
  }
  else if (value > maxValue)
  {
    fieldValidator = getRangeValidator(numericInput);
    msg = fieldValidator.maxMessage;
    displayRangeError(numericInput, msg);
  }
  else
  {
    // Clear error display
    clearRangeError(numericInput);
  }
}

function getRangeValidator(numericInput)
{
  var parent = numericInput.parentElement
  var childLen = parent.childNodes.length;
  var i;

  for(i = 0; i < childLen; i++)
  {

    fieldValidator =  parent.childNodes[i];
    if (fieldValidator.nodeName == 'SPAN')
    {
      if (fieldValidator.type == 'valid-range-validator')
      {
        return fieldValidator;
      }
    }
  }

  return null;
}

function displayRangeError(numericInput, msg)
{
  var fieldValidator = getRangeValidator(numericInput);

  if (fieldValidator != null)
  {
    fieldValidator.style.display = "";
    fieldValidator.style.visibility = "visible";

    fieldValidator.message = msg;
    
    var validatorImg = getRangeImg(fieldValidator);

    if (validatorImg != null)
    {
      validatorImg.alt = msg;
    }

    numericInput.focus();
    numericInput.select();
  }
}

function getRangeImg(fieldValidator)
{
  var numFieldValidatorChildren = fieldValidator.childNodes.length;
  for (k=0; k<numFieldValidatorChildren; k++)
  {
    var validatorImg = fieldValidator.childNodes[k];
    if (validatorImg.nodeName == 'IMG')
    {
      return validatorImg;
    }
  }
  return null;
}

function clearRangeError(numericInput)
{
  var fieldValidator = getRangeValidator(numericInput);

  if (fieldValidator != null)
  {
    fieldValidator.style.visibility = "hidden";
  }
}

function trapExcelPivotChanges()
{
  var excelPivotsInPage = document.getElementsByName("excel_pivot_id");
  
  for (var i=0; i < excelPivotsInPage.length; i++)
  {
    var id = excelPivotsInPage[i].value;
    var result = i2uiExtractPivot(id);
    eval("form." + id + "_CHANGES.value = result;");
  }
  return;
}

function tabsetScrollerButtons( cells, lt, endScroll )
{
  var cl = cells.length;
  var begin = cells[ cl - 8 ].children[ 0 ].rows[ 0 ].cells[ 0 ].children[ 0 ].children[ 0 ];
  var left = cells[ cl - 6 ].children[ 0 ].rows[ 0 ].cells[ 0 ].children[ 0 ].children[ 0 ];
  var right = cells[ cl - 4 ].children[ 0 ].rows[ 0 ].cells[ 0 ].children[ 0 ].children[ 0 ];
  var end = cells[ cl - 2 ].children[ 0 ].rows[ 0 ].cells[ 0 ].children[ 0 ].children[ 0 ];
  if( lt > 0 ){
    begin.style.cursor = 'hand';
    left.style.cursor = 'hand';
    begin.src = omxContextPath + '/i2/images/page_to_beginning.gif';
    left.src = omxContextPath + '/i2/images/previous_active.gif';
  }
  else{
    begin.style.cursor = 'default';
    left.style.cursor = 'default';
    begin.src = omxContextPath + '/i2/images/page_to_beginning_inact.gif';
    left.src = omxContextPath + '/i2/images/previous_inactive.gif';
  }
  if( endScroll > 0 ){
    right.style.cursor = 'hand';
    end.style.cursor = 'hand';
    right.src = omxContextPath + '/i2/images/next_active.gif';
    end.src = omxContextPath + '/i2/images/page_to_end.gif';
  }
  else{
    right.style.cursor = 'default';
    end.style.cursor = 'default';
    right.src = omxContextPath + '/i2/images/next_inactive.gif';
    end.src = omxContextPath + '/i2/images/page_to_end_inact.gif';
  }
}

function resizeTabsetScroller( table, w )
{
  if ( isV1() )
    return;
    
  if( w < 0 )
    w = document.body.clientWidth;
  var cells = table.rows[ 0 ].cells;
  var cl = cells.length;
  var filler = cells[ cl - 10 ];
  var first = 0;
  var last = cl - 10;
  var cw = 0;
  for( var j = 0; j < last; ++j ){
    var c = cells[ j ];
    c.style.display = '';
    cw += c.offsetWidth;
    if( ( j & 3 ) == 3 ){
      c.totalWidth = cw;
      cw = 0;
    }
  }
  while( ++j < cl )
    cells[ j ].style.display = 'none';
  if( filler.offsetWidth > 0 && table.offsetWidth <= w )
    return;
  for( var j = last + 1; j < cl; ++j )
    cells[ j ].style.display = '';
  var endScroll = 0;
  if( table.hasScrollerBegin == null ){
    for( var j = 0; j < last; j += 4 ){
      var c = cells[ j + 1 ];
      if( c.id == 'tabSelected' ){
        var e = j + 4;
        while( ( filler.offsetWidth == 0  || table.offsetWidth > w ) && last > e ){
          cells[ --last ].style.display = 'none';
          cells[ --last ].style.display = 'none';
          cells[ --last ].style.display = 'none';
          cells[ --last ].style.display = 'none';
          ++endScroll;
        }
        while( filler.offsetWidth == 0 || table.offsetWidth > w ){
          cells[ first++ ].style.display = 'none';
          cells[ first++ ].style.display = 'none';
          cells[ first++ ].style.display = 'none';
          cells[ first++ ].style.display = 'none';
        }
        table.scrollerBegin = first;
        break;
      }
    }
    table.hasScrollerBegin = true;
  }
  var lt = table.scrollerBegin;
  while( first < lt ){
    cells[ first++ ].style.display = 'none';
    cells[ first++ ].style.display = 'none';
    cells[ first++ ].style.display = 'none';
    cells[ first++ ].style.display = 'none';
  }
  while( filler.offsetWidth == 0 || table.offsetWidth > w ){
    cells[ --last ].style.display = 'none';
    cells[ --last ].style.display = 'none';
    cells[ --last ].style.display = 'none';
    cells[ --last ].style.display = 'none';
    ++endScroll;
  }
  table.endScroll = endScroll;
  tabsetScrollerButtons( cells, lt, endScroll );
}

function moveTabsetScroller( table, gotolast )
{
  var w = document.body.clientWidth;
  var cells = table.rows[ 0 ].cells;
  var cl = cells.length;
  var filler = cells[ cl - 10 ];
  var first = 0;
  var last = cl - 10;
  var j = 0;
  while( j < last ){
    cells[ j++ ].style.display = 'none';
    cells[ j++ ].style.display = 'none';
    cells[ j++ ].style.display = 'none';
    cells[ j++ ].style.display = 'none';
  }
  var endScroll = 0;
  if( gotolast ){
    while( last > 0 ){
      var c = cells[ --last ];
      if( filler.offsetWidth < c.totalWidth )
        break;
      c.style.display = '';
      cells[ --last ].style.display = '';
      cells[ --last ].style.display = '';
      cells[ --last ].style.display = '';
    }
    table.scrollerBegin = ++last;
  }
  else{
    var first = table.scrollerBegin;
    while( first < last ){
      var c3 = cells[ first + 3 ];
      if( filler.offsetWidth < c3.totalWidth )
        break;
      cells[ first++ ].style.display = '';
      cells[ first++ ].style.display = '';
      cells[ first++ ].style.display = '';
      c3.style.display = '';
      ++first;
    }
    endScroll = ( last - first ) / 4;
  }
  table.endScroll = endScroll;
  tabsetScrollerButtons( cells, table.scrollerBegin, endScroll );
}

function i2uiScrollTab( td, dir )
{
  var table = td.parentNode.parentNode.parentNode;
  if( dir == 'begin' ){
    if( table.scrollerBegin > 0 ){
      table.scrollerBegin = 0;
      moveTabsetScroller( table );
    }
  }
  else if( dir == 'left' ){
    if( table.scrollerBegin > 0 ){
      table.scrollerBegin -= 4;
      moveTabsetScroller( table );
    }
  }
  else if( dir == 'right' ){
    var es = table.endScroll;
    if( es > 0 ){
      table.scrollerBegin += 4;
      moveTabsetScroller( table );
    }
  }
  else if( dir == 'end' ){
    var es = table.endScroll;
    if( es > 0 )
      moveTabsetScroller( table, true );
  }
}

function isValidData(oField)
{
  if(isValid_field_worker(oField))
  {
    return;
  }
}