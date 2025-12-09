
function saveOrg()
{
	noError = "false";
    document.orgForm.UPDATE.value = "true";
	noError = validate_form('orgForm');
	if ( noError == true )
	{
 // needed for seller of customer status  
	  if( validateStatus() == true )
    {

		document.orgForm.submit();
    }
	}
}

function saveOrgAs()
{
	noError = "false";
	noError = validate_form('orgForm');
	if ( noError == true )
	{ 
    // needed for seller of customer status  
	  if( validateStatus() == true )
    {
	  	document.orgForm.IS_NEW.value = "true";
		document.orgForm.submit();
    }
	}
}
function validateStatus()
{
	var hasError = false;
  
  if((document.orgForm.SELLER_STATUS.value != "ACTIVE") && (document.orgForm.CUSTOMER_STATUS.value != "ACTIVE"))
	{
		errMsg = "You must specify this Organization as Customer, Seller, or Both.";
		hasError = true;
	}
	
	if( hasError )
	{
		omx_alert("PLEASE_SPECIFY_CUSTOMER_OR_SELLER");
		return false;
	}
	return true;
}