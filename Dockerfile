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
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893
RUN apt-get update
RUN apt-get install -y dotnet-dev-1.0.4

# Ruby crazy 
RUN git clone https://github.com/rbenv/rbenv.git /usr/local/rbenv 
RUN git clone https://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build 
RUN git clone https://github.com/jf/rbenv-gemset.git /usr/local/rbenv/plugins/rbenv-gemset 
RUN /usr/local/rbenv/plugins/ruby-build/install.sh
ENV PATH /usr/local/rbenv/bin:$PATH
ENV RBENV_ROOT /usr/local/rbenv
RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh 
RUN  echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /etc/profile.d/rbenv.sh 
RUN  echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /root/.bashrc 
RUN echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /root/.bashrc 
RUN echo 'eval "$(rbenv init -)"' >> /root/.bashrc
ENV CONFIGURE_OPTS --disable-install-doc
ENV PATH /usr/local/rbenv/bin:/usr/local/rbenv/shims:$PATH
RUN eval "$(rbenv init -)"; rbenv install 2.4.1 
RUN eval "$(rbenv init -)"; rbenv global 2.4.1 
RUN eval "$(rbenv init -)"; gem update --system 
RUN eval "$(rbenv init -)"; gem install bundler
RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /home/go/.bashrc 
RUN echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /home/go/.bashrc 
RUN echo 'eval "$(rbenv init -)"' >> /home/go/.bashrc && chown go:go /home/go/.bashrc 

RUN eval "$(rbenv init -)"; gem install awscli