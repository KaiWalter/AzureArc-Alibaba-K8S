# AzureArc-Alibaba-K8S

Connect a __Alibaba Cloud__ Kubernetes cluster to __Azure Arc___ and deploy workloads on it which has PaaS abstracted with __Dapr__.

## prerequisites

- Aliyun CLI
- Azure CLI
- jq
- Terraform

## getting started

### environment variables

set environment variables (e.g. in `.profile`) :

```bash
export ALICLOUD_ACCESS_KEY="----Alibaba Cloud access-key----"
export ALICLOUD_SECRET_KEY="----secret-key----"
export ALICLOUD_REGION="----region----" # e.g. cn-shanghai
export ALICLOUD_PROFILE="akProfile"

export AZURE_SUBSCRIPTION_ID="----Azure subscription id----"
export AZURE_LOCATION="----location---" # e.g. southeastasia
export AZURE_RESOURCE_GROUP="---resource group----"
```

### deploy jump VM and cluster

```bash
cd ./AzureArc-Alibaba-K8S/setups
terraform init
terraform apply
```

### setup jump VM

```bash
cd ..
./setup_ay_jump.sh
```

### check VM installation status

```bash
./ssh_ay_jump.sh

tail /var/log/cloud-init-output.log
```

### deploy sample application

```bash
./deploy_demo.sh
```
