#!/bin/bash

REPOSITORY=/home/ec2-user/app/step2
PROJECT_NAME=Boot_JPA_Example
JAR_PREFIX=bootEx

echo ">Build 파일 복사"

cp $REPOSITORY/zip/*.jar $REPOSITORY/

echo "> 현재 구동중인 앱 PID 확인"
CURRENT_PID=$(pgrep -f ${JAR_PREFIX}.*jar)

echo "현재 구동중인 PID : $CURRENT_PID"

if [ -z "$CURRENT_PID" ]; then
    echo "> 구동중인 앱이 없습니다."
else
    echo "> kill -9 $CURRENT_PID"
    kill -9 $CURRENT_PID
    sleep 5
fi

echo "> 새 앱 배포"

JAR_NAME=$(ls -tr $REPOSITORY/ | grep jar | tail -n 1)

echo "> JAR NAME : $JAR_NAME"

chmod +x $JAR_NAME

echo "> $JAR_NAME 실행"

nohup java -jar -Dspring.config.location=classpath:application-real.properties\
-Dspring.config.location=/home/ec2-user/app/application-real-db.properties\
$JAR_NAME > $REPOSITORY/nohup.out 2>&1 &
