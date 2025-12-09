function goBack()
{
	document.search_form.target="appFrame";
	document.search_form.action= omxContextPath + "/omx/user_admin/users_domain_add/goBack.cmd";
	document.search_form.submit();
}


function selectDomain()
{
	document.result_form.target="appFrame";
	document.result_form.action= omxContextPath + "/omx/user_admin/users_domain_add/selectDomain.cmd";
	document.result_form.submit();
}

function backToUserDetails()
{
	document.result_form.target="appFrame";
	document.result_form.action= omxContextPath + "/omx/user_admin/user_admin_domains/goBackToUserDetails.cmd?USER_ID=" + document.search_form.USER_ID.value;
	document.result_form.submit();
}


function addDomain()
{
	document.search_form.target="appFrame";
	document.search_form.action= omxContextPath + "/omx/user_admin/users_domain/addDomain.cmd";
	document.search_form.submit();
}


function deleteDomain()
{
	document.result_form.target="appFrame";
	document.result_form.action= omxContextPath + "/omx/user_admin/users_domain/deleteDomain.cmd";
	document.result_form.submit();
}

function refresh()
{
  document.user_form.action="../../omx/common/reload.cmd";
  document.user_form.submit();
  return;
}

function getOrganization() 
{
	document.user_form.action="users_org/view.cmd";
	document.user_form.submit();
}
	
function activate() 
{
	document.user_form.action="users_edit/activateUser.cmd";
	document.user_form.submit();
}
	
function deactivate() 
{
	document.user_form.action="users_edit/deactivateUser.cmd";
	document.user_form.submit();
}
	
function resetPassword() 
{
		
		var id;
		var message;
		id = document.user_form.ID.value;
		message = " Are you sure you really want to reset the password?";
		locstr = "../alert/redirectToConfirm.cmd?PAGE=passwd_reset&ACTION=user_admin/users_edit/resetPassword.cmd&HIDDEN=ID&ID=" + id + "&MESSAGE=" + message;
		popUpWindow(locstr,'popUp5');
}

function saveAs()
{
	error = "false";
	error = requiredFieldCheck();
	if ( error == 'false' )
	{
		document.user_form.action="user_admin_users/addUserProfile.cmd";
		document.user_form.submit();
	}
	return;
}

function save()
{
	error = "false";
	error = requiredFieldCheck();
	if ( error == 'false' )
	{
		document.user_form.action="user_admin_users/updateUserProfile.cmd";
		document.user_form.submit();
	}
  return;
}

function editDomain()
{
  document.user_form.action="user_admin_users/editDomains.cmd";
  document.user_form.submit();
}

/*
function add()
{
	alert('add clicked in omx/user_admin');
  document.location.href = omxContextPath + "/omx/user_admin/user_admin_users/view.cmd" ;
}
*/
function add()
{
//  document.location.href = omxContextPath + "/omx/user_admin/user_admin_users/view.cmd" ;
  document.user_form.action= omxContextPath + "/omx/user_admin/user_admin_users/view.cmd" ;
  document.user_form.submit();
}

function edit()
{
  var i;

  elemLen = document.result_form.elements.ID.length;
  
  if ( elemLen > 1 )
  {
    for(i = 0; i < document.result_form.ID.length; i++)
    {
      if( document.result_form.ID[i].checked == true )
      break;
    }
    var id = document.result_form.ID[i].value;
  }
  else
  {
    var id = document.result_form.ID.value;
  }
   
  document.location.href = omxContextPath + "/omx/user_admin/user_admin_users/view.cmd?fromPage=users_search&amp;ID=" + id;
}

function checkRequiredField()
{
	var webItem = document.getElementById('WEB');
	var webDetails = document.getElementById('WEB_DELIVERY_DETAILS');
	if (webItem.checked == true)
	{
		webDetails.required='true';
		i2uiToggleItemVisibility('WEB_DETAILS1', 'hide');
		i2uiToggleItemVisibility('WEB_DETAILS2', 'show');
	}
	else
	{
		webDetails.required='';
		i2uiToggleItemVisibility('WEB_DETAILS1', 'show');
		i2uiToggleItemVisibility('WEB_DETAILS2', 'hide');
		i2uiToggleItemVisibility('WEB_DELIVERY_DETAILS_REQ', 'hide');
	}
		  
	var emailItem = document.getElementById('EMAIL');
	var emailDetails = document.getElementById('EMAIL_DELIVERY_DETAILS');
	if (emailItem.checked == true)
	{
		emailDetails.required='true';
		i2uiToggleItemVisibility('EMAIL_DETAILS1', 'hide');
		i2uiToggleItemVisibility('EMAIL_DETAILS2', 'show');
	}
	else
	{
		emailDetails.required='';
		i2uiToggleItemVisibility('EMAIL_DETAILS1', 'show');
		i2uiToggleItemVisibility('EMAIL_DETAILS2', 'hide');
		i2uiToggleItemVisibility('EMAIL_DELIVERY_DETAILS_REQ', 'hide');
	}
}
function onResetPassword()
{
    var confirmMesg = "Are you sure? An e-mail will be sent to the user with a new password."
	if( core_confirm( confirmMesg ) == 'yes' )
	{ 
		document.result_form.target="appFrame";
		document.result_form.action= omxContextPath + "/omx/user_admin/users_edit/resetPasswordForUser.cmd";
		document.result_form.submit();
	}
}
function onAddNewUserGroup(){
	document.location.href = omxContextPath + "/bcm/framework/user_admin/user_admin_groups_new.jsp?ORG_ID=ORG_1";
}
