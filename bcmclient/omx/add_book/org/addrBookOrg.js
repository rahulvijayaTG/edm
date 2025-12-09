
function saveOrg()
{
	noError = "false";
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
  
  if((document.orgForm.SELLER_STATUS.value != "Active") && (document.orgForm.CUSTOMER_STATUS.value != "Active"))
	{
		errMsg += "You must specify this Organization as Customer, Seller, or Both.";
		hasError = true;
	}
	
	if( hasError )
	{
		omx_alert( errMsg );
		return false;
	}
	return true;
}

function redirectToManageOrg()
{
  if(ifAnySelected(result_form)){
  
	document.result_form.target="appFrame";
	document.result_form.action= omxContextPath + "/omx/add_book/org/pages/redirectToManageOrg.cmd";
	document.result_form.submit();

   }

   else {

	 omx_alert("PLEASE_SELECT_ORG");

   }

}

function redirectToOrgDetails()
{
  parent.location = omxContextPath + "/omx/add_book/org/pages/redirectToOrgDetails.cmd"
}


function redirectToAddOrg()
{
  parent.location= omxContextPath + "/omx/add_book/org/editOrg.jsp";

}


