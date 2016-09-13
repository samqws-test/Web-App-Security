<%@ include file="Common.jsp" %><%!
//
//   Filename: EmpDetail.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/01
//

static final String sFileName = "EmpDetail.jsp";
              
static final String PageBODY = "text=\"#000000\" link=\"#000080\" vlink=\"#000080\" alink=\"#000080\"";
static final String FormTABLE = "border=\"0\" cellspacing=\"2\" cellpadding=\"0\"";
static final String FormHeaderTD = "align=\"center\" bgcolor=\"#FFBB55\"";
static final String FormHeaderFONT = "style=\"font-size: 12pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\"";
static final String FieldCaptionTD = "bgcolor=\"#FFDD00\"";
static final String FieldCaptionFONT = "style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\"";
static final String DataTD = "";
static final String DataFONT = "style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\"";
static final String ColumnFONT = "style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\"";
static final String ColumnTD = "bgcolor=\"#000000\"";
%><%

boolean bDebug = false;

String sAction = getParam( request, "FormAction");
String sForm = getParam( request, "FormName");
String sRecordErr = "";

java.sql.Connection conn = null;
java.sql.Statement stat = null;
String sErr = loadDriver();
conn = cn();
stat = conn.createStatement();
if ( ! sErr.equals("") ) {
 try {
   out.println(sErr);
 }
 catch (Exception e) {}
}
if ( sForm.equals("Record") ) {
  sRecordErr = RecordAction(request, response, session, out, sAction, sForm, conn, stat);
  if ( "sendRedirect".equals(sRecordErr)) return;
}

%>            
<html>
<head>
<title>Employee Directory</title>
<meta name="GENERATOR" content="YesSoftware CodeCharge v.1.2.0 / JSP.ccp build 05/21/01"/>
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body text="#000000" link="#000080" vlink="#000080" alink="#000080">
<jsp:include page="Header.jsp" flush="true"/>
 <table>
  <tr>
   
   <td valign="top">
<% Record_Show(request, response, session, out, sRecordErr, sForm, sAction, conn, stat); %>
    
   </td>
  </tr>
 </table>


<center><font face="Arial"><small>This dynamic site was generated with <a href="http://www.codecharge.com">CodeCharge</a></small></font></center>
</body>
</html>
<%%>
<%
if ( stat != null ) stat.close();
if ( conn != null ) conn.close();
%>
<%!


  String RecordAction(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAction, String sForm, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
  
    String sRecordErr ="";
    try {

      if (sAction.equals("")) return "";

      String sSQL="";
      String transitParams = "";
      String primaryKeyParams = "";
      String sQueryString = "";
      String sPage = "";
      String sParams = "";
      String sActionFileName = "Default.jsp";
      String sWhere = " ";
      boolean bErr = false;
      long iCount = 0;

  
      sParams = "?";
      sParams += "dep_id=" + toURL(getParam( request, "Trn_dep_id")) + "&";
      sParams += "name=" + toURL(getParam( request, "Trn_name")) + "&";
      sParams += "email=" + toURL(getParam( request, "Trn_email"));
      String pPKemp_id = "";
      if (sAction.equalsIgnoreCase("cancel") ) {
        try {
          if ( stat != null ) stat.close();
          if ( conn != null ) conn.close();
        }
        catch ( java.sql.SQLException ignore ) {}
        response.sendRedirect (sActionFileName + sParams);
        return "sendRedirect";
      }

      final int iinsertAction = 1;
      final int iupdateAction = 2;
      final int ideleteAction = 3;
      int iAction = 0;

      if ( sAction.equalsIgnoreCase("insert") ) { iAction = iinsertAction; }
      if ( sAction.equalsIgnoreCase("update") ) { iAction = iupdateAction; }
      if ( sAction.equalsIgnoreCase("delete") ) { iAction = ideleteAction; }

      //** Create WHERE statement


      String fldemp_id="";
      String flddep_id="";

      //** Load all form fields into variables
    

      sSQL = "";
      //** Create SQL statement

      if ( sRecordErr.length() > 0 ) return sRecordErr;
      try {
        // Execute SQL statement
        stat.executeUpdate(sSQL);
      }
      catch(java.sql.SQLException e) {
        sRecordErr = e.toString(); return (sRecordErr);
      }
  
      try {
        if ( stat != null ) stat.close();
        if ( conn != null ) conn.close();
      }
      catch ( java.sql.SQLException ignore ) {}
      response.sendRedirect (sActionFileName + sParams);

      return "sendRedirect";
    }
    catch (Exception e) {out.println(e.toString()); }
    return (sRecordErr);
  }

  


  void Record_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sRecordErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {

      String sSQL="";
      String sQueryString = "";
      String sPage = "";
      String sWhere = "";
      String transitParams = "";
      String transitParamsHidden = "";
      String requiredParams = "";
      String primaryKeyParams ="";
      java.util.Hashtable rsHash = new java.util.Hashtable();
      
      String pemp_id = "";

      String flddep_id="";
      String fldname="";
      String fldemail="";
      String fldemp_id="";
      String fldtitle="";
      String fldwork_phone="";
      String fldcell_phone="";
      String fldhome_phone="";
      String fldaddress="";
      String fldpicture="";


      boolean bPK = true;

      if ( "".equals(sRecordErr)) {
        // Load primary key and form parameters
        flddep_id = getParam( request, "dep_id");
        fldname = getParam( request, "name");
        fldemail = getParam( request, "email");
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_dep_id\" value=\""+getParam( request, "dep_id")+"\">";
        transitParams += "Trn_dep_id="+getParam( request, "dep_id")+"&";
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_name\" value=\""+getParam( request, "name")+"\">";
        transitParams += "Trn_name="+getParam( request, "name")+"&";
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_email\" value=\""+getParam( request, "email")+"\">";
        transitParams += "Trn_email="+getParam( request, "email")+"&";
        pemp_id = getParam( request, "emp_id");
      }
      else {
        // Load primary key, form parameters and form fields
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_dep_id\" value=\""+getParam( request, "Trn_dep_id")+"\">";
        transitParams += "Trn_dep_id="+getParam( request, "Trn_dep_id")+"&";
        
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_name\" value=\""+getParam( request, "Trn_name")+"\">";
        transitParams += "Trn_name="+getParam( request, "Trn_name")+"&";
        
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_email\" value=\""+getParam( request, "Trn_email")+"\">";
        transitParams += "Trn_email="+getParam( request, "Trn_email")+"&";
        
        pemp_id = getParam( request, "PK_emp_id");
      }

      
      if ( isEmpty(pemp_id)) { bPK = false; }
      
      sWhere += "emp_id=" + toSQL(pemp_id, adNumber);
      primaryKeyParams += "<input type=\"hidden\" name=\"PK_emp_id\" value=\""+pemp_id+"\"/>";

      sSQL = "select * from emps where " + sWhere;


      out.println("    <table border=\"0\" cellspacing=\"2\" cellpadding=\"0\">");
      out.println("     <tr>\n      <td align=\"center\" bgcolor=\"#FFBB55\" colspan=\"2\"><font style=\"font-size: 12pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Employee</font></td>\n     </tr>");
      if ( ! sRecordErr.equals("")) {
        out.println("     <tr>\n      <td  colspan=\"2\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+sRecordErr+"</font></td>\n     </tr>");
      }
      sRecordErr="";
      out.println("     <form method=\"get\" action=\""+sFileName+"\" name=\"Record\">");

      java.sql.ResultSet rs = null;

      if ( bPK &&  ! (sAction.equals("insert") && "Record".equals(sForm))) {

        // Open recordset
        rs = openrs( stat, sSQL);
        rs.next();
        String[] aFields = getFieldsName( rs );
        getRecordToHash( rs, rsHash, aFields );
        rs.close();
        fldemp_id = (String) rsHash.get("emp_id");
        fldname = (String) rsHash.get("name");
        fldtitle = (String) rsHash.get("title");
        flddep_id = (String) rsHash.get("dep_id");
        fldemail = (String) rsHash.get("email");
        fldwork_phone = (String) rsHash.get("work_phone");
        fldcell_phone = (String) rsHash.get("cell_phone");
        fldhome_phone = (String) rsHash.get("home_phone");
        fldaddress = (String) rsHash.get("address");
        fldpicture = (String) rsHash.get("picture");

        if (sAction.equals("") || ! "Record".equals(sForm)) {
      
          fldemp_id = (String) rsHash.get("emp_id");
          fldname = (String) rsHash.get("name");
          fldtitle = (String) rsHash.get("title");
          flddep_id = (String) rsHash.get("dep_id");
          fldemail = (String) rsHash.get("email");
          fldwork_phone = (String) rsHash.get("work_phone");
          fldcell_phone = (String) rsHash.get("cell_phone");
          fldhome_phone = (String) rsHash.get("home_phone");
          fldaddress = (String) rsHash.get("address");
          fldpicture = (String) rsHash.get("picture");
        }
        else {
          fldemp_id = (String) rsHash.get("emp_id");
          fldname = (String) rsHash.get("name");
          fldtitle = (String) rsHash.get("title");
          flddep_id = (String) rsHash.get("dep_id");
          fldemail = (String) rsHash.get("email");
          fldwork_phone = (String) rsHash.get("work_phone");
          fldcell_phone = (String) rsHash.get("cell_phone");
          fldhome_phone = (String) rsHash.get("home_phone");
          fldaddress = (String) rsHash.get("address");
          fldpicture = (String) rsHash.get("picture");
        }
        
      }
      else {
        if ( "".equals(sRecordErr)) {
          fldname = toHTML(getParam(request,"name"));
          flddep_id = toHTML(getParam(request,"dep_id"));
          fldemail = toHTML(getParam(request,"email"));
        }
      }
      
      // Set lookup fields
          flddep_id = dLookUp( stat, "deps", "name", "dep_id=" + toSQL(flddep_id, adNumber));
      if ( "".equals(sRecordErr)) {
      
fldemail="<a href=mailto:" + fldemail + ">" + fldemail + "</a>";
fldpicture="<img border=0 src=images/emps/" + fldpicture + ">";
      }


      // Show form field
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Emp #</font></td><td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldemp_id)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Name</font></td><td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldname)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Title</font></td><td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldtitle)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Department</font></td><td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(flddep_id)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Email</font></td><td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+fldemail+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Work Phone</font></td><td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldwork_phone)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Cell Phone</font></td><td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldcell_phone)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Home Phone</font></td><td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldhome_phone)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Address</font></td><td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldaddress)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Picture</font></td><td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+fldpicture+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td colspan=\"2\" align=\"right\">");
      

      if ( bPK && ! (sAction.equals("insert") && "Record".equals(sForm))) {
        out.print("<input type=\"submit\" value=\"Back\" onclick=\"document.Record.FormAction.value = 'cancel';\">");
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"Record\"><input type=\"hidden\" value=\"\" name=\"FormAction\">");
      }
      
      out.print(transitParamsHidden+requiredParams+primaryKeyParams);
      out.println("</td>\n     </tr>\n     </form>\n    </table>");
      



    }
    catch (Exception e) { out.println(e.toString()); }
  } %>