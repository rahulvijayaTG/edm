<%@ include file="/core/include_header.jsp" %>
<%@ include file="/bcm/framework/include_dbformfilter.jsp" %>


<i2:xslt xslfile="$xsl:scenarioSearch">
  <x2:execute command="bcm.scenario.viewScenarios:load"/>
</i2:xslt>
