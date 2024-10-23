# To trace logs from a specific file from a specific time frame  
sed -n '/<Oct 22, 2024 1:52:58 PM CEST>/,/<Oct 22, 2024 3:53:12 PM CEST>/p' weblogic.20241009_131107.log>report_server.log  
