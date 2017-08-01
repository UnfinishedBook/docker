#!/bin/bash

if [ "$1" == "mysql" ]; then
    docker run --name mysql -t --net=host \
        -e MYSQL_DATABASE="zabbix" \
        -e MYSQL_USER="zabbix" \
        -e MYSQL_PASSWORD="zabbix_pwd" \
        -e MYSQL_ROOT_PASSWORD="root_pwd" \
        -d unfinishedbook/docker:mysql \
        --character-set-server=utf8 --collation-server=utf8_bin
elif [ "$1" == "zabbix-java-gateway" ]; then
    docker run --name zabbix-java-gateway -t --net=host \
        -d unfinishedbook/docker:zabbix-java-gateway
elif [ "$1" == "zabbix-server-mysql" ]; then
    docker run --name zabbix-server-mysql -t --net=host \
        -e DB_SERVER_HOST="127.0.0.1" \
        -e MYSQL_DATABASE="zabbix" \
        -e MYSQL_USER="zabbix" \
        -e MYSQL_PASSWORD="zabbix_pwd" \
        -e MYSQL_ROOT_PASSWORD="root_pwd" \
        -e ZBX_JAVAGATEWAY="zabbix-java-gateway" \
        -p 10051:10051 \
        -d unfinishedbook/docker:zabbix-server-mysql
elif [ "$1" == "zabbix-web-nginx-mysql" ]; then
    docker run --name zabbix-web-nginx-mysql -t --net=host \
        -e DB_SERVER_HOST="127.0.0.1" \
        -e ZBX_SERVER_HOST="127.0.0.1" \
        -e MYSQL_DATABASE="zabbix" \
        -e MYSQL_USER="zabbix" \
        -e MYSQL_PASSWORD="zabbix_pwd" \
        -e MYSQL_ROOT_PASSWORD="root_pwd" \
        -e TZ="Asia/Shanghai" \
        -d unfinishedbook/docker:zabbix-web-nginx-mysql
elif [ "$1" == "zabbix-agent" ]; then
    docker run --name zabbix-agent --privileged -t --net=host \
        -e ZBX_HOSTNAME="Zabbix server" \
        -e ZBX_SERVER_HOST="127.0.0.1" \
        -d unfinishedbook/docker:zabbix-agent
else
    echo 'docker-start.sh [mysql / zabbix-java-gateway / zabbix-server-mysql / zabbix-web-nginx-mysql / zabbix-agent]'
fi

