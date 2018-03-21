#!/bin/bash

## script to update security group inbound rules with current ip address
## takes argument of security group name
GROUPNAME=$1

### pull current security group inbound rules and find the current cidrip
### this assumes you only have one current inbound rule that ends with a /32
currentSgIp=$(aws ec2 describe-security-groups --group-names $GROUPNAME | awk '/CidrIp/ && /\/32/ {print $2}')
currentSgIp="${currentSgIp%\"}"
currentSgIp="${currentSgIp#\"}"

### revoke the current inbound rule
aws ec2 revoke-security-group-ingress --group-name $GROUPNAME --protocol tcp --port 22 --cidr $currentSgIp
echo "$currentSgIp has been revoked from security group $GROUPNAME."

### authorizing the new inbound rule with current ip address
newIp=$(curl http://checkip.amazonaws.com/)
aws ec2 authorize-security-group-ingress --group-name $GROUPNAME --protocol tcp --port 22 --cidr $newIp/32
echo "$newIp/32 has been authorized for security group $GROUPNAME"
