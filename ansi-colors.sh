#!/bin/sh

# ESC[A;B;Cm
# A = 38: set foreground color
# A = 48: set background color
# A = 0: reset
# B = 5: ???
# C = :
#     0-  7:  standard colors (as in ESC [ 30–37 m)
#     8- 15:  high intensity colors (as in ESC [ 90–97 m)
#    16-231:  6 × 6 × 6 cube (216 colors): 16 + 36 × r + 6 × g + b (0 ≤ r, g, b ≤ 5)
#   232-255:  grayscale from black to white in 24 steps

echo "[Standard and High-intensity colors]"
for I in $(seq 0 15); do
  printf '\033[38;5;%sm%-3s \033[0m' $I $I
done
echo
echo "[216 colors]"
for I in $(seq 16 231); do
  printf '\033[38;5;%sm%-3s \033[0m' $I $I
  if [ $(($(($I-15)) % 36)) -eq 0 ]; then
    printf "\n"
  fi
done
echo
echo "[Grayscale]"
for I in $(seq 232 255); do
  printf '\033[38;5;%sm%-3s \033[0m' $I $I
done
echo
