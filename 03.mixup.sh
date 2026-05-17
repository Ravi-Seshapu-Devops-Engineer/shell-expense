#!/bin/bash
set -e
trap 'echo "There is an error in $LINENO, Command: $BASH_COMMAND"' ERR
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-expense"
LOGS_FILE="/var/log/shell-expense/$0.log"

if [ $USERID -ne 0 ]; then
  echo -e "$R Please run the script with root user access $N" | tee $LOGS_FILE
  exit 1
fi

validate(){
  if [ $1 -ne 0 ]; then
    echo -e "$R installing $2 failed" | tee $LOGS_FILE
  else
    echo -e "$G installing $2 success" | tee $LOGS_FILE
  fi
}

for package in $@
do
  dnf list installed "$package" &>>$LOGS_FILE
  if [ $? -ne 0 ]; then
    echo -e "$Y The given package is not installed. Installing now $N"
    dnf install $package -y &>>$LOGS_FILE
    validate $? $package
  else
    echo -e "$Y already exists skipping..$N"
  fi
done