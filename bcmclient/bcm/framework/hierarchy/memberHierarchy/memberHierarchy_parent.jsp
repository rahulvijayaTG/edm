<%@ include file="/bcm/framework/headerinclude.jsp" %>
<i2:stylesheet path="/mdm_core.css"></i2:stylesheet>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>Parent</title>
  </head>

  <body onLoad="onLoad();" onkeypress="IEEnterKey();">

  <i2:xslt xslfile="$xsl:memberHierarchy_parent">
    <x2:execute command="bcm.framework.hierarchy.memberHierarchy.memberHierarchyView:load_parent"/>
  </i2:xslt>

    </body>
</html>
