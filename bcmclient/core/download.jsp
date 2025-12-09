<%@ page import="java.util.*,java.io.*,java.nio.ByteOrder"%><%

HttpSession _session = request.getSession();
// After the latest x2.jar 12/04/02
Object data = com.i2.x2.servlet.HttpUtil.getSessionAttribute(_session, "VIEW_FILE_CONTENTS", false );
//Object data = _session.getAttribute("VIEW_FILE_CONTENTS");
//set the header and also the Name by which user will be prompted to save

String ContentDispositionStr = " attachment; filename=" + request.getParameter("OUTPUT_FILE") ;

response.addHeader ("Content-type" ,"application/force-download; charset=unicode");
response.addHeader ("Content-Disposition", ContentDispositionStr);


byte[] contents = new byte[0];

if( data != null ){
  if( data instanceof byte[] ){
   contents = (byte[]) data;
OutputStream p = response.getOutputStream();
p.write(contents);
p.flush();
p.close();
  } else {
   String dataString = data.toString();
    ByteOrder byteOrder = ByteOrder.nativeOrder();
    if (byteOrder.equals(ByteOrder.BIG_ENDIAN))
    {
      // Needed to force BOM information to be correct
      dataString = "\ufeff"+dataString;
      response.getOutputStream().write(dataString.getBytes("UTF-16LE"));
    }
    else
    {
      response.getWriter().print(dataString);
    }

  }
}

%>