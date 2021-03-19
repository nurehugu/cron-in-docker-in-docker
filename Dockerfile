FROM ubuntu:14.04

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables \
    cron \
    nano

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# Prepare crontab
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh

# Define additional metadata for our image.
VOLUME /var/lib/docker
# CMD ["wrapdocker"]
CMD wrapdocker && cron && tail -f /var/log/cron.log
