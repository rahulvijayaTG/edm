<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">

  <xsl:import href="../../xsl/code_master.xsl"/>
  <xsl:import href="../../../core/xsl/validation.xsl"/>
  <!--<xsl:import href="../../xsl/required_field.xsl"/>-->
  <xsl:output method="html"/>
  <xsl:template match="RESPONSE">
    <xsl:param name="page"/>
    <xsl:param name="entityType"/>
    <xsl:param name="entityId"/>
    <xsl:call-template name="include_grouping_javascript"/>


    <table width="100%" height="100%" cellspacing="1" border="0">
      <form name="buyingLimitsForm" method="POST" target="appFrame">
        <input type="hidden" name="PAGE" value="{$page}"/>
        <input type="hidden" name="ENTITY_ID" value="{$entityId}"/>
        <input type="hidden" name="ENTITY_TYPE" value="{$entityType}"/>
        <input type="hidden" name="ORG_ID" value="{ORG_ID/@Value}"/>
        <input type="hidden" name="ORDER_POINT_ID" value="{LOCAL_ORDER_POINT/ORDER_POINT_ID/@Value}"/>
        <tr>
          <td height="100%" width="100%" colspan="3">
            <xsl:variable name="caption_title">
              <xsl:choose>
                <xsl:when test="$entityType = 'Org'">
                  <i18n:text>Buying Limits for Organization</i18n:text>
                </xsl:when>
                <xsl:when test="$entityType = 'OP'">
                  <i18n:text>Buying Limits for Order Point</i18n:text>
                </xsl:when>
              </xsl:choose>
            </xsl:variable>
            <i2:container title="{$caption_title}" inner="yes" stretch="yes">
              <xsl:call-template name="display_instruction_area">
                <xsl:with-param name="pFormName" select="'buyingLimitsForm'"/>
                <xsl:with-param name="pAnyFieldIsRequired" select="'true'"/>
                <xsl:with-param name="pErrorMessage" select="ERROR_MESSAGE/@Value"/>
                <xsl:with-param name="pSuccessMessage" select="SUCCESS_MESSAGE/@Value"/>
              </xsl:call-template>
              <table border="0" cellpadding="0" cellspacing="5" width="100%">
                <tr class="text">
                  <td nowrap="nowrap">
                    <i18n:text>Transaction Limit</i18n:text>
                    <xsl:text>:</xsl:text>
                    <xsl:call-template name="display_alert_mark"/>
                  </td>
                  <td nowrap="nowrap">
                    <xsl:variable name="transactionLimit">
                      <xsl:choose>
                        <xsl:when test="$entityType = 'Org'">
                          <i18n:currency>
                            <xsl:value-of select="LOCAL_CUSTOMER/TRANSACTION_BUYING_LIMIT/@Value"/>
                          </i18n:currency>
                        </xsl:when>
                        <xsl:when test="$entityType = 'OP'">
                          <i18n:currency>
                            <xsl:value-of select="LOCAL_ORDER_POINT/TRANSACTION_BUYING_LIMIT/@Value"/>
                          </i18n:currency>
                        </xsl:when>
                      </xsl:choose>
                    </xsl:variable>
                    <input type="field" name="TRANSACTION_BUYING_LIMIT_CY" value="{$transactionLimit}" groupid="1" required="true" tabIndex="" class="inputfieldIE" maxlength="16" size="10" onkeyup="javascript:onlyCurrency();"/>&#xA0;
                    <i18n:text>
                      <xsl:value-of select="CURRENCY_CODE/@Value"/>
                    </i18n:text>
                    <xsl:call-template name="display_alert_image">
                      <xsl:with-param name="fieldName" select="'TRANSACTION_BUYING_LIMIT_CY'"/>
                    </xsl:call-template>
                  </td>
                  <td nowrap="nowrap">
                    <i18n:text>Status</i18n:text>
                    <xsl:text>:</xsl:text>
                  </td>
                  <td nowrap="nowrap">
                    <select class="inputfieldIE" name="TRANSACTION_BUYING_LIMIT_STATUS" tabindex="">
                      <option value="ACTIVE">
                        <xsl:choose>
                          <xsl:when test="$entityType = 'Org'">
                            <xsl:if test="LOCAL_CUSTOMER/TRANSACTION_BUYING_LIMIT_STATUS/@Value = 'ACTIVE'">
                              <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                          </xsl:when>
                          <xsl:when test="$entityType = 'OP'">
                            <xsl:if test="LOCAL_ORDER_POINT/TRANSACTION_BUYING_LIMIT_STATUS/@Value = 'ACTIVE'">
                              <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                          </xsl:when>
                        </xsl:choose>
                        <i18n:text>Active</i18n:text>
                      </option>
                      <option value="INACTIVE">
                        <xsl:choose>
                          <xsl:when test="$entityType = 'Org'">
                            <xsl:if test="LOCAL_CUSTOMER/TRANSACTION_BUYING_LIMIT_STATUS/@Value = 'INACTIVE'">
                              <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                          </xsl:when>
                          <xsl:when test="$entityType = 'OP'">
                            <xsl:if test="LOCAL_ORDER_POINT/TRANSACTION_BUYING_LIMIT_STATUS/@Value = 'INACTIVE'">
                              <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                          </xsl:when>
                        </xsl:choose>
                        <i18n:text>Inactive</i18n:text>
                      </option>
                    </select>
                  </td>
                </tr>
                <tr class="text">
                  <td nowrap="nowrap">
                    <i18n:text>Periodic Limit</i18n:text>
                    <xsl:text>:</xsl:text>
                    <xsl:call-template name="display_alert_mark"/>
                  </td>
                  <td nowrap="nowrap">
                    <xsl:variable name="periodicLimit">
                      <xsl:choose>
                        <xsl:when test="$entityType = 'Org'">
                          <i18n:currency>
                            <xsl:value-of select="LOCAL_CUSTOMER/PERIODIC_BUYING_LIMIT/@Value"/>
                          </i18n:currency>
                        </xsl:when>
                        <xsl:when test="$entityType = 'OP'">
                          <i18n:currency>
                            <xsl:value-of select="LOCAL_ORDER_POINT/PERIODIC_BUYING_LIMIT/@Value"/>
                          </i18n:currency>
                        </xsl:when>
                      </xsl:choose>
                    </xsl:variable>
                    <input type="field" name="PERIODIC_BUYING_LIMIT_CY" value="{$periodicLimit}" groupid="3" required="true" tabIndex="" class="inputfieldIE" maxlength="16" size="10" onkeyup="javascript:onlyCurrency();"/>&#xA0;
                    <i18n:text>
                      <xsl:value-of select="CURRENCY_CODE/@Value"/>
                    </i18n:text>
                    <xsl:call-template name="display_alert_image">
                      <xsl:with-param name="fieldName" select="'PERIODIC_BUYING_LIMIT_CY'"/>
                    </xsl:call-template>
                  </td>
                  <td nowrap="nowrap">
                    <i18n:text>Status</i18n:text>
                    <xsl:text>:</xsl:text>
                  </td>
                  <td nowrap="nowrap">
                    <select class="inputfieldIE" name="PERIODIC_BUYING_LIMIT_STATUS" tabindex="">
                      <option value="ACTIVE">
                        <xsl:choose>
                          <xsl:when test="$entityType = 'Org'">
                            <xsl:if test="LOCAL_CUSTOMER/PERIODIC_BUYING_LIMIT_STATUS/@Value = 'ACTIVE'">
                              <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                          </xsl:when>
                          <xsl:when test="$entityType = 'OP'">
                            <xsl:if test="LOCAL_ORDER_POINT/PERIODIC_BUYING_LIMIT_STATUS/@Value = 'ACTIVE'">
                              <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                          </xsl:when>
                        </xsl:choose>
                        <i18n:text>Active</i18n:text>
                      </option>
                      <option value="INACTIVE">
                        <xsl:choose>
                          <xsl:when test="$entityType = 'Org'">
                            <xsl:if test="LOCAL_CUSTOMER/PERIODIC_BUYING_LIMIT_STATUS/@Value = 'INACTIVE'">
                              <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                          </xsl:when>
                          <xsl:when test="$entityType = 'OP'">
                            <xsl:if test="LOCAL_ORDER_POINT/PERIODIC_BUYING_LIMIT_STATUS/@Value = 'INACTIVE'">
                              <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                          </xsl:when>
                        </xsl:choose>
                        <i18n:text>Inactive</i18n:text>
                      </option>
                    </select>
                  </td>
                </tr>
                <tr class="text">
                  <td nowrap="nowrap">
                    <i18n:text>Period</i18n:text>
                    <xsl:text>:</xsl:text>
                  </td>
                  <td nowrap="nowrap">
                    <xsl:variable name="period">
                      <xsl:choose>
                        <xsl:when test="$entityType = 'Org'">
                          <i18n:text>
                            <xsl:value-of select="LOCAL_CUSTOMER/PERIOD/@Value"/>
                          </i18n:text>
                        </xsl:when>
                        <xsl:when test="$entityType = 'OP'">
                          <i18n:text>
                            <xsl:value-of select="LOCAL_ORDER_POINT/PERIODIC_BUYING_LIMIT_DURATION/@Value"/>
                          </i18n:text>
                        </xsl:when>
                      </xsl:choose>
                    </xsl:variable>
                    <select class="inputfieldIE" name="PERIODIC_BUYING_LIMIT_DURATION" tabIndex="">
                      <xsl:apply-templates select="/RESPONSES/RESPONSE/PERIODS/CODE_MASTER_VALUE" mode="pulldown_ids">
                        <xsl:with-param name="selectedId" select="$period"/>
                      </xsl:apply-templates>
                    </select>
                  </td>
                </tr>
                <tr class="text">
                  <td nowrap="nowrap">
                    <i18n:text>Period Start Date</i18n:text>
                    <xsl:text>:</xsl:text>
                    <xsl:call-template name="display_alert_mark"/>
                  </td>
                  <td nowrap="nowrap">
                    <xsl:variable name="periodStartDate">
                      <xsl:choose>
                        <xsl:when test="$entityType = 'Org'">
                          <i18n:date format="common">
                            <xsl:value-of select="LOCAL_CUSTOMER/PERIODIC_BUYING_LIMIT_START_DATE/@Value"/>
                          </i18n:date>
                        </xsl:when>
                        <xsl:when test="$entityType = 'OP'">
                          <i18n:date format="common">
                            <xsl:value-of select="LOCAL_ORDER_POINT/PERIODIC_BUYING_LIMIT_START_DATE/@Value"/>
                          </i18n:date>
                        </xsl:when>
                      </xsl:choose>
                    </xsl:variable>
                    <input type="field" class="inputfieldIE" groupid="3" name="PERIODIC_BUYING_LIMIT_START_DATE_DC" value="{$periodStartDate}" size="15" tabIndex="" required="true"/>&#xA0;
                    <A HREF="javascript:doNothing()" onclick="showCalendar(document.buyingLimitsForm.PERIODIC_BUYING_LIMIT_START_DATE_DC);" target="appFrame">
                      <i2:img src="/cal_icon.gif" border="0" align="center"/>
                    </A>
                    <xsl:call-template name="display_alert_image">
                      <xsl:with-param name="fieldName" select="'PERIODIC_BUYING_LIMIT_START_DATE_DC'"/>
                    </xsl:call-template>
                  </td>
                </tr>
              </table>
            </i2:container>
          </td>
        </tr>
        <xsl:if test="$entityType = 'Org'">
          <tr>
            <td width="100%">
              <xsl:variable name="caption_title">
                <i18n:text>Buying Limits for Payment Methods</i18n:text>
              </xsl:variable>
              <i2:container title="{$caption_title}" id="buying_container" inner="yes">
                <i2:table id="paymentMethodTable" width="100%" height="100%" scrollablerows="yes" scrollablecolumns="auto">
                  <i2:tr header="yes">
                    <td nowrap="yes">
                      <i18n:text>Payment Method</i18n:text>
                    </td>
                    <td nowrap="yes">
                      <i18n:text>Transaction Limit</i18n:text>/<i18n:text>Status</i18n:text>
                      <xsl:call-template name="display_alert_mark"/>
                    </td>
                    <td nowrap="yes">
                      <i18n:text>Periodic Limit</i18n:text>/<i18n:text>Status</i18n:text>
                      <xsl:call-template name="display_alert_mark"/>
                    </td>
                    <td nowrap="yes">
                      <i18n:text>Period</i18n:text>
                    </td>
                    <td nowrap="yes">
                      <i18n:text>Period Start Date</i18n:text>
                      <xsl:call-template name="display_alert_mark"/>
                    </td>
                  </i2:tr>
                  <xsl:apply-templates select="PAYMENT_METHODS/PAYMENT_METHOD"/>
                </i2:table>
              </i2:container>
            </td>
          </tr>
        </xsl:if>
        <script type="text/javascript">
          requiredFieldCheck('onLoad');
        </script>
      </form>
    </table>
  </xsl:template>
  <xsl:template match="PAYMENT_METHOD">
    <i2:tr>
      <td nowrap="yes">
        <input type="hidden" name="PM_PAYMENT_INST_TYPE" value="{PAYMENT_INST_TYPE/@Value}"/>
        <i18n:text>
          <xsl:value-of select="PAYMENT_INST_DESCRIPTION/@Value"/>
        </i18n:text>
      </td>
      <td nowrap="yes">
        <xsl:variable name="transactionLimit">
          <i18n:currency>
            <xsl:value-of select="PAYMENT_INSTRUMENT_BUYING_LIMIT/TRANSACTION_BUYING_LIMIT/@Value"/>
          </i18n:currency>
        </xsl:variable>
        <input type="field" name="PM_TRANSACTION_BUYING_LIMIT_CY" value="{$transactionLimit}" tabIndex="" groupid="2" class="inputfieldIE" maxlength="16" size="10" required="true" onkeyup="javascript:onlyCurrency();"/>
        <xsl:call-template name="display_alert_image">
          <xsl:with-param name="fieldName" select="'PM_TRANSACTION_BUYING_LIMIT_CY'"/>
        </xsl:call-template>
        &#xA0;
        <i18n:text>
          <xsl:value-of select="../../CURRENCY_CODE/@Value"/>
        </i18n:text>&#xA0;

        <select class="inputfieldIE" name="PM_TRANSACTION_BUYING_LIMIT_STATUS" tabindex="">
          <option value="ACTIVE">
            <xsl:if test="PAYMENT_INSTRUMENT_BUYING_LIMIT/TRANSACTION_BUYING_LIMIT_STATUS/@Value = 'ACTIVE'">
              <xsl:attribute name="selected">selected</xsl:attribute>
            </xsl:if>
            <i18n:text>Active</i18n:text>
          </option>
          <option value="INACTIVE">
            <xsl:if test="PAYMENT_INSTRUMENT_BUYING_LIMIT/TRANSACTION_BUYING_LIMIT_STATUS/@Value = 'INACTIVE'">
              <xsl:attribute name="selected">selected</xsl:attribute>
            </xsl:if>
            <i18n:text>Inactive</i18n:text>
          </option>
        </select>
      </td>
      <td nowrap="yes">
        <xsl:variable name="periodicLimit">
          <i18n:currency>
            <xsl:value-of select="PAYMENT_INSTRUMENT_BUYING_LIMIT/PERIODIC_BUYING_LIMIT/@Value"/>
          </i18n:currency>
        </xsl:variable>
        <input type="field" name="PM_PERIODIC_BUYING_LIMIT_CY" value="{$periodicLimit}" tabIndex="" groupid="4" class="inputfieldIE" maxlength="16" size="10" required="true" onkeyup="javascript:onlyCurrency();"/>
        <xsl:call-template name="display_alert_image">
          <xsl:with-param name="fieldName" select="'PM_PERIODIC_BUYING_LIMIT_CY'"/>
        </xsl:call-template>
        &#xA0;
        <i18n:text>
          <xsl:value-of select="../../CURRENCY_CODE/@Value"/>
        </i18n:text>&#xA0;

        <select class="inputfieldIE" name="PM_PERIODIC_BUYING_LIMIT_STATUS" tabindex="">
          <option value="ACTIVE">
            <xsl:if test="PAYMENT_INSTRUMENT_BUYING_LIMIT/PERIODIC_BUYING_LIMIT_STATUS/@Value = 'ACTIVE'">
              <xsl:attribute name="selected">selected</xsl:attribute>
            </xsl:if>
            <i18n:text>Active</i18n:text>
          </option>
          <option value="INACTIVE">
            <xsl:if test="PAYMENT_INSTRUMENT_BUYING_LIMIT/PERIODIC_BUYING_LIMIT_STATUS/@Value = 'INACTIVE'">
              <xsl:attribute name="selected">selected</xsl:attribute>
            </xsl:if>
            <i18n:text>Inactive</i18n:text>
          </option>
        </select>
      </td>
      <td nowrap="yes">
        <select class="inputfieldIE" name="PM_PERIODIC_BUYING_LIMIT_DURATION" tabIndex="">
          <xsl:apply-templates select="/RESPONSES/RESPONSE/PERIODS/CODE_MASTER_VALUE" mode="pulldown_ids">
            <xsl:with-param name="selectedId">
              <xsl:value-of select="PAYMENT_INSTRUMENT_BUYING_LIMIT/PERIODIC_BUYING_LIMIT_DURATION/@Value"/>
            </xsl:with-param>
          </xsl:apply-templates>
        </select>
      </td>
      <td nowrap="yes">
        <xsl:variable name="periodStartDate">
          <i18n:date format="common">
            <xsl:value-of select="PAYMENT_INSTRUMENT_BUYING_LIMIT/PERIODIC_BUYING_LIMIT_START_DATE/@Value"/>
          </i18n:date>
        </xsl:variable>
        <input type="field" groupid="4" class="inputfieldIE" name="PM_PERIODIC_BUYING_LIMIT_START_DATE_DC" value="{$periodStartDate}" size="15" tabIndex="" required="true"/>&#xA0;
        <A HREF="javascript:doNothing()" onclick="showCalendar(document.buyingLimitsForm.PM_PERIODIC_BUYING_LIMIT_START_DATE_DC[{position()-1}])" target="appFrame">
          <i2:img src="/cal_icon.gif" border="0" align="center"/>
        </A>
        <xsl:call-template name="display_alert_image">
          <xsl:with-param name="fieldName" select="'PM_PERIODIC_BUYING_LIMIT_START_DATE_DC'"/>
        </xsl:call-template>
      </td>
    </i2:tr>
  </xsl:template>
  <xsl:template name="include_grouping_javascript">
    <script type="text/javascript">
      function checkgroups(nform)
      {
        var i, j, k;        
        var groupElementHasValue = false;
        var groupElement3HasValue = false;
        var groupidFound = false;
      
        var formName = nform;
      
        // for each form
        for( j = 0; j &lt; document.forms.length; j++)
        {
          var formObj = document.forms[j];
          var currentformName = formObj.name;
          // if form name is passed
          // do validation for that 
          // else do for all forms
          if (formName != null &amp;&amp; formName != "")
          {
            if (currentformName != formName)
              continue;
          }
        
          var elementsLen = formObj.elements.length;
          
          for(i = 0; i &lt; elementsLen; i++)
          {
            var elem = document.forms[j].elements[i];
            if (elem.groupid == '1' || elem.groupid == '2' || elem.groupid == '3' || elem.groupid == '4')
            {
              elem.required = "true";
            }
          }


          // for each element in the form
          // first loop to check group id of 1
          for(i = 0; i &lt; elementsLen; i++)
          {
            var elem = document.forms[j].elements[i];
            if (elem.groupid == '1')
            {
              var elemValue = trimString(elem.value);
            
              if (elemValue != '')
                groupElementHasValue = true;
            }
            if (elem.groupid == '2')
              groupidFound = true;
          }

          var count = 0;
          for(i = 0; i &lt; elementsLen; i++)
          {
            var elem = document.forms[j].elements[i];            
            if (elem.groupid == '3')
            {
              var elemValue = trimString(elem.value);
              count++;
              if ((elemValue != '') &amp;&amp; (groupElement3HasValue == false))
              {
                if (count == 1)
                  groupElement3HasValue = true;
                if (count == 2)
                  groupElement3HasValue = false;
              }
              if ((elemValue != '') &amp;&amp; (groupElement3HasValue == true))
              {
                if (count == 1 || count == 2)
                {
                  groupElement3HasValue = true;
                  groupElementHasValue = true;
                }
              }
              if (elemValue == '')
              {                
                if (count == 1)
                  groupElement3HasValue = false;
                else if ((count == 2 &amp;&amp; groupElement3HasValue == false) &amp;&amp; groupElementHasValue == true)
                  groupElement3HasValue = true;
                else if ((count == 2 &amp;&amp; groupElement3HasValue == false) &amp;&amp; groupElementHasValue == false)
                  groupElement3HasValue = false;
                else if (count == 2 &amp;&amp; groupElement3HasValue == true)
                  groupElement3HasValue = false;
              }
            }
          }

          if(groupElementHasValue == false &amp;&amp; groupElement3HasValue == false)
          {

            // first loop to check group id of 2 and 4
            if (groupidFound == true)
            {

              var valuesFound = false;
              var wentInsideLoop = false;
              for (k = 0; k &lt; 4; k++)
              {
                var tlimit = document.forms[j].PM_TRANSACTION_BUYING_LIMIT_CY[k];
                var plimit = document.forms[j].PM_PERIODIC_BUYING_LIMIT_CY[k];
                var pstartDate = document.forms[j].PM_PERIODIC_BUYING_LIMIT_START_DATE_DC[k];
                var tlimitValue = trimString(tlimit.value);
                var plimitValue = trimString(plimit.value);
                var pstartDateValue = trimString(pstartDate.value);

                if ((tlimitValue == '' &amp;&amp; plimitValue == '') &amp;&amp; pstartDateValue == '')
                {
                  groupElementHasValue = false;
                  groupElement3HasValue = false;
                  wentInsideLoop = true;
                }
                else if (tlimitValue != '')
                {
                  tlimit.required = "true";
                  plimit.required = '';
                  pstartDate.required = '';
                  valuesFound = true;
                  //validation_clearImages(currentformName);
                }
                else if (plimitValue != '' || pstartDateValue != '')
                {
                  tlimit.required = '';
                  plimit.required = "true";
                  pstartDate.required = "true";
                  valuesFound = true;
                  //validation_clearImages(currentformName);
                }
              }

              if (valuesFound == true &amp;&amp; wentInsideLoop == false)
              {
                groupElementHasValue = true; 
                groupElement3HasValue = true;
              }
            }
          }

          if(groupElementHasValue == true &amp;&amp; groupElement3HasValue == true)
          {
            // for each element in the form
            for(i = 0; i &lt; elementsLen; i++)
            {
              var elem = document.forms[j].elements[i];
              if (elem.groupid == '1' || elem.groupid == '2' || elem.groupid == '3' || elem.groupid == '4')
              {
                elem.required = '';
                //validation_clearImages(currentformName);
              }
            }
          }

          // checking if any value is entered in the elements with group id of 4 and make that row required
          if (groupidFound == true)
          {
            // for each element in the form
            if(groupElementHasValue == true || groupElement3HasValue == true)
            {
              for(k = 0; k &lt; 4; k++)
              {
                var tlimit = document.forms[j].PM_TRANSACTION_BUYING_LIMIT_CY[k];
                var plimit = document.forms[j].PM_PERIODIC_BUYING_LIMIT_CY[k];
                var pstartDate = document.forms[j].PM_PERIODIC_BUYING_LIMIT_START_DATE_DC[k];
                var tlimitValue = trimString(tlimit.value);
                var plimitValue = trimString(plimit.value);
                var pstartDateValue = trimString(pstartDate.value);

                if (tlimitValue != '')
                {
                  tlimit.required = "true";
                  plimit.required = '';
                  pstartDate.required = '';
                  //validation_clearImages(currentformName);
                }
                if (plimitValue != '' || pstartDateValue != '')
                {
                  tlimit.required = '';
                  plimit.required = "true";
                  pstartDate.required = "true";
                  //validation_clearImages(currentformName);
                }
              }
            }
          }
        }
        return;
      }
	</script>
  </xsl:template>

</xsl:stylesheet>
