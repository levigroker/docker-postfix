#!/bin/bash
#
# A script to launch postfix server inside a docker container
#
# See the 'usage' function for supported commands and syntax.
#
# Levi Brown
# mailto:levigroker@gmail.com
# December 10, 2015
##

function usage()
{
	[[ "$@" = "" ]] || echo "$@" >&2
	echo "Usage:" >&2
	echo "$0 --start|--stop" >&2
	echo "    --start Start server." >&2
	echo "    --stop  Stop the server." >&2
	echo "" >&2
	echo "    ex.: $0 --start" >&2
	echo "    ex.: $0 --stop" >&2
    exit 1
}

function start_server()
{
	echo "Configuring server..."
	/opt/install.sh
	echo "Server configured."
	echo "Starting server..."
	/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
	while [ ! -r /var/log/syslog ]; do
		sleep 1
	done
	echo "Server started!"
	tail -f /var/log/syslog
}

function stop_server()
{
	supervisorctl stop postfix
}

DEBUG=${DEBUG:-0}
export DEBUG

set -eu
[ $DEBUG -ne 0 ] && set -x

# Make sure we have one and only one argument
if [[ -z ${1+x} || ! -z ${2+x} ]]; then
	usage
fi

command="$1"
case $command in
    --start)
	    start_server
    ;;
    --stop)
		stop_server
    ;;
    *)
    # Unknown option
    usage
    ;;
esac
