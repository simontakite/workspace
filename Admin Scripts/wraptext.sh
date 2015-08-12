#! /bin/sh
# #############################################################################

NAME_="wraptext"
HTML_="wrap text script"
PURPOSE_="wrap text file at 80th column; replace file with the wrapped version"
SYNOPSIS_="$NAME_ [-hl] <file> [file...]"
REQUIRES_="standard GNU commands"
VERSION_="1.0"
DATE_="2004-06-07; last update: 2004-06-21"
AUTHOR_="Dawid Michalczyk <dm@eonworks.com>"
URL_="www.comp.eonworks.com"
CATEGORY_="text"
PLATFORM_="Linux"
SHELL_="bash"
DISTRIBUTE_="yes"

# #############################################################################
# This program is distributed under the terms of the GNU General Public License

usage () {

    echo >&2 "$NAME_ $VERSION_ - $PURPOSE_
    Usage: $SYNOPSIS_
    Requires: $REQUIRES_
    Options:
    -h, usage and options (this help)
    -l, see this script"
    exit 1
}

# args check
[ $# -eq 0 ] && { echo >&2 missing argument, type $NAME_ -h for help; exit 1; }

# arg handling and execution
case $1 in

    -h) usage ;;
    -l) more $0; exit 1 ;;
    *) # main execution
    for a in "$@";do
        if [ -f "$a" ]; then
            fmt -w 80 -s $a > /tmp/$$.tmp
            mv /tmp/$$.tmp $a
        else
            echo file $a does not exist
        fi
    done ;;

esac
