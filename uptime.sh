#!/bin/sh

if [ -r "/proc/stat" ]; then
  # try Procfs first (Linux)
  BootTime=$(grep btime /proc/stat | cut -d ' ' -f 2)
else
  # fall back on sysctl
  BootTime=$(sysctl -n kern.boottime 2>/dev/null | cut -d, -f1 | cut -d' ' -f4)
  if [ $? -gt 0 ]; then
    echo "Failed to get boot time." >&2
    exit 1
  fi
fi

TotalSec=$(($(date +%s) - $BootTime))
Days=$(($TotalSec / 86400))
Hours=$((($TotalSec - $Days * 86400) / 3600))
Minutes=$((($TotalSec - $Days * 86400 - $Hours * 3600) / 60))
printf "%id %02ih %02im\n" $Days $Hours $Minutes
