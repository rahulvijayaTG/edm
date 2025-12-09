<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<i2:xslt xslfile="$xsl:createFavorite">
	<x2:execute command="bcm.framework.favorites.createView:load"/>
</i2:xslt>
<x2:execute command="bcm.framework.favorites.createView:load"/>