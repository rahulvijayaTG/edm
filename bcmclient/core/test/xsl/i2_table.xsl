<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" extension-element-prefixes="i2 " version="1.0">
	<xsl:import href="../../../core/xsl/page.xsl"/>
	<xsl:output method="html"/>
	<!-- page.xsl Javascript -->
	<!-- ********************************************************************** 
       *********************************************************************** -->
	<xsl:template name="include_javascript_onLoad">
		<script><![CDATA[
        var slave2_width = 200;
 function handletreeaction(table, relatedtable, action, scrolltop, name)
    {
      if (name != null && name != 'undefined')
        alert("user altered state of treecell item '"+name+"'");
      if (table == 'TTsyncslave')
      {
        // by delaying the resize just a bit, the browser can react 
        // to the tree actions before attempting to realign the columns
        var cmd="i2uiResizeScrollableArea('TTsyncmaster',300,20,'TTsyncslave',56)";
        setTimeout(cmd, 50);
      }
    }
      function onLoad()
      {

        onLoadSuper();//Page.xsl
        resizeContainers();
        setFocus();
      }
        ]]></script>
	</xsl:template>
	<!-- ********************************************************************** 
       *********************************************************************** -->
	<xsl:template name="include_javascript_onResize">
		<script>
      function onResize()
      {
        onResizeSuper();//Page.xsl
        resizeContainers();
      }
    </script>
	</xsl:template>
	<!-- ********************************************************************** 
     *********************************************************************** -->
	<xsl:template name="include_javascript_resize">
		<script>

  function resizeContainers()
  {
              // scroller + left margin + right margin = 16 + 10 + 10 = 36
              var x = document.body.scrollWidth - 36;
          
              i2uiResizeScrollableArea('scrollrowdemo',150,x,null,20);
              i2uiResizeColumns('scrollrowdemo');

              i2uiResizeScrollableArea('scrollcolumndemo',150,x,null,20);

              i2uiResizeScrollableArea('scrollcolumndemo2',150,x,null,20);
              
              i2uiResizeScrollableArea('scrollbothdemo',null,x-10,null,20);
              
              // margin = slave's margin + left +right = 36 + 10 + 10 = 56
              i2uiResizeScrollableArea('syncmaster',100,20,'syncslave',56);
              
              i2uiResizeScrollableArea('dualsyncslave2',200,200);
              // margin = left + right + middle = 10 + 10 + 10 = 30
              i2uiResizeScrollableArea('dualsyncmaster',200,20,'dualsyncslave',30,200);

              i2uiResizeScrollableArea('resizabledualsyncslave2',100,slave2_width);
              i2uiResizeScrollableArea('resizabledualsyncmaster',100,20,'resizabledualsyncslave',30,slave2_width);

              i2uiResizableSlave('slave2_width','resizabledualsyncmaster','resizabledualsyncslave','resizabledualsyncslave2',30);

              i2uiCollapseTreeTable('TTsyncslave',10,null,0);
              i2uiResizeScrollableArea('TTsyncmaster',300,20,'TTsyncslave',56);
              i2uiManageTreeTableUserFunction = 'handletreeaction';

              i2uiCollapseTreeTable('TT2',10,null,0);
              i2uiCollapseTreeTable('TT2span',10,null,0);
              i2uiCollapseTreeTable('TT3',0,null,1,true);

              i2uiCollapseTreeTable('simpletree',10,null,0);

              i2uiResizeScrollableArea('selectable',200,x,null,20,null,10);

  }
    </script>
	</xsl:template>
	<!-- ********************************************************************** 
     *********************************************************************** -->
	<xsl:template match="RESPONSES" mode="content">
		<xsl:call-template name="include_javascript_resize"/>
    <!-- i2 table -->
		<i2:table id="demo1a" title="some title">
			<i2:tr header="yes">
				<TD>column 1</TD>
				<TD>column 2</TD>
			</i2:tr>
			<i2:tr id="row1">
				<TD>upper left</TD>
				<TD>upper right</TD>
			</i2:tr>
			<i2:tr id="row2">
				<TD>middle left</TD>
				<TD>middle right</TD>
			</i2:tr>
			<i2:tr id="row3">
				<TD>lower left</TD>
				<TD>lower right</TD>
			</i2:tr>
			<i2:footer>test
              <i2:buttonbar>
					<i2:button name="test"/>
				</i2:buttonbar>
			</i2:footer>
		</i2:table>
		<br/>
    <!-- i2 table width 50% -->
		<i2:table width="50%" id="demo1b" title="width is 50%">
			<i2:tr header="yes">
				<TD>column 1</TD>
				<TD>column 2</TD>
			</i2:tr>
			<i2:tr id="row1">
				<TD>upper left</TD>
				<TD>upper right</TD>
			</i2:tr>
			<i2:tr id="row2">
				<TD>middle left</TD>
				<TD>middle right</TD>
			</i2:tr>
			<i2:tr id="row3">
				<TD>lower left</TD>
				<TD>lower right</TD>
			</i2:tr>
		</i2:table>
		<br/>
		<b>table - titleless</b>
		<i2:table id="demo2a">
			<i2:tr header="yes">
				<TD>column 1</TD>
				<TD>column 2</TD>
			</i2:tr>
			<i2:tr>
				<TD>special row</TD>
				<TD>class is rowHighlight</TD>
			</i2:tr>
			<i2:tr id="row1">
				<TD>upper left</TD>
				<TD>upper right</TD>
			</i2:tr>
			<i2:tr id="row2">
				<TD>middle left</TD>
				<TD>middle right</TD>
			</i2:tr>
			<i2:tr id="row3">
				<TD>lower left</TD>
				<TD>lower right</TD>
			</i2:tr>
		</i2:table>
		<br/>
		<i2:table width="50%" id="demo2b">
			<i2:tr header="yes">
				<TD>column 1</TD>
				<TD>column 2</TD>
			</i2:tr>
			<i2:tr id="row1">
				<TD>upper left</TD>
				<TD>upper right</TD>
			</i2:tr>
			<i2:tr id="row2">
				<TD>middle left</TD>
				<TD>middle right</TD>
			</i2:tr>
			<i2:tr id="row3">
				<TD>lower left</TD>
				<TD>lower right</TD>
			</i2:tr>
		</i2:table>
		<br/>
		<b>table - scrollable data rows (works in IE and NS6 only)</b>
		<i2:container title="scrollable rows" footer="nice eh?">
			<i2:table id="scrollrowdemo" scrollablerows="yes">
				<i2:tr header="yes">
					<TD>column 1</TD>
					<TD>column 2</TD>
				</i2:tr>
				<i2:tr>
					<TD>upper left</TD>
					<TD>upper right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>middle left</TD>
					<TD>middle right</TD>
				</i2:tr>
				<i2:tr>
					<TD>lower left</TD>
					<TD>lower right</TD>
				</i2:tr>
			</i2:table>
		</i2:container>
		<br/>
		<b>table - scrollable data columns (IE only)</b>
		<i2:container title="scrollable columns" footer="nice eh?">
			<i2:table id="scrollcolumndemo" scrollablecolumns="yes">
				<i2:tr header="yes">
					<td nowrap="yes">January</td>
					<td nowrap="yes">February</td>
					<td nowrap="yes">March</td>
					<td nowrap="yes">April</td>
					<td nowrap="yes">May</td>
					<td nowrap="yes">June</td>
					<td nowrap="yes">July</td>
					<td nowrap="yes">August</td>
					<td nowrap="yes">September</td>
					<td nowrap="yes">October</td>
					<td nowrap="yes">November</td>
					<td nowrap="yes">December</td>
				</i2:tr>
				<i2:tr>
					<td nowrap="yes">100</td>
					<td nowrap="yes">200</td>
					<td nowrap="yes">300</td>
					<td nowrap="yes">400</td>
					<td nowrap="yes">500</td>
					<td nowrap="yes">600</td>
					<td nowrap="yes">700</td>
					<td nowrap="yes">800</td>
					<td nowrap="yes">900</td>
					<td nowrap="yes">1000</td>
					<td nowrap="yes">1100</td>
					<td nowrap="yes">1200</td>
				</i2:tr>
				<i2:tr>
					<td nowrap="yes">100</td>
					<td nowrap="yes">200</td>
					<td nowrap="yes">300</td>
					<td nowrap="yes">400</td>
					<td nowrap="yes">500</td>
					<td nowrap="yes">600</td>
					<td nowrap="yes">700</td>
					<td nowrap="yes">800</td>
					<td nowrap="yes">900</td>
					<td nowrap="yes">1000</td>
					<td nowrap="yes">1100</td>
					<td nowrap="yes">1200</td>
				</i2:tr>
				<i2:tr>
					<td nowrap="yes">100</td>
					<td nowrap="yes">200</td>
					<td nowrap="yes">300</td>
					<td nowrap="yes">400</td>
					<td nowrap="yes">500</td>
					<td nowrap="yes">600</td>
					<td nowrap="yes">700</td>
					<td nowrap="yes">800</td>
					<td nowrap="yes">900</td>
					<td nowrap="yes">1000</td>
					<td nowrap="yes">1100</td>
					<td nowrap="yes">1200</td>
				</i2:tr>
				<i2:tr>
					<td nowrap="yes">100</td>
					<td nowrap="yes">200</td>
					<td nowrap="yes">300</td>
					<td nowrap="yes">400</td>
					<td nowrap="yes">500</td>
					<td nowrap="yes">600</td>
					<td nowrap="yes">700</td>
					<td nowrap="yes">800</td>
					<td nowrap="yes">900</td>
					<td nowrap="yes">1000</td>
					<td nowrap="yes">1100</td>
					<td nowrap="yes">1200</td>
				</i2:tr>
			</i2:table>
		</i2:container>
		<br/>
		<b>table - auto scrollable data columns (IE only)</b>
		<i2:container title="auto scrollable columns" footer="nice eh?">
			<i2:table id="scrollcolumndemo2" scrollablecolumns="auto">
				<i2:tr header="yes">
					<td nowrap="yes">January</td>
					<td nowrap="yes">February</td>
					<td nowrap="yes">March</td>
					<td nowrap="yes">April</td>
					<td nowrap="yes">May</td>
					<td nowrap="yes">June</td>
					<td nowrap="yes">July</td>
					<td nowrap="yes">August</td>
					<td nowrap="yes">September</td>
					<td nowrap="yes">October</td>
					<td nowrap="yes">November</td>
					<td nowrap="yes">December</td>
				</i2:tr>
				<i2:tr>
					<td nowrap="yes">100</td>
					<td nowrap="yes">200</td>
					<td nowrap="yes">300</td>
					<td nowrap="yes">400</td>
					<td nowrap="yes">500</td>
					<td nowrap="yes">600</td>
					<td nowrap="yes">700</td>
					<td nowrap="yes">800</td>
					<td nowrap="yes">900</td>
					<td nowrap="yes">1000</td>
					<td nowrap="yes">1100</td>
					<td nowrap="yes">1200</td>
				</i2:tr>
				<i2:tr>
					<td nowrap="yes">100</td>
					<td nowrap="yes">200</td>
					<td nowrap="yes">300</td>
					<td nowrap="yes">400</td>
					<td nowrap="yes">500</td>
					<td nowrap="yes">600</td>
					<td nowrap="yes">700</td>
					<td nowrap="yes">800</td>
					<td nowrap="yes">900</td>
					<td nowrap="yes">1000</td>
					<td nowrap="yes">1100</td>
					<td nowrap="yes">1200</td>
				</i2:tr>
				<i2:tr>
					<td nowrap="yes">100</td>
					<td nowrap="yes">200</td>
					<td nowrap="yes">300</td>
					<td nowrap="yes">400</td>
					<td nowrap="yes">500</td>
					<td nowrap="yes">600</td>
					<td nowrap="yes">700</td>
					<td nowrap="yes">800</td>
					<td nowrap="yes">900</td>
					<td nowrap="yes">1000</td>
					<td nowrap="yes">1100</td>
					<td nowrap="yes">1200</td>
				</i2:tr>
				<i2:tr>
					<td nowrap="yes">100</td>
					<td nowrap="yes">200</td>
					<td nowrap="yes">300</td>
					<td nowrap="yes">400</td>
					<td nowrap="yes">500</td>
					<td nowrap="yes">600</td>
					<td nowrap="yes">700</td>
					<td nowrap="yes">800</td>
					<td nowrap="yes">900</td>
					<td nowrap="yes">1000</td>
					<td nowrap="yes">1100</td>
					<td nowrap="yes">1200</td>
				</i2:tr>
			</i2:table>
		</i2:container>
		<br/>
		<b>table - scrollable data both (works in IE, NS6 only has scrollable rows)</b>
		<i2:container title="scrollable both" footer="works">
			<i2:table id="scrollbothdemo" scrollablerows="yes" scrollablecolumns="yes">
				<i2:tr header="yes">
					<td nowrap="yes">January</td>
					<td nowrap="yes">February</td>
					<td nowrap="yes">March</td>
					<td nowrap="yes">April</td>
					<td nowrap="yes">May</td>
					<td nowrap="yes">June</td>
					<td nowrap="yes">July</td>
					<td nowrap="yes">August</td>
					<td nowrap="yes">September</td>
					<td nowrap="yes">October</td>
					<td nowrap="yes">November</td>
					<td nowrap="yes">December</td>
				</i2:tr>
				<i2:tr>
					<td nowrap="yes">100</td>
					<td nowrap="yes">200</td>
					<td nowrap="yes">300</td>
					<td nowrap="yes">400</td>
					<td nowrap="yes">500</td>
					<td nowrap="yes">600</td>
					<td nowrap="yes">700</td>
					<td nowrap="yes">800</td>
					<td nowrap="yes">900</td>
					<td nowrap="yes">1000</td>
					<td nowrap="yes">1100</td>
					<td nowrap="yes">1200</td>
				</i2:tr>
				<i2:tr>
					<td nowrap="yes">100</td>
					<td nowrap="yes">200</td>
					<td nowrap="yes">300</td>
					<td nowrap="yes">400</td>
					<td nowrap="yes">500</td>
					<td nowrap="yes">600</td>
					<td nowrap="yes">700</td>
					<td nowrap="yes">800</td>
					<td nowrap="yes">900</td>
					<td nowrap="yes">1000</td>
					<td nowrap="yes">1100</td>
					<td nowrap="yes">1200</td>
				</i2:tr>
				<i2:tr>
					<td nowrap="yes">100</td>
					<td nowrap="yes">200</td>
					<td nowrap="yes">300</td>
					<td nowrap="yes">400</td>
					<td nowrap="yes">500</td>
					<td nowrap="yes">600</td>
					<td nowrap="yes">700</td>
					<td nowrap="yes">800</td>
					<td nowrap="yes">900</td>
					<td nowrap="yes">1000</td>
					<td nowrap="yes">1100</td>
					<td nowrap="yes">1200</td>
				</i2:tr>
				<i2:tr>
					<td nowrap="yes">100</td>
					<td nowrap="yes">200</td>
					<td nowrap="yes">300</td>
					<td nowrap="yes">400</td>
					<td nowrap="yes">500</td>
					<td nowrap="yes">600</td>
					<td nowrap="yes">700</td>
					<td nowrap="yes">800</td>
					<td nowrap="yes">900</td>
					<td nowrap="yes">1000</td>
					<td nowrap="yes">1100</td>
					<td nowrap="yes">1200</td>
				</i2:tr>
				<i2:tr>
					<td nowrap="yes">100</td>
					<td nowrap="yes">200</td>
					<td nowrap="yes">300</td>
					<td nowrap="yes">400</td>
					<td nowrap="yes">500</td>
					<td nowrap="yes">600</td>
					<td nowrap="yes">700</td>
					<td nowrap="yes">800</td>
					<td nowrap="yes">900</td>
					<td nowrap="yes">1000</td>
					<td nowrap="yes">1100</td>
					<td nowrap="yes">1200</td>
				</i2:tr>
				<i2:tr>
					<td nowrap="yes">100</td>
					<td nowrap="yes">200</td>
					<td nowrap="yes">300</td>
					<td nowrap="yes">400</td>
					<td nowrap="yes">500</td>
					<td nowrap="yes">600</td>
					<td nowrap="yes">700</td>
					<td nowrap="yes">800</td>
					<td nowrap="yes">900</td>
					<td nowrap="yes">1000</td>
					<td nowrap="yes">1100</td>
					<td nowrap="yes">1200</td>
				</i2:tr>
				<i2:tr>
					<td nowrap="yes">100</td>
					<td nowrap="yes">200</td>
					<td nowrap="yes">300</td>
					<td nowrap="yes">400</td>
					<td nowrap="yes">500</td>
					<td nowrap="yes">600</td>
					<td nowrap="yes">700</td>
					<td nowrap="yes">800</td>
					<td nowrap="yes">900</td>
					<td nowrap="yes">1000</td>
					<td nowrap="yes">1100</td>
					<td nowrap="yes">1200</td>
				</i2:tr>
				<i2:tr>
					<td nowrap="yes">100</td>
					<td nowrap="yes">200</td>
					<td nowrap="yes">300</td>
					<td nowrap="yes">400</td>
					<td nowrap="yes">500</td>
					<td nowrap="yes">600</td>
					<td nowrap="yes">700</td>
					<td nowrap="yes">800</td>
					<td nowrap="yes">900</td>
					<td nowrap="yes">1000</td>
					<td nowrap="yes">1100</td>
					<td nowrap="yes">1200</td>
				</i2:tr>
			</i2:table>
		</i2:container>
		<br/>
		<b>table - scrollable data syncronized (IE only)</b>
		<i2:container title="scrollable N'Sync">
			<i2:footer>
      this works too!
    </i2:footer>
			<table width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top">
						<i2:table id="syncslave" scrollablerows="hidden">
							<i2:tr header="yes">
								<td nowrap="yes">first</td>
								<td nowrap="yes">last</td>
								<td nowrap="yes">address</td>
								<td nowrap="yes">city</td>
								<td nowrap="yes">state</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">larry</td>
								<td nowrap="yes">mason</td>
								<td nowrap="yes">2107 birdwood</td>
								<td nowrap="yes">corinth</td>
								<td nowrap="yes">tx</td>
							</i2:tr>
							<i2:tr>
								<td>donna</td>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
							<i2:tr>
								<td>caitlin</td>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
							<i2:tr>
								<td>bethany</td>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
							<i2:tr>
								<td>biskit</td>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
							<i2:tr>
								<td>fish1</td>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
							<i2:tr>
								<td>fish2</td>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
							<i2:tr>
								<td>fish3</td>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
						</i2:table>
					</td>
					<td valign="top" width="100%">
						<i2:table id="syncmaster" scrollablerows="yes" scrollablecolumns="yes" scrollablesyncedtable="syncslave">
							<i2:tr header="yes">
								<td nowrap="yes">January</td>
								<td nowrap="yes">February</td>
								<td nowrap="yes">March</td>
								<td nowrap="yes">April</td>
								<td nowrap="yes">May</td>
								<td nowrap="yes">June</td>
								<td nowrap="yes">July</td>
								<td nowrap="yes">August</td>
								<td nowrap="yes">September</td>
								<td nowrap="yes">October</td>
								<td nowrap="yes">November</td>
								<td nowrap="yes">December</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
						</i2:table>
					</td>
				</tr>
			</table>
		</i2:container>
		<br/>
		<b>table - dual scrollable data syncronized (IE only)</b>
		<i2:container title="dual scrollable N'Sync (also multiple header rows in master)">
			<i2:footer>
      all rows in sync, 2 sets of scrollable columns. known in SCP as 'axis-cross'
      </i2:footer>
			<table width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top">
						<i2:table id="dualsyncslave2" scrollablecolumns="yes" scrollablerows="hidden">
							<i2:tr header="yes">
								<td nowrap="yes">first</td>
								<td nowrap="yes">last</td>
								<td nowrap="yes">address</td>
								<td nowrap="yes">city</td>
								<td nowrap="yes">state</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">larry</td>
								<td nowrap="yes">mason</td>
								<td nowrap="yes">2107 birdwood circle drive lane avenue</td>
								<td nowrap="yes">corinth</td>
								<td nowrap="yes">tx</td>
							</i2:tr>
							<i2:tr>
								<td>donna</td>
								<td>mason</td>
								<td>2107 birdwood circle drive</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
							<i2:tr>
								<td>caitlin</td>
								<td>mason</td>
								<td>2107 birdwood circle</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
							<i2:tr>
								<td>bethany</td>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
						</i2:table>
					</td>
					<td valign="top">
						<i2:table id="dualsyncslave" scrollablerows="hidden">
							<i2:tr header="yes">
								<td nowrap="yes">&#xA0;</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">
									<b>Budget</b>
								</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">
									<b>Actual</b>
								</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">
									<b>Budget</b>
								</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">
									<b>Actual</b>
								</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">
									<b>Budget</b>
								</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">
									<b>Actual</b>
								</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">
									<b>Budget</b>
								</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">
									<b>Actual</b>
								</td>
							</i2:tr>
						</i2:table>
					</td>
					<td valign="top" width="100%">
						<i2:table id="dualsyncmaster" scrollablerows="yes" scrollablecolumns="yes" scrollablesyncedtable="dualsyncslave">
							<i2:tr header="yes">
								<td nowrap="yes" colspan="3">
									<center>Q1</center>
								</td>
								<td nowrap="yes" colspan="3">
									<center>Q2</center>
								</td>
							</i2:tr>
							<i2:tr header="yes">
								<td nowrap="yes">January</td>
								<td nowrap="yes">February</td>
								<td nowrap="yes">March</td>
								<td nowrap="yes">April</td>
								<td nowrap="yes">May</td>
								<td nowrap="yes">June</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">102</td>
								<td nowrap="yes">250</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">490</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">120</td>
								<td nowrap="yes">240</td>
								<td nowrap="yes">330</td>
								<td nowrap="yes">490</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">130</td>
								<td nowrap="yes">280</td>
								<td nowrap="yes">340</td>
								<td nowrap="yes">450</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">50</td>
								<td nowrap="yes">209</td>
								<td nowrap="yes">350</td>
								<td nowrap="yes">430</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
							</i2:tr>
						</i2:table>
					</td>
				</tr>
			</table>
		</i2:container>
		<br/>
		<i2:container title="resizable dual scrollable N'Sync (IE only)">
			<i2:footer>
      all rows in sync, 2 sets of scrollable columns PLUS resizable
    </i2:footer>
			<table width="100%" cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td valign="top">
						<i2:table id="resizabledualsyncslave2" scrollablecolumns="yes" scrollablerows="hidden">
							<i2:tr header="yes">
								<td nowrap="yes">first</td>
								<td nowrap="yes">last</td>
								<td nowrap="yes">address</td>
								<td nowrap="yes">city</td>
								<td nowrap="yes">state</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">larry</td>
								<td nowrap="yes">mason</td>
								<td nowrap="yes">2107 birdwood</td>
								<td nowrap="yes">corinth</td>
								<td nowrap="yes">tx</td>
							</i2:tr>
							<i2:tr>
								<td>donna</td>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
							<i2:tr>
								<td>caitlin</td>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
							<i2:tr>
								<td>bethany</td>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
						</i2:table>
					</td>
					<td valign="top">
						<i2:table id="resizabledualsyncslave" scrollablerows="hidden">
							<i2:tr header="yes">
								<td nowrap="yes" align="center">
									<i2:img id="TABLERESIZE_slave2_width" src="/slider_icon.gif"/>
								</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">
									<b>Budget</b>
								</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">
									<b>Actual</b>
								</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">
									<b>Budget</b>
								</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">
									<b>Actual</b>
								</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">
									<b>Budget</b>
								</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">
									<b>Actual</b>
								</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">
									<b>Budget</b>
								</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">
									<b>Actual</b>
								</td>
							</i2:tr>
						</i2:table>
					</td>
					<td valign="top" width="100%">
						<i2:table id="resizabledualsyncmaster" scrollablerows="yes" scrollablecolumns="yes" scrollablesyncedtable="resizabledualsyncslave">
							<i2:tr header="yes">
								<td nowrap="yes">January</td>
								<td nowrap="yes">February</td>
								<td nowrap="yes">March</td>
								<td nowrap="yes">April</td>
								<td nowrap="yes">May</td>
								<td nowrap="yes">June</td>
								<td nowrap="yes">July</td>
								<td nowrap="yes">August</td>
								<td nowrap="yes">September</td>
								<td nowrap="yes">October</td>
								<td nowrap="yes">November</td>
								<td nowrap="yes">December</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">102</td>
								<td nowrap="yes">250</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">490</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">120</td>
								<td nowrap="yes">240</td>
								<td nowrap="yes">330</td>
								<td nowrap="yes">490</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">130</td>
								<td nowrap="yes">280</td>
								<td nowrap="yes">340</td>
								<td nowrap="yes">450</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">50</td>
								<td nowrap="yes">209</td>
								<td nowrap="yes">350</td>
								<td nowrap="yes">430</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
						</i2:table>
					</td>
				</tr>
			</table>
		</i2:container>
		<br/>
		<b>table - first column contains a tree structure</b>
		<i2:table id="TT2" title="tree in a table">
			<i2:tr header="yes">
				<td>column 1</td>
				<td>column 2</td>
				<td>column 3</td>
			</i2:tr>
			<i2:tr>
				<i2:treecell depth="0" column="0" name="one">name 1</i2:treecell>
				<td>column 2</td>
				<td>column 3</td>
			</i2:tr>
			<i2:tr>
				<i2:treecell depth="1" name="one_one">name 1_1</i2:treecell>
				<td>column 2</td>
				<td>column 3</td>
			</i2:tr>
			<i2:tr>
				<i2:treecell depth="2" name="one_one_one">name 1_1_1</i2:treecell>
				<td>column 2</td>
				<td>column 3</td>
			</i2:tr>
			<i2:tr>
				<i2:treecell depth="2" name="one_one_two">name 1_1_2</i2:treecell>
				<td>column 2</td>
				<td>column 3</td>
			</i2:tr>
			<i2:tr>
				<i2:treecell depth="1" name="one_two">name 1_2</i2:treecell>
				<td>column 2</td>
				<td>column 3</td>
			</i2:tr>
		</i2:table>
		<br/>
		<form>
			<b>table - second column contains a tree structure</b>
			<i2:table id="TT3" title="tree in a table">
				<i2:tr header="yes">
					<td width="10">&#xA0;</td>
					<td>column 1</td>
					<td>column 2</td>
					<td>column 3</td>
				</i2:tr>
				<i2:tr>
					<td>
						<input name="rowpicker" type="checkbox" value="row1"/>
					</td>
					<i2:treecell depth="0" column="1">name 1</i2:treecell>
					<td>column 2</td>
					<td>column 3</td>
				</i2:tr>
				<i2:tr>
					<td>
						<input name="rowpicker" type="checkbox" value="row2"/>
					</td>
					<i2:treecell depth="1" column="1">name 1_1</i2:treecell>
					<td>column 2</td>
					<td>column 3</td>
				</i2:tr>
				<i2:tr>
					<td>
						<input name="rowpicker" type="checkbox" value="row3"/>
					</td>
					<i2:treecell depth="2" column="1">name 1_1_1</i2:treecell>
					<td>column 2</td>
					<td>column 3</td>
				</i2:tr>
				<i2:tr>
					<td>
						<input name="rowpicker" type="checkbox" value="row4"/>
					</td>
					<i2:treecell depth="2" column="1">name 1_1_2</i2:treecell>
					<td>column 2</td>
					<td>column 3</td>
				</i2:tr>
				<i2:tr>
					<td>
						<input name="rowpicker" type="checkbox" value="row5"/>
					</td>
					<i2:treecell depth="1" column="1">name 1_2</i2:treecell>
					<td>column 2</td>
					<td>column 3</td>
				</i2:tr>
			</i2:table>
		</form>
		<br/>
		<i2:container title="tree in a sync'd scrollable table (also multiple header rows)">
			<table width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top">
						<i2:table id="TTsyncslave" scrollablerows="hidden" relatedtableids="TTsyncmaster">
							<i2:tr header="yes">
								<td nowrap="yes">first</td>
								<td nowrap="yes">last</td>
								<td nowrap="yes">street</td>
								<td nowrap="yes">city</td>
								<td nowrap="yes">state</td>
							</i2:tr>
							<i2:tr>
								<i2:treecell depth="0">
              larry
              </i2:treecell>
								<td nowrap="yes">mason</td>
								<td nowrap="yes">2107 birdwood</td>
								<td nowrap="yes">corinth</td>
								<td nowrap="yes">tx</td>
							</i2:tr>
							<i2:tr>
								<i2:treecell depth="0">
              donna
              </i2:treecell>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
							<i2:tr>
								<i2:treecell depth="1">
              caitlin
              </i2:treecell>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
							<i2:tr>
								<i2:treecell depth="2">
              fish1
              </i2:treecell>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
							<i2:tr>
								<i2:treecell depth="2">
              fish2
              </i2:treecell>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
							<i2:tr>
								<i2:treecell depth="2">
              fish3
              </i2:treecell>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
							<i2:tr>
								<i2:treecell depth="1">
              bethany
              </i2:treecell>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
							<i2:tr>
								<i2:treecell depth="2">
              biskit
              </i2:treecell>
								<td>mason</td>
								<td>2107 birdwood</td>
								<td>corinth</td>
								<td>tx</td>
							</i2:tr>
						</i2:table>
					</td>
					<td valign="top" width="100%">
						<i2:table id="TTsyncmaster" scrollablerows="yes" scrollablecolumns="yes" scrollablesyncedtable="TTsyncslave">
							<i2:tr header="yes">
								<td nowrap="yes" colspan="3">
									<center>Q1</center>
								</td>
								<td nowrap="yes" colspan="3">
									<center>Q2</center>
								</td>
								<td nowrap="yes" colspan="3">
									<center>Q3</center>
								</td>
								<td nowrap="yes" colspan="3">
									<center>Q4</center>
								</td>
							</i2:tr>
							<i2:tr header="yes">
								<td nowrap="yes">January</td>
								<td nowrap="yes">February</td>
								<td nowrap="yes">March</td>
								<td nowrap="yes">April</td>
								<td nowrap="yes">May</td>
								<td nowrap="yes">June</td>
								<td nowrap="yes">July</td>
								<td nowrap="yes">August</td>
								<td nowrap="yes">September</td>
								<td nowrap="yes">October</td>
								<td nowrap="yes">November</td>
								<td nowrap="yes">December</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
							<i2:tr>
								<td nowrap="yes">100</td>
								<td nowrap="yes">200</td>
								<td nowrap="yes">300</td>
								<td nowrap="yes">400</td>
								<td nowrap="yes">500</td>
								<td nowrap="yes">600</td>
								<td nowrap="yes">700</td>
								<td nowrap="yes">800</td>
								<td nowrap="yes">900</td>
								<td nowrap="yes">1000</td>
								<td nowrap="yes">1100</td>
								<td nowrap="yes">1200</td>
							</i2:tr>
						</i2:table>
					</td>
				</tr>
			</table>
		</i2:container>
		<br/>
A scrollable table with a fixed width for column 1.  Makes it very narrow.
<form>
			<i2:table id="selectable" scrollablerows="auto" scrollablecolumns="auto">
				<i2:tr header="yes">
					<th nowrap="yes">
						<input type="checkbox"/>
					</th>
					<td nowrap="yes">column 1</td>
					<td nowrap="yes">column 2</td>
					<td nowrap="yes">column 3</td>
				</i2:tr>
				<i2:tr>
					<th nowrap="yes">
						<input type="checkbox"/>
					</th>
					<td nowrap="yes">larry</td>
					<td nowrap="yes">this_is_very_wide_stuff which_may_take_multiple_rows or_then_maybe_not</td>
					<td nowrap="yes">test</td>
				</i2:tr>
				<i2:tr>
					<th nowrap="yes">
						<input type="checkbox"/>
					</th>
					<td nowrap="yes">larry</td>
					<td nowrap="yes">this_is_very_wide_stuff</td>
					<td nowrap="yes">test</td>
				</i2:tr>
			</i2:table>
		</form>
    <br/>
    <i2:container title="A simple tree" width="200">
      <i2:tree id="simpletree">
        <i2:treecell depth="0" onclick="i2uiToggleTabNoop()">
          larry
        </i2:treecell>
        <i2:treecell depth="0" onclick="i2uiToggleTabNoop()">
          donna
        </i2:treecell>
        <i2:treecell depth="1" onclick="i2uiToggleTabNoop()">
          caitlin
        </i2:treecell>
        <i2:treecell depth="2" onclick="i2uiToggleTabNoop()">
          fish1
        </i2:treecell>
        <i2:treecell depth="2" onclick="i2uiToggleTabNoop()">
          fish2
        </i2:treecell>
        <i2:treecell depth="1" onclick="i2uiToggleTabNoop()">
          bethany
        </i2:treecell>
        <i2:treecell depth="2" onclick="i2uiToggleTabNoop()">
          biskit
        </i2:treecell>
      </i2:tree>
    </i2:container>
	</xsl:template>
</xsl:stylesheet>
