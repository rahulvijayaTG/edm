<%@ page import="java.util.*,java.io.*,com.i2.x2.context.*,com.i2.x2.engine.*,com.i2.x2.servlet.*,com.i2.bcm.x2.util.*,org.jdom.Element;"%>
<%
System.out.println("INSIDE DOWNLOAD with new jsp");

HttpSession _session = request.getSession();
// After the latest x2.jar 12/04/02
Object xmlData = com.i2.x2.servlet.HttpUtil.getSessionAttribute(_session, "VIEW_FILE_CONTENTS", false );
//System.out.println("class-->"+xmlData);
//set the header and also the Name by which user will be prompted to save
out.clearBuffer(); //V Imp. otherwise junk characters will be generated in output
String ContentDispositionStr = " attachment; filename=" + request.getParameter("OUTPUT_FILE") ;
response.addHeader ("Content-type" ,"application/force-download");
response.addHeader ("Content-Disposition", ContentDispositionStr);
OutputStream p = response.getOutputStream();

//changes for EXPORT TO EXCEL PSR
GenerateSpreadSheet gss = new GenerateSpreadSheet();
gss.createData((Element)xmlData);
gss.write(p);

%>  
