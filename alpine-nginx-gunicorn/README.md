# alpine-nginx-gunicorn

This image is made for my personal use, but you are welcomed to try and I will provide support as I can. Any suggestions are welcomed as well.

Long story short, this image can host your website, especially websites made using python frameworks like Django and Flask. An example website has been given in the app folder, which is a minimal Flask site.

The image uses nginx as gateway, gunicorn as WSGI bridge. It is based on Alpine.

## Instructions

### Build with proxy

This image allows you to use http proxy when building. This is especially useful when building in the GFW. To do this, just pass the proxy as an argument. By the way, you are suggested to use NAT ip (192.168.x.x), which can be acquired by `ifconfig` or `ip a`, rather than localhost ip (127.0.0.1), because it seems localhost does not work within the container. So for a build with proxy, you can do as follows:

```
docker build --build-arg HTTP_PROXY=http://x.x.x.x:x -t centos-nginx-gunicorn .
```

Don't forget to use `http://` before the address, otherwise apk could fail to use the proxy.

### Basic run

You need to explore the ports of the container, like most of docker images that handles network. There are two suggested methods to run a container: as daemon or as a program.

The command below shows the way to run as an interactive program. In this case you can interact with it (especially when you are running `sh`). Or you can use `ctrl+C` to terminate it.

```
sudo docker run -it -p 80:80 --name example-name \
alpine-nginx-gunicorn:latest
```

Another method is run it as daemon, which is a better choice to run on a server. This makes the container totally running at background, so you can not do interaction.

```
sudo docker run -d -p 80:80 --name example-name\
--restart unless-stopped alpine-nginx-gunicorn:latest
```

In this case, you can stop it by:

```
docker stop example-name
```

Additionally, you can interact with it in another way:

```
docker exec example-name -it sh
```

### Runtime python packages

When building the image, it will finish most of the work, but all the python packages will be installed when running. This makes it possible to mount your directories at runtime, the container will still be able to install the packages in the `requirements.txt` file, although it's not highly suggested. To do this, you need to mount your directory `/deploy/app`. Here is an example:

```
docker run -p 80:80 -v /your/folder/on/disc:/deploy/app \
--name test alpine-nginx-gunicorn:latest
```

By the way, of course you can modify the image easily to do the same thing without mounting local directory, and that is more suggested since it makes the container isolate from your filesystem.

### Run with proxy

It might be useful to use a proxy if you want to get better speed with pip. You can do the same as when building the image:

```
docker run -e HTTP_PROXY=http://x.x.x.x:x -p 80:80 centos-nginx-gunicorn:latest
```
