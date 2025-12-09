
function saveOrg()
{
    if ( requiredFieldCheck() == 'false' )
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
    if ( requiredFieldCheck() == 'false' )
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


function redirectToManageOrg()
{
  var len = document.result_form.ID.length;
  var i=0;
  for(;i<len;i++)
  {
    if (document.result_form.ID[i].checked)
	  break;
  }
  var selectedIndex = eval(i+1);
  if(ifAnySelected(result_form)){
	document.result_form.target="appFrame";
	document.result_form.action= omxContextPath + "/omx/add_book/org/pages/redirectToManageOrg.cmd?SELECTED_INDEX=" + selectedIndex;
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
  document.result_form.target = "appFrame";
  document.result_form.action = omxContextPath + "/omx/add_book/org/editOrg.jsp";
  document.result_form.submit();
  //parent.location= omxContextPath + "/omx/add_book/org/editOrg.jsp";

}

function activateCustomer()
{		
	if(document.orgForm.ORG_ID.value){

		document.orgForm.action = "data/activateCustomer.cmd";
		document.orgForm.submit();
	}

	else {

		document.orgForm.CUSTOMER_STATUS.value = "ACTIVE";
		document.orgForm.action = "data/refreshOrg.cmd";
		document.orgForm.submit();
	}
}

function activateSeller()
{
	if(document.orgForm.ORG_ID.value){

		document.orgForm.action = "data/activateSeller.cmd";
		document.orgForm.submit();
	}

	else {

		document.orgForm.SELLER_STATUS.value = "ACTIVE";
		document.orgForm.action = "data/refreshOrg.cmd";
		document.orgForm.submit();
	}

}
	
function deactivateCustomer()
{
	if(document.orgForm.ORG_ID.value){

		document.orgForm.action = "data/removeCustomer.cmd";
		document.orgForm.submit();
	}

	else {

		document.orgForm.CUSTOMER_STATUS.value = "NONE";
		document.orgForm.action = "data/refreshOrg.cmd";
		document.orgForm.submit();
	}

}

function deactivateSeller()
{
	
	if(document.orgForm.ORG_ID.value){

		document.orgForm.action = "data/removeSeller.cmd";
		document.orgForm.submit();
	}

	else {
	 	
		document.orgForm.SELLER_STATUS.value = "NONE";
		document.orgForm.action = "data/refreshOrg.cmd";
		document.orgForm.submit();
	}

}

function activateLocalCustomer()
{
  if(document.localOrgForm.ID.value != ''){

    document.localOrgForm.action = "data/activateLocalCustomer.cmd";
    document.localOrgForm.submit();

  }
  else {

     document.localOrgForm.action = "data/addEditLocalOrganization.cmd";
     document.localOrgForm.submit();

  }
 
}

function deactivateLocalCustomer()
{
    document.localOrgForm.action = "data/removeLocalCustomer.cmd";
    document.localOrgForm.submit();
}

function activateLocalSeller()
{
  if(document.localOrgForm.IS_NEW.value != 'true'){
    document.localOrgForm.action = "data/activateLocalSeller.cmd";
    document.localOrgForm.submit();
  }
  else {
     document.localOrgForm.action = "data/addEditLocalSellerOrganization.cmd";
     document.localOrgForm.submit();
  }
 
}

function deactivateLocalSeller()
{
    document.localOrgForm.action = "data/removeLocalSeller.cmd";
    document.localOrgForm.submit();
}

function removeSharedOrgs()
{        
  document.sharedForm.action = "data/removeSharedOrg.cmd";
  document.sharedForm.submit();    
}

function shareOrg()
{
  document.sharedForm.action = "data/searchSharedOrg.cmd";
  document.sharedForm.submit();
}

function cancelShareOrg()
{
  document.search_form.action = omxContextPath + "/omx/add_book/org/data/cancelSharedOrg.cmd";
  document.search_form.submit();
}

function addShareOrg()
{
  document.result_form.action = omxContextPath + "/omx/add_book/org/data/addSharedOrg.cmd";
  document.result_form.submit();
}
