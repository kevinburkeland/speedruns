#!/bin/bash
amiID='068663a3c619dd892'
iNum='1'
iType='t2.micro'
iSg='0654b352a41c99d03'

#launch it and collect the json
iId=$(aws ec2 run-instances \
--image-id ami-$amiID \
--count $iNum \
--instance-type $iType \
--security-group-ids sg-$iSg \
--user-data file://instance-setup.sh)
#parse the json for the instance id
iId=`echo $iId|jq --raw-output '.Instances[0].InstanceId'`
#use the instance id to grab the ip
iIp=`aws ec2 describe-instances --instance-id $iId| jq --raw-output .Reservations[].Instances[].PublicIpAddress`

until curl -sSf http://$iIp
    do sleep 1
done