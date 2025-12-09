<%@ include file="/core/include_header.jsp" %>
<%@ include file="/bcm/framework/include_dbformfilter.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<i2:xslt xslfile="$xsl:domain_nodes_result">
	<x2:execute command="omx.user_admin.domain_nodes_search:loadResult"/>
</i2:xslt>