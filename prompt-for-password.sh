#!/bin/sh
# POSIX compatible password prompt example

# Print prompt
printf "Password:"

# save tty settings
sttyo=$(stty -g)

# disable printing input characters back to terminal
stty -echo

# read line from terminal and store in $Password
read Password

# restore tty settings
stty $sttyo


# For demonstration purposes: clear line, show password for 1 second then clear line again
printf "\033[2K\r"
printf $Password
sleep 1
printf "\033[2K\r"

