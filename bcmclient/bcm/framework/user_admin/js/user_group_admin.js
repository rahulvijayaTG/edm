function addOraganizationToDomain(){
    document.forms.result_form.action = omxContextPath + '/bcm/framework/user_admin/user_admin_groups_new/addOrgnizationsToDomain.cmd';
    document.forms.result_form.submit();
}
function addUsersToGroup(){
    document.forms.result_form.action = omxContextPath + '/bcm/framework/user_admin/user_admin_groups_new/addUsersToUserGroup.cmd';
    document.forms.result_form.submit();
}

function ViewUsersDone(){
    document.forms.result_form.action = omxContextPath + '/bcm/framework/user_admin/user_admin_groups_new/goToPage.cmd?WHERE=USER_GROUP_MAIN';
    document.forms.result_form.submit();
}
function onAddNewUserGroup(){
	document.location.href = omxContextPath + "/bcm/framework/user_admin/user_admin_groups_new.jsp?ORG_ID=ORG_1";
}

