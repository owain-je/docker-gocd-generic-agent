FROM gocd/gocd-agent-ubuntu-16.04:v17.7.0
RUN apt-get update -y 
RUN apt-get install -y git vim ruby language-pack-en-base curl apt-transport-https lsb-release software-properties-common python-pip python-software-properties  git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev libffi-dev
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
RUN curl -LO https://packages.chef.io/files/stable/chef/12.21.3/ubuntu/16.04/chef_12.21.3-1_amd64.deb
RUN dpkg -i ./chef_12.21.3-1_amd64.deb
RUN echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list


RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && / 
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && / 
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc && /
	exec $SHELL
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build && /
	echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc && /
	exec $SHELL && /
	rbenv install 2.3.1 && /
	rbenv global 2.3.1

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893
RUN apt-get update
RUN apt-get install -y dotnet-dev-1.0.4