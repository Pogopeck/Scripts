 # Python Script Connect to the Admin Server
connect('wlsarmal', 'cramer123', 't3://decr47hr.dc-ratingen.de:7750')
 
# Start an edit session
edit()
startEdit()
 
# Redeploy the application
redeploy(appName='CramerCluster_de-amendsupport-ear', path='/opt/SP/weblogic/APP_DOMAINS/ARM10_AL/ARMWeblogicHighAvailability2MS/deployments/DeliveryEngine/work/ears/de-amendsupport-ear.ear', upload='true')
 
# Save and activate changes
save()
activate(block='true')
 
# Disconnect from the Admin Server
disconnect()
exit()  


# Script to update deployment in weblogic
# Save this python file e.g update.py
# go run this scrcipt along with  wlst.sh e.g $./wlst.sh update.py
