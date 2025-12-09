#!/usr/bin/ksh 
cd /edminf/i2/MDM/6.2.7/qa1a/web/weblogic/bcmclient/bin; export JAVA_HOME=/opt/java1.4;

#mkcolocjar.sh

if test -f  ../../WEB-INF/lib/coloc.jar 
then 
    rm ../../WEB-INF/lib/coloc.jar
fi

mkdir temp

cd temp

cp ../../WEB-INF/bcm/cfg/properties/*.xml .
cp -r ../../WEB-INF/bcm/cfg/xservice .

$JAVA_HOME/bin/jar cvf ../../WEB-INF/lib/coloc.jar *

cd ..

rm -fr temp
