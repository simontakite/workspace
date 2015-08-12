#! /bin/sh
# #############################################################################

NAME_="rmleads"
HTML_="delete blank leading spaces"
PURPOSE_="remove empty leading spaces from an ascii file; replace input file"
SYNOPSIS_="$NAME_ [-vhl] <file> [file...]"
REQUIRES_="standard GNU commands, file"
VERSION_="1.1"
DATE_="1999-06-19; last update: 2005-07-20"
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
    -v, verbose
    -h, usage and options (help)
    -l, see this script"
    exit 1
}

# arg check
[ $# -eq 0 ] && { echo >&2 missing argument, type $NAME_ -h for help; exit 1; }

# tmp file set up
tmp_1=/tmp/tmp.${RANDOM}$$

# signal trapping and tmp file removal
trap 'rm -f $tmp_1 >/dev/null 2>&1' 0
trap "exit 1" 1 2 3 15

# var init
verbose=

# option and arg handling
while getopts vhl options; do

    case $options in
        v) verbose=on ;;
        h) usage ;;
        l) more $0 ;;
        \?) echo invalid or missing argument, type $NAME_ -h for help; exit 1 ;;
    esac

done

shift $(( $OPTIND - 1 ))

# main
for a in "$@"; do

    # does file exist
    [ -f "$a" ] || { echo >&2 ${NAME_}: file \"$a\" does not exist; exit 1; }

    file "$a" | grep -q text # is input an ascii file
    [ $? == 0 ] && text=0 || text=1

    if [[ $text == 0 ]]; then

        sed 's/^[ 	]*//' < "$a" > $tmp_1 && mv $tmp_1 "$a"
        [[ $verbose ]] && echo ${NAME_}: removed leading space from: "$a"

    elif [[ $text == 1 ]];then

        echo ${NAME_}: skipping: "$a" not an ascii file

    fi

done
