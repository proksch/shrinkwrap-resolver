#!/bin/bash

# specify path to the checkout of the "repository" branch, build artifacts will be deployed there
LOCAL_REPO="<path to local repo>"
# for example:
#LOCAL_REPO=/Users/seb/versioned/fasten/shrinkwrap-resolver-patched/repository

# only adopt these VARs if you change the build
BASE="target/shrinkwrap-resolver-impl-maven-patched-3.1.4"
POM=pom.xml
JAR="$BASE.jar"
SOURCES="$BASE-sources.jar"
JAVADOC="$BASE-javadoc.jar"

echo "LOCAL_REPO: $LOCAL_REPO"
echo "POM: $POM"
echo "JAR: $JAR"
echo "SOURCES: $SOURCES"
echo "JAVADOC: $JAVADOC"

mvn install:install-file \
	-DpomFile=$POM \
	-Dfile=$JAR \
	-Dsources=$SOURCES \
	-Djavadoc=$JAVADOC \
	-DlocalRepositoryPath=$LOCAL_REPO \
	-DcreateChecksum=true

echo ""
echo ""
echo "!!! Do not forget to commit/push the deployed files to a repository. !!!"
echo ""