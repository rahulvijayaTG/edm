<%@ include file="/omx/headerinclude.jsp" %>
<%@ page import="com.i2.x2.util.web.multipart.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.File" %>
<%@ page import="com.i2.xcore.util.Base64" %>

<%
	HttpSession _session = request.getSession();
	String userFileName = request.getParameter("FILE_PATH");
	String tempName = request.getParameter("TEMPLATE_NAME");
	String dataType = request.getParameter("DATA_TYPE");
	String displayName = request.getParameter("DISPLAY_NAME");

  MultipartRequest data = new MultipartRequest( request, null);

  String queryStr = "local_upload_file_result.jsp?";

  int fileSize = 0;
  //Get file name, type and content
  for (Enumeration filenames = data.getFileNames(); filenames.hasMoreElements() ;) 
  {
    String name = (String)filenames.nextElement();
  
    String fileSystemName = data.getFilesystemName(name);
    String contentType = data.getContentType(name);
    byte[] contents = data.getFileContent(name);
    fileSize = (new String(contents)).length();
    
    queryStr += "FILE_NAME";
    queryStr += "=";
    queryStr += userFileName;
    queryStr += "&";
    queryStr += "FILE_SIZE";
    queryStr += "=";
    queryStr += fileSize;
    queryStr += "&";
    queryStr += "CONTENT_TYPE";
    queryStr += "=";
    queryStr += contentType;
    queryStr += "&";
    queryStr += request.getQueryString();

 		com.i2.x2.servlet.HttpUtil.setSessionAttribute(_session, "uploadContentFile", new String(Base64.encode(contents)), false);

  }

	if (fileSize == 0)
	{
		response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
		response.setHeader("Location", "upload_report/loadUploadFailure.x2c?FAIL_TYPE=FILE_NOT_FOUND&TEMPLATE_NAME=" + tempName + "&DATA_TYPE=" + dataType + "&DISPLAY_NAME=" + displayName);
	}
	else
	{
		response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
		response.setHeader("Location", queryStr);
	}

%>