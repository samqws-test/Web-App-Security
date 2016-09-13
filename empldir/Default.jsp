<%@ include file="Common.jsp" %><%!
//
//   Filename: Default.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/01
//

static final String sFileName = "Default.jsp";
              
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

out.println("Value of sessionID = " + session.getId());

boolean bDebug = false;
String sAction = getParam( request, "FormAction");
String sForm = getParam( request, "FormName");
String sGridErr = "";
String sSearchErr = "";
String sEmpMonthErr = "";

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
<% EmpMonth_Show(request, response, session, out, sEmpMonthErr, sForm, sAction, conn, stat); %>
    
   </td>
   <td valign="top">
<% Search_Show(request, response, session, out, sSearchErr, sForm, sAction, conn, stat); %>
    
   </td>
  </tr>
 </table>
 <table>
  <tr>
   <td valign="top">
<% Grid_Show(request, response, session, out, sGridErr, sForm, sAction, conn, stat); %>
    
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

  void Grid_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sGridErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException  {
  
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

      String pdep_id="";
      String pemail="";
      String pname="";


    transitParams = "name=" + toURL(getParam( request, "name")) + "&dep_id=" + toURL(getParam( request, "dep_id")) + "&email=" + toURL(getParam( request, "email")) + "&";
    formParams = "name=" + toURL(getParam( request, "name")) + "&dep_id=" + toURL(getParam( request, "dep_id")) + "&email=" + toURL(getParam( request, "email")) + "&"; 
    // Build WHERE statement
        
    //-- Check dep_id parameter and create a valid sql for where clause
  
    pdep_id = getParam( request, "dep_id");
    if ( ! isNumber (pdep_id)) {
      pdep_id = "";
    }
    
    if (pdep_id != null && ! pdep_id.equals("")) {
            
        hasParam = true;
        sWhere += "e.dep_id=" + pdep_id;
    }
    
    //-- Check email parameter and create a valid sql for where clause
  
    pemail = getParam( request, "email");
    if (pemail != null && ! pemail.equals("")) {
            
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += "e.email like '%" + replace(pemail, "'", "''") + "%'";
    }
    
    //-- Check name parameter and create a valid sql for where clause
  
    pname = getParam( request, "name");
    if (pname != null && ! pname.equals("")) {
            
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += "e.name like '%" + replace(pname, "'", "''") + "%'";
    }
    
    if (hasParam) { sWhere = " AND (" + sWhere + ")"; }
    // Build ORDER statement
    sOrder = " order by e.name Asc";
    String sSort = getParam( request, "FormGrid_Sorting");
    String sSorted = getParam( request, "FormGrid_Sorted");
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
        sSortParams = "FormGrid_Sorting=" + sSort + "&FormGrid_Sorted=" + sSort + "&";
      }
      else {
        sSorted=sSort;
        sForm_Sorting = sSort;
        sDirection = " ASC";
        sSortParams = "FormGrid_Sorting=" + sSort + "&FormGrid_Sorted=" + "&";
      }
    
      if ( iSort == 1) { sOrder = " order by e.name" + sDirection; }
      if ( iSort == 2) { sOrder = " order by e.title" + sDirection; }
      if ( iSort == 3) { sOrder = " order by d.name" + sDirection; }
      if ( iSort == 4) { sOrder = " order by e.work_phone" + sDirection; }
      if ( iSort == 5) { sOrder = " order by e.email" + sDirection; }
    }
  

  // Build full SQL statement
  
  sSQL = "select e.dep_id as e_dep_id, " +
    "e.email as e_email, " +
    "e.emp_id as e_emp_id, " +
    "e.name as e_name, " +
    "e.title as e_title, " +
    "e.work_phone as e_work_phone, " +
    "d.dep_id as d_dep_id, " +
    "d.name as d_name " +
    " from emps e, deps d" +
    " where d.dep_id=e.dep_id  ";
  
  sSQL = sSQL + sWhere + sOrder;

  String sNoRecords = "     <tr>\n      <td colspan=\"5\" ><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">No records</font></td>\n     </tr>";


  String tableHeader = "";
      tableHeader = "     <tr>\n      <td bgcolor=\"#000000\"><a href=\""+sFileName+"?"+formParams+"FormGrid_Sorting=1&FormGrid_Sorted="+sSorted+"&\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Name</font></a></td>\n      <td bgcolor=\"#000000\"><a href=\""+sFileName+"?"+formParams+"FormGrid_Sorting=2&FormGrid_Sorted="+sSorted+"&\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Title</font></a></td>\n      <td bgcolor=\"#000000\"><a href=\""+sFileName+"?"+formParams+"FormGrid_Sorting=3&FormGrid_Sorted="+sSorted+"&\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Department</font></a></td>\n      <td bgcolor=\"#000000\"><a href=\""+sFileName+"?"+formParams+"FormGrid_Sorting=4&FormGrid_Sorted="+sSorted+"&\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Work Phone</font></a></td>\n      <td bgcolor=\"#000000\"><a href=\""+sFileName+"?"+formParams+"FormGrid_Sorting=5&FormGrid_Sorted="+sSorted+"&\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Email</font></a></td>\n     </tr>";
  
  
  try {
    out.println("    <table border=\"0\" cellspacing=\"2\" cellpadding=\"0\">");
    out.println("     <tr>\n      <td align=\"center\" bgcolor=\"#FFBB55\" colspan=\"5\"><a name=\"Grid\"><font style=\"font-size: 12pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Employee Directory</font></a></td>\n     </tr>");
    out.println(tableHeader);

  }
  catch (Exception e) {}

  
  try {
    java.sql.ResultSet rs = null;
    // Open recordset
    rs = openrs( stat, sSQL);
    iCounter = 0;
    
    java.util.Hashtable rsHash = new java.util.Hashtable();
    String[] aFields = getFieldsName( rs );

    // Show main table based on recordset
    while ( rs.next() ) {

      getRecordToHash( rs, rsHash, aFields );
      String flddep_id = (String) rsHash.get("d_name");
      String fldemail = (String) rsHash.get("e_email");
      String fldname = (String) rsHash.get("e_name");
      String fldtitle = (String) rsHash.get("e_title");
      String fldwork_phone = (String) rsHash.get("e_work_phone");
fldemail="<a href=mailto:" + fldemail + ">" + fldemail + "</a>";

      out.println("     <tr>");
      
      out.print("      <td >"); out.print("<a href=\"EmpDetail.jsp?"+transitParams+"emp_id="+toURL((String) rsHash.get("e_emp_id"))+"&\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldname)+"</font></a>");

      out.println("</td>");
      out.print("      <td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldtitle)+"&nbsp;</font>");
      out.println("</td>");
      out.print("      <td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(flddep_id)+"&nbsp;</font>");
      out.println("</td>");
      out.print("      <td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldwork_phone)+"&nbsp;</font>");
      out.println("</td>");
      out.print("      <td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+fldemail+"&nbsp;</font>");
      out.println("</td>");
      out.println("     </tr>");
    
      iCounter++;
    }
    if (iCounter == 0) {
      // Recordset is empty
      out.println(sNoRecords);
    
      iCounter = RecordsPerPage+1;
      bIsScroll = false;
    }

    if ( rs != null ) rs.close();
    out.println("    </table>");
    
  }
  catch (Exception e) { out.println(e.toString()); }
}


  void Search_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sSearchErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {
      

      String flddep_id="";
      String fldname="";
      String fldemail="";


      String sSQL="";
      String transitParams = "";
      String sQueryString = "";
      String sPage = "";
      

      out.println("    <table border=\"0\" cellspacing=\"2\" cellpadding=\"0\">");
      out.println("     <tr>\n      <td align=\"center\" bgcolor=\"#FFBB55\" colspan=\"7\"><a name=\"Search\"><font style=\"font-size: 12pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Search</font></a></td>\n     </tr>");
      out.println("     <form method=\"get\" action=\"Default.jsp\" name=\"Search\">\n     <tr>");
      // Set variables with search parameters
      
      flddep_id = getParam( request, "dep_id");
      fldname = getParam( request, "name");
      fldemail = getParam( request, "email");

      // Show fields
      

      out.println("      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Department</font></td>");
      out.print("      <td >"); 
      out.print("<select name=\"dep_id\">"+getOptions( conn, "select dep_id, name from deps order by 2",true,false,flddep_id)+"</select>");
       out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Name</font></td>");
      out.print("      <td >"); out.print("<input type=\"text\"  name=\"name\" maxlength=\"15\" value=\""+toHTML(fldname)+"\" size=\"15\">");
 out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td bgcolor=\"#FFDD00\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Email</font></td>");
      out.print("      <td >"); out.print("<input type=\"text\"  name=\"email\" maxlength=\"50\" value=\""+toHTML(fldemail)+"\" size=\"15\">");
 out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td align=\"right\" colspan=\"3\"><input type=\"submit\" value=\"Search\"/></td>");
      out.println("     </tr>\n     </form>\n    </table>");
      out.println("");
    }
    catch (Exception e) { out.println(e.toString()); }
  }


  void EmpMonth_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sEmpMonthErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException  {
  
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


 
    // Build WHERE statement
        
    sWhere = " WHERE manmonth=1";

  // Build full SQL statement
  
  sSQL = "select e.name as e_name, " +
    "e.picture as e_picture " +
    " from emps e ";
  
  sSQL = sSQL + sWhere + sOrder;

  String sNoRecords = "     <tr>\n      <td colspan=\"1\" ><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">No records</font></td>\n     </tr>";


  String tableHeader = "";
    
  
  try {
    out.println("    <table border=\"0\" cellspacing=\"2\" cellpadding=\"0\">");
    out.println("     <tr>\n      <td align=\"center\" bgcolor=\"#FFBB55\" colspan=\"1\"><a name=\"EmpMonth\"><font style=\"font-size: 12pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Man of the Month</font></a></td>\n     </tr>");
    out.println(tableHeader);

  }
  catch (Exception e) {}

  
  try {
    java.sql.ResultSet rs = null;
    // Open recordset
    rs = openrs( stat, sSQL);
    iCounter = 0;
    
    java.util.Hashtable rsHash = new java.util.Hashtable();
    String[] aFields = getFieldsName( rs );

    // Show main table based on recordset
    while ( rs.next() ) {

      getRecordToHash( rs, rsHash, aFields );
      String fldname = (String) rsHash.get("e_name");
      String fldpicture = (String) rsHash.get("e_picture");
fldpicture="<img border=0 height=100 width=100 src=images/emps/" + fldpicture + ">";

      out.print("     <tr>\n      <td bgcolor=\"#000000\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\"></font> </td></tr><tr><td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+fldpicture+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      out.print("     <tr>\n      <td bgcolor=\"#000000\"><font style=\"font-size: 10pt; color: #FFFFFF; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\"></font> </td></tr><tr><td >"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldname)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      out.println("     <tr>\n      <td colspan=\"2\" >&nbsp;</td>\n     </tr>");
    
      iCounter++;
    }
    if (iCounter == 0) {
      // Recordset is empty
      out.println(sNoRecords);
    
      iCounter = RecordsPerPage+1;
      bIsScroll = false;
    }

    if ( rs != null ) rs.close();
    out.println("    </table>");
    
  }
  catch (Exception e) { out.println(e.toString()); }
}
%>
