#!/bin/sh

#get the login page
wget -a log.txt --keep-session-cookies --save-cookies cookies.txt "http://calculus.sisl.rites.uic.edu:443/5f3decd5/empldir/Login.jsp"

#enter login credentials
wget -a log.txt --load-cookies cookies.txt --post-data 'FormName=Login&Login=admin&Password=admin&FormAction=login' "http://calculus.sisl.rites.uic.edu:443/5f3decd5/empldir/Login.jsp"

#get the login page
wget -a log.txt "http://calculus.sisl.rites.uic.edu:443/5f3decd5/XSRF.jsp"

