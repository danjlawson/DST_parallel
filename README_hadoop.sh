#!/bin/sh
# http://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html#Standalone_Operation
# https://www.linuxjournal.com/content/introduction-mapreduce-hadoop-linux
# https://examples.javacodegeeks.com/enterprise-java/apache-hadoop/hadoop-streaming-example/
# https://dzone.com/articles/local-hadoop-on-laptop-for-practice

## If running on BlueCrystal, you load Java with:
## module load Java/1.8.0_92

## but here we only want:

wget http://mirror.ox.ac.uk/sites/rsync.apache.org/hadoop/common/hadoop-3.1.3/hadoop-3.1.3.tar.gz
tar -xzvf hadoop-3.1.3.tar.gz

## NEED mapping files and so on from the tutorial
cp -r /vagrant/* .

## To run Map/Reduce locally
./map.py < test.log | sort | ./reduce.py

export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

#############
HDIR=hadoop-3.1.3
$HDIR/bin/hadoop jar \
  $HDIR/share/hadoop/tools/lib/hadoop-streaming-3.1.3.jar \
  -mapper map.py -reducer reduce.py \
  -input test.log -output output

#############
## GET SOME DATA
mkdir books
cd books
for i in `seq 5720 5730`; do
    wget http://ota.ox.ac.uk/text/$i.txt
done
cd ..

$HDIR/bin/hadoop jar \
  $HDIR/share/hadoop/tools/lib/hadoop-streaming-3.1.3.jar \
  -mapper map_wc.py -reducer reduce_wc.py \
  -input books/* -output books_wc

#############
## Running "real" hadoop

## NOW you have to setup ssh with password-free access! See
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

## test (and add to known_hosts) with 
ssh localhost
## If that works, then you can type "exit" to get back to your regular login.

## Setup HDFS: tell it to replicate only 1 time
echo "
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>
" > $HDIR/etc/hadoop/hdfs-site.xml

## Format HDFS and setup a namenode
$HDIR/bin/hdfs namenode -format

## Create a folder on HDFS
$HDIR/bin/hdfs dfs -mkdir hdfs
$HDIR/bin/hdfs dfs -put books hdfs/

## See also 
## hdfs dfs -copyToLocal <hdfs_input_file_path> <output_path>

## Rerun the hadoop job, this time specifying 10 reducers

$HDIR/bin/hadoop jar \
  $HDIR/share/hadoop/tools/lib/hadoop-streaming-3.1.3.jar \
  -D mapred.reduce.tasks=10 \
  -mapper map_wc.py -reducer reduce_wc.py \
  -input hdfs/books/* -output hdfs/books_wc
