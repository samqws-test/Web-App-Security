<%@ include file="Common.jsp" %><%!
//
//   Filename: Header.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/01
//

static final String sFileName = "Header.jsp";
              
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
String sHeaderErr = "";

java.sql.Connection conn = null;
java.sql.Statement stat = null;
conn = cn();
stat = conn.createStatement();
%>
 <table>
  <tr>
   <td valign="top">
<% Header_Show(request, response, session, out, sHeaderErr, sForm, sAction, conn, stat); %>   
   </td>
  </tr>
 </table>

<%!

  void Header_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sHeaderErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {
  
      out.println("    <table border=\"0\" cellspacing=\"2\" cellpadding=\"0\">");
      
      out.print("     <tr>");
      // Set URLs
      
      String fldField3 = "Default.jsp";
      String fldField1 = "Default.jsp";
      //String fldField2 = "AdminMenu.jsp";
      String fldField2 = "Login.jsp";
      // Show fields
      
      out.print("\n      <td ><a href=\""+fldField3+"\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\"><img border=\"0\" src=\"images/logo.gif\" width=\"434\" height=\"90\"></font></a></td>");
      out.print("\n      <td ><a href=\""+fldField1+"\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\"><center><img border=\"0\" src=\"images/home.gif\" width=\"77\" height=\"77\"><br>Home</center></font></a></td>");
      out.print("\n      <td ><a href=\""+fldField2+"\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\"><center><img border=\"0\" src=\"images/admin.gif\" width=\"77\" height=\"77\"><br>Administration</center></font></a></td>");

      out.println("\n     </tr>\n    </table>");
  
    }
    catch (Exception e) { out.println(e.toString()); }
  }
%>
