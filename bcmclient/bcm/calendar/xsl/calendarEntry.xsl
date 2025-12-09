<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../../core/xsl/page.xsl"/>
  <xsl:import href="../../framework/xsl/core_container_override.xsl"/>
  <xsl:import href="../../framework/xsl/required_field.xsl"/>
  <xsl:output method="html"/>
  <!-- Page Content -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <xsl:call-template name="include_javascript_calendar_entry"/>
    <xsl:call-template name="include_javascript_calendar"/>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <!-- Container Content -->
  <xsl:template match="RESPONSE" mode="container_content">
    <!-- Body -->
    <form name="cal_entry_form" action="POST">
      <!-- hidden fields -->
      <input name="calendarID" type="hidden" value="{/RESPONSES/RESPONSE/calendarID/@Value}"/>
      <input name="calendarTypeID" type="hidden" value="{/RESPONSES/RESPONSE/calendarTypeID/@Value}"/>
      <input name="calendarEntryID" type="hidden" value="{/RESPONSES/RESPONSE/calendarEntryID/@Value}"/>
      <input type="hidden" name="DATE_FORMAT" value="{/RESPONSES/RESPONSE/FORMAT/@Date}"/>
      <table border="0" cellpadding="0" cellspacing="6" width="100%">
        <tr>
          <td width="100%">
            <xsl:apply-templates select="CALENDAR_ENTRY/ENTRY_HEADER"/>
          </td>
        </tr>
        <tr>
          <td width="100%">
            <xsl:apply-templates select="PATTERN"/>
          </td>
        </tr>
        <tr>
          <td>
            <xsl:apply-templates select="ATTRIBUTE"/>
          </td>
        </tr>
      </table>
    </form>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:variable name="mode" select="/RESPONSES/RESPONSE/CALENDAR_ENTRY/ENTRY_HEADER/MODE/@Value"/>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="ENTRY_HEADER">
    <xsl:call-template name="display_instruction_area"/>
    <xsl:variable name="displayNameOfStartDate">
      <xsl:choose>
        <xsl:when test="$mode = 'EDIT' ">
          <i18n:text>Effective Start Date</i18n:text>
        </xsl:when>
        <xsl:otherwise>
          <i18n:text>From Date</i18n:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="nameOfStartDate">
      <xsl:choose>
        <xsl:when test="$mode = 'EDIT' ">effStartDate_DC</xsl:when>
        <xsl:otherwise>startDate_DC</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="valueOfStartDate">
      <xsl:choose>
        <xsl:when test="$mode = 'EDIT' ">
          <xsl:value-of select="/RESPONSES/RESPONSE/effStartDate/@Value"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="/RESPONSES/RESPONSE/startDate/@Value"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="displayNameOfEndDate">
      <xsl:choose>
        <xsl:when test="$mode = 'EDIT' ">
          <i18n:text>Effective End Date</i18n:text>
        </xsl:when>
        <xsl:otherwise>
          <i18n:text>To Date</i18n:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="nameOfEndDate">
      <xsl:choose>
        <xsl:when test="$mode = 'EDIT' ">effEndDate_DC</xsl:when>
        <xsl:otherwise>endDate_DC</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="valueOfEndDate">
      <xsl:choose>
        <xsl:when test="$mode = 'EDIT' ">
          <xsl:value-of select="/RESPONSES/RESPONSE/effEndDate/@Value"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="/RESPONSES/RESPONSE/endDate/@Value"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <table id="detail_table">
      <tr>
        <td nowrap="nowrap">
      &#xA0; &#xA0;<i18n:text>
      Calendar Name
      </i18n:text>
          <xsl:text>:</xsl:text>
        </td>
        <td nowrap="nowrap">
          <xsl:value-of select="/RESPONSES/RESPONSE/name/@Value"/>
        </td>
        <td nowrap="nowrap">
          <xsl:value-of select="$displayNameOfStartDate"/>
          <xsl:text>:</xsl:text>
          <xsl:call-template name="display_alert_mark"/>
        </td>
        <td nowrap="nowrap">
          <xsl:variable name="i18nStartDate">
            <i18n:date format="common">
              <xsl:value-of select="$valueOfStartDate"/>
            </i18n:date>
          </xsl:variable>
            &#xA0;&#xA0;<input type="field" name="{$nameOfStartDate}" value="{$i18nStartDate}" required="true" tabIndex="" class="inputfieldIE" maxlength="32" size="12"/>
          <A HREF="javascript:doNothing()" onclick="showCalendar(document.cal_entry_form.{$nameOfStartDate});">
            <i2:img src="/cal_icon.gif" border="0" align="bottom"/>
          </A>
          <xsl:call-template name="display_alert_image">
            <xsl:with-param name="fieldName" select="$nameOfStartDate"/>
          </xsl:call-template>
        </td>
        <td nowrap="nowrap">
            &#xA0; &#xA0;&#xA0;
            <xsl:value-of select="$displayNameOfEndDate"/>
          <xsl:text>:</xsl:text>
          <xsl:call-template name="display_alert_mark"/>
        </td>
        <td nowrap="nowrap">
          <xsl:variable name="i18nEndDate">
            <i18n:date format="common">
              <xsl:value-of select="$valueOfEndDate"/>
            </i18n:date>
          </xsl:variable>
            &#xA0;&#xA0;<input type="field" name="{$nameOfEndDate}" value="{$i18nEndDate}" required="true" tabIndex="" class="inputfieldIE" maxlength="32" size="12"/>
          <A HREF="javascript:doNothing()" onclick="showCalendar(document.cal_entry_form.{$nameOfEndDate});">
            <i2:img src="/cal_icon.gif" border="0" align="bottom"/>
          </A>
          <xsl:call-template name="display_alert_image">
            <xsl:with-param name="fieldName" select="$nameOfEndDate"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td nowrap="nowrap">
                &#xA0; &#xA0;<i18n:text>
                Calendar Type
                </i18n:text>
                    <xsl:text>:</xsl:text>
                  </td>
                  <td nowrap="nowrap">
                    <xsl:value-of select="/RESPONSES/RESPONSE/calendarTypeID/@Value"/>
        </td>
        <td nowrap="nowrap">
          <i18n:text>Start Time
        </i18n:text>
          <xsl:text>:</xsl:text>
        </td>
        <td nowrap="nowrap">
          <xsl:variable name="dateString1">
            <xsl:value-of select="/RESPONSES/RESPONSE/dailyStartTime/@Value"/>
          </xsl:variable>
          <xsl:variable name="dateSubStr1">
            <xsl:choose>
              <xsl:when test="contains($dateString1 , '01/01/1900 ' )">
                <xsl:value-of select="substring-after($dateString1, '01/01/1900 ' )"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$dateString1"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
      &#xA0;
       <input type="field" name="dailyStartTime" value="{$dateSubStr1}" tabIndex="" class="inputfieldIE" maxlength="32" size="12" onkeyup="javascript:onlyValidTime(/[0123456789:/ ]/)"/>
       &#xA0;<xsl:text>hh:mm:ss</xsl:text>
        </td>
        <td nowrap="nowrap">
        &#xA0; &#xA0;&#xA0;
        <i18n:text>End Time
        </i18n:text>
          <xsl:text>:</xsl:text>
        </td>
        <td nowrap="nowrap">
          <xsl:variable name="dateString2">
            <xsl:value-of select="/RESPONSES/RESPONSE/dailyEndTime/@Value"/>
          </xsl:variable>
          <xsl:variable name="dateSubStr2">
            <xsl:choose>
              <xsl:when test="contains($dateString2 , '01/01/1900 ' )">
                <xsl:value-of select="substring-after($dateString2, '01/01/1900 ' )"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$dateString2"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
      &#xA0;
       <input type="field" name="dailyEndTime" value="{$dateSubStr2}" tabIndex="" class="inputfieldIE" maxlength="32" size="12" onkeyup="javascript:onlyValidTime(/[0123456789:/ ]/)"/>
       &#xA0;<xsl:text>hh:mm:ss</xsl:text>
        </td>
        <tr>
        <xsl:if test="$mode = 'EDIT' ">
              <td nowrap="nowrap">
                    &#xA0;&#xA0;
                   <i18n:text>Priority
                    </i18n:text>
                <xsl:text>:</xsl:text>
                <xsl:call-template name="display_alert_mark"/>
              </td>
              <td nowrap="nowrap">
                     &#xA0;
                    <input type="field" name="priority" value="{/RESPONSES/RESPONSE/priority/@Value}" tabIndex="" class="inputfieldIE" maxlength="32" size="12" onkeyup="javascript:onlyPositiveInteger()"/>
              </td>
            </xsl:if>
            <xsl:choose>
              <xsl:when test="$mode = 'EDIT' "/>
              <xsl:otherwise>
                <td nowrap="nowrap">
                &#xA0;&#xA0;
                            <i18n:text>Bucket Size
                </i18n:text>
                  <xsl:text>:</xsl:text>
                </td>
                <td>&#xA0;
                <select class="pulldown" name="bucketSize" tabIndex="" onchange="onCalendarBucket();">
                    <option value="-1">
                      <xsl:if test="/RESPONSES/RESPONSE/bucketSize/@Value = '-1' ">
                        <xsl:attribute name="selected">true</xsl:attribute>
                      </xsl:if>
                      <i18n:text>
                        <xsl:value-of select="'One Bucket'"/>
                      </i18n:text>
                    </option>
                    <option value="1">
                      <xsl:if test="/RESPONSES/RESPONSE/bucketSize/@Value = '1' ">
                        <xsl:attribute name="selected">true</xsl:attribute>
                      </xsl:if>
                      <i18n:text>
                        <xsl:value-of select="'Daily Bucket'"/>
                      </i18n:text>
                    </option>
                    <option value="7">
                      <xsl:if test="/RESPONSES/RESPONSE/bucketSize/@Value = '7' ">
                        <xsl:attribute name="selected">true</xsl:attribute>
                      </xsl:if>
                      <i18n:text>
                        <xsl:value-of select="'7 Day Bucket'"/>
                      </i18n:text>
                    </option>
                  </select>
                </td>
              </xsl:otherwise>
        </xsl:choose>        
        </tr>
      </tr>
    </table>
    <!--HR size="4"  width="100%"/>
      <table id="bucket_table">
       <tr>
         <td>
            <select  class="pulldown" name="bucketSize"  tabIndex="" onchange="onCalendarBucket();" >
              <option value="-1">One Bucket</option>
              <option value="1">Daily Bucket</option>
              <option value="7">7 Day Bucket</option>
            </select>
         </td>
       </tr>
      </table-->
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="PATTERN">
    <xsl:apply-templates select="CONTAINER" mode="container">
      <xsl:with-param name="content" select="."/>
    </xsl:apply-templates>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="ATTRIBUTE">
    <xsl:variable name="count" select="count(./*)"/>
     <xsl:choose>
      <xsl:when test="$count=1"/>
       <xsl:when test="$count=0"/>
      <xsl:otherwise>
        <xsl:apply-templates select="CONTAINER" mode="container">
          <xsl:with-param name="content" select="."/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:variable name="patternName" select="/RESPONSES/RESPONSE/patternName/@Value"/>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="PATTERN" mode="container_content">
    <xsl:choose>
      <xsl:when test="$mode = 'EDIT' ">
        <xsl:apply-templates select="." mode="edit"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="new"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="PATTERN" mode="new">
    <xsl:param name="contect"/>
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
      <tr>
        <td>
          <table id="every_day_table">
            <tr>
              <td nowrap="nowrap">
                        &#xA0;
                        <input type="radio" name="patternName" checked="true" value="EVERYDAY">
                  <xsl:if test="$patternName = 'EVERYDAY' ">
                    <xsl:attribute name="checked">true</xsl:attribute>
                  </xsl:if>
                </input>
              </td>
              <td nowrap="nowrap">
                        &#xA0; &#xA0;&#xA0;
                        <i18n:text>Every Day
                        </i18n:text>
              </td>
            </tr>
          </table>
          <table id="every_n_day_table">
            <tr>
              <td nowrap="nowrap">
                        &#xA0;
                        <input type="radio" name="patternName" value="EVERY_N_DAYS">
                  <xsl:if test="$patternName = 'EVERY_N_DAYS' ">
                    <xsl:attribute name="checked">true</xsl:attribute>
                  </xsl:if>
                </input>
              </td>
              <td nowrap="nowrap">
                        &#xA0; &#xA0;&#xA0;
                        <i18n:text>Every
                        </i18n:text>
                <xsl:text>:</xsl:text>
              </td>
              <td nowrap="nowrap">
              
                      &#xA0;  
                                   <input type="field" name="EVERY_N_DAYS" value="{/RESPONSES/RESPONSE/EVERY_N_DAYS/@Value}" tabIndex="" class="inputfieldIE" maxlength="32" size="12" onkeyup="javascript:onlyPositiveInteger()"/>
              </td>
              <td nowrap="nowrap">
                        &#xA0; &#xA0;&#xA0;
                        <i18n:text>Day(s)
                        </i18n:text>
              </td>
            </tr>
          </table>
          <table id="every_week_table">
            <tr>
              <td nowrap="nowrap">
                        &#xA0;
                        <input type="radio" name="patternName" value="DAYS_OF_WEEK">
                  <xsl:if test="$patternName = 'DAYS_OF_WEEK' ">
                    <xsl:attribute name="checked">true</xsl:attribute>
                  </xsl:if>
                </input>
              </td>
              <td nowrap="nowrap">
                        &#xA0; &#xA0;&#xA0;
                        <i18n:text>Every Week On
                        </i18n:text>&#xA0; &#xA0;&#xA0;
                        <xsl:text>:</xsl:text>
              </td>
              <td nowrap="nowrap">
                        &#xA0; &#xA0;&#xA0;
                        <i18n:text>Mon
                        </i18n:text>
              </td>
              <!--EQ:574677 To make the db entry from MONDAY,TUESDAY etc to Mo,Tuetc-->
              <td nowrap="nowrap">
                      &#xA0;
                      <input type="checkbox" name="WEEK_DAY" value="Mo">
                  <xsl:if test="/RESPONSES/RESPONSE/*[name() = 'WEEK_DAY' ] /@Value = 'Mo' ">
                    <xsl:attribute name="checked">true</xsl:attribute>
                  </xsl:if>
                </input>
              </td>
              <td nowrap="nowrap">
                        &#xA0; &#xA0;&#xA0;
                        <i18n:text>Tue
                        </i18n:text>
              </td>
              <td nowrap="nowrap">
                      &#xA0;
                      <input type="checkbox" name="WEEK_DAY" value="Tu">
                  <xsl:if test="/RESPONSES/RESPONSE/*[name() = 'WEEK_DAY' ] /@Value = 'TuY' ">
                    <xsl:attribute name="checked">true</xsl:attribute>
                  </xsl:if>
                </input>
              </td>
              <td nowrap="nowrap">
                        &#xA0; &#xA0;&#xA0;
                        <i18n:text>Wed
                        </i18n:text>
              </td>
              <td nowrap="nowrap">
                      &#xA0;
                      <input type="checkbox" name="WEEK_DAY" value="We">
                  <xsl:if test="/RESPONSES/RESPONSE/*[name() = 'WEEK_DAY' ] /@Value = 'We' ">
                    <xsl:attribute name="checked">true</xsl:attribute>
                  </xsl:if>
                </input>
              </td>
              <td nowrap="nowrap">
                        &#xA0; &#xA0;&#xA0;
                        <i18n:text>Thu
                        </i18n:text>
              </td>
              <td nowrap="nowrap">
                      &#xA0;
                      <input type="checkbox" name="WEEK_DAY" value="Th">
                  <xsl:if test="/RESPONSES/RESPONSE/*[name() = 'WEEK_DAY' ] /@Value = 'Th' ">
                    <xsl:attribute name="checked">true</xsl:attribute>
                  </xsl:if>
                </input>
              </td>
              <td nowrap="nowrap">
                        &#xA0; &#xA0;&#xA0;
                        <i18n:text>Fri
                        </i18n:text>
              </td>
              <td nowrap="nowrap">
                      &#xA0;
                      <input type="checkbox" name="WEEK_DAY" value="Fr">
                  <xsl:if test="/RESPONSES/RESPONSE/*[name() = 'WEEK_DAY' ] /@Value = 'Fr' ">
                    <xsl:attribute name="checked">true</xsl:attribute>
                  </xsl:if>
                </input>
              </td>
              <td nowrap="nowrap">
                        &#xA0; &#xA0;&#xA0;
                        <i18n:text>Sat
                        </i18n:text>
              </td>
              <td nowrap="nowrap">
                      &#xA0;
                      <input type="checkbox" name="WEEK_DAY" value="Sa">
                  <xsl:if test="/RESPONSES/RESPONSE/*[name() = 'WEEK_DAY' ] /@Value = 'Sa' ">
                    <xsl:attribute name="checked">true</xsl:attribute>
                  </xsl:if>
                </input>
              </td>
              <td nowrap="nowrap">
                        &#xA0; &#xA0;&#xA0;
                        <i18n:text>Sun
                        </i18n:text>
              </td>
              <td nowrap="nowrap">
                      &#xA0;
                      <input type="checkbox" name="WEEK_DAY" value="Su">
                  <xsl:if test="/RESPONSES/RESPONSE/*[name() = 'WEEK_DAY' ] /@Value = 'Su' ">
                    <xsl:attribute name="checked">true</xsl:attribute>
                  </xsl:if>
                </input>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="PATTERN" mode="edit">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
      <tr>
        <td>
          <xsl:choose>
            <xsl:when test="$patternName = 'EVERYDAY'">
              <table id="every_day_table">
                <tr>
                  <td nowrap="nowrap">
                                &#xA0;
                                <input type="radio" name="patternName" checked="true" value="EVERYDAY"/>
                  </td>
                  <td nowrap="nowrap">
                                &#xA0; &#xA0;&#xA0;
                                <i18n:text>Every Day
                                </i18n:text>
                  </td>
                </tr>
              </table>
            </xsl:when>
            <xsl:when test="$patternName = 'EVERY_N_DAYS'">
              <table id="every_n_day_table">
                <tr>
                  <td nowrap="nowrap">
                                &#xA0;
                                <input type="radio" name="patternName" checked="true" value="EVERY_N_DAYS"/>
                  </td>
                  <td nowrap="nowrap">
                                &#xA0; &#xA0;&#xA0;
                                <i18n:text>Every
                                </i18n:text>
                    <xsl:text>:</xsl:text>
                  </td>
                  <td nowrap="nowrap">
                              &#xA0;
                              <input type="field" name="EVERY_N_DAYS" value="{/RESPONSES/RESPONSE/EVERY_N_DAYS/@Value}" tabIndex="" class="inputfieldIE" maxlength="32" size="12" onkeyup="javascript:onlyPositiveInteger()"/>
                  </td>
                  <td nowrap="nowrap">
                                &#xA0; &#xA0;&#xA0;
                                <i18n:text>Day
                                </i18n:text>
                  </td>
                </tr>
              </table>
            </xsl:when>
            <xsl:when test="$patternName = 'DAYS_OF_WEEK'">
              <table id="every_week_table">
                <tr>
                  <td nowrap="nowrap">
                                &#xA0;
                                <input type="radio" name="patternName" checked="true" value="DAYS_OF_WEEK"/>
                  </td>
                  <td nowrap="nowrap">
                                &#xA0; &#xA0;&#xA0;
                                <i18n:text>Every Week On
                                </i18n:text>&#xA0; &#xA0;&#xA0;
                                <xsl:text>:</xsl:text>
                  </td>
                  <td nowrap="nowrap">
                                &#xA0; &#xA0;&#xA0;
                                <i18n:text>Mon
                                </i18n:text>
                  </td>
                  <td nowrap="nowrap">
                              &#xA0;
                              <input type="checkbox" name="WEEK_DAY" value="Mo">
                      <xsl:if test="/RESPONSES/RESPONSE/*[name() = 'WEEK_DAY' ] /@Value = 'Mo' ">
                        <xsl:attribute name="checked">true</xsl:attribute>
                      </xsl:if>
                    </input>
                  </td>
                  <td nowrap="nowrap">
                                &#xA0; &#xA0;&#xA0;
                                <i18n:text>Tue
                                </i18n:text>
                  </td>
                  <td nowrap="nowrap">
                              &#xA0;
                              <input type="checkbox" name="WEEK_DAY" value="Tu">
                      <xsl:if test="/RESPONSES/RESPONSE/*[name() = 'WEEK_DAY' ] /@Value = 'Tu' ">
                        <xsl:attribute name="checked">true</xsl:attribute>
                      </xsl:if>
                    </input>
                  </td>
                  <td nowrap="nowrap">
                                &#xA0; &#xA0;&#xA0;
                                <i18n:text>Wed
                                </i18n:text>
                  </td>
                  <td nowrap="nowrap">
                              &#xA0;
                              <input type="checkbox" name="WEEK_DAY" value="We">
                      <xsl:if test="/RESPONSES/RESPONSE/*[name() = 'WEEK_DAY' ] /@Value = 'We' ">
                        <xsl:attribute name="checked">true</xsl:attribute>
                      </xsl:if>
                    </input>
                  </td>
                  <td nowrap="nowrap">
                                &#xA0; &#xA0;&#xA0;
                                <i18n:text>Thu
                                </i18n:text>
                  </td>
                  <td nowrap="nowrap">
                              &#xA0;
                              <input type="checkbox" name="WEEK_DAY" value="Th">
                      <xsl:if test="/RESPONSES/RESPONSE/*[name() = 'WEEK_DAY' ] /@Value = 'Th' ">
                        <xsl:attribute name="checked">true</xsl:attribute>
                      </xsl:if>
                    </input>
                  </td>
                  <td nowrap="nowrap">
                                &#xA0; &#xA0;&#xA0;
                                <i18n:text>Fri
                                </i18n:text>
                  </td>
                  <td nowrap="nowrap">
                              &#xA0;
                              <input type="checkbox" name="WEEK_DAY" value="Fr">
                      <xsl:if test="/RESPONSES/RESPONSE/*[name() = 'WEEK_DAY' ] /@Value = 'Fr' ">
                        <xsl:attribute name="checked">true</xsl:attribute>
                      </xsl:if>
                    </input>
                  </td>
                  <td nowrap="nowrap">
                                &#xA0; &#xA0;&#xA0;
                                <i18n:text>Sat
                                </i18n:text>
                  </td>
                  <td nowrap="nowrap">
                              &#xA0;
                              <input type="checkbox" name="WEEK_DAY" value="Sa">
                      <xsl:if test="/RESPONSES/RESPONSE/*[name() = 'WEEK_DAY' ] /@Value = 'Sa' ">
                        <xsl:attribute name="checked">true</xsl:attribute>
                      </xsl:if>
                    </input>
                  </td>
                  <td nowrap="nowrap">
                                &#xA0; &#xA0;&#xA0;
                                <i18n:text>Sun
                                </i18n:text>
                  </td>
                  <td nowrap="nowrap">
                              &#xA0;
                              <input type="checkbox" name="WEEK_DAY" value="Su">
                      <xsl:if test="/RESPONSES/RESPONSE/*[name() = 'WEEK_DAY' ] /@Value = 'Su' ">
                        <xsl:attribute name="checked">true</xsl:attribute>
                      </xsl:if>
                    </input>
                  </td>
                </tr>
              </table>
            </xsl:when>
          </xsl:choose>
        </td>
      </tr>
    </table>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="ATTRIBUTE" mode="container_content">
    <xsl:variable name="count" select="count(./calendarEntryAttributeID)"/>
    <xsl:variable name="count1" select="0"/>
    <xsl:variable name="iterCount">
      <xsl:choose>
        <xsl:when test="$count=0">
          <xsl:value-of select="0"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="((($count)-1) div 3)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <table border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td>
          <table id="attribute_table">
            <xsl:call-template name="doLayout">
              <xsl:with-param name="iterCount" select="$iterCount"/>
              <xsl:with-param name="count1" select="$count1"/>
            </xsl:call-template>
            <!--
            <tr>
              <xsl:for-each select="calendarEntryAttributeID[position() &lt;= 3]">
                <xsl:variable name="isRequired" select="./@Mandatory"/>
                <xsl:variable name="val" select="./@Value"/>
                <td nowrap="nowrap">
                        &#xA0;
                        <i18n:text>
                    <xsl:value-of select="$val"/>
                  </i18n:text>
                  <xsl:text>:</xsl:text>
                  <xsl:if test="$isRequired='true'">
                    <xsl:call-template name="display_alert_mark"/>
                  </xsl:if>
                </td>
                <td nowrap="nowrap">
                        &#xA0;
                        <input type="field" name="{$val}" value="{/RESPONSES/RESPONSE/*[name() = $val] /@Value}" tabIndex="" class="inputfieldIE" maxlength="32" size="12" required="{$isRequired}"/>
                  <xsl:if test="$isRequired='true'">
                    <xsl:call-template name="display_alert_image">
                      <xsl:with-param name="fieldName" select="$val"/>
                    </xsl:call-template>
                  </xsl:if>
                </td>
              </xsl:for-each>
            </tr>
            <tr>
              <xsl:for-each select="calendarEntryAttributeID[position() &gt; 3 and position() &lt;= 6]">
                <xsl:variable name="val" select="./@Value"/>
                <td nowrap="nowrap">
                        &#xA0;
                        <i18n:text>
                    <xsl:value-of select="$val"/>
                  </i18n:text>
                  <xsl:text>:</xsl:text>
                </td>
                <td nowrap="nowrap">
                        &#xA0;
                        <input type="field" name="{$val}" value="{/RESPONSES/RESPONSE/*[name() = $val] /@Value}" tabIndex="" class="inputfieldIE" maxlength="32" size="12"/>
                </td>
              </xsl:for-each>
            </tr>
            <tr>
              <xsl:for-each select="calendarEntryAttributeID[position() &gt; 6 and position() &lt;= 9]">
                <xsl:variable name="val" select="./@Value"/>
                <td nowrap="nowrap">
                        &#xA0;
                        <i18n:text>
                    <xsl:value-of select="$val"/>
                  </i18n:text>
                  <xsl:text>:</xsl:text>
                </td>
                <td nowrap="nowrap">
                        &#xA0;
                        <input type="field" name="{$val}" value="{/RESPONSES/RESPONSE/*[name() = $val] /@Value}" tabIndex="" class="inputfieldIE" maxlength="32" size="12"/>
                </td>
              </xsl:for-each>
            </tr>
            <tr>
              <xsl:for-each select="calendarEntryAttributeID[position() &gt; 9 and position() &lt;= 12]">
                <xsl:variable name="val" select="./@Value"/>
                <td nowrap="nowrap">
                        &#xA0;
                        <i18n:text>
                    <xsl:value-of select="$val"/>
                  </i18n:text>
                  <xsl:text>:</xsl:text>
                </td>
                <td nowrap="nowrap">
                        &#xA0;
                        <input type="field" name="{$val}" value="{/RESPONSES/RESPONSE/*[name() = $val] /@Value}" tabIndex="" class="inputfieldIE" maxlength="32" size="12"/>
                </td>
              </xsl:for-each>
            </tr>
            -->
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>
  <!-- **********************************************************************
   *********************************************************************** -->
  <xsl:template name="doLayout">
      <xsl:param name="iterCount"/>
      <xsl:param name="count1"/>
      <tr>
        <xsl:for-each select="calendarEntryAttributeID[(position() &gt; (3*($count1))) and (position() &lt;=  (3*($count1+1)))]">
          <xsl:variable name="isRequired" select="./@Mandatory"/>
          <xsl:variable name="val" select="./@Value"/>
          <xsl:variable name="isDropDown" select="count(./OPTION/*)"/>
          <td nowrap="nowrap">
                          &#xA0;
                          <i18n:text>
              <xsl:value-of select="$val"/>
            </i18n:text>
            <xsl:text>:</xsl:text>
            <xsl:if test="$isRequired='true'">
              <xsl:call-template name="display_alert_mark"/>
            </xsl:if>
          </td>
          
          <xsl:variable name="inputVal" select="/RESPONSES/RESPONSE/*[name() = $val]/@Value"/>  
          <!-- EQ:574859-->
          <xsl:choose>                    
            <xsl:when test="./@DataType='boolean'">
            <td nowrap="nowrap" align="left">          
              <select class="inputfieldIE" name="{$val}" required="{$isRequired}" tabIndex="">
                 <xsl:choose>
                  <xsl:when test="string-length($inputVal) &gt; 0">
                    <xsl:choose>
                      <xsl:when test="$inputVal='True' or $inputVal='1'">
                        <option value="1" selected="yes">
                          <i18n:text>True</i18n:text>
                        </option>
                        <option value="0">
                          <i18n:text>False</i18n:text>
                        </option>
                      </xsl:when>
                      <xsl:when test="$inputVal='False' or $inputVal='0'">
                        <option value="1" >
                          <i18n:text>True</i18n:text>
                        </option>
                        <option value="0" selected="yes">
                          <i18n:text>False</i18n:text>
                        </option>
                      </xsl:when>
                    </xsl:choose>                                    
                  </xsl:when>
                  <xsl:otherwise>
                    <option value="1">
                      <i18n:text>True</i18n:text>
                    </option>
                    <option value="0">
                      <i18n:text>False</i18n:text>
                    </option>
                  </xsl:otherwise>
                </xsl:choose>
                
              </select>
              <xsl:if test="$isRequired='true'">
              <xsl:call-template name="display_alert_image">
                <xsl:with-param name="fieldName" select="$val"/>
              </xsl:call-template>
              </xsl:if>
            </td>
            </xsl:when>
            <xsl:when test="./@DataType='int'">
              <td nowrap="nowrap">
           &#xA0;
            <input type="field" name="{$val}" value="{/RESPONSES/RESPONSE/*[name() = $val] /@Value}" tabIndex="" class="inputfieldIE" maxlength="32" size="12" required="{$isRequired}" onkeyup="javascript:onlyValidCharacters(/[0123456789,\u0020\u00A0]/)"/>
            <xsl:if test="$isRequired='true'">
              <xsl:call-template name="display_alert_image">
            <xsl:with-param name="fieldName" select="$val"/>
              </xsl:call-template>
            </xsl:if>
             </td>
           </xsl:when>
           <xsl:when test="./@DataType='double' or ./@DataType='float'">
         <td nowrap="nowrap">
           &#xA0;
        <input type="field" name="{$val}" value="{/RESPONSES/RESPONSE/*[name() = $val] /@Value}" tabIndex="" class="inputfieldIE" maxlength="32" size="12" required="{$isRequired}" onkeyup="javascript:onlyValidCharacters(/[0123456789.,\u0020\u00A0]/)"/>
            <xsl:if test="$isRequired='true'">
              <xsl:call-template name="display_alert_image">
            <xsl:with-param name="fieldName" select="$val"/>
              </xsl:call-template>
            </xsl:if>
        </td>
           </xsl:when>
            
            <xsl:otherwise>
              <td nowrap="nowrap">
                              &#xA0;
                              <input type="field" name="{$val}" value="{/RESPONSES/RESPONSE/*[name() = $val] /@Value}" tabIndex="" class="inputfieldIE" maxlength="32" size="12" required="{$isRequired}"/>
                <xsl:if test="$isRequired='true'">
                  <xsl:call-template name="display_alert_image">
                    <xsl:with-param name="fieldName" select="$val"/>
                  </xsl:call-template>
                </xsl:if>
              </td>
            </xsl:otherwise>
          </xsl:choose>
          
          <!-- <xsl:choose>
            
            <xsl:when test="$isDropDown > 0">
            <td nowrap="nowrap" align="left">          
              <select class="inputfieldIE" name="{$val}" required="{$isRequired}" tabIndex="">
                <option value="">
                  <i18n:text>Select...</i18n:text>
                </option>
                <xsl:choose>
                  <xsl:when test="string-length(/RESPONSES/RESPONSE/*[name() = $val]/@Value) &gt; 0">
                    <xsl:apply-templates select="./OPTION/VALID_VALUE">                    
                      <xsl:with-param name="selectedId" select="/RESPONSES/RESPONSE/*[name() = $val]/@Value"/>
                    </xsl:apply-templates>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:apply-templates select="./OPTION/VALID_VALUE"/>
                  </xsl:otherwise>
                </xsl:choose>
                
              </select>
              <xsl:if test="$isRequired='true'">
              <xsl:call-template name="display_alert_image">
                <xsl:with-param name="fieldName" select="$val"/>
              </xsl:call-template>
              </xsl:if>
            </td>
            </xsl:when>
            
            <xsl:otherwise>
              <td nowrap="nowrap">
                              &#xA0;
                              <input type="field" name="{$val}" value="{/RESPONSES/RESPONSE/*[name() = $val] /@Value}" tabIndex="" class="inputfieldIE" maxlength="32" size="12" required="{$isRequired}" onkeyup="javascript:onlyValidCharacters(/[0123456789.,\u0020\u00A0]/)"/>
                <xsl:if test="$isRequired='true'">
                  <xsl:call-template name="display_alert_image">
                    <xsl:with-param name="fieldName" select="$val"/>
                  </xsl:call-template>
                </xsl:if>
              </td>
            </xsl:otherwise>
          </xsl:choose> -->
          
        </xsl:for-each>
      </tr>
      <xsl:if test="$count1 &lt; $iterCount">
        <xsl:call-template name="doLayout">
          <xsl:with-param name="thisParam" select="."/>
          <xsl:with-param name="iterCount" select="$iterCount"/>
          <xsl:with-param name="count1" select="$count1+1"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:template>

  <!-- Javascript -->
  <!-- **********************************************************************
   *********************************************************************** -->
  <xsl:template name="include_javascript_calendar">
    <i2:javascript path="/calendar.js"/>
  </xsl:template>
  <!-- **********************************************************************
   *********************************************************************** -->
  <xsl:template name="onLoad_js">
     function onLoad()
     {
       requiredFieldCheck('onLoad');
       resize_Containers();
       <xsl:choose>
      <xsl:when test="/RESPONSES/RESPONSE/bucketSize/@Value = 1 ">
          i2uiToggleItemVisibility('every_day_table', 'show');
          i2uiToggleItemVisibility('every_n_day_table', 'hide');
          i2uiToggleItemVisibility('every_week_table', 'hide');
          if(document.cal_entry_form.EVERY_N_DAYS!=null)
          {
          document.cal_entry_form.EVERY_N_DAYS.disabled = false;
          }
      </xsl:when>
      <xsl:when test="/RESPONSES/RESPONSE/bucketSize/@Value = -7 ">
          i2uiToggleItemVisibility('every_day_table', 'show');
          i2uiToggleItemVisibility('every_n_day_table', 'show');
          i2uiToggleItemVisibility('every_week_table', 'hide');
          document.cal_entry_form.EVERY_N_DAYS.value = "7";
          document.cal_entry_form.EVERY_N_DAYS.disabled = true;
     </xsl:when>
      <xsl:otherwise>
          i2uiToggleItemVisibility('every_day_table', 'show');
          i2uiToggleItemVisibility('every_n_day_table', 'show');
          i2uiToggleItemVisibility('every_week_table', 'show');
           if(document.cal_entry_form.EVERY_N_DAYS!=null)
          {
          document.cal_entry_form.EVERY_N_DAYS.disabled = false;
          }
       </xsl:otherwise>
    </xsl:choose>

     }
   </xsl:template>
  <xsl:template name="onResize_js">
     function onResize()
     {
       resize_Containers();
     }
   </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <!-- custom javascript -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_calendar_entry">
    <script>
    <!-- ISSUE : 532023 -->
    var msg_valid_date="VALID_DATE_FORMAT {0}";
    function onSaveAndReturn()
    {
    
          var dateFormat = document.cal_entry_form.DATE_FORMAT.value;
      if ( isDate(document.cal_entry_form.startDate_DC.value, dateFormat) == false )
          {
              core_alert(msg_valid_date,dateFormat);
              success = false;
              return;
          }
      
      if ( isDate(document.cal_entry_form.endDate_DC.value, dateFormat) == false )
          {
              core_alert(msg_valid_date,dateFormat);
              success = false;
              return;
          }
    
    <!--EQ: 574860 To check the time format -->
    var stTime=document.cal_entry_form.dailyStartTime.value;
    var timePat = /^(\d{1,2}):(\d{2})(:(\d{2}))/;
    var plength = stTime.toString().length ;
    var hrSt = new String(stTime);
    if(plength > 0)
    {
         var starttimeArray= stTime.match(timePat);
         if (starttimeArray == null) 
         {
             core_alert("INVALID_START_TIME");
             return;
        }
        if(hrSt.substring(0,2) > 23)
        {
            core_alert("INVALID_START_TIME");
            return;
        }

        if(hrSt.substring(3,5) > 59 || hrSt.substring(3,5).length == 0)
        {
            core_alert("INVALID_START_TIME");
            return;
        }

        if(hrSt.substring(6,7) > 59 || hrSt.substring(6,7).length == 0)
        {
             core_alert("INVALID_START_TIME");
             return;
        }
    }
    var endTime=document.cal_entry_form.dailyEndTime.value;
    var hrEnd = new String(endTime);
    var plength1 = endTime.toString().length ;
    if(plength1 > 0)
    {
        var endtimeArray= endTime.match(timePat);
        if (endtimeArray == null) 
        {
         core_alert("INVALID_END_TIME");
         return;
        }
        if(hrEnd.substring(0,2) > 23)
        {
            core_alert("INVALID_END_TIME");
            return;
        }

        if(hrEnd.substring(3,5) > 59 || hrEnd.substring(3,5).length == 0)
        {
            core_alert("INVALID_END_TIME");

            return;
        }

        if(hrEnd.substring(6,7) > 59 || hrEnd.substring(6,7).length == 0)
        {
            core_alert("INVALID_END_TIME");
            return;
        }
    }
    <!--EQ: 574860 To check the time format -->
    
      if(document.cal_entry_form.EVERY_N_DAYS!=null)
        {
        <!-- TAR ID: 515274 -->
         <!-- Note: 1 was already added to the dateDiff -->
        var d1=getDateFromFormat(document.cal_entry_form.startDate_DC.value,dateFormat);
        var d2=getDateFromFormat(document.cal_entry_form.endDate_DC.value,dateFormat);
        var dateDiff = (d2-d1)/(1000 *24*60*60)+1;
                       
        if(document.cal_entry_form.EVERY_N_DAYS.disabled == true)
        {
          document.cal_entry_form.EVERY_N_DAYS.disabled = false;
          document.cal_entry_form.EVERY_N_DAYS.value = "7";
        }
        
        if(dateDiff &lt; 1)
        {
            <!-- Fixed 512346 -->
            core_alert("OLT_DATE_ERR_MSG");
                return;
        }
        if(document.cal_entry_form.EVERY_N_DAYS.value &gt; dateDiff)
        {
            <!-- Fixed 512346 -->
            core_alert("NDAY_VALIDATION");
                return;
        }

      }

      error = "false";
      error = requiredFieldCheck();
      
          
                
      if( checkifWeekSelected (cal_entry_form)  &amp;&amp; ! checkifOneDaySelected(cal_entry_form)  )
      {
        core_alert("WEEK_ONE_DAY");
        return;
      }    
      if(checkifNDaysSelected(cal_entry_form) &amp;&amp; (cal_entry_form.EVERY_N_DAYS.value &lt;= 0))
      {
        core_alert("DAY_PAT_VALIDATION");
        return;
      } 
      if(checkifNDaysSelected(cal_entry_form) &amp;&amp; ! checkifNDaysNumber(cal_entry_form))
      {
   
        core_alert("EVERY_NDAY_PATTERN");
        return;
      }    
      if ( error == 'false' )
      {
        document.cal_entry_form.action="entry/controller/addNewEntry.cmd";
        document.cal_entry_form.submit();
      }
    } 
      
    function onEditSaveAndReturn()
    {
       
       var dateFormat = document.cal_entry_form.DATE_FORMAT.value;
      if ( isDate(document.cal_entry_form.effStartDate_DC.value, dateFormat) == false )
          {
              core_alert(msg_valid_date,dateFormat);
              success = false;
              return;
          }
      
      if ( isDate(document.cal_entry_form.effEndDate_DC.value, dateFormat) == false )
          {
              core_alert(msg_valid_date,dateFormat);
              success = false;
              return;
          }
          
      <!--EQ: 574860 To check the time format -->          
      var stTime=document.cal_entry_form.dailyStartTime.value;
      var timePat = /^(\d{1,2}):(\d{2})(:(\d{2}))/;
      var plength = stTime.toString().length ;
      var hrSt = new String(stTime);
      if(plength > 0)
      {
          var starttimeArray= stTime.match(timePat);
          if (starttimeArray == null) 
          {
            core_alert("INVALID_START_TIME");
            return;
          }
          if(hrSt.substring(0,2) > 23)
          {
              core_alert("INVALID_START_TIME");
              return;
          }

          if(hrSt.substring(3,5) > 59 || hrSt.substring(3,5).length == 0)
          {
              core_alert("INVALID_START_TIME");
              return;
          }

          if(hrSt.substring(6,7) > 59 || hrSt.substring(6,7).length == 0)
          {
               core_alert("INVALID_START_TIME");
               return;
          }
      }
      var endTime=document.cal_entry_form.dailyEndTime.value;
      
      var hrEnd = new String(endTime);
      var plength1 = endTime.toString().length ;
      if(plength1 > 0)
      {
          var endtimeArray= endTime.match(timePat);
          if (endtimeArray == null) 
          {
           core_alert("INVALID_END_TIME");
           return;
          }
          if(hrEnd.substring(0,2) > 23)
          {
              core_alert("INVALID_END_TIME");
              return;
          }

          if(hrEnd.substring(3,5) > 59 || hrEnd.substring(3,5).length == 0)
          {
              core_alert("INVALID_END_TIME");

              return;
          }

          if(hrEnd.substring(6,7) > 59 || hrEnd.substring(6,7).length == 0)
          {
              core_alert("INVALID_END_TIME");
              return;
          }
        }
        <!--EQ: 574860 To check the time format -->
      
      if(document.cal_entry_form.EVERY_N_DAYS!=null)
      {   
        var d1=getDateFromFormat(document.cal_entry_form.effStartDate_DC.value,dateFormat);
        var d2=getDateFromFormat(document.cal_entry_form.effEndDate_DC.value,dateFormat);
        var dateDiff = (d2-d1)/(1000 *24*60*60);
        
        //var dateDiff = (new Date(document.cal_entry_form.effEndDate_DC.value) - new Date(document.cal_entry_form.effStartDate_DC.value))/(1000 *24*60*60);
        //alert("dateDiff = "+dateDiff + "  N pattern = "+document.cal_entry_form.EVERY_N_DAYS.value);
        
        if(document.cal_entry_form.EVERY_N_DAYS.disabled == true)
        {             
          document.cal_entry_form.EVERY_N_DAYS.disabled = false;
          document.cal_entry_form.EVERY_N_DAYS.value = "7";
        }
        
        if(document.cal_entry_form.EVERY_N_DAYS.value &gt; (dateDiff + 1))
        {
          core_alert("NDAY_VALIDATION");
          return;
        }
      }      
    
      error = "false";
      error = requiredFieldCheck();
      
      
          
          
          
      
      if( checkifWeekSelected (cal_entry_form)  &amp;&amp; ! checkifOneDaySelected(cal_entry_form)  )
      {
        core_alert("WEEK_ONE_DAY");
        return;
      }
      if(checkifNDaysSelected(cal_entry_form) &amp;&amp; (cal_entry_form.EVERY_N_DAYS.value &lt;= 0))
      {    
        core_alert("DAY_PAT_VALIDATION");
        return;
      }     
      if(checkifNDaysSelected(cal_entry_form) &amp;&amp; ! checkifNDaysNumber(cal_entry_form))
      {
        core_alert("DAY_PAT");
        return;
      }    
      if ( error == 'false' )
      {
        document.cal_entry_form.action="entry/controller/updateEntry.cmd";
        document.cal_entry_form.submit();
      }
    }
   <![CDATA[

    function onCalendarBucket()
    {
      if(document.cal_entry_form.bucketSize.value == '-1' )
       {
          i2uiToggleItemVisibility('every_day_table', 'show');
          i2uiToggleItemVisibility('every_n_day_table', 'show');
          i2uiToggleItemVisibility('every_week_table', 'show');
         if(document.cal_entry_form.EVERY_N_DAYS!=null)
          {
           document.cal_entry_form.EVERY_N_DAYS.value = "";
           document.cal_entry_form.EVERY_N_DAYS.disabled = false;
          }
        }
       else if (document.cal_entry_form.bucketSize.value == '1' )
       {
          i2uiToggleItemVisibility('every_day_table', 'show');
          checkPatternRadio(cal_entry_form , 'EVERYDAY' );
          i2uiToggleItemVisibility('every_n_day_table', 'hide');
          i2uiToggleItemVisibility('every_week_table', 'hide');
          if(document.cal_entry_form.EVERY_N_DAYS!=null)
          {
           document.cal_entry_form.EVERY_N_DAYS.value = "";
           document.cal_entry_form.EVERY_N_DAYS.disabled = false;
          }

        }
       else if (document.cal_entry_form.bucketSize.value == '7' )
       {
          i2uiToggleItemVisibility('every_day_table', 'show');
          checkPatternRadio(cal_entry_form , 'EVERYDAY' );
          i2uiToggleItemVisibility('every_n_day_table', 'show');
          i2uiToggleItemVisibility('every_week_table', 'hide');
          document.cal_entry_form.EVERY_N_DAYS.value = "7";
        document.cal_entry_form.EVERY_N_DAYS.disabled = true;
        }

    }

    function onCancel()
      {
                document.cal_entry_form.action="calendarDetail.jsp";
                document.cal_entry_form.submit();
      }


    function resize_Containers()
    {
      i2uiResizeScrollableContainer('container',document.body.offsetHeight , null, document.body.offsetWidth - 15, true, 'yes');
    }
    function checkPatternRadio(form , val)
    {
         var count;

         var elementsLen = form.elements.length;

         for(count = 0; count < elementsLen; count++)
         {
           if( form.elements[count].type == "radio" && form.elements[count].checked == false  &&
              form.elements[count].name == "patternName"  &&  form.elements[count].value == val )
            {
              form.elements[count].checked = true;
              break;
            }
         }
    }
    function checkifNDaysSelected(form)
    {
         var count;

         var elementsLen = form.elements.length;

         for(count = 0; count < elementsLen; count++)
         {
           if( form.elements[count].type == "radio" && form.elements[count].checked == true  &&
              form.elements[count].name == "patternName"  &&  form.elements[count].value == 'EVERY_N_DAYS' )
            {
              return true;
              break;
            }
         }
         return false;
    }
    function checkifNDaysNumber(form)
    {
         var count;

        var elementsLen = form.elements.length;
         for(count = 0; count < elementsLen; count++)
         {
           if( form.elements[count].type != "radio" &&
              form.elements[count].name == "EVERY_N_DAYS" )
            {
              //alert(form.elements[count].value);
              var val =  form.elements[count].value ;
              if( val.trim().length > 0 && parseInt ( val ) > 0 )
                return true;
              else
                return false;
            }
         }
         return false; 
    }
    function checkifWeekSelected(form)
    {
         var count;

         var elementsLen = form.elements.length;

         for(count = 0; count < elementsLen; count++)
         {
           if( form.elements[count].type == "radio" && form.elements[count].checked == true  &&
              form.elements[count].name == "patternName"  &&  form.elements[count].value == 'DAYS_OF_WEEK' )
            {
              return true;
              break;
            }
         }
         return false;
    }
    function checkifOneDaySelected(form)
    {
         var count;
         var numOfChecks = 0;
         var elementsLen = form.elements.length;

         for(count = 0; count < elementsLen; count++)
         {
           if( form.elements[count].type == "checkbox" &&
              form.elements[count].name == "WEEK_DAY" && form.elements[count].checked == true)
            {
              return true;
              break;
            }
         }
         return false;
    }

  ]]></script>
  </xsl:template>
</xsl:stylesheet>
