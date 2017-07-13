FROM gocd/gocd-agent-ubuntu-16.04:v17.7.0
RUN apt-get update -y 
RUN apt-get install -y git vim ruby language-pack-en-base curl apt-transport-https lsb-release software-properties-common python-pip python-software-properties
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -  
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update -y 
#RUN apt-cache policy docker-ce
RUN apt-get install -y docker-ce
RUN usermod -aG docker go
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl && mv ./kubectl /usr/local/bin/
RUN curl -LO https://storage.googleapis.com/kubernetes-helm/helm-v2.5.0-linux-amd64.tar.gz 
RUN tar -zxvf helm-v2.5.0-linux-amd64.tar.gz 
RUN mv linux-amd64/helm /usr/local/bin 
RUN pip install --upgrade pip
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
RUN unzip awscli-bundle.zip
RUN ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
RUN rm -f awscli-bundle.zip && rm -rf ./awscli-bundle





#apt-get update -y && apt-get install -y git vim ruby curl apt-transport-https lsb-release software-properties-common python-software-properties && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -  && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && apt-get update -y && apt-get install -y docker-ce && usermod -aG docker go && curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/ && curl -LO https://storage.googleapis.com/kubernetes-helm/helm-v2.5.0-linux-amd64.tar.gz && tar -zxvf helm-v2.5.0-linux-amd64.tar.gz && mv linux-amd64/helm /usr/local/bin 