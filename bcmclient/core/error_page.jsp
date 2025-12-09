<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/system/tld/xrequest.tld" prefix="x2" %>
<%@ taglib uri="/WEB-INF/system/tld/i2uitaglib.tld" prefix="i2" %>
<%@ taglib uri="/WEB-INF/system/tld/i18n.tld" prefix="i18n" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<i2:xslt xslfile="xsl/error_page.xsl">
  <x2:execute command="core.error:load" />     
</i2:xslt>  
