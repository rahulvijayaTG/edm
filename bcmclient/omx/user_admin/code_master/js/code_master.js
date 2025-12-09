
function checkIfAnySelected(form)
{
	var count; 
	var elementsLen = form.elements.length;
	var foundChecked = false;
	 
  for(count = 0; count < elementsLen; count++)
	{
	 	if( (form.elements[count].type == 'checkbox') && (form.elements[count].checked == true)  && (form.elements[count].name != 'SELECT_ALL') )
		{	
			 foundChecked = true;break;
		}
	}
	return foundChecked;
	
}
function checkIfAnyFieldsNullValues(form)
{
	
	var foundNull = false;
	if (form.SELECTED_ID[0] == null)
	{
		if (form.SELECTED_ID.checked == true && form.VALUE_ID.value.trim() == '')
		{
			foundNull = true;
		}
	}
	else
	{
		var count; 
		var elementsLen = form.SELECTED_ID.length;

		for(count = 0; count < elementsLen; count++)
		{
			if(form.SELECTED_ID[count].checked == true && form.VALUE_ID[count].value.trim() == '')
			{	
				foundNull = true;
				break;
			}
		}
	}
	
	return foundNull;
}

function deactivateCodeMasterValue()
{
  if (checkIfAnySelected(result_form) == true)
  {
	  document.result_form.action='controller/deactivateCodeMasterValue.cmd';
      document.result_form.submit();
  }
  else
  {
	  core_alert("PLEASE_SELECT_CODE_MASTER_VALUE");
  }
}

function activateCodeMasterValues()
{
  if (checkIfAnySelected(result_form))
  {
	  document.result_form.action='controller/activateCodeMasterValue.cmd';
      document.result_form.submit();
  }
  
	else
  {
	  core_alert("PLEASE_SELECT_CODE_MASTER_VALUE");
  }

}

function deleteCodeMasterValues()
{
	if (checkIfAnySelected(result_form))
	{
		document.result_form.action='controller/deleteCodeMasterValues.cmd';
        document.result_form.submit();
	}
	else
	{
		core_alert("PLEASE_SELECT_CODE_MASTER_VALUE");
	}
}
function checkNullValue(form)
{
	
	var foundNullValue = false;
	
	if (form.VALUE_ID.value.trim() == '')
		{
			foundNullValue = true;		
		}
			
		
	return foundNullValue;
}
function addCodeMasterValue()
{
  var foundNullVal = checkNullValue(add_new_form);

  if(foundNullVal == false)
	{
		  document.add_new_form.action='controller/addCodeMasterValue.cmd';
		  document.add_new_form.submit();
	}
	else
	{
		core_alert("NAME_SHOULD_NOT_BE_NULL");
	}
}

function modifyCodeMasterValues()
{
	var checkForNull = checkIfAnyFieldsNullValues(result_form);
	var checkSel = checkIfAnySelected(result_form);
	
		if(checkSel == true)
		{
				
			 if(checkForNull == false)
			 {
			  document.result_form.action='controller/modifyCodeMasterValues.cmd';
			  document.result_form.submit();
			 }
			 else
	         {
	  			core_alert("UPDATED_VALUE_SHOULD_NOT_NULL");
			 }
		}
		else
		{
			core_alert("PLEASE_SELECT_CODE_MASTER_VALUE");
  		}
	
	
}

// resize function added to resize the display space of the table.
 function onResize()
 {
 	//alert("resize");
	var table_id = 'result_form_table';
	var width = document.body.offsetWidth - 50;
	var height = document.body.offsetHeight -375; // Resize the table so as to use asmuch of the tha avaiable space as possible.
	i2uiResizeScrollableArea(table_id, height, width, null, null, null,null, null);
 }
 
 
 