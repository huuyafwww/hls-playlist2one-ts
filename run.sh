#!/usr/bin/env bash

source "`pwd`/messages.sh";
source "`pwd`/functions.sh";

if [ $# = 0 ]; then
    exit_program not_found_cli_option_message
fi

while getopts f:s:o: OPTION
do
  case ${OPTION} in
      f) file=${OPTARG};;
      s) src=${OPTARG};;
      o) output=${OPTARG};;
      \?) exit_program confirm_cli_option_message
  esac
done

if [ -z ${file} -o -z ${src} ]; then
  exit_program shortage_cli_option_message
fi

if [ -z ${output} ]; then
  output="`pwd`/temp"
fi

file_exists ${file}

if [ ${?} -eq 0 ]; then
  exit_program playlist_file_not_exists_message
fi

is_playlist_file ${file}

if [ ${?} -eq 0 ]; then
  exit_program is_not_playlist_file_message
fi

temp_dir_exists

if [ ${?} -eq 0 ]; then
  mkdir ${output}
fi

i=1
while read line
do
  is_segment_file_line ${line}
  if [ ${?} -eq 1 ]; then
    segment_file_url=`echo ${src}${line}`
    curl ${segment_file_url} > ${output}/${i}.ts
    i=`expr $i + 1`
  fi
done < ${file}

eval "cat ${output}/{1..${i}}.ts > ${output}/output.ts"

for filename in `seq 1 ${i}`
do
  rm -f ${output}/${filename}.ts
done
