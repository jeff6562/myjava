#!/bin/bash
PROG_NAME=$0
ACTION=$1
ONLINE_OFFLINE_WAIT_TIME=6  # 实例上下线的等待时间
APP_START_TIMEOUT=50     # 等待应用启动的时间
APP_PORT=8080          # 应用端口
HEALTH_CHECK_URL=http://127.0.0.1:${APP_PORT}/lz-test001  # 应用健康检查URL
HEALTH_CHECK_FILE_DIR=/home/admin/status   # 脚本会在这个目录下生成nginx-status文件
APP_HOME=/home/admin/lz-test001  # 从package.tgz中解压出来的jar包放到这个目录下
WAR_NAME=lz-test001.war # jar包的名字
APP_LOG=${APP_HOME}/logs/app.log # 应用的日志文件
# 创建出相关目录
mkdir -p ${HEALTH_CHECK_FILE_DIR}  
mkdir -p ${APP_HOME}
mkdir -p ${APP_HOME}/logs
usage() {
    echo "Usage: $PROG_NAME {start|stop|online|offline|restart}"
    exit 2
}
online() {
    # 挂回SLB
    touch -m $HEALTH_CHECK_FILE_DIR/nginx-status || exit 1
    echo "wait app online in ${ONLINE_OFFLINE_WAIT_TIME} seconds..."
    sleep ${ONLINE_OFFLINE_WAIT_TIME} 
}
offline() {
    # 摘除SLB
    rm -f $HEALTH_CHECK_FILE_DIR/nginx-status || exit 1
    echo "wait app offline in ${ONLINE_OFFLINE_WAIT_TIME} seconds..."
    sleep ${ONLINE_OFFLINE_WAIT_TIME}
}
health_check() {
    exptime=0
    echo "checking ${HEALTH_CHECK_URL}"
    while true
    do
        status_code=`/usr/bin/curl -L -o /dev/null --connect-timeout 5 -s -w %{http_code}  ${HEALTH_CHECK_URL}`
        if [ x$status_code != x200 ];then
            sleep 1
            ((exptime++))
            echo -n -e "\rWait app to pass health check: $exptime..."
        else
            break
        fi
        if [ $exptime -gt ${APP_START_TIMEOUT} ]; then
            echo
            echo 'app start failed'
            exit 1
        fi
    done
    echo "check ${HEALTH_CHECK_URL} success"
}
start_application() {
    rm -f /usr/local/apache-tomcat/webapps/*
    cp /home/admin/lz-test001/lz-test001.war /usr/local/apache-tomcat/webapps/
    echo 'starting the tomcat'
    rm -f /usr/local/apache-tomcat/logs/catalina.out
    /usr/local/apache-tomcat/bin/catalina.sh start
    exptime=0
    while true
    do
          ret=`fgrep "Server startup in" /usr/local/apache-tomcat/logs/catalina.out`
          if [ -z "$ret" ]; then
              sleep 1
              ((exptime++))
              echo -n -e  "\rWait Tomcat Start: $exptime..."
          else
             echo 'has server startup'
             break
          fi
    done
}
stop_application() {
    echo 'stopping the tomcat'

    PID=`ps ax | grep 'tomcat' | grep -v grep | awk '{print $1}'`
    echo ${PID}
    if [[ ! -z "$PID" ]]; then
    kill -15 $PID
    else
     echo 'tomcat is not running'
    fi
}
start() {
    start_application
    health_check
    online
}
stop() {
    offline
    stop_application
}
case "$ACTION" in
    start)
        start
    ;;
    stop)
        stop
    ;;
    online)
        online
    ;;
    offline)
        offline
    ;;
    restart)
        stop
        start
    ;;
    *)
        usage
    ;;
esac