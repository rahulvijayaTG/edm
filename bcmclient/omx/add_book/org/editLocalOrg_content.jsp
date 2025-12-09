<%@ include file="../../headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>Address Book</title>
<script type="text/javascript" src="addrBookOrg.js"></script>
<script language="javascript">
function activateCustomer()
{
  document.orgForm.action = "data/activateCustomer.cmd";
  document.orgForm.CUSTOMER_STATUS.value = "ACTIVE";
  document.orgForm.submit();
}

function activateSeller()
{
  document.orgForm.action = "data/activateSeller.cmd";
  document.orgForm.SELLER_STATUS.value = "ACTIVE";
  document.orgForm.submit();
}

function deactivateCustomer()
{
    document.orgForm.action = "data/removeCustomer.cmd";
    document.orgForm.submit();
}

function deactivateSeller()
{
    document.orgForm.action = "data/removeSeller.cmd";
    document.orgForm.submit();
}
</script>

</head>

<body class="contentFrameBody" topmargin="0" marginheight="0">

<!-- Page Title Area -->
	<i2:xslt xslfile="xsl/pageEditLocalOrg.xsl"><xrequest:batch>
      <xrequest:executeCommand name="getOrganizationTabs">
	    <PAGE Value="details"/>
	  </xrequest:executeCommand>
      <xrequest:executeCommand name="getOrganization"/>
      <xrequest:executeCommand name="getLocalCustomer"/>
	  <xrequest:executeCommand name="getStates"/>
	  <xrequest:executeCommand name="getCountries"/>
	  <xrequest:executeCommand name="getCustomerTypes"/>
	  <xrequest:executeCommand name="getConversionMethods"/>
	  <xrequest:executeCommand name="getFulfillmentCenters"/>
	  <xrequest:executeCommand name="getPricingTemplates"/>
	</xrequest:batch>
    </i2:xslt>
	</body>
</html>
