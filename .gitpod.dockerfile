FROM gitpod/workspace-postgres

RUN sudo apt-get update  && sudo apt-get install -y redis-server chromium-chromedriver apt-transport-https ca-certificates && sudo update-ca-certificates  && sudo rm -rf /var/lib/apt/lists/*

USER gitpod
SHELL ["/bin/bash", "-c"]

RUN cd && /home/gitpod/.rvm/bin/rvm install "ruby-2.7.7"

