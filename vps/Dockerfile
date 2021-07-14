FROM ubuntu:latest
LABEL org.opencontainers.image.authors="driversti@gmail.com"

ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY init_user.sh /temp/i.sh
#RUN chmod +x /etc/init_user.sh
#RUN ln -s /temp/init_user.sh /etc/profile.d/init_user.sh
COPY setup_phase_1.sh /temp/s1.sh
COPY setup_phase_2.sh /temp/s2.sh
#CMD ["/bin/sh", "/temp/init_user.sh"]
