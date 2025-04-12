#!/bin/sh

rc_start() {
        service nut_exporter start
}

rc_stop() {
        service nut_exporter stop
}

rc_restart() {
        rc_stop
        rc_start

}

case $1 in
        start)
                rc_start
                ;;
        stop)
                rc_stop
                ;;
        restart)
                rc_restart
                ;;
esac
