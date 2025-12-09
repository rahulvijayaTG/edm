cd /D /edminf/i2/MDM/6.2.7/qa1a\web\weblogic\bcmclient\bin
set JAVA_HOME=/opt/java1.4
set PATH=.;%JAVA_HOME%\bin;%PATH%
set CLASSPATH=.;/edminf/i2/MDM/6.2.7/qa1a\web\weblogic\bcmclient\WEB-INF\lib\xercesImpl.jar;/edminf/i2/MDM/6.2.7/qa1a\web\weblogic\bcmclient\WEB-INF\lib\bpe-server.jar;/edminf/i2/MDM/6.2.7/qa1a\web\weblogic\bcmclient\WEB-INF\lib\bpe-services.jar;%CLASSPATH%
echo off 

set CLASSPATH=.;..\WEB-INF\lib\bpe-server.jar;..\WEB-INF\lib\bpe-services.jar;..\WEB-INF\lib\xercesImpl.jar;%CLASSPATH%

echo "<!--***** Reading DB params from dbadd.txt & modifying xserver.xml accordingly *****-->"


for %%i in (..\WEB-INF\bcm\cfg\properties\xserver.xml) do %JAVA_HOME%\bin\java DbpropertyUpdate %%i

exit
