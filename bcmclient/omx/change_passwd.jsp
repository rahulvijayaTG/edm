<%@ include file="/core/include_header.jsp" %>
<%@ include file="/core/include_css.jsp" %>

<%
      String jscript = request.getParameter("JSCRIPT");
      String contextPath = request.getContextPath();
      if( jscript != null && !(jscript.equals("")) )
      {
      %>
      <script type="text/javascript" src="<%=contextPath%>/<%=jscript%>"></script>
      <%
      }
%> 

<HTML>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  	<TITLE>i2 Technologies</TITLE>
  	<SCRIPT LANGUAGE="JavaScript">

  		function setfocus()
  		{
  			document.userfm.OLD_PASSWORD.focus();
  		}

  		function validate()
  		{

  			if (document.userfm.OLD_PASSWORD.value == "")
  			{
  				core_alert('ENTER_OLD_PASSWORD');
  				document.userfm.OLD_PASSWORD.focus();
  				return;
  			}

			if (document.userfm.NEW_PASSWORD.value == "")
  			{
  				core_alert('ENTER_NEW_PASSWORD');
  				document.userfm.OLD_PASSWORD.focus();
  				return;
  			}

			if (document.userfm.CONFIRM_PASSWORD.value == "")
  			{
  				core_alert('ENTER_NEW_PASSWORD_CONFIRM');
  				document.userfm.OLD_PASSWORD.focus();
  				return;
  			}
			if (document.userfm.NEW_PASSWORD.value != document.userfm.CONFIRM_PASSWORD.value)
			{
				core_alert('NEW_OLD_PASSWORD_SAME_MSG');
				document.userfm.CONFIRM_PASSWORD.focus();
				return;
			}

			if (document.userfm.PROMPT_SECRET_QUESTION.value == "yes")
			{
				if (document.userfm.PWD_QUESTION.value == "")
				{
					core_alert('PASSWORD_QUESTION');
					document.userfm.PWD_QUESTION.focus();
					return;
				}

				if (document.userfm.PWD_ANSWER.value == "")
				{
					core_alert('PASSWORD_ANSWER');
					document.userfm.PWD_ANSWER.focus();
					return;
				}
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
        //parent.location = "common/redirectToLogin.cmd";
		document.userfm.action = "common/redirectToLogin.cmd";
		document.userfm.submit();
      }

		  function onLoad()
		{
		  requiredFieldCheck('onLoad');
		}

    </SCRIPT>
  </head>
  <body >
	<i2:xslt xslfile="$xsl:change_passwd">
		<x2:execute command="bcm.framework.config:getChangePasswordPage"/>
	</i2:xslt>
  </body>

</html>
