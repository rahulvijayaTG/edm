<%@ include file="/bcm/framework/headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>User Admin Content</title>
<SCRIPT language="javascript">

function checkIfAnySelected(form)
{
		var count;
		var elementsLen = form.elements.length;
		var foundChecked = false;

 		for(count = 0; count < elementsLen; count++)
		{
		 	if(
				form.elements[count].type == "checkbox" &&
				form.elements[count].checked == true  &&
				 form.elements[count].name != "SELECT_ALL"
			)
			{
				 foundChecked = true;break;
			}
		}
		return foundChecked;
}

function removeEntity()
{

	if (checkIfAnySelected(removeEntityForm) == true)
	{
		{
            document.removeEntityForm.action="user_admin_domains/removeEntitiesFromDomain.cmd";
			document.removeEntityForm.submit();
		}

  }
	else
		{
			omx_alert("PLEASE_SELECT_ENTITY");
		}
}

function addEntity()
{

	if (checkIfAnySelected(addEntityForm) == true)
	{
      document.addEntityForm.action="user_admin_domains/addEntitiesToDomain.cmd";
			document.addEntityForm.submit();
  }
	else
		{
			omx_alert("PLEASE_SELECT_ENTITY");
		}
}

</SCRIPT>

  </head>
  <body  class="contentFrameBody">

	    <i2:xslt xslfile="xsl/user_admin_domains.xsl">
          <x2:execute command="omx.user_admin.user_admin_domains:loadUserAdminDomains"/>
	    </i2:xslt>

  </body>
</html>