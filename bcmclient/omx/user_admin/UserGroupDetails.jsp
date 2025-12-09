<%@ include file="/core/include_header.jsp" %>
<i2:javascript path="/hashtable.js"/>

<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<i2:xslt xslfile="$xsl:user_group_details">
	<x2:execute command="omx.user_admin.user_group_details:load"/>
</i2:xslt>