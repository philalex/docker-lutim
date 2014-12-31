FROM ubuntu:14.04
MAINTAINER Philippe ALEXANDRE <alexandre.philippe+github@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
ENV ENV INITRD No
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git perl supervisor cpanminus build-essential perlmagick nginx
RUN cpanm Carton

# nginx
ADD nginx_lutim.conf /etc/nginx/sites-available/lutim.conf
RUN ln -s /etc/nginx/sites-available/lutim.conf /etc/nginx/sites-enabled/lutim.conf
RUN rm /etc/nginx/sites-enabled/default
# tell Nginx to stay foregrounded
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

WORKDIR /srv
RUN git clone https://git.framasoft.org/luc/lutim.git
WORKDIR /srv/lutim
RUN carton install
ADD lutim.conf /srv/lutim/lutim.conf
RUN chown -R www-data.www-data /srv/lutim

# supervivor
ADD supervisor_lutim.conf /etc/supervisor/conf.d/lutim.conf

EXPOSE 80
CMD ["/usr/bin/supervisord", "-n"]