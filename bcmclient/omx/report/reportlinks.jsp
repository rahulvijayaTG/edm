<!--
This is a report portal page which makes use of the CAS bo portal APIs.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<HTML>
<HEAD>
<TITLE>Reports</TITLE>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META http-equiv="Expires" content="0"/>
<script>document.domain=document.domain.substring(document.domain.indexOf('.') + 1);</script>
<script language="JavaScript" src="js/BoPortal.js"   ></script>
<script language="JavaScript" src="js/BoPortalTop.js"></script>

<%! private String requestingUrlBase; %>

<script language="JavaScript">

function init() {

  var callbackFunction = "<%= request.getParameter("CALLBACK")      %>";
  var serviceUrl       = "<%= request.getParameter("SERVICE_URL")   %>";
  var login            = "<%= request.getParameter("LOGIN_ID")      %>";
  var password         = "<%= request.getParameter("PASSWORD")      %>";
  var reportType       = "<%= request.getParameter("TYPE")          %>";
  var passThru         = "<%= request.getParameter("PASS_THRU")     %>";
  var passThruUrl      = "<%= request.getParameter("PASS_THRU_URL") %>";

  /*
   *  Just pass-thru to this url...
   */
  if ( passThru == 'true' && callbackFunction == 'bpiPortalInitDone' ) {
     cas_data_frame.location.replace(passThruUrl);
     return;
  }

  <%
      //--------------------------------------------------
      // save the base part of the url that initiated the
      // request.  will use when generating the form...
      //--------------------------------------------------
      String uri = request.getRequestURI();
      requestingUrlBase = "http://" +
                         request.getHeader("HOST") +
                         uri.substring(0, uri.lastIndexOf('/'));
  %>

  if ( reportType == 'CORPORATE' )
    boPortalTop.setGetCorpDocs(true);
  else
    boPortalTop.setGetCorpDocs(false);

  if ( reportType == 'PERSONAL' )
    boPortalTop.setGetPersDocs(true);
  else
    boPortalTop.setGetPersDocs(false);

  boPortalTop.setGetInboxDocs(false);
  boPortalTop.setCallbackFrame(this);

  boPortalTop.loginAndInit( login,
                            password,
                            serviceUrl,
                            window.helper_frame,
                            "",
                            callbackFunction );

}

/* ================================================================= *
 *  Generate a Form with all the data corresponding to the reports   *
 *  and then turn around and submit the form to a jsp that can       *
 *  call out to an x2 command which will collate it into an xml      *
 *  structure for xsl transformation/display...                      *
 * ================================================================= */
function generateForm( mDoc, docList, typeSymbol, typeHeader ) {

 var base   = '<%= requestingUrlBase + "/" %>';
 var rptKey = "<%= request.getParameter("key") %>";

  mDoc.writeln("<form name=\"reportlinks_form\" target=\"cas_data_frame\" action=\""+base+"reportlinks_content.jsp\" method=\"POST\" >" );

  var ix;
  for ( ix=0 ; ix < docList.length ; ix++ ) {
    var url = getDocumentUrl( docList[ix], typeSymbol );
    mDoc.writeln( "<input type=\"hidden\" name=\"REPORT_URL\" value=\""+url+"\">" );
    mDoc.writeln( "<input type=\"hidden\" name=\"REPORT_NAME\" value=\""+docList[ix]+"\">" );
  }

  mDoc.writeln( "<input type=\"hidden\" name=\"REPORT_TYPE\" value=\""+typeHeader+"\">" );
  mDoc.writeln( "<input type=\"hidden\" name=\"key\"         value=\""+rptKey+"\">" );
  mDoc.writeln("</form>" );
}

function bpiPortalInitDone() {

  var reportType   = "<%= request.getParameter("TYPE")   %>";
  var reportFilter = "<%= request.getParameter("FILTER") %>";
  var typeSymbol;
  var typeHeader;

  if ( reportType == 'CORPORATE' ) {
    typeSymbol = "C";
    typeHeader = "Corporate Reports";
  }
  else if ( reportType = 'PERSONAL' ) {
    typeSymbol = "P";
    typeHeader = "Standard Reports";
  }

  var mDoc = window.cas_data_frame.document;
  var docList = boPortalTop.getDocList( typeSymbol, reportFilter ); 

  /* ==================================================== *
   * generate a page which is a form, and then submit it  *
   * ==================================================== */
  mDoc.writeln("<html><head>");
  mDoc.writeln("</head><body>");
  generateForm( mDoc, docList, typeSymbol, typeHeader );
  mDoc.writeln("</body></html>");

  /* submit it */
  mDoc.reportlinks_form.submit();

}

function createDocument() {
  createDoc(cas_data_frame);
}

</script>

</HEAD>

<%
  String queryStr = request.getQueryString();
  
  if (queryStr == null)
  {
    queryStr = "";
  }
  else
  {
    queryStr = "?"+queryStr;
  }
%>


<frameset id="topmost" rows="30,*,1" marginwidth="0" frameborder="0" framespacing="0" marginheight="0" onload="init()">
	<frame name="bpi_frame" src="<%="reportlinks_header.jsp"+queryStr%>"  scrolling="no" marginheight="0" marginwidth="0">

<% if ( request.getParameter("CALLBACK").equals("createDocument") ) { %>
		<frame name="cas_data_frame" src="createblank.html"  scrolling="yes" marginheight="0" marginwidth="0">
<% } else { %>
		<frame name="cas_data_frame" src="blank.html"  scrolling="yes" marginheight="0" marginwidth="0">
<% } %>

	<frame name="helper_frame" src="blank.html"  scrolling="no" marginheight="0" marginwidth="0">	
</frameset>

<NOFRAMES>
This application requires frames!
</NOFRAMES>
</HTML>

