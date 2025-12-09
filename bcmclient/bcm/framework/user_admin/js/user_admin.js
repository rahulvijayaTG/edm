function goBack()
{
	document.search_form.target="appFrame";
	document.search_form.action= omxContextPath + "/omx/user_admin/user_grps_domain_add/goBack.cmd";
	document.search_form.submit();
}


function selectDomain()
{
	document.result_form.target="appFrame";
	document.result_form.action= omxContextPath + "/omx/user_admin/user_grps_domain_add/selectDomain.cmd";
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
  document.user_form.action="../../../omx/common/reload.cmd";
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
	document.user_form.action="../../../omx/user_admin/users_edit/activateUser.cmd";
	document.user_form.submit();
}
	
function deactivate() 
{
	document.user_form.action="../../../omx/user_admin/users_edit/deactivateUser.cmd";
	document.user_form.submit();
}
	
function resetPassword() 
{
		
		var id;
		var message;
		id = document.user_form.ID.value;
		//message = "Are you sure you really want to reset the password?";
		message = "PWD_RESET";
		locstr = "../alert/redirectToConfirm.cmd?PAGE=passwd_reset&ACTION=user_admin/users_edit/resetPassword.cmd&HIDDEN=ID&ID=" + id + "&MESSAGE=" + message;
		popUpWindow(locstr,'popUp5');
}

function saveAs()
{
	error = "false";
	error = requiredFieldCheck();
	if ( error == 'false' )
	{
		if (document.user_form.PASSWORD.value != document.user_form.PASSWORD1.value)
		{
			//core_alert("The 'Password' and 'Verify Password' fields must have the same value.");
			core_alert("PWD_VERIFY");
			return;
		}		
		document.user_form.action = omxContextPath + "/omx/user_admin/user_admin_users/addUserProfile.cmd";
		document.user_form.submit();
	}
	return;
}

function save()
{
	error = "false";
	error = requiredFieldCheck();
	if (error == 'false' )
	{
		if(document.user_form.userLocale.value != "" && 
			document.user_form.userLocale.value != document.user_form.LOCALE.options[document.user_form.LOCALE.selectedIndex].value)
		{
			//core_alert("You are changing your locale settings. " + "\nPlease login again for the new locale settings to take effect.");			
			core_alert("LOCALE_ALERT");
		}
		document.user_form.action= omxContextPath + "/omx/user_admin/user_admin_users/updateUserProfile.cmd";
		document.user_form.submit();
	}
  return;
}

function changePassword(user_form)
{
	document.user_form.CHANGE_PASSWD.value = "yes";
	document.user_form.action= omxContextPath + "/omx/user_admin/user_admin_users/changePasswordFromMyProfile.cmd";
	document.user_form.submit();
}

function editDomain()
{
  document.user_form.action= omxContextPath + "/omx/user_admin/user_admin_users/editDomains.cmd";
  document.user_form.submit();
}

/*
function add()
{
	alert('add clicked in bcm/user_admin');
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
   
  document.location.href = omxContextPath + "/omx/user_admin/user_admin_users/view.cmd?ID=" + id;
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

function onCancel(page)
{
	  document.user_form.action=omxContextPath + "/omx/user_admin/users_edit/returnToPreviousPage.cmd?page=" + page;
  	document.user_form.submit();
}

function SetfocusSubmit( target )
{ 
  save();  
}
