#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shell-expense"
LOGS_FILE="/var/log/shell-expense/$0.log"
USERID=$(id -u)
SCRIPT_DIR=$PWD
MYSQL_HOST=mysql.seshapudevops.online


if [ $USERID -ne 0 ]; then
  echo -e "$R please run the scriptwith sudo user access $N" | tee -a $LOGS_FILE
  exit 1
fi

mkdir -p $LOGS_FOLDER

validate(){
  if [ $1 -ne 0 ]; then
    echo -e "$R $2 failed $N" | tee -a $LOGS_FILE
  else
    echo -e "$G $2 success $N" | tee -a $LOGS_FILE
  fi
}

dnf module disable nodejs -y &>> $LOGS_FILE
validate $? "disabling nodejs existing version is $N"

dnf module enable nodejs:20 -y &>> $LOGS_FILE
validate $? "Enabling nodejs 20 version is"

dnf install nodejs -y &>> $LOGS_FILE
validate $? "Installing Nodejs is"

dnf update -y openssh openssh-server openssh-clients &>> $LOGS_FILE
validate $? "openssh enabling is"

id expense
if [ $? -ne 0 ]; then
  echo "user does not exist creating the user now"
  useradd expense
  validate $? "adding user expense is"
else
  echo "User already exists.. skipping"
fi

rm -r /app
validate $? "Removing the appdirectory is"

mkdir /app
validate $? "creating app directory is"

curl -o /tmp/backend.zip https://expense-joindevops.s3.us-east-1.amazonaws.com/expense-backend-v2.zip
validate $? " Downloading the code is"

cd /app
validate $? "changed to app directory is"

rm -rf /app/*
validate $? "removing the existing code"

unzip /tmp/backend.zip
validate $? "downloading the code"

npm install
validate $? "installing dependencies is"

cp /$SCRIPT_DIR/backend.service /etc/systemd/system/backend.service
validate $? "Coying the backend service file is"

systemctl daemon-reload
validate $? "reload is"

systemctl start backend
validate $? "backend starting is"

systemctl enable backend
validate $? "enabling backend is"

dnf install mysql -y
validate $? "Installing mysql is"

mysql -h $MYSQL_HOST -uroot -pExpenseApp@1 < /app/schema/backend.sql &>> $LOGS_FILE
validate $? "loading schema is"

systemctl restart backend
validate $? "backend restart is"



