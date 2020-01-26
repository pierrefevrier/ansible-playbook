# Don't work with centos8
FROM centos:centos7

MAINTAINER Pierre FEVRIER <docker@pierrefevrier.fr>

RUN yum clean all && \
    # epel-release is needed to install python-pip
    yum -y install epel-release && \
    # openssh-clients: The OpenSSH client applications
    # openssh-client: The OpenSSH server daemon (to use ssh-agent)
    yum -y install python-pip openssh-clients openssh-client which
RUN mkdir /etc/ansible && echo -e '[local]\nlocalhost' > /etc/ansible/hosts
RUN pip install ansible==2.9.4

# To avoid the following error: "Failed to connect to the host via ssh: Host key verification failed."
ENV ANSIBLE_HOST_KEY_CHECKING false

