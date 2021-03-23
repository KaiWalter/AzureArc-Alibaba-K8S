#!/bin/bash
# cluster_id=$(aliyun cs GET /clusters --name azure-arc-poc | jq -r '.[0].cluster_id')
# aliyun cs GET /k8s/$cluster_id/user_config | jq -r '.config' >./kubeconfig

chmod go-r ~/.kube/config

public_ip=$(aliyun ecs DescribeInstances --InstanceName azure-arc-poc-jump | jq -r '.Instances.Instance[0].PublicIpAddress.IpAddress[0]')
ssh -i ~/.ssh/id_rsa root@$public_ip mkdir /root/.kube
scp -i ~/.ssh/id_rsa ~/.kube/config root@$public_ip:/root/.kube/config
scp -i ~/.ssh/id_rsa ./connect_cluster.sh root@$public_ip:/root/connect_cluster.sh