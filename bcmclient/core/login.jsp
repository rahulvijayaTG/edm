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
        if ( document.userfm.USER_NAME )
      		document.userfm.USER_NAME.focus();
  		}

  		function onLoad()
  		{
         var height = document.body.offsetHeight - 90;
         var obj = document.getElementById('panel_img');
         //alert(obj.height);
//         alert(height)
         obj.height = height;


        setfocus();
  		}
  
  		function onResize()
  		{
        onLoad();
  		}
  		function validate()
  		{
        if ( document.userfm.USER_NAME )
        {
    			if (document.userfm.USER_NAME.value == "")
    			{
    			core_login_alert("Please enter your Username");
    			document.userfm.USER_NAME.focus();
    			return;
    			}
    
    
    			if (document.userfm.PASSWORD.value == "")
    			{
    			core_login_alert("Please enter your Password");
    			document.userfm.PASSWORD.focus();
    			return;
    			}
        }
        
     var totalAvailWidth = document.body.offsetWidth;
     document.userfm.SCR_WIDTH.value = totalAvailWidth;

  			document.userfm.CHANGE_PASSWD.value = "no";
  			document.userfm.submit();
  		}
		
		function changePasswd()
  		{
  			document.userfm.CHANGE_PASSWD.value = "yes";
  			document.userfm.submit();
  		}
    
      function SetfocusSubmit( target ) {
      		if ( target == document.userfm.USER_NAME ){
      			document.userfm.PASSWORD.focus();
      		} else {	
      			validate();
      		}
      }	                                   
      
       function IEEnterKey() {
      
      	if( window.event.keyCode == 13 && ((window.event.srcElement.name == "USER_NAME") || (window.event.srcElement.name == "PASSWORD")) ){
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
	<i2:xslt xslfile="$xsl:core_login">
    <x2:execute command="core.login.view:load"/>
  </i2:xslt>
</html>
