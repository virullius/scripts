#!/bin/sh

# $1 = username
# $2 = hostname
# $3 = scriptname

if [ $# -lt 3 ];
then
  echo "Usage: $0 <username> <hostname> <script file>" > /dev/stderr
  exit 1
fi

printf "Enter password for $1@$2:"
# save terminal settings
sttyo=$(stty -g)
# disable terminal echo
stty -echo
read RemoteHostPassword
# restore terminal settings
stty $sttyo
printf "\033[2K\r"

# on remote host: pipe script file contents to remote host over ssh, save in
# temp file and return temp file name
RemoteTempFile=$(ssh $1@$2 "\
    TempFile=\$(mktemp) &&  \
    cat > \$TempFile &&     \
    chmod u+x \$TempFile && \
    echo \$TempFile         \
" < $3)

# send password to ssh process which forwards to sudo which takes password
# on STDIN with -S argument, execute temp file, remove temp file
echo $RemoteHostPassword | \
  ssh -qt $1@$2 "\
    (sudo -S $RemoteTempFile 2>/dev/null ||           \
     echo \"Script failed on host\" > /dev/stderr) && \
     rm $RemoteTempFile                               \
"

