#!/bin/bash

# person1=$1
# person2=$2

# echo "$person1: Hi $person2, how are you?"
# echo "$person2: I'm good $person1, how about you?"

# echo "please enter your username"
# read USERNAME
# echo "username is $USERNAME"

# echo "enter you passcode"
# read -s PASSCODE


# START_TIME=$(date +%s)
# #echo "script stated executing at $START_TIME"
# sleep 10
# END_Time=$(date +%s)
# total_time=$(($END_Time-$START_TIME))
# echo "script executed in $total_time seconds"

# ##special variables
# echo "all variables passed to the script: $@"
# echo "no of variables passed to the script: $#"
# echo "status code of the previous command: $?"
# echo "present working directory: $PWD"
# echo "script name: $0"
# echo "who is running the script: $USER"
# echo "PID od the script: $$"
# sleep 100 &
# echo "bckground process id: $!"

#datatypes array

# fruits=("Apple" "banana" "mango")
# first_fruit=${fruits[0]}
# echo "$first_fruit"
# echo "second fruit is ${fruits[1]}"
# echo "fourth fruit is ${fruits[3]}"

# NUMBER=$1

# if [ $NUMBER -gt 20 ]; then
#   echo " The number $NUMBER is greater than 20"
# elif [ $NUMBER -eq 20 ]; then
#   echo " The number $NUMBER ie equal to 20"
# else
#   echo "The number $NUMBER is less than 20"
# fi


USERID=$(id -u)

if [ $USERID -ne 0 ]; then
  echo "please run the script with sudo user access"
  exit 1
fi

# echo "installing nginx"
# dnf install nginx -y

# if [ $? -ne 0 ]; then
#   echo "installing nginx is failed"
# else
#   echo "installing nginx is success"
# fi

validate(){
  if [ $1 -ne 0 ]; then
    echo "installing $2 failed"
  else
    echo "installing $2 success"
  fi
}

dnf install mysql
validate $? mysql