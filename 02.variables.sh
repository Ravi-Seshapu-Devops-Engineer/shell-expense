#!/bin/bash

person1=$1
person2=$2

echo "$person1: Hi $person2, how are you?"
echo "$person2: I'm good $person1, how about you?"

echo "please enter your username"
read USERNAME
echo "username is $USERNAME"

echo "enter you passcode"
read -s PASSCODE


START_TIME=$(date +%s)
echo "script stated executing at $START_TIME"
sleep 10
END_Time=$(date +%s)
total_time=$($END_Time-$START_TIME)
echo "script executed in $total_time seconds"



