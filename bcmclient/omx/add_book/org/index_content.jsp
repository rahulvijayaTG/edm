<%@ include file="../../headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>Enterprise Address Book</title>

<script type="text/javascript">

    function setfocus()
    {
      if ( document.org_form )
       document.org_form.ORG_SEARCH_CRITERIA.focus();
    }

</script>



</head>

<body class="contentFrameBody" onLoad="javascript:setfocus()">

      <i2:xslt xslfile="xsl/orgList.xsl"><x2:execute command="omx.add_book.org.index:getPageData"/>
      </i2:xslt>
</body>
</html>
