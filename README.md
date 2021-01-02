# openhub

[OpenHAB](https://openhab.org/) - A vendor and technology agnostic open source automation software for your home

## Getting Started

These instructions will cover usage information and for the docker container 

### Prerequisities

In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

### Usage

#### Container Parameters

The image could be started by the following command.  

```shell
$ docker run -d briezh/openhab
```

The working directory should be a volume at the host system.  

```shell
$ docker run -v <HOST>:/opt/openhab -d briezh/openhab:latest
```

The container port could be mapped to an other port of the host system. 

```shell
$ docker run -p <PORT>:8080 -d briezh/openhab:latest
```

Use all settings an to set a container-name use:

```shell
$ docker run --name openHAB \
 -p <PORT>:8080 \
 -v <HOST>:/opt/openhab \
 -d briezh/openhab:latest
```

#### Ports

* `8080tcp` - OpenHAB server port.

#### Volumes

* `/opt/openHAB` - OpenHAB working directory.

### Using Podman instead of Docker

If using `podman` Version >=1.9 instead of `docker` it should be possible to use the `auto-update` feature with `systemd`.

First create the container (pod) than run `generate` command. The systemd service files will be created within the same folder.
These .service file(s) should be moved to a systemd folder. 
If the system uses SELinux the new files must be updated with the correct labels. 
Then the systemd daemon must reload the service files.

```shell
$ podman create --name <container_name> \
 -p [host]:8080 \
 -v [host]:/opt/picapport:Z \
 -l "io.containers.autoupdate=image" \
 -t briezh/openhab:latest

$ podman generate systemd --new --name <container_name> --files
$ mv *.service /usr/lib/systemd/
$ restorecon -Rv /usr/lib/systemd/
$ systemctl daemon-reload

$ systemctl start <service> --now
```

## Find Us

* [GitHub](https://github.com/BKhenloo/holdingnuts_server)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the 
[tags on this repository](https://github.com/BKhenloo/holdingnuts_server/tags). 

## Authors

* **Briezh Khenloo** - *Initial work* - [B.Khenloo](https://github.com/BKhenloo)

See also the list of [contributors](https://github.com/BKhenloo/holdingnuts_server/contributors) who 
participated in this project.
