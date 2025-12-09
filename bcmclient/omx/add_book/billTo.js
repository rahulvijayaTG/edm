function saveBillTo()
{
  if ( validate() == true )
  {
    document.billToForm.IS_NEW.value = "false";
	  document.billToForm.submit();
  }
  return;
}

function saveBillToAsNew()
{
  if ( validate() == true )
  {
	  document.billToForm.IS_NEW.value = "true";
	  document.billToForm.submit();
  }
  return;
}

function validate()
{
/*****
  if ( (document.billToForm.CREDIT_LIMIT_CY.value == "") 
//!!i18n
//        || isNaN(document.billToForm.CREDIT_LIMIT.value) 
     )
    {
//      alert("Credit Limit should be a valid number");
      document.billToForm.CREDIT_LIMIT_CY.focus();
      return;
    }

  if ( (document.billToForm.AR_BALANCE_CY.value == "") 
//       || isNaN(document.billToForm.AR_BALANCE.value) 
     )
    {
//      alert("AR Balance should be a valid number");
      document.billToForm.AR_BALANCE_CY.focus();
      return;
    }
    
  if ( (document.billToForm.AR_DAYS_N0.value == "") 
//        || isNaN(document.billToForm.AR_DAYS.value) 
     )
    {
//      alert("AR Days should be a valid number");
      document.billToForm.AR_DAYS_N0.focus();
      return;
    }
*****/
  return true;
}
