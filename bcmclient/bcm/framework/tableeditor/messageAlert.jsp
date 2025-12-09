<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <%@ include file="/core/include_header.jsp" %>
    <%@ include file="/core/include_css.jsp" %>
     <SCRIPT LANGUAGE="JavaScript">
        function onLoad()
               {
              document.message_form.message.value =window.opener.document.displayMessage.message.value;
               resize_Containers();
               }


       </SCRIPT>
 </head> 
 <body onLoad="javascript:onLoad()">
 
 
<i2:container>
			<table height="100%" width="100%" scrollable="yes" resizable="yes">
			    <form name="message_form" method="post">

				<tr>
					<td>
					 

					  <TEXTAREA  fieldtype="TEXTAREA" name="message" type="TEXTAREA"  tabIndex="" class="inputfieldIE" COLS="50" ROWS="25" resizable="yes" readonly="yes">
					
					  </TEXTAREA>
                                        </td>
				</tr>
				  </form>

			</table>
			
			   <i2:footer>
			      <table cellspacing="0" cellpadding="0" width="100%" border="0">
			        <tr>
			          <td>
			                <i2:buttonbar>
				       		    <i2:button onclick="javascript:onClose()"><i18n:text>Close</i18n:text></i2:button>
				         		 
		                        </i2:buttonbar>
			          </td>
			        </tr>
			      </table>
    </i2:footer> </i2:container> </body>
			</html>	
	




