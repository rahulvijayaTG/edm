

function onChangeSearchEntities()
{
	var docType= document.search_form.DOC_TYPE.value;
	var orgId = document.search_form.ORG_ID.value;
	
	if (docType == "REMIT_TO")
		parent.document.location.href  = "searchRemitTo.jsp?DOC_TYPE="+docType+"&ORG_ID="+orgId+"&SELLING_ORG_ID="+orgId;
	else if (docType == "FULFILLMENT_CENTER")
		parent.document.location.href  = "searchFulfillmentCenter.jsp?DOC_TYPE="+docType+"&ORG_ID="+orgId+"&SELLING_ORG_ID="+orgId;
	else if (docType == "ORDER_POINT")
		parent.document.location.href  = "searchOrderPoint.jsp?DOC_TYPE="+docType+"&ORG_ID="+orgId+"&CUSTOMER_ORG_ID="+orgId;
	else if (docType == "BILL_TO")
		parent.document.location.href  = "searchBillTo.jsp?DOC_TYPE="+docType+"&ORG_ID="+orgId+"&CUSTOMER_ORG_ID="+orgId;
	else if (docType == "SHIP_TO")
		parent.document.location.href  = "searchShipTo.jsp?DOC_TYPE="+docType+"&ORG_ID="+orgId+"&CUSTOMER_ORG_ID="+orgId;
}
 