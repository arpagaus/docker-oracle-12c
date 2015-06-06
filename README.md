# Oracle 12c Docker Image
A Docker image for [Oracle Database 12c Enterprise Edition Release 12.1.0.2.0](http://www.oracle.com/technetwork/database/enterprise-edition/overview/index.html) based on an Oracle Linux 7.1 image.

## Run
Create a new container running an Oracle 12c database:
```
$ docker run -dP arpagaus/oracle-12c
```

## Image
Due to legal restrictions I cannot publish this image on the Docker Hub but you may build it yourself. 

### Prerequisites
Due to Docker limitations this image cannot be built using the stock binary provided on docker.com. By default the amount of available memory on /dev/shm is limited to 64MB (see docker/docker#2606). This is not sufficient to meet Oracle's MEMORY_TARGET minimum requirements.
If you are not comfortable building & using a modified docker version let me assure you that the steps are well documented on https://docs.docker.com/project/set-up-dev-env/ and work smoothly because the build is actually executed within a docker container.
If you're still not convinced the you can still use the original https://github.com/wscherphof/oracle-12c instead.

You'll find my modified Docker v1.5.0 source which increases /dev/shm to 2GB here https://github.com/arpagaus/docker

### Build
First download `linuxamd64_12102_database_1of2.zip` & `linuxamd64_12102_database_2of2.zip` from [Oracle Tech Net](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/database12c-linux-download-2240591.html) and put them in the root folder. Afterwards simply run:

```
$ docker build -t arpagaus/oracle-12c .
```

## Acknowledgement
This image is largely based on the work of [Wouter Scherphof](https://github.com/wscherphof)

## Known issues
### Updating Oracle Linux
Whiles installing packages on the Oracle Linux container using yum an error might occur. As I workaround I've published an updated version of the Oracle Linux 7.1 image arpagaus/oraclelinux.

## License
[GNU Lesser General Public License (LGPL)](http://www.gnu.org/licenses/lgpl-3.0.txt) for the contents of this GitHub repo; for Oracle's database software, see their [Licensing Information](http://docs.oracle.com/database/121/DBLIC/toc.htm)

