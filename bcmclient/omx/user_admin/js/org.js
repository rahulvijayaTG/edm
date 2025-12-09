function selectOrganization()
{
	document.result_form.target="appFrame";
	document.result_form.action= omxContextPath + "/omx/user_admin/users_org/selectOrganization.cmd";
	document.result_form.submit();
}