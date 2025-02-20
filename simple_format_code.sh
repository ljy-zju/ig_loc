#!/bin/bash

set -euo pipefail

clang_format_name=clang-format-10
clang_format_exe=/usr/bin/$clang_format_name
if [ ! -f $clang_format_exe ]; then
  echo "Please install clang-format-10..."
  echo "====> sudo apt install $clang_format_name -y"
  exit 1
fi

result=''

function FormatCode()
{
  if [ "X$1" != 'X' ]; then
    cd "$1"
  fi

  files=`ls`

  for filename in $files
  do
    if [ -d $filename ]; then
      FormatCode $filename
    elif [ ${filename##*.} = 'cpp' ] || [ ${filename##*.} = 'h' ]; then
        result=${result}" "$filename
        ${clang_format_exe} -style=file -i $filename
        format_curr_result="$?"
        if [ "x$format_curr_result" = "x0" ]; then
          echo -e "\033[34m Finished clang-format $filename \033[0m"
        else
          echo -e "\033[31m >> [Error] Something is wrong in process of formating code $filename \033[0m"
        fi
    fi
  done

  cd ..
}

script_dir=$(cd $(dirname $0) && pwd)
src_dir=$script_dir/src
echo $src_dir
FormatCode $src_dir

src_dir=$script_dir/include
echo $src_dir
FormatCode $src_dir

git_status=`git status -s`
if [ -n "$git_status" ]; then
  echo "Please check the format of files below."
  echo $git_status
  # Return 1 for file change test.
  exit 1
fi
