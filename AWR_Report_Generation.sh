#!/bin/bash
 
cd $HOME
. ./.profile
cd /home/cal09/pogo/cramer/AWR/
 
DB_STRING_CRAMER='syscramer/systest@CRRMTAL.test.de'
sqlplus $DBSTRING_CRAMER @BEGIN_SNAP.sql
sqlplus $DBSTRING_CRAMER @END_SNAP.sql
 
report_type='html'
dbid=2539392974
inst_num1=1
inst_num2=2
num_days=1
export begin_snap=`cat begin_snap.txt`
export end_snap=`cat end_snap.txt`
report_name1='awr_report1.html'
report_name2='awr_report2.html'
TO_EMAIL='chandan.sahoo@vodafone.com'
SUBJECT1='AL pre | AWR Report of inst1'
SUBJECT2='AL pre | AWR Report of inst2'
 
# SQL script to call awrrpti.sql with the provided arguments for INST1
 
SQL_SCRIPT1="
SET PAGESIZE 0 FEEDBACK OFF VERIFY OFF HEADING OFF ECHO OFF
@/opt/oracle/product/121020_cl_64/cl/rdbms/admin/awrrpti.sql
$report_type
$dbid
$inst_num1
$num_days
$begin_snap
$end_snap
$report_name1
EXIT;
"
# SQL script using sqlplus
 
echo "$SQL_SCRIPT1" | sqlplus -s "$DB_STRING_CRAMER"
 
# SQL script to call awrrpti.sql with the provided arguments for INST2
 
SQL_SCRIPT2="
SET PAGESIZE 0 FEEDBACK OFF VERIFY OFF HEADING OFF ECHO OFF
@/opt/oracle/product/121020_cl_64/cl/rdbms/admin/awrrpti.sql
$report_type
$dbid
$inst_num2
$num_days
$begin_snap
$end_snap
$report_name2
EXIT;
"
# SQL script using sqlplus
 
echo "$SQL_SCRIPT2" | sqlplus -s "$DB_STRING_CRAMER"
 
# Read the content of the AWR report for INST1
REPORT_CONTENT1=$(cat "$report_name1")
 
 
# Create the email content with HTML headers
EMAIL_CONTENT1="To: $TO_EMAIL
Subject: $SUBJECT1
MIME-Version: 1.0
Content-Type: text/html
 
<html>
<body>
<h2>AWR Report generation for inst1</h2>
$REPORT_CONTENT1
</body>
</html>
"
 
# Send the email using sendmail
echo "$EMAIL_CONTENT1" | sendmail -t
 
echo "Email sent to $TO_EMAIL with the AWR report of inst1 in HTML format."
 
# Read the content of the AWR report for INST2
REPORT_CONTENT2=$(cat "$report_name2")
 
 
# Create the email content with HTML headers
EMAIL_CONTENT2="To: $TO_EMAIL
Subject: $SUBJECT2
MIME-Version: 1.0
Content-Type: text/html
 
<html>
<body>
<h2>AWR Report generation for inst2</h2>
$REPORT_CONTENT2
</body>
</html>
"
 
# Send the email using sendmail
echo "$EMAIL_CONTENT2" | sendmail -t
 
echo "Email sent to $TO_EMAIL with the AWR report of inst2 in HTML format."

-----------------------------------------------------------------------------------

SPOOL /home/cal09/pogo/cramer/AWR/begin_snap.txt;
SET PAGESIZE 0 FEEDBACK OFF VERIFY OFF HEADING OFF ECHO OFF
select max(snap_id)-1 from dba_hist_snapshot where INSTANCE_NUMBER=1 order by SNAP_ID desc;
SPOOL OFF;
EXIT

save this content in a SQL file e.g BEGIN_SNAP.sql
 
SPOOL /home/cal09/pogo/cramer/AWR/end_snap.txt;
SET PAGESIZE 0 FEEDBACK OFF VERIFY OFF HEADING OFF ECHO OFF
select max(snap_id) from dba_hist_snapshot where INSTANCE_NUMBER=1 order by SNAP_ID desc;
SPOOL OFF;
EXIT

save this content in a SQL file e.g END_SNAP.sql
 
NOTE: We can optize this by adding both the sqls inside shell file and successfully tested for AL preprod.
