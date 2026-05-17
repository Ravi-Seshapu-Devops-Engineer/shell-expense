#!/bin/bash

R="\[31m"
Y="\[32m"
G="\[33m"
N="\[0m"
LOGS_FOLDER="/var/log/shell-expense"
LOGS_FILE="/var/log/shell-expense/$0.log"
USERID=$(id -u)

if [ $USERID -ne 0 ]; then
  echo -e "$R please run the scriptwith sudo user access $N" | tee -a $LOGS_FILE
  exit 1
fi

validate(){
  if [ $1 -ne 0 ]; then
    echo -e "$R $2 failed $N" | tee -a $LOGS_FILE
  else
    echo -e "$G $2 success $N" | tee -a $LOGS_FILE
  fi
}

dnf install mysql-server -y &>>$LOGS_FILE
validate $? "mysql-server installation is "

systemctl enable mysqld &>>$LOGS_FILE
systemctl start mysqld &>>$LOGS_FILE
validate $? "mysqld enable"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGS_FILE
validate $? "mysql_secure_installation is"