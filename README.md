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
export ALICLOUD_ACCESS_KEY="----access-key----"
export ALICLOUD_SECRET_KEY="----secret-key----"
export ALICLOUD_REGION="----region----"  # e.g. cn-shanghai
export ALICLOUD_PROFILE="akProfile"
```

### deploy jump VM and cluster

```bash
cd ./AzureArc-Alibaba-K8S/setups
terraform init
terraform apply
```

### copy `kubeconfig` to jump VM

```bash
cd ..
./set_kubeconfig.sh
```

### check VM installation status

```bash
./ssh_ay_jump.sh

tail /var/log/cloud-init-output.log
```
