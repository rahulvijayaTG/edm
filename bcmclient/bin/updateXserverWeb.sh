#!/usr/bin/ksh
cd /edminf/i2/MDM/6.2.7/qa1a/web/weblogic/bcmclient/bin; export JAVA_HOME=/opt/java1.4; export CLASSPATH=.:/edminf/i2/MDM/6.2.7/qa1a/web/weblogic/bcmclient/WEB-INF/lib/xercesImpl.jar:/edminf/i2/MDM/6.2.7/qa1a/web/weblogic/bcmclient/WEB-INF/lib/bpe-server.jar:/edminf/i2/MDM/6.2.7/qa1a/web/weblogic/bcmclient/WEB-INF/lib/bpe-services.jar:CLASSPATH; export PATH=.:PATH;

echo Reading DB params from dbadd.txt and updating xserver.xml accordingly 


$JAVA_HOME/bin/java DbpropertyUpdate ../WEB-INF/bcm/cfg/properties/xserver.xml
