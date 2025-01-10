#!/bin/sh

export LANG=ja_JP.UTF-8

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

export SPARK_HOME=/opt/spark
export SPARK_CONF_DIR="${SPARK_HOME}/conf"
export SPARK_LOG_DIR="${SPARK_HOME}/logs"
export SPARK_PID_DIR="${SPARK_HOME}/pid"

###

echo $PATH | grep "${JAVA_HOME}/bin" >/dev/null
if [ $? -ne 0 ]; then
    PATH="${JAVA_HOME}/bin:$PATH"
fi

###

echo $PATH | grep "${SPARK_HOME}/bin" >/dev/null
if [ $? -ne 0 ]; then
    PATH="${SPARK_HOME}/bin:$PATH"
fi

echo $PATH | grep "${SPARK_HOME}/sbin" >/dev/null
if [ $? -ne 0 ]; then
    PATH="${SPARK_HOME}/sbin:$PATH"
fi
