<script>
  if( top != self ){
    top.document.location = document.location;
  }
</script>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/system/tld/xrequest.tld" prefix="x2" %>
<%@ taglib uri="/WEB-INF/system/tld/i2uitaglib.tld" prefix="i2" %>
<%@ taglib uri="/WEB-INF/system/tld/i18n.tld" prefix="i18n" %>
<HTML>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  	<TITLE>i2 Technologies</TITLE>
	  <i2:stylesheet path="/style_sheet_core.css"></i2:stylesheet>
	  <i2:stylesheet path="/omx_core.css"></i2:stylesheet>
	  <i2:javascript path="/global_javascript.js"></i2:javascript>
		<i2:dhtml padsupport="yes"></i2:dhtml>
  	<SCRIPT LANGUAGE="JavaScript">
  
  		function setfocus()
  		{
  			document.userfm.ID.focus();
  		}
  
  		function validate()
  		{
  
  			if (document.userfm.ID.value == "")
  			{
  				core_login_alert("Please enter your Username");
  				document.userfm.ID.focus();
  				return;
  			}

  			if (document.userfm.OLD_PASSWORD.value == "")
  			{
  				core_login_alert("Please enter your old Password");
  				document.userfm.OLD_PASSWORD.focus();
  				return;
  			}
			
			if (document.userfm.NEW_PASSWORD.value == "")
  			{
  				core_login_alert("Please enter your new Password");
  				document.userfm.NEW_PASSWORD.focus();
  				return;
  			}
			
			if (document.userfm.CONFIRM_PASSWORD.value == "")
  			{
  				core_login_alert("Please enter your new Password to confirm");
  				document.userfm.CONFIRM_PASSWORD.focus();
  				return;
  			}
			if (document.userfm.NEW_PASSWORD.value != document.userfm.CONFIRM_PASSWORD.value)
			{
				core_login_alert("Please retype your new password");
				document.userfm.NEW_PASSWORD.focus();
				return;
			}
  
  			document.userfm.submit();
  		}
    
      function SetfocusSubmit( target ) {
      		if ( target == document.userfm.OLD_PASSWORD ){
      			document.userfm.NEW_PASSWORD.focus();
      		} else if( target == document.userfm.NEW_PASSWORD ){
      			document.userfm.CONFIRM_PASSWORD.focus();
			}
			else{	
      			validate();
      		}
      }	                                   
      
      function IEEnterKey() {
      
      	if(window.event.keyCode == 13){ 
      		SetfocusSubmit(window.event.srcElement)
      		event.returnValue=false;
      	}	
      }
      
      function NetEnterKey(e) {
      	key = e.which;
      	if(key == 13){ 
      		SetfocusSubmit( e.target )
      		return false;}
      }	
      
      browserName = navigator.appName;
      
      if (browserName == "Netscape") {
      	document.captureEvents(Event.KEYPRESS);
      	document.onkeypress=NetEnterKey;}
      else{ if (browserName.indexOf("Explorer") >= 0){
            document.onkeypress=IEEnterKey;}
      	}
      
      function cancel()
      {
        parent.location = "login/controller/display.x2c";
      }	
  
    </SCRIPT>
  </head>
	<i2:xslt xslfile="$xsl:core_change_passwd">
    <x2:execute command="core.config:getChangePasswordPage"/>
  </i2:xslt>
</html>
