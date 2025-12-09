<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<i2:xslt xslfile="$xsl:outboundStagingRefreshPage">
  <x2:execute command="bcm.outboundStaging.view:load"/>
</i2:xslt>
