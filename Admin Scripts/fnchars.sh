#! /bin/sh
# #############################################################################

NAME_="fnchars"
HTML_="find long file names"
PURPOSE_="print name of file if it has more then n chars in its name"
SYNOPSIS_="$NAME_ [-hl] <n> <file> [file...]"
REQUIRES_="standard GNU commands"
VERSION_="1.0"
DATE_="2004-05-27; last update: 2004-06-14"
AUTHOR_="Dawid Michalczyk <dm@eonworks.com>"
URL_="www.comp.eonworks.com"
CATEGORY_="file"
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
    <n>, an integer referring to minimum characters
    -h, usage and options (this help)
    -l, see this script"
    exit 1
}

# enabling extended globbing
shopt -s extglob

# arg handling and execution
case "$1" in

    -h) usage ;;
    -l) more $0; exit 1 ;;
    +([0-9])) # arg1 can only be an integer

    n=$1
    shift
    for a in "$@";do

        fname=$(echo "${a##*/}") # stripping path in case we run it with find
        if (( "${#fname}" > $n ));then
            echo "${#fname} chars in: $a"
        fi

    done ;;

    *) echo invalid argument, type $NAME_ -h for help; exit 1 ;;

esac
