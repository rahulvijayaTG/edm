<%@ include file="/core/include_header.jsp" %>
<%@ include file="/bcm/framework/include_dbformfilter.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<i2:xslt xslfile="$xsl:user_admin_group_search">
	<x2:execute command="omx.user_admin.user_group_search:load"/>
</i2:xslt>