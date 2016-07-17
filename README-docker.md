# Docker image for dev on Tinkuy.dk

Run

    ./build.sh

To create a docker image, and

    ./run.sh

to start it.  Rails will start an instance of the tinkuy site on

    http://localhost:3000

Pressing CTRL-c will stop rails and enter into bash.

The image can be also accessed through ssh:

    ssh root@172.17.0.2

with password 1234

The IP address may differ and can be found out by first finding the container
id with `docker ps` and then `docker inspect <container id>` to list the container
info.
