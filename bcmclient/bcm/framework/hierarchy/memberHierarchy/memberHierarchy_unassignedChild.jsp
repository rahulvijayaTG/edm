<%@ include file="/bcm/framework/headerinclude.jsp" %>
<i2:javascript path="/hashtable.js"></i2:javascript>
<i2:stylesheet path="/mdm_core.css"></i2:stylesheet>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <title>MemberHierarchy Un Assigned Childs</title>
  </head>
  <body onLoad="onLoad();" onkeypress="IEEnterKey();">

  <i2:xslt xslfile="$xsl:memberHierarchy_unassignedChild">
    <x2:execute command="bcm.framework.hierarchy.memberHierarchy.memberHierarchyView:load_unassigedChild"/>
  </i2:xslt>

  </body>
</html>
