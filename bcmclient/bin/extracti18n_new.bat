@echo off

REM **** The following setting works correctly when this pgm is run from the web\weblogic\bcmclient\bin dir in build ***
set SOURCE_DIRTOP=..\..\..\..

REM *** Set it as follows to have it work from the src\web\bin dir in the VOB ***
REM set SOURCE_DIRTOP=..\..\..\src
REM *****************************************************************************

set SIX_X_ROOT=%SOURCE_DIRTOP%
set WEB_LIB=..\WEB-INF\lib
set WEB_CLASSES=..\WEB-INF\classes
set BUNDLE_DIR=..\WEB-INF\classes
set BUNDLE_FILE=i18n-messages_en_US.properties
set DEFAULT_BUNDLE_FILE=i18n-messages.properties

set JDOM_JAR=%WEB_LIB%\jdom.jar

set XERCES_JAR=%WEB_LIB%\xerces.jar
set XALAN_JAR=%WEB_LIB%\xalan.jar
set X2_3RD_JAR=%WEB_LIB%\x2thirdparty.jar
set X2_JAR=%WEB_LIB%\x2.jar;%WEB_LIB%\x2-i18n.jar
set XCORE_JAR=%WEB_LIB%\xcoreclient.jar
set X2FULL_JAR=%WEB_LIB%\bpe-x2.jar
set LOG4J_JAR=%WEB_LIB%\log4j.jar
set LOCALCLASSPATH=%WEB_CLASSES%;%JDOM_JAR%;%XERCES_JAR%;%XCORE_JAR%;%LOG4J_JAR%;%XALAN_JAR%;%X2_3RD_JAR%;%X2_JAR%;%XCORE_JAR%;%X2FULL_JAR%

@echo on
@echo ..
@echo -- clearing previous bundles --
del %BUNDLE_DIR%\%BUNDLE_FILE%
del %BUNDLE_DIR%\%DEFAULT_BUNDLE_FILE%

@echo off
@echo ..
@echo -- creating bundle --
java -cp %LOCALCLASSPATH% com.i2.bcm.x2.util.i18n.i18nTextFinder -s -d %SOURCE_DIRTOP% -p %BUNDLE_DIR%\%BUNDLE_FILE% %1 %2 %3 %4 %5 %6

@echo on
@echo ..
@echo -- sorting bundle --
if exist %BUNDLE_DIR%\sorted.tmp del %BUNDLE_DIR%\sorted.tmp
sort < %BUNDLE_DIR%\%BUNDLE_FILE% > %BUNDLE_DIR%\sorted.tmp
del %BUNDLE_DIR%\%BUNDLE_FILE%
ren %BUNDLE_DIR%\sorted.tmp %BUNDLE_FILE%

@echo ..
@echo -- creating default bundle --
copy %BUNDLE_DIR%\%BUNDLE_FILE% %BUNDLE_DIR%\%DEFAULT_BUNDLE_FILE%

