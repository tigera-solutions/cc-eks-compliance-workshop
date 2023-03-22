# 0. Getting Started

## Prerequisites 

The following are the basic requirements to **start** the workshop.

* AWS Account [AWS Portal](https://aws.amazon.com/console/)
* Git [Git SCM](https://git-scm.com/downloads)
* AWS CLI [Getting Started](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-prereqs.html)
* Access/Secret Key [Setup](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-prereqs.html#getting-started-prereqs-keys)
* kubectl installed [Instructions](https://kubernetes.io/docs/tasks/tools/)
  
## Instructions

1. Clone the workshop repo into the your local environment

   ```bash
   git clone https://github.com/tigera-solutions/cc-eks-compliance-workshop.git && \
   cd cc-eks-compliance-workshop
   ```

2. Ensure you are using the correct AWS account and IAM role you want to deploy your EKS cluster to.

   View account #

   ```bash
   aws sts get-caller-identity --query "Account" --output text
   ```

3. Setup AWS credentials file as per [the instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html) by running ```aws configure```

4. (Optional) Configure the kubectl autocomplete (Example below given for ```bash```)

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

[:arrow_right: 1. Deploy EKS](../1.%20Deploy%20EKS/readme.md) <br>
 
[:leftwards_arrow_with_hook: Back to Main](../README.md)