#! /bin/sh
# #############################################################################

NAME_="loggedin"
HTML_="login alert"
PURPOSE_="notify when a particular user has logged in"
SYNOPSIS_="$NAME_ [-hml] <user> <n>"
REQUIRES_="standard GNU commands"
VERSION_="1.1"
DATE_="2000-10-07; last update: 2004-04-21"
AUTHOR_="Dawid Michalczyk <dm@eonworks.com>"
URL_="www.comp.eonworks.com"
CATEGORY_="misc"
PLATFORM_="Linux"
SHELL_="bash"
DISTRIBUTE_="yes"

# #############################################################################
# This program is distributed under the terms of the GNU General Public License

usage () {

    echo >&2 "$NAME_ $VERSION_ - $PURPOSE_
    Usage: $SYNOPSIS_
    Requires: $REQUIRES_
    Options:a
    <user>, user name
    <n>, integer referring to time in seconds for how often to check for the user
    -h, usage and options (this help)
    -m, manual
    -l, see this script"
    exit 1
}

manual () { echo >&2 "

NAME

$NAME_ $VERSION_ - $PURPOSE_

SYNOPSIS

$SYNOPSIS_

DESCRIPTION

$NAME_ displays a notification message when a particular user has logged in.
The user option specifies the user name of the person and the time option is
the time interval, in seconds, for how often to check whether the user has
logged in.

AUTHOR

$AUTHOR_ Suggestions and bug reports are welcome.
For updates and more scripts visit $URL_

"; exit 1; }


loggedin() {

    # checking if user is logged out
    who | grep "^$1 " 2>&1 > /dev/null
    if [[ $? == 0 ]]; then
        echo user $1 is logged in
        exit 1
    fi

    # checking when user logs in
    until who | grep "^$1 "; do
        sleep $2
    done

    echo $1 just logged in
    exit 0
}

# arg check
[ $# -eq 0 ] && { echo >&2 missing argument, type $NAME_ -h for help; exit 1; }

case $1 in

    -h) usage;;
    -m) manual ;;
    -l) more $0; exit 1 ;;
    *) [ $# -eq 2 ] && loggedin $1 $2 || { echo >&2 invalid arg, type $NAME_ -h for help; exit 1; }

esac
