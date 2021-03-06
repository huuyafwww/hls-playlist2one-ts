#!/usr/bin/env bash

exit_program(){
  echo ${!1};
  exit 1;
};

file_or_folder_exists(){
  if [ -e "${1}" ]; then
    return 1
  else
    return 0
  fi
};

is_playlist_file(){
  if [ "`file "${1}" -d | grep "M3U playlist"`" ]; then
    return 1
  else
    return 0
  fi
};

is_segment_file_line(){
  if [ "`echo "${1}" | grep ".ts"`" ]; then
    return 1
  else
    return 0
  fi
}