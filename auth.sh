#!/bin/sh
echo "START CHECKING"
curl -s https://baidu.com | grep -q white
if [ $? -ne 0 ];then
  echo "AUTHING"
  LOGIN=$(curl -s -X POST **将KEY粘贴到这个位置！！星号删除！POST后有一个空格！**
)
  echo "$LOGIN" | grep -q success
  if [ $? -eq 0 ];then
    echo "AUTH SUCCESS"
  else
    echo "AUTH FILD, CHECK ISSUE"
  fi
else
  echo "IS ONLINE"
fi