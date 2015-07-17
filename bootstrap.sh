#!/usr/bin/env bash

# Java Version
JAVA_VERSION_MAJOR="8"
JAVA_VERSION_MINOR="45"
JAVA_VERSION_BUILD="14"
JAVA_PACKAGE="jdk"
JAVA_DIRECTORY="jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}"

echo "Installing Oracle Java 8 ..."
wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz

tar -xzvf jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz
mkdir /usr/lib/jvm
mv ${JAVA_DIRECTORY} /usr/lib/jvm
ln -s /usr/lib/jvm/${JAVA_DIRECTORY} /usr/lib/jvm/java-${JAVA_VERSION_MAJOR}-oracle
update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/java-${JAVA_VERSION_MAJOR}-oracle/bin/java" 1
update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/java-${JAVA_VERSION_MAJOR}-oracle/bin/javac" 1 
rm /home/vagrant/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz

echo "Installing SBT ..."
wget https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.13.7/sbt-launch.jar
mv sbt-launch.jar /bin/sbt-launch.jar

cat > /bin/sbt << 'EOF'
SBT_OPTS="-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled"
java $SBT_OPTS -jar `dirname $0`/sbt-launch.jar "$@"
EOF

chmod 755 /bin/sbt

echo "cd /vagrant" >> /home/vagrant/.bashrc
