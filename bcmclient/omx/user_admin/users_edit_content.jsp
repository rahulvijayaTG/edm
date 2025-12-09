<%@ include file="/bcm/framework/headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>User Admin Content</title>
<script type="text/javascript" src="../saved_trans/search_transactions.js"></script>
<script>
    function IEEnterKey() {
    	if(window.event.keyCode == 13){
				document.search_form.DO_SEARCH.value='Yes';
				document.search_form.submit();
     	}
    }

	function activateUser() {
		document.userForm.action="users_edit/activateUser.cmd";
		document.userForm.submit();
	}

	function deactivateUser() {
		document.userForm.action="users_edit/deactivateUser.cmd";
		document.userForm.submit();
	}

	function resetPassword() {

		var id;
		var message;
		id = document.userForm.ID.value;
		message = " Are you sure you really want to reset the password?";
		locstr = "../alert/redirectToConfirm.cmd?PAGE=passwd_reset&ACTION=user_admin/users_edit/resetPassword.cmd&HIDDEN=ID&ID=" + id + "&MESSAGE=" + message;
		popUpWindow(locstr,'popUp5');
	}

    function NetEnterKey(e) {
    	key = e.which;
     	if(key == 13){
				document.search_form.DO_SEARCH.value='Yes';
				document.search_form.submit();
			}
    }

    browserName = navigator.appName;

    if (browserName == "Netscape") {
    	document.captureEvents(Event.KEYPRESS);
     	document.onkeypress=NetEnterKey;}
    else{ if (browserName.indexOf("Explorer") >= 0){
      document.onkeypress=IEEnterKey;}
    }
		</script>
</head>
  <body  class="contentFrameBody" onFocus="checkForPopUps()" onKeyDown="mappedKeyCheck()">
	    <!-- Tabbed Container -->
	    <i2:xslt xslfile="$xsl:users_edit">
           <x2:execute command="omx.user_admin.users_edit:loadUserToEdit"/>
	    </i2:xslt>
  </body>
</html>