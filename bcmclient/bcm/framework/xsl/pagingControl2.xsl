<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:output method="html" indent="no"/>




<!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template name="i2:pagingtemplate">
    <xsl:param name="firsturl"></xsl:param>
    <xsl:param name="lasturl"></xsl:param>

    <xsl:param name="previousurl"></xsl:param>
    <xsl:param name="nexturl"></xsl:param>
    <xsl:param name="jumpurl"></xsl:param>
    <xsl:param name="jumpname">i2uijump</xsl:param>
    <xsl:param name="jumptext"><i18n:text>Jump</i18n:text></xsl:param>

    <table cellspacing="0" cellpadding="1" border="0">
      <tr>
      <!-- First -->
        <td >
          <i2:button >
            <i2:attribute name="onclick">
              <xsl:choose>
                <xsl:when test="$firsturl=''">
                  javascript:void(0);
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$firsturl"/>
                </xsl:otherwise>
              </xsl:choose>
            </i2:attribute>
            <xsl:if test="$firsturl=''">
              <i2:attribute name="disabled">yes</i2:attribute>
            </xsl:if>
            <center>
              <i2:img border="0">
                <i2:attribute name="src">
                  <xsl:choose>
                    <xsl:when test="$firsturl=''">/page_to_beginning_inact.gif</xsl:when>
                    <xsl:otherwise>/page_to_beginning.gif</xsl:otherwise>
                  </xsl:choose>
                </i2:attribute>
              </i2:img>
            </center>
          </i2:button>
        </td>

        <!-- Next -->
        <td nowrap="yes">
          <i2:button>
            <i2:attribute name="onclick">
              <xsl:choose>
                <xsl:when test="$previousurl=''">
                  javascript:void(0);
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$previousurl"/>
                </xsl:otherwise>
              </xsl:choose>
            </i2:attribute>
            <xsl:if test="$previousurl=''">
              <i2:attribute name="disabled">yes</i2:attribute>
            </xsl:if>
            <center>
              <i2:img border="0">
                <i2:attribute name="src">
                  <xsl:choose>
                    <xsl:when test="$previousurl=''">/previous_inactive.gif</xsl:when>
                    <xsl:otherwise>/previous_active.gif</xsl:otherwise>
                  </xsl:choose>
                </i2:attribute>
              </i2:img>
            </center>
          </i2:button>
        </td>
        <td >
          <i2:button >
            <i2:attribute name="onclick">
              <xsl:choose>
                <xsl:when test="$nexturl=''">
                  javascript:void(0);
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$nexturl"/>
                </xsl:otherwise>
              </xsl:choose>
            </i2:attribute>
            <xsl:if test="$nexturl=''">
              <i2:attribute name="disabled">yes</i2:attribute>
            </xsl:if>
            <center>
              <i2:img border="0">
                <i2:attribute name="src">
                  <xsl:choose>
                    <xsl:when test="$nexturl=''">/next_inactive.gif</xsl:when>
                    <xsl:otherwise>/next_active.gif</xsl:otherwise>
                  </xsl:choose>
                </i2:attribute>
              </i2:img>
            </center>
          </i2:button>
        </td>

        <!-- Last -->
        <td >
          <i2:button >
            <i2:attribute name="onclick">
              <xsl:choose>
                <xsl:when test="$lasturl=''">
                  javascript:void(0);
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$lasturl"/>
                </xsl:otherwise>
              </xsl:choose>
            </i2:attribute>
            <xsl:if test="$lasturl=''">
              <i2:attribute name="disabled">yes</i2:attribute>
            </xsl:if>
            <center>
              <i2:img border="0">
                <i2:attribute name="src">
                  <xsl:choose>
                    <xsl:when test="$lasturl=''">/page_to_end_inact.gif</xsl:when>
                    <xsl:otherwise>/page_to_end.gif</xsl:otherwise>
                  </xsl:choose>
                </i2:attribute>
              </i2:img>
            </center>
          </i2:button>
        </td>

        <td >
          <!--<input type="text" size="3" maxlength="4" class="&lt;i2:formclass type=&quot;smallinputfield&quot;/&gt;">
        <xsl:attribute name="name"><xsl:value-of select="$jumpname"/></xsl:attribute>
        </input>-->
          <input fieldtype="Text"
                 name="pagenum"
                 value=""
                 type="field"
                 class="inputfieldIE" size="3" onkeyup="javascript:onlyInteger();"/>
        </td>
        <td  >
          <i2:button>
            <i2:attribute name="onclick"><xsl:value-of select="$jumpurl"/></i2:attribute>
            <xsl:if test="$jumpurl=''">
              <i2:attribute name="disabled">yes</i2:attribute>
            </xsl:if>&#xA0;<xsl:value-of select="$jumptext"/>&#xA0;
          </i2:button>
        </td>

      </tr>
    </table>

  </xsl:template>

  <xsl:template match="PAGINATION">
    <xsl:param name="formName"/>
    <xsl:param name="noOfColumns"/>
    <xsl:param name="noOfRows"/>
    <xsl:param name="totalRecordCount"/>
    <xsl:param name="startAtRow"/>
    <xsl:param name="maxRows"/>



      <xsl:variable name="currentPage"><xsl:value-of select="ceiling(($startAtRow+1) div $maxRows)"/></xsl:variable>

      <xsl:variable name="endPage">
      <xsl:choose>
        <xsl:when test="$totalRecordCount = '1000000000000000'"><i18n:text>UnKnown</i18n:text>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="ceiling($totalRecordCount div $maxRows)"/></xsl:otherwise>
      </xsl:choose>
      </xsl:variable>

      <xsl:variable name="pageXOfY"><i18n:text>Page</i18n:text>&#xA0;<xsl:value-of select="$currentPage"/>&#xA0;<i18n:text>of</i18n:text>&#xA0;<xsl:value-of select="$endPage"/> &#xA0;</xsl:variable>
      <xsl:variable name="searchPagingTitle">&lt;b&gt;<i18n:text>Search Results</i18n:text>&lt;/b&gt;:&#xA0;<xsl:value-of select="$pageXOfY"/> </xsl:variable>
      <xsl:variable name="searchResults">&lt;b&gt;<i18n:text>Search Results</i18n:text>&lt;/b&gt;:&#xA0;</xsl:variable>
      <xsl:variable name="searchPagingTitleNoTransactions"><xsl:value-of select="$searchResults"/><i18n:text>No transactions found</i18n:text>.</xsl:variable>
      <xsl:variable name="searchPagingTitleNoEntities"><xsl:value-of select="$searchResults"/><i18n:text>No entities found</i18n:text>.</xsl:variable>


    <xsl:variable name="pStartAtRow">
      <xsl:choose>
        <xsl:when test="START_COUNT">
          <xsl:value-of select="START_COUNT/@Value"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$startAtRow"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="pRecordCount">
      <xsl:choose>
        <xsl:when test="RECORD_COUNT">
          <xsl:value-of select="RECORD_COUNT/@Value"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$totalRecordCount"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

<!--
    <xsl:variable name="pPageNum">
      <xsl:choose>
        <xsl:when test="pagenum">
          <xsl:value-of select="pagenum/@Value"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select=" '' "/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
-->

    <xsl:call-template name="i2:pagingtemplate">
      <xsl:with-param name="firsturl">
        <xsl:if test ="$currentPage &gt; 1">
          javascript:getRecords('jump','1')
        </xsl:if>
      </xsl:with-param>


      <xsl:with-param name="previousurl">
        <xsl:if test ="$currentPage &gt; 1">
          javascript:getRecords('jump','<xsl:value-of select="$currentPage - 1"/>')
        </xsl:if>
      </xsl:with-param>

      <xsl:with-param name="nexturl">
       	<xsl:if test="$currentPage &lt; $endPage or $endPage = 'UnKnown'">
          javascript:getRecords('jump','<xsl:value-of select="$currentPage + 1"/>')
      	</xsl:if>
      </xsl:with-param>

      <xsl:with-param name="lasturl">
       	<xsl:if test="$currentPage &lt; $endPage">
          javascript:getRecords('jump', '<xsl:value-of select="$endPage"/>')
        </xsl:if>
      </xsl:with-param>

      <xsl:with-param name="jumpurl">
        <xsl:if test ="($pStartAtRow &gt; 0) or ($pStartAtRow &lt; ($pRecordCount - $maxRows))">
          javascript:getRecords('jump');
        </xsl:if>
      </xsl:with-param>

      <xsl:with-param name="jumpname">pagenum</xsl:with-param>
      <xsl:with-param name="jumptext"><i18n:text>Jump</i18n:text></xsl:with-param>
    </xsl:call-template>

  </xsl:template>

</xsl:stylesheet>
