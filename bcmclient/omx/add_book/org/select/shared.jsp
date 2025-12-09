<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<i2:xslt xslfile="$xsl:select_shared_orgs">
  <x2:execute command ="omx.add_book.org.select.shared.view:load" />
</i2:xslt>