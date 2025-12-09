<%@ include file="/omx/headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>View Buying Limits</title>
<script type="text/javascript" src="../../javascript/calendar.js"></script>
<script type="text/javascript" src="../../javascript/CheckDateTime.js"></script>
<script type="text/javascript">
function save()
{
  if ( requiredFieldCheck() == 'false' )
  {
    
    // validate the numerical fields
    /* replaced with onlyCurrency onKeyup javascript
    
    var elem = buyingLimitsForm.elements.length;

    for (k = 0; k < elem; k++)
    {
      if ( buyingLimitsForm.elements[k].name.indexOf( "LIMIT_CY" ) != -1 )
      {
        if ( checkPositive( buyingLimitsForm.elements[k] ) == false )
        {
          buyingLimitsForm.elements[k].focus();
          omx_alert( "This field must be a positive number" );
          return;
        } 
      }
    }
    */
    document.buyingLimitsForm.action = "data/saveBuyingLimits.cmd";
    document.buyingLimitsForm.submit();
  }
}


function checkPositive(objName)
{
  var checkOK = "0123456789.,";
  var checkStr = objName;
  var allValid = true;
  var decPoints = 0;
  var allNum = "";

  for (i = 0;  i < checkStr.value.length;  i++)
  {
    ch = checkStr.value.charAt(i);
    for (j = 0;  j < checkOK.length;  j++)
      if (ch == checkOK.charAt(j))
        break;
    if (j == checkOK.length)
    {
      allValid = false;
      break;
    }
    if (ch != ",")
      allNum += ch;
  }
  if (!allValid)
  { 
    return false;
  }
  return true;
}


function reset()
{
  parent.location="orgBuyingLimits.jsp?ORG_ID=<%=request.getParameter("ORG_ID")%>";
}

function onLoad()
{
  initTable();
  setFocus();
}

function onResize()
{
  initTable();
}

function initTable()
{    
  if (!document.layers)
  {
    // scroller + left margin + right margin = 16 + 10 + 10 = 36
    var x = document.body.scrollWidth - 22;
  
    i2uiResizeScrollableArea('paymentMethodTable',200,x,null,20);
    i2uiResizeColumns('paymentMethodTable');
  }
}   

function showCalendar(fieldName)
{
  setDateField(fieldName);
}
</script>
</head>

<body class="contentFrameBody" topmargin="0" marginheight="0" onResize="javascript:onResize();" onLoad="javascript:onLoad();">

<i2:xslt xslfile="$xsl:org_buying_limits_xsl">
  <x2:execute command="omx.add_book.org.orgBuyingLimits:getPageData"/>
</i2:xslt>

</body>
</html>
