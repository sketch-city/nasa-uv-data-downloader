#!/usr/bin/env bash

cookies_file=".urs_cookies"
netrc_path=".netrc"
base_url="https://mirador.gsfc.nasa.gov/WWW-TMP/cccb769ddedb8863f08c347325ee5cc6_all.txt"
regex='(<a\ +href=\")([^\"]+)(\">)'

curl_with_auth="curl -b ${cookies_file} -c ${cookies_file} --netrc-file ${netrc_path}"

add_to_netrc () {
  touch $netrc_path
  username=${1:-pandafulmanda}
  password=${2:-publicPASS20170304}

  echo "machine urs.earthdata.nasa.gov login ${username} password ${password}" >> $netrc_path
  chmod 0600 $netrc_path
}

make_cookies_file () {
  touch $cookies_file
}

make_https () {
  echo ${1/http:/https:}
}

make_url () {
  local first_url=${1/http:/https:}
  echo "url     = $first_url"
}

make_filename () {
  echo "output  = $(basename $1)"
}

make_curling_file () {
  touch $2

  while read line; do
    make_url $line >> ${2}
    make_filename $line >> ${2}
  done < $1
}

parse_for_link () {
  local link_html=$($curl_with_auth $1 | grep -ioE "$regex")
  [[ $link_html =~ $regex ]]
  echo ${BASH_REMATCH[2]}
}

authenticate () {
  echo $(parse_for_link $(parse_for_link $(parse_for_link $1)))
}

download_starter_file () {
  # curl --url $base_url | grep '_2017m' >> $1
  curl --url $base_url | grep ${FILE_PATTERN} >> $1
}

run () {
  local starter_file='./00-starter.dat'
  local file_o_links='./01-file-o-links.dat'

  # things for authenthication
  add_to_netrc $1 $2
  make_cookies_file

  echo "make cookies_file"
  download_starter_file $starter_file
  echo "starter file downloaded"
  make_curling_file $starter_file $file_o_links
  echo "file o' links written"
  authenticate $(make_https $(head -n 1 $starter_file))

  $curl_with_auth -K $file_o_links
}

make_file_pattern_from_date () {
  echo _${1:0:4}m${1:4:4}
}

parse_args () {
# http://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash#answer-14203146
USERNAME=""
PASSWORD=""
FILE_PATTERN='.'

while [[ $# -gt 1 ]]
do
key="$1"


case $key in
    -u|--username)
    USERNAME="$2"
    shift # past argument
    ;;
    -p|--password)
    PASSWORD="$2"
    shift # past argument
    ;;
    -d|--date)
    FILE_PATTERN=$(make_file_pattern_from_date $2)
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done
}

parse_args "$@"
run $USERNAME $PASSWORD
