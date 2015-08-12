#! /bin/sh
# #############################################################################

NAME_="samesize"
HTML_="same size files"
PURPOSE_="list files of same size in current dir"
SYNOPSIS_="$NAME_ [-hl]"
REQUIRES_="standard GNU commands"
VERSION_="1.0"
DATE_="2005-05-02; last update: 2005-05-02"
AUTHOR_="Dawid Michalczyk <dm@eonworks.com>"
URL_="www.comp.eonworks.com"
CATEGORY_="file"
PLATFORM_="Linux"
SHELL_="bash"
DISTRIBUTE_="yes"

# #############################################################################
# This program is distributed under the terms of the GNU General Public License

usage() {

    echo >&2 "$NAME_ $VERSION_ - $PURPOSE_
    Usage: $SYNOPSIS_
    Requires: $REQUIRES_
    Options:
    -h, usage and options (help)
    -l, list the script"

    exit 1

}

# tmp file setup
tmp_1=/tmp/tmp.${RANDOM}$$

# signal trapping and tmp file removal
trap 'rm -f $tmp_1 >/dev/null 2>&1' 0
trap "exit 2" 1 2 3 15

# arg handling
while getopts hl options; do

    case $options in

        h) usage ;;
        l) more $0; exit 1 ;;
        \?) echo >&2 invalid argument, type $NAME_ -h for help; exit 1 ;;

    esac

done
shift $(( $OPTIND - 1 ))

# main
for a in *;do

    f_size=$(set -- $(ls -l -- "$a"); echo $5)
    find . -maxdepth 1 -type f ! -name "$a" -size ${f_size}c > $tmp_1
    [ -s $tmp_1 ] && { echo file with same size as file \"$a\": ; cat $tmp_1; }

done
