<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/system/tld/xrequest.tld" prefix="x2" %>
<%@ taglib uri="/WEB-INF/system/tld/i2uitaglib.tld" prefix="i2" %>
<%@ taglib uri="/WEB-INF/system/tld/i18n.tld" prefix="i18n" %>
<HTML>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
	  <TITLE>i2 Technologies Forgot Password</TITLE>
	  <i2:stylesheet path="/style_sheet_core.css"></i2:stylesheet>
	  <i2:stylesheet path="/omx_core.css"></i2:stylesheet>
	  <i2:javascript path="/global_javascript.js"></i2:javascript>
 		<i2:javascript path="/i2uitaglib.js"></i2:javascript>   
 		<i2:dhtml padsupport="yes"></i2:dhtml>
  	<SCRIPT LANGUAGE="JavaScript">
  
  		function setfocus()
  		{
  		document.userfm.EMAIL_ADDRESS.focus();
  		}
  
		function cancel(){
			document.userfm.action = "login.jsp";
			document.userfm.submit();
		}
  		function validate()
  		{
  
  			if (document.userfm.EMAIL_ADDRESS.value == "")
  			{
  			core_login_alert("Please enter your Email Address");
  			document.userfm.EMAIL_ADDRESS.focus();
  			return;
  			}
  
  			document.userfm.CHANGE_PASSWD.value = "no";
  			document.userfm.submit();
  		}
		
      function SetfocusSubmit( target ) {
      		if ( target == document.userfm.USER_NAME )
      			validate();
      }	                                   
      
       function IEEnterKey() {
      
      	if( window.event.keyCode == 13 && ((window.event.srcElement.name == "EMAIL_ADDRESS")) )
			{
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
  
    </SCRIPT>
  </head>
	<i2:xslt xslfile="$xsl:forgotLoginName"><x2:execute command="bcm.framework.config:getforgotLoginNamePage"/></i2:xslt>
<body>

</body>
</html>
