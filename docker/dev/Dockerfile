FROM ubuntu:20.04

ENV LC_ALL C.UTF-8

ADD ./init_ubuntu.sh /root
RUN bash /root/init_ubuntu.sh && rm -rf /root/init_ubuntu.sh

ADD ./cmake-*.tar.gz /opt
RUN ln -s /opt/cmake*/bin/cmake /usr/local/bin && \
ln -s /opt/cmake*/bin/ccmake /usr/local/bin

CMD ["/usr/sbin/sshd", "-D", "-p 9999"]
