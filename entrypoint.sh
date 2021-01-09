#!/bin/sh

set -x

TOKEN=$1
IMAGE=$2
DROPLET=$3

echo Num args passed $#
echo Token is $TOKEN >> /tmp/debug
echo Image is $IMAGE >> /tmp/debug
echo Droplet is $DROPLET >> /tmp/debug

cat /tmp/debug

check_progress (){
  ACTION_STATUS=`curl -s -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" "https://api.digitalocean.com/v2/actions/$ACTION_ID" | jq -r .action.status`
  echo The current action status is $ACTION_STATUS
  if [ "$ACTION_STATUS" = "completed" ]; then
    echo "Completed"
    return 0
  else
    sleep 5
    echo Rebuild not yet complete... 
    check_progress
  fi
}


curl -v -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d '{"type":"rebuild","image":"'$IMAGE'"}' "https://api.digitalocean.com/v2/droplets/$DROPLET/actions"

ACTION_ID=`curl -v -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d '{"type":"rebuild","image":"'$IMAGE'"}' "https://api.digitalocean.com/v2/droplets/$DROPLET/actions" | jq .action.id`


echo Action ID is $ACTION_ID

check_progress
if [ $? -ne 0 ]
then
  check_progress
fi

echo Rebuild of droplet $DROPLET is complete.
return 0

