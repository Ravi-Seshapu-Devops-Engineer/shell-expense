#!/bin/bash
#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shell-expense"
LOGS_FILE="/var/log/shell-expense/$0.log"
USERID=$(id -u)
SCRIPT_DIR=$PWD


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

dnf install nginx -y 
validate $? "Installing nginx is "

systemctl enable nginx
validate $? "enabling nginx is"

systemctl start nginx
validate $? "starting nginx is"

rm -rf /usr/share/nginx/html/*
validate $? "removing the existing html conent is"

curl -o /tmp/frontend.zip https://expense-joindevops.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip
validate $? "Downloading frontend content is "

cd /usr/share/nginx/html
validate $? "moving to html directory is "

unzip /tmp/frontend.zip
validate $? "unzipping the code is "

cp $SCRIPT_DIR/expense.conf /etc/nginx/default.d/expense.conf
validate $? "Copying is "

systemctl restart nginx
validate $? "restart is"