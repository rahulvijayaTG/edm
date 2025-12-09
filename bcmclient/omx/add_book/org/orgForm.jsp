<%@ include file="../../headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>New Organization Entry</title>
</head>

<body topmargin="0" marginheight="0">

<!-- Page Title -->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width=15 rowspan=2></td>
		<td class="largeheadline"><i18n:text>Enterprise Address Book</i18n:text></td>
		<td align="right"><img src="../images/pb_i2.gif" width=68 height=21><br/></td>
		<td width=15 rowspan=2></td>
	</tr>
	<tr>	  
	  <td height="20" valign="bottom" align="left">
	    <table>
		  <tr>
		    <td><a href="index.jsp"><i18n:text>Select Enterprise</i18n:text></a> &gt;</td>
			<td><i18n:text>Add Organization</i18n:text></td>
		  </tr>
		</table>
	  </td>
	</tr>
</table>

  <form action="omx.add_book.org.data:createOrganization.cmd" method="post" name="addOrgForm">

	<table width="33%">
	<tr>
	  <td>
    <xsl:variable name="caption_title"><i18n:text>Create New Organization</i18n:text></xsl:variable>
    <i2:container title="{$caption_title}"> 
	  <br/>
	  <table>
	    <tr>
		  <td>Name:</td>
		  <td valign="top">
		     <input class="inputfieldIE" type="text" name="ORG_NAME" size="15"/>				
		  </td>
		  <td />
		</tr>		
		<tr>
		 <td/>
		 <td width="80%"></td>
		 <td align="right">
		  <i2:buttonbar>
		    <i2:button onclick="javascript:document.addOrgForm.submit()"><i18n:text>Add</i18n:text></i2:button>
  		    <i2:button onclick="index.jsp"><i18n:text>Cancel</i18n:text></i2:button>
		  </i2:buttonbar>
		 </td>
		</tr>
	  </table>
	</i2:container>  
	
	  </td>
	</tr>
	</table>

	</form>

</body>
</html>
