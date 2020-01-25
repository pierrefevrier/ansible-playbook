# Don't work with centos8
FROM centos:centos7
MAINTAINER Pierre FEVRIER <docker@pierrefevrier.fr>
RUN yum clean all && \
    # epel-release is needed to install python-pip
    yum -y install epel-release && \
    # sshpass allows to use user/password ssh connection method
    yum -y install python-pip openssh-clients sshpass
RUN mkdir /etc/ansible && echo -e '[local]\nlocalhost' > /etc/ansible/hosts
RUN pip install ansible==2.9.4
# Required to use user/password ssh connection method
ENV ANSIBLE_HOST_KEY_CHECKING false
