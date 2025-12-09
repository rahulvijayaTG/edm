<%@ include file="/core/include_header.jsp" %>
<%@ include file="/bcm/framework/include_dbformfilter.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">



<i2:xslt xslfile="$xsl:horizonRefDetail">
<x2:execute command="bcm.framework.hierarchy.timeHierarchy.view:load"/>
</i2:xslt>





