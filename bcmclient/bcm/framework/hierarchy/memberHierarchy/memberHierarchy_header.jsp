<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>Parent</title>
  </head>

  <body>
  
    <i2:xslt xslfile="$xsl:memberHierarchy_header">
	      <x2:execute command="bcm.framework.hierarchy.memberHierarchy.memberHierarchyView:load_header"/>
    </i2:xslt>

    </body>
</html>
