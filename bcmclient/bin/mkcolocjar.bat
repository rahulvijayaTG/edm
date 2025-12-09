cd /D /edminf/i2/MDM/6.2.7/qa1a\web\weblogic\bcmclient\bin
set JAVA_HOME=/opt/java1.4
rem mkcolocjar.bat

IF EXIST ..\..\WEB-INF\lib\coloc.jar del ..\..\WEB-INF\lib\coloc.jar

md temp

cd temp
md xservice
copy ..\..\WEB-INF\bcm\cfg\properties\*.xml .
xcopy ..\..\WEB-INF\bcm\cfg\xservice xservice /s

%JAVA_HOME%\bin\jar cvf ..\..\WEB-INF\lib\coloc.jar *

cd ..

rmdir /s /q temp
