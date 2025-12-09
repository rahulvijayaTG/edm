<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>Search</title>

<%@ include file="/core/include_header.jsp" %>
<%@ include file="/core/include_css.jsp" %>

	  <i2:javascript path="/searchformfilter.js"></i2:javascript>
	  <i2:javascript path="/calendar.js"></i2:javascript>



  </head>

      <i2:xslt xslfile="$xsl:dbformfilter">
        <x2:execute command="bcm.framework.queryform.dbformfilter.view:load"/>
      </i2:xslt>

</html>










