FROM centos:7
MAINTAINER Charles Chen
LABEL Description="vsftpd Docker image based on Centos 7. Supports passive mode." \
	License="Apache License 2.0" \
	Usage="docker run -d -p [HOST PORT NUMBER]:21 -v [HOST FTP HOME]:/home/ftpuser charlestg/centos_vsftp" \
	Version="1.0"

RUN yum -y update && \
    yum install -y epel-release && \
    yum clean all
RUN yum -y install httpd && yum clean all
RUN yum install -y \
	vsftpd \
    supervisor &&\
    mkdir -p /var/run/vsftpd/empty && \
    mkdir -p /var/log/supervisor
    

ENV FTP_USER=ftpuser
ENV FTP_PASS=ftpuser
ENV FTP_ADDRESS=change_me
ENV FTP_MIN_PORT=21100
ENV FTP_MAX_PORT=21110
ENV FTP_BANNER="Welcome to VSFTPD service."

EXPOSE 20 21 
EXPOSE 21100 21101 21102 21103 21104 21105 21106 21107 21108 21109 21110

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD start.sh /usr/local/bin/start.sh

ENTRYPOINT ["/usr/local/bin/start.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]