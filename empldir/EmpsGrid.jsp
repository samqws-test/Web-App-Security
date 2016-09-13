<%@ include file="Common.jsp" %><%!
//
//   Filename: EmpsGrid.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/01
//

static final String sFileName = "EmpsGrid.jsp";
              
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

out.println("Value of session = " + session.getAttribute("UserID"));

String cSec = checkSecurity(3, session, response, request);
if ("sendRedirect".equals(cSec) ) return;
                
boolean bDebug = false;

String sAction = getParam( request, "FormAction");
String sForm = getParam( request, "FormName");
String sempsErr = "";
String sSearchErr = "";

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
<% Search_Show(request, response, session, out, sSearchErr, sForm, sAction, conn, stat); %>
    
   </td>
  </tr>
 </table>
 <table>
  <tr>
   <td valign="top">
<% emps_Show(request, response, session, out, sempsErr, sForm, sAction, conn, stat); %>
    
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

  void emps_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sempsErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException  {
  
    String sWhere = "";
    int iCounter=0;
    int iPage = 0;
    boolean bIsScroll = true;
    boolean hasParam = false;
    String sOrder = "";
    String sSQL="";
    String transitParams = "";
    String sQueryString = "";
    String sPage = "";
    int RecordsPerPage = 20;
    String sSortParams = "";
    String formParams = "";

      String pemp_login="";
      String pmanmonth="";
      String pname="";  
      int manmonth = 0;


    transitParams = "emp_login=" + toURL(getParam( request, "emp_login")) + "&name=" + toURL(getParam( request, "name")) + "&manmonth=" + toURL(getParam( request, "manmonth")) + "&";
    formParams = "emp_login=" + toURL(getParam( request, "emp_login")) + "&name=" + toURL(getParam( request, "name")) + "&manmonth=" + toURL(getParam( request, "manmonth")) + "&"; 
    // Build WHERE statement
        
    //** Check emp_login parameter and create a valid sql for where clause
    
    pemp_login = getParam( request, "emp_login");
    if (pemp_login != null && !pemp_login.equals("")){
    
        hasParam = true;
        sWhere += " e.emp_login like '%" + replace(pemp_login,"'", "''") + "%'";
    }
    
    //** Check manmonth parameter and create a valid sql for where clause
    
    pmanmonth = getParam( request, "manmonth");
    if(pmanmonth.equals("Yes")){
      manmonth = 1;
    }
    else if(pmanmonth.equals("No")){
      manmonth = 0;
    }
    else
      pmanmonth = "";
    if(!pmanmonth.equals("")){
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += " e.manmonth = " + manmonth;
    }
    
    //** Check name parameter and create a valid sql for where clause
    
    pname = getParam( request, "name");
    if (pname != null && ! pname.equals("")) {
            
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += " e.name like '%" + replace(pname, "'", "''") + "%'";
    }    
    
    if (hasParam) { sWhere = " WHERE (" + sWhere + ")"; }
    // Build ORDER statement
    sOrder = " order by e.emp_login Asc";
    String sSort = getParam( request, "Formemps_Sorting");
    String sSorted = getParam( request, "Formemps_Sorted");
    String sDirection = "";
    String sForm_Sorting = "";
    int iSort = 0;
    try {
      iSort = Integer.parseInt(sSort);
    }
    catch (NumberFormatException e ) {
      sSort = "";
    }
    if ( iSort == 0 ) {
      sForm_Sorting = "";
    }
    else {
      if ( sSort.equals(sSorted)) { 
        sSorted="0";
        sForm_Sorting = "";
        sDirection = " DESC";
        sSortParams = "Formemps_Sorting=" + sSort + "&Formemps_Sorted=" + sSort + "&";
      }
      else {
        sSorted=sSort;
        sForm_Sorting = sSort;
        sDirection = " ASC";
        sSortParams = "Formemps_Sorting=" + sSort + "&Formemps_Sorted=" + "&";
      }
    
      if ( iSort == 1) { sOrder = " order by e.emp_login" + sDirection; }
      if ( iSort == 2) { sOrder = " order by e.name" + sDirection; }
      if ( iSort == 3) { sOrder = " order by e.emp_level" + sDirection; }
      if ( iSort == 4) { sOrder = " order by e.manmonth" + sDirection; }
    }
  

  // Build full SQL statement
  
  sSQL = "select e.emp_id as e_emp_id, " +
    "e.emp_level as e_emp_level, " +
    "e.emp_login as e_emp_login, " +
    "e.manmonth as e_manmonth, " +
    "e.name as e_name " +
    " from emps e ";
  
  sSQL = sSQL + sWhere + sOrder;

  String sNoRecords = "     <tr>\n      <td colspan=\"5\" ><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">No records</font></td>\n     </tr>";


  String tableHeader = "";
      tableHeader = "     <tr>\n      <td bgcolor=\"#000000\"><a &\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Edit</font></a></td>\n      <td bgcolor=\"#000000\"><a href=\""+sFileName+"?"+formParams+"Formemps_Sorting=1&Formemps_Sorted="+sSorted+"&\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Login</font></a></td>\n      <td bgcolor=\"#000000\"><a href=\""+sFileName+"?"+formParams+"Formemps_Sorting=2&Formemps_Sorted="+sSorted+"&\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Name</font></a></td>\n      <td bgcolor=\"#000000\"><a href=\""+sFileName+"?"+formParams+"Formemps_Sorting=3&Formemps_Sorted="+sSorted+"&\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Level</font></a></td>\n      <td bgcolor=\"#000000\"><a href=\""+sFileName+"?"+formParams+"Formemps_Sorting=4&Formemps_Sorted="+sSorted+"&\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Man of the Month</font></a></td>\n     </tr>";
  
  
  try {
    out.println("    <table border=\"0\" cellspacing=\"2\" cellpadding=\"0\">");
    out.println("     <tr>\n      <td align=\"center\" bgcolor=\"#FFBB55\" colspan=\"5\"><a name=\"emps\"><font style=\"font-size: 12pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Employees</font></a></td>\n     </tr>");
    out.println(tableHeader);

  }
  catch (Exception e) {}

  
  try {
    // Select current page
    iPage = Integer.parseInt(getParam( request, "Formemps_Page"));
  }
  catch (NumberFormatException e ) {
    iPage = 0;
  }

  if (iPage == 0) { iPage = 1; }
  RecordsPerPage = 20;
  try {
    java.sql.ResultSet rs = null;
    // Open recordset
    rs = openrs( stat, sSQL);
    iCounter = 0;
    absolute (rs, (iPage-1)*RecordsPerPage+1);
    java.util.Hashtable rsHash = new java.util.Hashtable();
    String[] aFields = getFieldsName( rs );

    // Show main table based on recordset
    while ( (iCounter < RecordsPerPage) && rs.next() ) {

      getRecordToHash( rs, rsHash, aFields );
      String fldemp_level = (String) rsHash.get("e_emp_level");
      String fldemp_login = (String) rsHash.get("e_emp_login");
      String fldmanmonth = (String) rsHash.get("e_manmonth");
      String fldname = (String) rsHash.get("e_name");
      String fldemp_id= "Edit";

      out.println("     <tr>");
      
      out.print("      <td >"); out.print("<a href=\"EmpsRecord.jsp?"+transitParams+"emp_id="+toURL((String) rsHash.get("e_emp_id"))+"&\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldemp_id)+"</font></a>");

      out.println("</td>");
      out.print("      <td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldemp_login)+"&nbsp;</font>");
      out.println("</td>");
      out.print("      <td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldname)+"&nbsp;</font>");
      out.println("</td>");
      out.print("      <td >"); 
        fldemp_level = getValFromLOV(fldemp_level, "0;;3;Admin");out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldemp_level)+"&nbsp;</font>");
      out.println("</td>");
      out.print("      <td >"); 
        fldmanmonth = getValFromLOV(fldmanmonth, "0;;1;Yes");out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldmanmonth)+"&nbsp;</font>");
      out.println("</td>");
      out.println("     </tr>");
    
      iCounter++;
    }
    if (iCounter == 0) {
      // Recordset is empty
      out.println(sNoRecords);
    
      out.print("     <tr>\n      <td colspan=\"5\" bgcolor=\"#000000\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">");
      out.print("<a href=\"EmpsRecord.jsp?"+formParams+"\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Insert</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.println("</td>\n     </tr>");
    
      iCounter = RecordsPerPage+1;
      bIsScroll = false;
    }

    else {

  
    // Parse scroller
    boolean bInsert = false;
    boolean bNext = rs.next();
    if ( !bNext && iPage == 1 ) {
    
      out.print("     <tr>\n      <td colspan=\"5\" bgcolor=\"#000000\">\n       <font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">");
      out.print("\n        <a href=\"EmpsRecord.jsp?"+formParams+"\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Insert</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.println("\n      </td>\n     </tr>");
    
    }
    else {
      out.print("     <tr>\n      <td colspan=\"5\" bgcolor=\"#000000\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">");
    
      out.print("\n       <a href=\"EmpsRecord.jsp?"+formParams+"\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Insert</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      bInsert = true;
    
      if ( iPage == 1 ) {
        out.print("\n       <a href_=\"#\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Previous</font></a>");
      }
      else {
        out.print("\n       <a href=\""+sFileName+"?"+formParams+sSortParams+"Formemps_Page="+(iPage - 1)+"#Form\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Previous</font></a>");
      }
  
      out.print("\n       [ "+iPage+" ]");
  
      if (!bNext) { 
        out.print("\n       <a href_=\"#\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Next</font></a><br>");
      }
      else {
        out.print("\n       <a href=\""+sFileName+"?"+formParams+sSortParams+"Formemps_Page="+(iPage + 1)+"#Form\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Next</font></a><br>");
      }
    
      if ( ! bInsert ) {
        out.print("     <tr>\n      <td colspan=\"5\" bgcolor=\"#000000\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">");
        out.print("\n        <a href=\"EmpsRecord.jsp?"+formParams+"\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Insert</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      }
    
      out.println("</td>\n     </tr>");
    }
  
    }

    if ( rs != null ) rs.close();
    out.println("    </table>");
    
  }
  catch (Exception e) { out.println(e.toString()); }
}


  void Search_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sSearchErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {
      

      String fldemp_login="";
      String fldname="";
      String fldmanmonth="";


      String sSQL="";
      String transitParams = "";
      String sQueryString = "";
      String sPage = "";
      

      out.println("    <table border=\"0\" cellspacing=\"2\" cellpadding=\"0\">");
      out.println("     <tr>\n      <td align=\"center\" bgcolor=\"#FFBB55\" colspan=\"7\"><a name=\"Search\"><font style=\"font-size: 12pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Search</font></a></td>\n     </tr>");
      out.println("     <form method=\"get\" action=\"EmpsGrid.jsp\" name=\"Search\">\n     <tr>");
      // Set variables with search parameters
      
      fldemp_login = getParam( request, "emp_login");
      fldname = getParam( request, "name");
      fldmanmonth = getParam( request, "manmonth");

      // Show fields
      

      out.println("      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Login</font></td>");
      out.print("      <td >"); out.print("<input type=\"text\"  name=\"emp_login\" maxlength=\"20\" value=\""+toHTML(fldemp_login)+"\" size=\"10\">");
 out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Name</font></td>");
      out.print("      <td >"); out.print("<input type=\"text\"  name=\"name\" maxlength=\"100\" value=\""+toHTML(fldname)+"\" size=\"10\">");
 out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Man of the Month</font></td>");
      out.print("      <td >"); 
      out.print("<select name=\"manmonth\">"+getOptionsLOV(";All;0;No;1;Yes",true,false,fldmanmonth)+"</select>");
       out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td align=\"right\" colspan=\"3\"><input type=\"submit\" value=\"Search\"/></td>");
      out.println("     </tr>\n     </form>\n    </table>");
      out.println("");
    }
    catch (Exception e) { out.println(e.toString()); }
  }
%>
