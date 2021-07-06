FROM centos:8
MAINTAINER Christian Eichelmann "christian@crapworks.de"

ENV CEPH_VERSION nautilus

# Install Ceph
RUN rpm --import 'https://download.ceph.com/keys/release.asc'
RUN rpm -Uvh http://download.ceph.com/rpm-${CEPH_VERSION}/el8/noarch/ceph-release-1-1.el8.noarch.rpm
RUN yum install -y epel-release && yum clean all
RUN yum install -y ceph python2 python2-pip && yum clean all

COPY . /cephdash
WORKDIR /cephdash
RUN pip2 install -r requirements.txt

ENTRYPOINT ["/cephdash/contrib/docker/entrypoint.sh"]
CMD ["ceph-dash.py"]
