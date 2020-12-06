#!/bin/bash -xe

iid=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

export AWS_DEFAULT_REGION="${eks_cluster_region}"

ilc=`aws ec2 describe-instances --instance-ids $iid --query 'Reservations[0].Instances[0].InstanceLifecycle' --output text`

if [ "$ilc" == "spot" ]; then
  kubelet_extra_args='--node-labels=lifecycle=Ec2Spot --register-with-taints=spotInstance=true:PreferNoSchedule'
else
  kubelet_extra_args='--node-labels=lifecycle=OnDemand'
fi

# Bootstrap and join the cluster
B64_CLUSTER_CA='${eks_cluster_auth_base64}'
API_SERVER_URL='${eks_cluster_endpoint}'
/etc/eks/bootstrap.sh '${eks_cluster_name}'\
  --kubelet-extra-args "$kubelet_extra_args ${eks_cluster_kubelet_extra_args}" \
  --b64-cluster-ca "$B64_CLUSTER_CA" \
  --apiserver-endpoint "$API_SERVER_URL" \
  ${eks_cluster_bootstrap_extra_args}
