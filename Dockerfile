FROM ubuntu:20.04

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y openssh-client curl python3-pip vim bash-completion git jq nodejs

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN mv kubectl /usr/local/bin/ && chmod a+x /usr/local/bin/kubectl
RUN kubectl completion bash > /usr/share/bash-completion/completions/kubectl

RUN pip3 install awscli

RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
RUN mv /tmp/eksctl /usr/local/bin
RUN eksctl completion bash > /usr/share/bash-completion/completions/eksctl

RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
RUN helm completion bash > /usr/share/bash-completion/completions/helm


RUN curl -so /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest && chmod +x /usr/local/bin/ecs-cli

RUN curl -L https://npmjs.org/install.sh | sh
RUN npm install -g --no-bin-links aws-cdk
ADD requirements.txt .
RUN pip3 install -r requirements.txt

RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "/tmp/session-manager-plugin.deb" && dpkg -i /tmp/session-manager-plugin.deb

RUN apt update && DEBIAN_FRONTEND=noninteractive apt -y install unzip

RUN curl "https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip" -o "/tmp/terraform_0.12.24_linux_amd64.zip" \
    && unzip /tmp/terraform_0.12.24_linux_amd64.zip -d /usr/local/bin

ADD post-install.sh /var/tmp
RUN chmod a+x /var/tmp/post-install.sh



#./launch-instance.sh AKIAVZZ64MGKZVQBLX5D wDzLxH4woSoHGOP0faqGirnjwxOU7/oYrR4xRls5
#ssh-keygen -f /root/.ssh/id_rsa -N ''
#aws ec2 import-key-pair --key-name yop --public-key-material "$(cat /root/.ssh/id_rsa.pub)"
#eksctl create cluster -f /root/eks.yaml
