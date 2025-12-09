<%@ include file="/core/include_header.jsp" %>
<%@ include file="/bcm/framework/include_dbformfilter.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<i2:xslt xslfile="$xsl:dataValidationErrorDetail">
  <x2:execute command="bcm.framework.alerts.data_validation_summary.data_validation_error_details.dataValidationErrorDetailView:load"/>
</i2:xslt> 

