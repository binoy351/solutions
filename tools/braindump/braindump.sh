#!/bin/bash 

# This is your helm deployment name
# If you need to find this, please use "helm list" to find the Cortex deployment name
HELM_MANIFEST="cortex"
NAMESPACE="cortex"

# This is your backend deployment name.
# If you need to find this, please use "kubectl get deployments"
CORTEX_BACKEND_DEPLOYMENT="cortex-deployment-backend"

mkdir braindump; cd braindump/
helm get manifest $HELM_MANIFEST -n $NAMESPACE > helm-manifest.yaml
kubectl describe deployments -n $NAMESPACE > deployments.json
kubectl get po -o json -l cortex -n $NAMESPACE > pods.json
kubectl logs --since=8h deployment/$CORTEX_BACKEND_DEPLOYMENT -n $NAMESPACE > backend-logs.log
cd ..
tar -cvzf braindump.tar.gz braindump

echo "\n\n############################## CORTEX BRAINDUMP COMPLED ###################################"
echo "Please send the generated file \'braindump.tar.gz\' to Cortex support at help@cortex.io!"
echo "###########################################################################################\n\n"
