#!/bin/sh

# PROVIDE: nut_exporter
# REQUIRE: NETWORKING
# KEYWORD: shutdown
#

. /etc/rc.subr

name=nut_exporter
rcvar=nut_exporter_enable

load_rc_config $name

: ${nut_exporter_enable:="NO"}
: ${nut_exporter_syslog_output_enable:="NO"}
: ${nut_exporter_syslog_output_priority:="info"}
: ${nut_exporter_syslog_output_facility:="daemon"}

if checkyesno nut_exporter_syslog_output_enable; then
        nut_exporter_syslog_output_flags="-t ${name} -T ${name}"

        if [ -n "${nut_exporter_syslog_output_priority}" ]; then
                nut_exporter_syslog_output_flags="${nut_exporter_syslog_output_flags} -s ${nut_exporter_syslog_output_priority}"
        fi

        if [ -n "${nut_exporter_syslog_output_facility}" ]; then
                nut_exporter_syslog_output_flags="${nut_exporter_syslog_output_flags} -l ${nut_exporter_syslog_output_facility}"
        fi
fi

pidfile=/var/run/${name}.pid
procname="/opt/nut_exporter/${name}"
flags=""
logfile="/var/log/${name}.log"

start_cmd="${name}_start"

nut_exporter_start() {
        /usr/sbin/daemon -f ${nut_exporter_syslog_output_flags} -o ${logfile} -p ${pidfile} ${procname} ${flags}
}

run_rc_command "$1"

