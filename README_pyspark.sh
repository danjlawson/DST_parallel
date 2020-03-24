#!/bin/sh
## See https://www.tutorialspoint.com/pyspark/pyspark_quick_guide.htm
## And https://spark.apache.org/examples.html



## INSTALLATION OF anaconda on vagrant:
wget https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh
bash Anaconda3-2019.03-Linux-x86_64.sh
## When you install anaconda, it adds some things to your profile so that the filesystem knows where everything is. You can log out and back in again, or just call the script 
source ~/.bashrc
## IMPORTANT: You have to interactively accept various terms and so on.
export PATH="$PATH:~/.local/bin/"

## On BLUECRYSTAL we already have anaconda so just enable it:
## module load languages/anaconda3/3.6.5

pip install pyspark --user

################
## WE ARE NOW READY TO USE pyspark

## Run a python script using pyspark
spark-submit pys_firstapp.py &> pys_firstapp.log
grep "Lines" pys_firstapp.log

## Do this for count, filter, collect, broadcast, ...
spark-submit pys_count.py &> pys_count.log
grep -v INFO pys_count.log | grep -v WARN

spark-submit pys_count.py &> pys_count.log
grep -v INFO pys_count.log | grep -v WARN

## Examine the storage type
spark-submit pys_storagelevel.py &> pys_storagelevel.log
grep -v INFO pys_storagelevel.log | grep -v WARN

## Run a basic distributed ML algorithm
spark-submit pys_recommend.py &> pys_recommend.log
grep -v INFO pys_recommend.log | grep -v WARN

## Run map-reduce word counting
spark-submit pys_wordcount.py &> pys_wordcount.log
grep -v INFO pys_wordcount.log | grep -v WARN

##########
## https://towardsdatascience.com/machine-learning-with-pyspark-and-mllib-solving-a-binary-classification-problem-96396065d2aa
spark-submit pys_schema.py &> pys_schema.log
grep -v INFO pys_schema.log | grep -v WARN

