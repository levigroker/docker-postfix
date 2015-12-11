# Postfix mail daemon
#
# December 10, 2015
# Levi Brown <mailto:levigroker@gmail.com>
#
# Creates a Postfix server to handle sending of email.
#
## To build the image:
#
# # docker build -t levigroker/postfix .
#
## To deploy to hub.docker.com:
#
# # docker login
# # docker push levigroker/postfix
#
## To run the image locally:
#
# # docker run -p 25:25 -e maildomain=mail.example.com -e smtp_user=user:pwd --name postfix -d levigroker/postfix
#
# This will map the server port of 25 to the docker port of 25 and run the application in
# "detached" mode. Use `docker ps` to list the processes and
# `docker stop <CONTAINER ID>; docker rm <CONTAINER ID>` to stop the application. When run
# in "detached" mode, one can view the stdout of the container via
# `docker logs -f <CONTAINER ID>`
#
## .dockerignore
#
# There is likely a `.dockerignore` file as a peer to this `Dockerfile`. This file should
# be used to omit items from the "docker context" which will, by default, copy everything
# at the `Dockerfile` level, and down, into the available namespace when building the
# image. Be sure to make entries in the `.dockerignore` to omit files which need not be
# included, and a general good practice is not to place extraneous files and folders in
# this context directory.
#
## Reference
#
# https://docs.docker.com/articles/dockerfile_best-practices/
# https://docs.docker.com/reference/builder/
#
##

# We are building on the `ubuntu` docker image
FROM ubuntu:trusty
MAINTAINER Levi Brown

# Install
RUN DEBIAN_FRONTEND=noninteractive && \
	apt-get update -y && \
    apt-get install -y supervisor postfix sasl2-bin opendkim opendkim-tools && \
    apt-get clean

# Copy files
COPY ["cmd.sh", "cmd.sh"]
COPY ["conf/install.sh", "/opt/install.sh"]
COPY ["conf/postfix.sh", "/opt/postfix.sh"]
COPY ["conf/supervisord.conf", "/etc/supervisor/conf.d/supervisord.conf"]

# The command used to start the instance
CMD ["./cmd.sh", "--start"]
