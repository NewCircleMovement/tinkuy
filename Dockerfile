#
# Develeopment image for tinkuy.dk
#
FROM ruby:2.2
RUN apt-get update -qq && \
    apt-get install -y \
      build-essential \
      graphicsmagick \
      less \
      nano \
      nodejs \
      openssh-server \
      postgresql-9.4 \
      postgresql-contrib-9.4 \
      postgresql-server-dev-9.4 \
      vim

RUN gem install pg

WORKDIR /root/tinkuy
ADD . /root/tinkuy
RUN bundle install

RUN mkdir -p /root/bin
COPY entrypoint.sh /root/bin
ENTRYPOINT ["/root/bin/entrypoint.sh"]

RUN sed -i -e 's|^PermitEmptyPasswords no|PermitEmptyPasswords yes|' \
           -e 's|^PermitRootLogin without-password|PermitRootLogin yes|' \
              /etc/ssh/sshd_config

RUN sed -i -e 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

RUN echo 'root:1234' | chpasswd

EXPOSE 22 3000 5432
