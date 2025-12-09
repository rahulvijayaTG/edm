<%@ include file="/bcm/framework/headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>User Admin Content</title>
    <script LANGUAGE="JavaScript">
       function setfocus()
       {
          document.termsSearchForm.KEYWORDS.focus();
       }
		function clear()
		{
			parent.location="user_admin_terms.jsp";
		}

		function saveAs()
		{
			if ( validate() == true )
			{
				document.termsForm.action="addSystemTerms.cmd";
				document.termsForm.submit();
			}
			return;
		}

		function save()
		{
			if ( validateID() == true && validate() == true )
			{
				document.termsForm.action="updateSystemTerms.cmd";
				document.termsForm.submit();
			}
			return;
		}

   		function deleteTerm()
            {
            if ( validateID() == true )
            {
                document.termsForm.action="deleteSystemTerms.cmd";
                document.termsForm.submit();
                clear();
            }
            return;
            }

		function validate()
		{
			var errMsg = "Please fill the following manadatory fields ";
			errMsg += "\n";
			var bError = false;

            if (document.termsForm.DESCRIPTION.value == "")
				{
					errMsg += " - Description \n";
					bError = true;
				}

            if (document.termsForm.DUE_DAYS.value == "")
				{
					errMsg += " - Due Days \n";
					bError = true;
				}

            if (document.termsForm.NAME.value == "")
				{
					errMsg += " - Name \n";
					bError = true;
				}

            if (document.termsForm.SELLING_ORG_ID.value == "")
				{
					errMsg += " - Selling Organization \n";
					bError = true;
				}

            if (document.termsForm.DISCOUNT_PERCENT.value == "")
				{
					errMsg += " - Discount Percentage \n";
					bError = true;
				}

            if (document.termsForm.DISCOUNT_DAYS.value == "")
				{
					errMsg += " - Discount Due Days \n";
					bError = true;
				}

            if (document.termsForm.START_DAY.value == "")
				{
					errMsg += " - Start Day \n";
					bError = true;
				}

			if(bError == true)
			{
				alert(errMsg);
				return false;
			}

			return true;
		}

   		function validateID()
   		{
            var errMsg = "Invalid Field ";
            errMsg += "\n";
            var bError = false;

            if (document.termsForm.ID.value == "")
            {
                errMsg += " - ID \n";
                bError = true;
            }

            if(bError == true)
            {
                alert(errMsg);
                return false;
            }

            return true;
   		}
    </script>
  </head>

  <body  class="contentFrameBody" onFocus="checkForPopUps()" onKeyDown="mappedKeyCheck()" onLoad="javascript:setfocus()">
	    <!-- Tabbed Container -->
        <i2:xslt xslfile="xsl/user_admin_terms.xsl"><xrequest:batch>
        <xrequest:executeCommand name="getUserAdminLinks">
	          <PAGE Value="user_admin_terms"/>
	          <SUB_PAGE Value="terms"/>
              </xrequest:executeCommand>
              <xrequest:executeCommand name="getUserAdminTermsSearchTypes"/>
              <xrequest:executeCommand name="getUserAdminTerms"/>
          </xrequest:batch>
	    </i2:xslt>


  </body>
</html>