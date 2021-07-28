#!/bin/sh
# Not POSIX compatible due to -p argument on read

Prompt=">"

function do_one {
  echo "one"
}

function do_two {
  echo "two"
}

while read -p "$Prompt " line
do
  case "$line" in
    one)
      do_one
      ;;
    two)
      do_two
      ;;
    quit)
      exit 0
      ;;
    *)
      echo "unknown command \"$line\""
  esac
done
