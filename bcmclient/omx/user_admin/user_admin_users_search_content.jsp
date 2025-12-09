<%@ include file="/bcm/framework/headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>User Admin Content</title>
		<script type="text/javascript" src="../saved_trans/search_transactions.js"></script>
    <script type="text/javascript">


    function IEEnterKey()
		{
    	if(window.event.keyCode == 13)
			{
				document.search_form.DO_SEARCH.value='Yes';
				document.search_form.submit();
     	}
    }

    function NetEnterKey(e)
		{
    	key = e.which;
     	if(key == 13)
			{
				document.search_form.DO_SEARCH.value='Yes';
				document.search_form.submit();
			}
    }

    browserName = navigator.appName;

    if (browserName == "Netscape")
		{
    	document.captureEvents(Event.KEYPRESS);
     	document.onkeypress=NetEnterKey;
		}
    else
		{
			if (browserName.indexOf("Explorer") >= 0)
			{
      	document.onkeypress=IEEnterKey;}
	    }
		</script>

		<script type="text/javascript">
 		function sendemail()
 		{
              var first = true
              var line = "mailto:"
              var f = document.resultForm
              for ( var i = 0; i < f.length; ++i )
              {
                var e = f.elements[i]
                var name = e.name
                if ( name.search( "EMAIL_" ) == 0 )
                {
                  if ( e.checked )
                  {
                    var addr = e.value
                    if ( !isBlank( addr ) )
                    {
                      if ( !first )
                        line += ";"
                      else
                        first = false
                      line += addr
                    }
                  }
                }
              }

              // was anything selected?
              if ( !first )
                parent.location = line
              else
                omx_alert( "You must first select something" )
    		}

            function isBlank(s)
            {
              for ( var i = 0; i < s.length; ++i )
              {
                var c = s.charAt(i)
                if ( c != ' ' )
                  return false
              }
              return true;
   }

		function initUsersTable()
		{

		  if (!document.layers)
  	  {

        // scroller + left margin + right margin = 16 + 10 + 10 = 36
        var x = document.body.scrollWidth - 15;


         i2uiResizeScrollableArea('usersTable',200,x,null,20);
         i2uiResizeColumns('usersTable');
				}
		}

		function onresize()
		{
			 initUsersTable();

		}
		function onload()
		{
			initUsersTable();
		}

		</script>


  </head>

  <body onload="onload()" onresize="onresize()" class="contentFrameBody" onFocus="checkForPopUps()" onKeyDown="mappedKeyCheck()">

	    <!-- Tabbed Container -->
	    <i2:xslt xslfile="xsl/user_admin_users_search.xsl">
          <x2:execute command="omx.user_admin.users_admin_users_search:loadUserAdminUsersSearch"/>
	    </i2:xslt>
         <i2:popupmenu name="sortOrder">
			<i2:popupmenuoption text="Ascending" url="javascript:sortOrder('Ascending')"></i2:popupmenuoption>
			<i2:popupmenuoption text="Descending" url="javascript:sortOrder('Descending')"></i2:popupmenuoption>
		</i2:popupmenu>
  </body>
</html>