	function updateStates()
	{
		document.forms[ 'orderPointForm' ].action = 'refreshOrderPoint.cmd';
		document.forms[ 'orderPointForm' ].submit();
	}

  function confirmRemove(){
    {
	  document.location = 'removeOrderPoint.cmd?ORDER_POINT_ID=<xsl:value-of select="ID/@Value"/>&amp;CUSTOMER_ORG_ID=<xsl:value-of select="CUSTOMER_ORG_ID/@Value"/>';
	}
  }

  function confirmRemoveBilling(){
    {
	  document.forms[ 'billToForm' ].action = 'data/removeOrderPointAssociations.cmd';		
	  document.forms[ 'billToForm' ].submit();
	}
  }
  
  function confirmRemoveShipping(){
   {
	  document.forms[ 'shipToForm' ].action = 'data/removeOrderPointAssociationForShipTo.cmd';	
	  document.forms[ 'shipToForm' ].submit();
	}
  }    

  function confirmSetDefaultShipping(){
    {
	  document.forms[ 'shipToForm' ].action = 'data/setOrderPointDefaultShipTo.cmd'; 
	  document.forms[ 'shipToForm' ].submit();
	}
  }  
  
  function confirmSetDefaultBilling(){
    {
	  document.forms[ 'billToForm' ].action = 'data/setOrderPointDefaultBillTo.cmd'; 
	  document.forms[ 'billToForm' ].submit();
	}
  }    

function saveOrderPoint()
{
  if ( requiredFieldCheck() == 'false' )
  {
  document.orderPointForm.IS_NEW.value = "false";
	document.orderPointForm.submit();
  }
  return;
}

function saveOrderPointAsNew()
{
  if ( requiredFieldCheck() == 'false' )
  {
	document.orderPointForm.IS_NEW.value = "true";
	document.orderPointForm.submit();
  }
  return;
}

function reloadCountryChange()
{
    document.orderPointForm.action = "../../user_admin/user_admin_users/reloadCountryChange.cmd";
    document.orderPointForm.submit();
}

function onActivate()
{
    document.orderPointForm.action = "data/activateOrderPoint.cmd";
    document.orderPointForm.submit();
}

function onDeactivate()
{
    document.orderPointForm.action = "data/deactivateOrderPoint.cmd";
    document.orderPointForm.submit();
}


function onActivateLocal()
{
    document.localOrderPointForm.action = "data/activateLocalOrderPoint.cmd";
    document.localOrderPointForm.submit();
}

function onDeactivateLocal()
{
    document.localOrderPointForm.action = "data/removeLocalOrderPoint.cmd";
    document.localOrderPointForm.submit();
}
