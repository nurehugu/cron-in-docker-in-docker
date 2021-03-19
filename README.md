# BUILD
docker build -t dind-cron .

# RUN without deamon
docker run -v /var/run/docker.sock:/var/run/docker.sock --privileged --rm -t -i --name=dind-cron dind-cron

# RUN with deamon
docker run -v /var/run/docker.sock:/var/run/docker.sock --privileged --rm -it -e DOCKER_DAEMON_ARGS="-D" --name=dind-cron dind-cron
