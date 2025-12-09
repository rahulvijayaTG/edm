#!/usr/bin/ksh 
cd /edminf/i2/MDM/6.2.7/qa1a/web/weblogic/bcmclient/bin; export JAVA_HOME=/opt/java1.4; export PATH={PATH};
# **** The following exportting works correctly when this pgm is run from the web/weblogic/bcmclient/bin dir in build ***
export SOURCE_DIRTOP=../../../..

# *** export it as follows to have it work from the src/web/bin dir in the VOB ***
# export SOURCE_DIRTOP=../../../src
# *****************************************************************************

export SIX_X_ROOT=$SOURCE_DIRTOP
export WEB_LIB=../WEB-INF/lib
export WEB_CLASSES=../WEB-INF/classes
export BUNDLE_DIR=../WEB-INF/classes
export BUNDLE_FILE=i18n-messages_en_US.properties
export DEFAULT_BUNDLE_FILE=i18n-messages.properties

export JDOM_JAR=${WEB_LIB}/jdom.jar
export LOG4J_JAR=${WEB_LIB}/log4j.jar
export XERCES_JAR=${WEB_LIB}/xerces.jar
export XALAN_JAR=${WEB_LIB}/xalan.jar
export X2_3RD_JAR=${WEB_LIB}/x2thirdparty.jar
export X2_JAR=${WEB_LIB}/x2.jar:${WEB_LIB}/x2-i18n.jar
export XCORE_JAR=${WEB_LIB}/xcoreclient.jar
export X2FULL_JAR=${WEB_LIB}/bpe-x2.jar

export LOCALCLASSPATH=$WEB_CLASSES:${JDOM_JAR}:${XERCES_JAR}:${XCORE_JAR}:${LOG4J_JAR}:${XALAN_JAR}:${X2_3RD_JAR}:${X2_JAR}:${XCORE_JAR}:${X2FULL_JAR}


echo -- clearing previous bundles --
rm -f $BUNDLE_DIR/$BUNDLE_FILE
rm -f $BUNDLE_DIR/$DEFAULT_BUNDLE_FILE

echo off
echo ..
echo -- creating bundle --
java -cp ${LOCALCLASSPATH} com.i2.bcm.x2.util.i18n.i18nTextFinder -s -d $SOURCE_DIRTOP -p ${BUNDLE_DIR}/${BUNDLE_FILE} $1 $2 $3 $4 $5 $6

echo on
echo ..
echo -- sorting bundle --
rm -f $BUNDLE_DIR/sorted.tmp

sort -o${BUNDLE_DIR}/sorted.tmp ${BUNDLE_DIR}/${BUNDLE_FILE} 
#rm -R ${BUNDLE_DIR}/${BUNDLE_FILE}
mv -f ${BUNDLE_DIR}/sorted.tmp ${BUNDLE_DIR}/${BUNDLE_FILE}


echo ..
echo -- creating default bundle --
cp ${BUNDLE_DIR}/${BUNDLE_FILE} ${BUNDLE_DIR}/${DEFAULT_BUNDLE_FILE}

echo exit
#exit
