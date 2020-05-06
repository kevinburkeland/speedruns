#!/bin/bash
#vars for the instance
amiID='068663a3c619dd892'
iNum='1'
iType='t2.micro'
sshKey='Kevin-Linux-Ec2'
iSg='0a81ba4381d9225ae'

#launch it and collect the json
iId=$(aws ec2 run-instances \
--image-id ami-$amiID \
--count $iNum \
--instance-type $iType \
--key-name $sshKey \
--security-group-ids sg-$iSg \
--user-data file://wp-docker.sh)
#parse the json for the instance id
iId=`echo $iId|jq --raw-output '.Instances[0].InstanceId'`
#use the instance id to grab the ip
iIp=`aws ec2 describe-instances --instance-id $iId| jq --raw-output .Reservations[].Instances[].PublicIpAddress`
#check the site every 5 seconds until its up and running
until curl -sSf http://$iIp
    do sleep 5
done