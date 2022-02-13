#!bin/bash

echo '######################################'
echo '##### push source code to github #####'
echo '######################################'

## push source code to github
#################
echo '##########################'
echo '######push to github######'
echo '##########################'
time=$(date "+%Y-%m-%d %H:%M:%S")  # get current time
git status
git add .
git commit -m "only push at ${time}"
# git remote add origin git@github.com:crazyjums/blog3.git
git push
