#!/bin/bash

SG_ID="sg-0a5abae1f19128f75" #Replace with your ID
AMI_ID="ami-0220d79f3f480ecf5" # Replace with your ID

for instance in "$@"
do
    INSTANCE_ID=$(aws ec2 run-instances \
        --image-id $AMI_ID \
        --instance-type t3.micro \
        --security-group-ids $SG_ID \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
        --query 'Instances[0].InstanceId' \
        --output text)
    
    if [ $INSTANCE_ID == "frontend" ]; then
        IP=$(
            aws ec2 describe-instances \
            --instance-ids $INSTANCE_ID \
            --query 'Reservations[].Instances[].PublicIpAddress' \
            --output text
        )
    else
        IP=$(
            aws ec2 describe-instances \
            --instance-ids $INSTANCE_ID \
            --query 'Reservations[].Instances[].PublicIpAddress' \
            --output text
        )
    fi
    echo "IP Address: $IP"
done


# aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text

# INSTANCE_ID=$(aws ec2 run-instances \
#     --image-id ami-xxxxxxxxxxxxxxxxx \
#     --count 1 \
#     --instance-type t2.micro \
#     --key-name YourKeyPairName \
#     --security-group-ids sg-xxxxxxxxxxxxxxxxx \
#     --subnet-id subnet-xxxxxxxxxxxxxxxxx \
#     --query 'Instances[0].InstanceId' \
#     --output text)