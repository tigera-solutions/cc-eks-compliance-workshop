# 0. Getting Started

## Prerequisites 

The following are the basic requirements to **start** the workshop.

* AWS Account with appropriate IAM role [AWS Portal](https://aws.amazon.com/console/)
* Access/Secret Key [Setup](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-prereqs.html#getting-started-prereqs-keys)
* ```eksctl``` CLI tool installed
  
The following pre-requisites apply if you are using your own (local) environment/terminal:

* Git [Git SCM](https://git-scm.com/downloads)
* AWS CLI [Getting Started](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-prereqs.html)
* kubectl installed [Instructions](https://kubernetes.io/docs/tasks/tools/)
  
## Instructions

0. If using AWS CloudShell, then log into the AWS Console for your account. If using a local environment, fire up your terminal

1. Clone the workshop repo into your environment of choice

   ```bash
   git clone https://github.com/tigera-solutions/cc-eks-compliance-workshop.git && \
   cd cc-eks-compliance-workshop
   ```

2. Setup AWS credentials file as per [the instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html) by running ```aws configure```
   For example:

   ```bash
   AWS Access Key ID [none]: <redacted>
   AWS Secret Access Key [none]: <redacted>
   Default region name [none]: us-east-1
   Default output format [none]:
   ```

3. Ensure you are using the correct AWS account and IAM role you want to deploy your EKS cluster to.

   View account #

   ```bash
   aws sts get-caller-identity --query "Account" --output text
   ```

   should output the user account number.

4. If using local environment, make sure ```kubectl``` is installed as per the instructions for your environment: [Instructions](https://kubernetes.io/docs/tasks/tools/)

5. (Optional) Configure the kubectl autocomplete (Example below given for ```bash```)

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