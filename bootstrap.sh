#!/usr/bin/env bash

echo "Installing Oracle Java 8 ..."
wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u40-b25/jdk-8u40-linux-x64.tar.gz"
tar -xzvf jdk-8u40-linux-x64.tar.gz
mkdir /usr/lib/jvm
mv jdk1.8.0_40 /usr/lib/jvm
ln -s /usr/lib/jvm/jdk1.8.0_40/ /usr/lib/jvm/java-8-oracle
update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/java-8-oracle/bin/java" 1
update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/java-8-oracle/bin/javac" 1 
rm /home/vagrant/jdk-8u40-linux-x64.tar.gz

echo "Installing SBT ..."
wget https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.13.7/sbt-launch.jar
mv sbt-launch.jar /bin/sbt-launch.jar

cat > /bin/sbt << 'EOF'
SBT_OPTS="-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled"
java $SBT_OPTS -jar `dirname $0`/sbt-launch.jar "$@"
EOF

chmod 755 /bin/sbt
