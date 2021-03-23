#!/bin/bash
public_ip=$(aliyun ecs DescribeInstances --InstanceName azure-arc-poc-jump | jq -r '.Instances.Instance[0].PublicIpAddress.IpAddress[0]')
ssh -i ~/.ssh/id_rsa root@$public_ip