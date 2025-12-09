<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<i2:xslt xslfile="$xsl:select_payment_term">
  <x2:execute command ="omx.add_book.org.select.payment_term.view:load" />
</i2:xslt>