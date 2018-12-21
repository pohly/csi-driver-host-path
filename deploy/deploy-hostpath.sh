#!/usr/bin/env bash

# This script captures the steps required to successfully
# deploy the hostpath plugin driver.  This should be considered
# authoritative and all updates for this process should be
# done here and referenced elsewhere.

# The script assumes that kubectl is available on the OS path 
# where it is executed.

K8S_RELEASE=${K8S_RELEASE:-"release-1.13"}
CSI_RELEASE=${CSI_RELEASE:-"release-1.0"}
BASE_DIR=$(dirname "$0")

# apply CSIDriver and CSINodeInfo API objects
kubectl apply -f https://raw.githubusercontent.com/kubernetes/csi-api/${K8S_RELEASE}/pkg/crd/manifests/csidriver.yaml --validate=false
kubectl apply -f https://raw.githubusercontent.com/kubernetes/csi-api/${K8S_RELEASE}/pkg/crd/manifests/csinodeinfo.yaml --validate=false

# rbac rules
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-provisioner/${CSI_RELEASE}/deploy/kubernetes/rbac.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-attacher/${CSI_RELEASE}/deploy/kubernetes/rbac.yaml

# deploy hostpath plugin and registrar sidecar
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/node-driver-registrar/${CSI_RELEASE}/deploy/kubernetes/rbac.yaml
kubectl apply -f ${BASE_DIR}/hostpath
