<%@ include file="/core/include_header.jsp" %>
<%@ page import="java.util.*,java.io.*,com.i2.x2.util.web.multipart.*"%>
<%
HttpSession _session = request.getSession();
String entireUrlPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();

MultipartRequest data = new MultipartRequest( request, null);

String queryStr = entireUrlPath + data.getParameter("REDIRECT_COMMAND") + "?";

//Get file name, type and content
for (Enumeration filenames = data.getFileNames(); filenames.hasMoreElements() ;) {
  String name = (String)filenames.nextElement();

  String fileSystemName = data.getFilesystemName(name);
  String contentType = data.getContentType(name);
  byte[] contents = data.getFileContent(name);

  queryStr += "FILE_NAME";
  queryStr += "=";
  queryStr += fileSystemName;
  queryStr += "&";
  queryStr += "CONTENT_TYPE";
  queryStr += "=";
  queryStr += contentType;
  queryStr += "&";

  com.i2.x2.servlet.HttpUtil.setSessionAttribute(_session, name + "_CONTENTS", (new String(contents)), false);
}

//Get all parameters
for (Enumeration params = data.getParameterNames(); params.hasMoreElements() ;) {
  String paramName = (String)params.nextElement();
  queryStr += paramName;
  queryStr += "=";
  queryStr += data.getParameter(paramName);
  if ( params.hasMoreElements() )
    queryStr += "&";
}

response.sendRedirect(queryStr);
%>


