function saveShipTo()
{
	if ( validate() == true )
	{
		document.shipToForm.submit();
	}
	return;
}

function saveShipToAsNew()
{
	if ( validate() == true )
	{
		document.shipToForm.IS_NEW.value = "true";
		document.shipToForm.submit();
	}
	return;
}

function validate()
{

	var allValid = true;
	
	if (!checkPositive(document.shipToForm.DAYS_EARLY))
	{
		omx_alert("Please provide a positive integer value for 'Days Early'.");
		allValid = false;
	}
	if (!checkPositive(document.shipToForm.DAYS_LATE))
	{
		omx_alert("Please provide a positive integer value for 'Days Late'.");
		allValid = false;
	}
	
	return allValid;


/**********
	if ( (document.shipToForm.MAX_PARTIAL_SHIPMENTS_N0.value == "") 
//!!i18n
//      || isNaN(document.shipToForm.MAX_PARTIAL_SHIPMENTS.value) 
	   )
		{
//			alert("Maximum Partial Shipment should be a valid number");
			document.shipToForm.MAX_PARTIAL_SHIPMENTS_N0.focus();
			return;
		}
		
	if ( (document.shipToForm.DAYS_LATE_N0.value == "") 
//	     || isNaN(document.shipToForm.DAYS_LATE.value) 
	   )
		{
//			alert("Days Late should be a valid number");
			document.shipToForm.DAYS_LATE_N0.focus();
			return;
		}

	if ( (document.shipToForm.DAYS_EARLY_N0.value == "") 
//      || isNaN(document.shipToForm.DAYS_EARLY.value) 
	   )
		{
//			alert("Days Early should be a valid number");
			document.shipToForm.DAYS_EARLY_N0.focus();
			return;
		}
********/
	return true;
}


function checkPositive(objName)
{
	
	var checkOK = "0123456789";
	var checkStr = objName;
	var allValid = true;
	var decPoints = 0;
	var allNum = "";

	for (i = 0;  i < checkStr.value.length;  i++)
	{
		ch = checkStr.value.charAt(i);
		for (j = 0;  j < checkOK.length;  j++)
		if (ch == checkOK.charAt(j))
			break;
		if (j == checkOK.length)
		{
			allValid = false;
			break;
		}
		if (ch != ",")
			allNum += ch;
	}
	if (!allValid)
	{	
		return false;
	}
	return true;
}

