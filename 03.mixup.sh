#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-expense"
LOGS_FILE="/var/log/shell-expense/$0.log"

if [ $LOGS_FILEUSERID -ne 0 ]; then
  echo "$R Please run the script with root user access $N"
  exit 1
fi


