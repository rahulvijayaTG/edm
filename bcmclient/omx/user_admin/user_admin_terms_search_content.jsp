<%@ include file="/bcm/framework/headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>User Admin Content</title>
    <script type="text/javascript">
		function sort(keywords, searchby, sortby)
		{
			document.termsSearchForm.reset();
			document.termsSearchForm.SORT_BY.value=sortby;
			document.termsSearchForm.KEYWORDS.value=keywords;
			document.termsSearchForm.SEARCH_BY.value=searchby;
			document.termsSearchForm.submit();
		}

           function setfocus()
           {
              document.termsSearchForm.KEYWORDS.focus();
           }

    		function clear()
    		{
    			parent.location="user_admin_terms.jsp";
    		}
		</script>
  </head>

  <body  class="contentFrameBody"  class="contentFrameBody" onFocus="checkForPopUps()" onKeyDown="mappedKeyCheck()" onLoad="javascript:setfocus()">
	    <!-- Tabbed Container -->
	    <i2:xslt xslfile="xsl/user_admin_terms_search.xsl"><xrequest:batch>
	        <xrequest:executeCommand name="getUserAdminLinks">
	          <PAGE Value="user_admin_terms"/>
	          <SUB_PAGE Value="terms_search"/>
	        </xrequest:executeCommand>
            <xrequest:executeCommand name="getUserAdminTermsSearchTypes"/>
	        <xrequest:executeCommand name="getUserAdminTermsSearch"/>
          </xrequest:batch>
	    </i2:xslt>
  </body>
</html>