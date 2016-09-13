<%@ include file="Common.jsp" %><%!
//
//   Filename: EmpsRecord.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/01
//

static final String sFileName = "EmpsRecord.jsp";
              
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

String cSec = checkSecurity(3, session, response, request);
if ("sendRedirect".equals(cSec) ) return;
                
boolean bDebug = false;

String sAction = getParam( request, "FormAction");
String sForm = getParam( request, "FormName");
String sempsErr = "";

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
if ( sForm.equals("emps") ) {
  sempsErr = empsAction(request, response, session, out, sAction, sForm, conn, stat);
  if ( "sendRedirect".equals(sempsErr)) return;
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
<% emps_Show(request, response, session, out, sempsErr, sForm, sAction, conn, stat); %>
    <SCRIPT Language="JavaScript">
if (document.forms["emps"])
  document.emps.onsubmit=delconf;
function delconf() {
if (document.emps.FormAction.value == 'delete')
  return confirm('Delete record?');
}
</SCRIPT>
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


  String empsAction(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAction, String sForm, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
  
    String sempsErr ="";
    try {

      if (sAction.equals("")) return "";

      String sSQL="";
      String transitParams = "";
      String primaryKeyParams = "";
      String sQueryString = "";
      String sPage = "";
      String sParams = "";
      String sActionFileName = "EmpsGrid.jsp";
      String sWhere = " ";
      boolean bErr = false;
      long iCount = 0;

  
      String pPKemp_id = "";
      if (sAction.equalsIgnoreCase("cancel") ) {
        try {
          if ( stat != null ) stat.close();
          if ( conn != null ) conn.close();
        }
        catch ( java.sql.SQLException ignore ) {}
        response.sendRedirect (sActionFileName);
        return "sendRedirect";
      }

      final int iinsertAction = 1;
      final int iupdateAction = 2;
      final int ideleteAction = 3;
      int iAction = 0;

      if ( sAction.equalsIgnoreCase("insert") ) { iAction = iinsertAction; }
      if ( sAction.equalsIgnoreCase("update") ) { iAction = iupdateAction; }
      if ( sAction.equalsIgnoreCase("delete") ) { iAction = ideleteAction; }

      // Create WHERE statement

      if ( iAction == iupdateAction || iAction == ideleteAction ) { 
        pPKemp_id = getParam( request, "PK_emp_id");
        if ( isEmpty(pPKemp_id)) return sempsErr;
        sWhere = "emp_id=" + toSQL(pPKemp_id, adNumber);
      }

      String fldname="";
      String fldtitle="";
      String fldemp_login="";
      String fldemp_password="";
      String fldemp_level="";
      String flddep_id="";
      String fldaddress="";
      String fldemail="";
      String fldwork_phone="";
      String fldhome_phone="";
      String fldcell_phone="";
      String fldmanmonth="";
      String fldpicture="";
      String fldemp_id="";
      int dep_id = 0;
      int level = 0;
      int manmonth = 0;

      //** Load all form fields into variables
      
      fldname = getParam(request, "name");
      fldtitle = getParam(request, "title");
      fldemp_login = getParam(request, "emp_login");
      fldemp_password = getParam(request, "emp_password");
      fldemp_level = getParam(request, "emp_level");      
      level = Integer.parseInt(fldemp_level);
      flddep_id = getParam(request, "dep_id");      
      dep_id = Integer.parseInt(flddep_id);      
      fldaddress = getParam(request, "address");
      fldemail = getParam(request, "email");
      fldwork_phone = getParam(request, "work_phone");
      fldhome_phone = getParam(request, "home_phone");
      fldcell_phone = getParam(request, "cell_phone");
      fldmanmonth = getParam(request, "manmonth");   
      if(fldmanmonth.equals(""))
         manmonth = 0;
      else   
         manmonth = Integer.parseInt(fldmanmonth);
      fldpicture = getParam(request, "picture");
      fldemp_id = getParam(request, "emp_id");

      //** Validate fields, append errors to sempsErr
      if ( iAction == iinsertAction || iAction == iupdateAction ) {

		//** validate here
        if (sempsErr.length() > 0 ) {
          return (sempsErr);
        }
      }


      sSQL = "";
      // Create SQL statement

      switch (iAction) {
  
        case iinsertAction :
          
            //** create insert statement
            sSQL = "insert into emps(dep_id, name, title, work_phone, home_phone, cell_phone, " +
                   "address, email, picture, emp_login, emp_password, emp_level, manmonth) " + 
                   " values(" + dep_id + ", '" + fldname + "', '" + fldtitle + "', '" + fldwork_phone + "', '" + fldhome_phone + "', " + 
                   "'" + fldcell_phone + "', '" + fldaddress + "', '" + fldemail + "', '" + fldpicture + "', '" + fldemp_login + "', " +            
                   "'" + fldemp_password + "'," + level + "," + manmonth + ");";
          break;
  
      case iupdateAction:
        
          //** create update statement
          sSQL = "update emps set dep_id = " + dep_id + ", name = '" + fldname + "', title = '" + fldtitle + "', work_phone = '" + fldwork_phone + "'"+
                 ", home_phone = '" + fldhome_phone + "', cell_phone = '" + fldcell_phone + "', address = '" + fldaddress + "', email = " +
                 "'" + fldemail + "', picture = '" + fldpicture + "', emp_login = '" + fldemp_login + "', emp_password = '" + fldemp_password + "'" +
                 ", emp_level = " + level + ", manmonth = " + manmonth + " where  ";          
        break;
      
      case ideleteAction:
           //** create delete statement
           sSQL = "delete from emps where  ";
          
        break;
  
      }
      
      if(!sWhere.equals(""))
         sSQL = sSQL + sWhere + ";";

      if ( sempsErr.length() > 0 ) return sempsErr;
      try {
        // Execute SQL statement
        stat.executeUpdate(sSQL);
      }
      catch(java.sql.SQLException e) {
        sempsErr = e.toString(); return (sempsErr);
      }
  
      try {
        if ( stat != null ) stat.close();
        if ( conn != null ) conn.close();
      }
      catch ( java.sql.SQLException ignore ) {}
      response.sendRedirect (sActionFileName);

      return "sendRedirect";
    }
    catch (Exception e) {out.println(e.toString()); }
    return (sempsErr);
  }

  


  void emps_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sempsErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
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

      String fldemp_id="";
      String fldname="";
      String fldtitle="";
      String fldemp_login="";
      String fldemp_password="";
      String fldemp_level="";
      String flddep_id="";
      String fldaddress="";
      String fldemail="";
      String fldwork_phone="";
      String fldhome_phone="";
      String fldcell_phone="";
      String fldmanmonth="";
      String fldpicture="";


      boolean bPK = true;

      if ( "".equals(sempsErr)) {
        // Load primary key and form parameters
        fldemp_id = getParam( request, "emp_id");
        pemp_id = getParam( request, "emp_id");
      }
      else {
        // Load primary key, form parameters and form fields
        fldemp_id = getParam( request, "emp_id");
        fldname = getParam( request, "name");
        fldtitle = getParam( request, "title");
        fldemp_login = getParam( request, "emp_login");
        fldemp_password = getParam( request, "emp_password");
        fldemp_level = getParam( request, "emp_level");
        flddep_id = getParam( request, "dep_id");
        fldaddress = getParam( request, "address");
        fldemail = getParam( request, "email");
        fldwork_phone = getParam( request, "work_phone");
        fldhome_phone = getParam( request, "home_phone");
        fldcell_phone = getParam( request, "cell_phone");
        fldmanmonth = getParam( request, "manmonth");
        fldpicture = getParam( request, "picture");
        pemp_id = getParam( request, "PK_emp_id");
      }

      
      if ( isEmpty(pemp_id)) { bPK = false; }
      
      sWhere += "emp_id=" + toSQL(pemp_id, adNumber);
      primaryKeyParams += "<input type=\"hidden\" name=\"PK_emp_id\" value=\""+pemp_id+"\"/>";

      sSQL = "select * from emps where " + sWhere;


      out.println("    <table border=\"0\" cellspacing=\"2\" cellpadding=\"0\">");
      out.println("     <tr>\n      <td align=\"center\" bgcolor=\"#FFBB55\" colspan=\"2\"><font style=\"font-size: 12pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">emps</font></td>\n     </tr>");
      if ( ! sempsErr.equals("")) {
        out.println("     <tr>\n      <td  colspan=\"2\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+sempsErr+"</font></td>\n     </tr>");
      }
      sempsErr="";
      out.println("     <form method=\"get\" action=\""+sFileName+"\" name=\"emps\">");

      java.sql.ResultSet rs = null;

      if ( bPK &&  ! (sAction.equals("insert") && "emps".equals(sForm))) {

        // Open recordset
        rs = openrs( stat, sSQL);
        rs.next();
        String[] aFields = getFieldsName( rs );
        getRecordToHash( rs, rsHash, aFields );
        rs.close();
        fldemp_id = (String) rsHash.get("emp_id");
        if ( "".equals(sempsErr)) {
          // Load data from recordset when form displayed first time
          fldname = (String) rsHash.get("name");
          fldtitle = (String) rsHash.get("title");
          fldemp_login = (String) rsHash.get("emp_login");
          fldemp_password = (String) rsHash.get("emp_password");
          fldemp_level = (String) rsHash.get("emp_level");
          flddep_id = (String) rsHash.get("dep_id");
          fldaddress = (String) rsHash.get("address");
          fldemail = (String) rsHash.get("email");
          fldwork_phone = (String) rsHash.get("work_phone");
          fldhome_phone = (String) rsHash.get("home_phone");
          fldcell_phone = (String) rsHash.get("cell_phone");
          fldmanmonth = (String) rsHash.get("manmonth");
          fldpicture = (String) rsHash.get("picture");
        }

        if (sAction.equals("") || ! "emps".equals(sForm)) {
      
          fldemp_id = (String) rsHash.get("emp_id");
          fldname = (String) rsHash.get("name");
          fldtitle = (String) rsHash.get("title");
          fldemp_login = (String) rsHash.get("emp_login");
          fldemp_password = (String) rsHash.get("emp_password");
          fldemp_level = (String) rsHash.get("emp_level");
          flddep_id = (String) rsHash.get("dep_id");
          fldaddress = (String) rsHash.get("address");
          fldemail = (String) rsHash.get("email");
          fldwork_phone = (String) rsHash.get("work_phone");
          fldhome_phone = (String) rsHash.get("home_phone");
          fldcell_phone = (String) rsHash.get("cell_phone");
          fldmanmonth = (String) rsHash.get("manmonth");
          fldpicture = (String) rsHash.get("picture");
        }
        
      }
      else {
        if ( "".equals(sempsErr)) {
          fldemp_id = toHTML(getParam(request,"emp_id"));
        }
      }
      


      // Show form field
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Name</font></td><td >"); out.print("<input type=\"text\"  name=\"name\" maxlength=\"100\" value=\""+toHTML(fldname)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Title</font></td><td >"); out.print("<input type=\"text\"  name=\"title\" maxlength=\"50\" value=\""+toHTML(fldtitle)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Login</font></td><td >"); out.print("<input type=\"text\"  name=\"emp_login\" maxlength=\"20\" value=\""+toHTML(fldemp_login)+"\" size=\"20\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Password</font></td><td >"); out.print("<input type=\"password\"  name=\"emp_password\" maxlength=\"20\" value=\""+toHTML(fldemp_password)+"\" size=\"20\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Level</font></td><td >"); 
      out.print("<select name=\"emp_level\">"+getOptionsLOV("0;None;3;Admin",false,true,fldemp_level)+"</select>");
      
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Department</font></td><td >"); 
      out.print("<select name=\"dep_id\">"+getOptions( conn, "select dep_id, name from deps order by 2",false,true,flddep_id)+"</select>");
      
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Address</font></td><td >"); out.print("<textarea name=\"address\" cols=\"50\" rows=\"2\">"+toHTML(fldaddress)+"</textarea>");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Email</font></td><td >"); out.print("<input type=\"text\"  name=\"email\" maxlength=\"50\" value=\""+toHTML(fldemail)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Work Phone</font></td><td >"); out.print("<input type=\"text\"  name=\"work_phone\" maxlength=\"50\" value=\""+toHTML(fldwork_phone)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Home Phone</font></td><td >"); out.print("<input type=\"text\"  name=\"home_phone\" maxlength=\"50\" value=\""+toHTML(fldhome_phone)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Cell Phone</font></td><td >"); out.print("<input type=\"text\"  name=\"cell_phone\" maxlength=\"50\" value=\""+toHTML(fldcell_phone)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Man of the Month</font></td><td >"); 
      if ( fldmanmonth.equalsIgnoreCase("1") ) {
        out.print("<input checked type=\"checkbox\" name=\"manmonth\" value=\"1\">");
      }
      else {
        out.print("<input type=\"checkbox\" name=\"manmonth\" value=\"1\">");
      }
      
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Picture</font></td><td >"); out.print("<input type=\"text\"  name=\"picture\" maxlength=\"100\" value=\""+toHTML(fldpicture)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td colspan=\"2\" align=\"right\">");
      

      if ( bPK && ! (sAction.equals("insert") && "emps".equals(sForm))) {
        out.print("<input type=\"submit\" value=\"Update\" onclick=\"document.emps.FormAction.value = 'update';\">");out.print("<input type=\"submit\" value=\"Delete\" onclick=\"document.emps.FormAction.value = 'delete';\">");out.print("<input type=\"submit\" value=\"Cancel\" onclick=\"document.emps.FormAction.value = 'cancel';\">");
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"emps\"><input type=\"hidden\" value=\"update\" name=\"FormAction\">");
      }
      
      else {
        out.print("<input type=\"submit\" value=\"Insert\" onclick=\"document.emps.FormAction.value = 'insert';\">");out.print("<input type=\"submit\" value=\"Cancel\" onclick=\"document.emps.FormAction.value = 'cancel';\">");
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"emps\"><input type=\"hidden\" value=\"insert\" name=\"FormAction\">");
      }out.print("<input type=\"hidden\" name=\"emp_id\" value=\""+toHTML(fldemp_id)+"\">");
      out.print(transitParamsHidden+requiredParams+primaryKeyParams);
      out.println("</td>\n     </tr>\n     </form>\n    </table>");
      



    }
    catch (Exception e) { out.println(e.toString()); }
  } %>
