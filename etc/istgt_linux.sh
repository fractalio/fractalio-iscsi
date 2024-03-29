#!/bin/sh
#
### BEGIN INIT INFO
# Provides:       istgt
# Required-Start: $remote_fs $syslog $named
# Required-Stop:  $remote_fs $syslog
# Should-Start: network-remotefs
# Should-Stop: network-remotefs
# Default-Start:  3 5
# Default-Stop:   0 1 2 6
# Short-Description: Userspace iSCSI target daemon
# Description: Userspace iSCSI target daemon
### END INIT INFO

. /etc/rc.status
rc_reset

name="istgt"

: ${istgt_config="/usr/local/etc/istgt/istgt.conf"}
: ${istgt_pidfile="/var/run/istgt.pid"}
: ${istgt_flags=""}

required_files="${istgt_config}"
pidfile="${istgt_pidfile}"
command="/usr/local/sbin/istgt"
command_args="-c ${istgt_config} ${istgt_flags}"

case "$1" in
	start)
		echo "Starting iSCSI target daemon (${name})"
		startproc $command $command_args
		rc_status -v
		;;
	stop)
		echo "Shutting down iSCSI target daemon (${name})"
		killproc -p $istgt_pidfile -TERM $command
		rc_status -v
		rm -f $istgt_pidfile 2>/dev/null
		;;
	restart)
		$0 stop
		$0 start
		rc_status
		;;
	force-reload|reload)
		echo "Reloading iSCSI target daemon (${name})"
		killproc -p $istgt_pidfile -HUP $command
		rc_status -v
		;;
	status)
		echo "Checking for iSCSI target daemon (${name})"
		checkproc -p $istgt_pidfile $command
		rc_status -v
		;;
	*)
		echo "Usage: $0 {start|stop|restart|status}"
		exit 1
		;;
esac

rc_exit
