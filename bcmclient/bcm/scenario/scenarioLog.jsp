<%@ include file="/core/include_header.jsp" %>
<%@ include file="/bcm/framework/include_dbformfilter.jsp" %>

<i2:xslt xslfile="$xsl:scenarioLog">
  <x2:execute command="bcm.scenario.viewScenarioLog:load"/>
</i2:xslt>
