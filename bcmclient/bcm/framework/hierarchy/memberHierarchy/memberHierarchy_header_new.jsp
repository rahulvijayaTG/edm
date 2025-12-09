<%@ include file="/bcm/framework/headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
  <head>
    <title>Member Heirarchy Header</title>
  </head>
  <body topmargin="3" leftmargin="0" marginwidth="0" marginheight="0" class="shellContent" onLoad="initFrameToggleGif('../../')" onFocus="checkForPopUps()" onKeyDown="mappedKeyCheck()">

    <i2:xslt xslfile="$xsl:header">
	      <x2:execute command="bcm.framework.hierarchy.memberHierarchy.memberHierarchyView:load_header_new" />
    </i2:xslt>

  </body>
</html>
