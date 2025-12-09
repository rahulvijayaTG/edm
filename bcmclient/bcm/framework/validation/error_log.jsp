<%@ include file="/core/include_header.jsp" %>
<%@ include file="/bcm/framework/include_dbformfilter.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<i2:xslt xslfile="$xsl:document_error_log">
  <x2:execute command="bcm.framework.validation.doc_error:load"/>
</i2:xslt>

