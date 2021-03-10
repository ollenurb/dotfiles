#!/bin/zsh
DIR="/home/matteo/.backgrounds/"
PIC=$(ls $DIR | shuf -n 1)
feh --bg-fill $DIR$PIC
