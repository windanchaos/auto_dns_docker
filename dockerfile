FROM centos:latest
MAINTAINER bojiang

EXPOSE 22
USer root
RUN yum install -y curl wget yum-cron cronie crontabs 
RUN sed -i '/session required pam_loginuid.so/c\#session required pam_loginuid.so' /etc/pam.d/crond
RUN echo "*/5 * * * * bash /root/changeIP.sh" >> /var/spool/cron/root
COPY getIP.py changeIP.sh ali_api newip.txt oldip.txt /root/
ENTRYPOINT ["/usr/sbin/init"]