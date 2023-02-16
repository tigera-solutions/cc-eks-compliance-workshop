# 0. Getting Started

## Prerequisites 

The following are the basic requirements to **start** the workshop.

* Azure Account [Azure Portal](https://portal.azure.com)
* Git [Git SCM](https://git-scm.com/downloads)
* Azure Cloud Shell [https://shell.azure.com](https://shell.azure.com)

## Instructions

1. Login to Azure Portal at http://portal.azure.com.
2. Open the Azure Cloud Shell and choose Bash Shell (do not choose Powershell)

   ![img-cloud-shell](https://user-images.githubusercontent.com/104035488/214944180-0b72595f-b58d-445d-9bde-2530bd491ace.png)

3. The first time Cloud Shell is started will require you to create a storage account.

4. Once your cloud shell is started, clone the workshop repo into the cloud shell environment

   ```bash
   git clone https://github.com/tigera-solutions/cc-aks-compliance.git && \
   cd cc-aks-compliance
   ```

   > Note: In the cloud shell, you are automatically logged into your Azure subscription.

5. Ensure you are using the correct Azure subscription you want to deploy AKS to.

   View subscriptions
   ```bash
   az account list
   ```

   Verify selected subscription
   ```bash
   az account show
   ```

   Set correct subscription (if needed)
   ```bash
   az account set --subscription <subscription_id>
   ```
   
   Verify correct subscription is now set
   ```bash
   az account show
   ```

6. Configure the kubectl autocomplete.

   ```bash
   source <(kubectl completion bash) # set up autocomplete in bash into the current shell, bash-completion package should be installed first.
   echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.
   ```

   You can also use a shorthand alias for kubectl that also works with completion:

   ```bash
   alias k=kubectl
   complete -o default -F __start_kubectl k
   echo "alias k=kubectl"  >> ~/.bashrc
   echo "complete -o default -F __start_kubectl k" >> ~/.bashrc
   ```

---

[:arrow_right: 1. Deploy AKS](../1.%20Deploy%20AKS/readme.md) <br>
 
[:leftwards_arrow_with_hook: Back to Main](../README.md)