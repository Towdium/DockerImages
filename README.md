# centos-nginx-gunicorn

This image is made for my personal use, but you are welcomed to try and I will provide support is I can. Any suggestions are welcomed as well.

Long story short, this image can host your website, especially websites made using python frameworks like Django and Flask. An example website has been given in the app folder, which is a minimal Flask site.

The image uses nginx as gateway, gunicorn as WSGI bridge. It is based on CentOS 7.

## Instructions

### Build with proxy

This image allows you to use http proxy when building. This is especially useful when building in the GFW. To do this, just pass the proxy as an argument. By the way, you are suggested to use NAT ip (192.168.x.x), which can be acquired by `ifconfig` or `ip a`, rather than localhost ip (127.0.0.1), because it seems localhost does not work within the container. So for a build with proxy, you can do as follows:

```
docker build --build-arg HTTP_PROXY=x.x.x.x:x -t centos-nginx-gunicorn .
```

### Basic run

You need to explore the ports of the container, like most of docker images that handles network. It is a good practise to give it a name using `--name`. Here is an example:

```
sudo docker run -p 80:80 --name example-name centos-nginx-gunicorn:latest
```

But you might find it difficult to stop. Oops! So there are two methods you can do to make everyone happy. The first is open as interactive program:

```
sudo docker run -it -p 80:80 --name example-name centos-nginx-gunicorn:latest
```

Then you can interact with it (especially when you are running bash). So you can use `ctrl+C` to terminate it.

Another method is run it as daemon:

```
sudo docker run -d -p 80:80 --name example-name centos-nginx-gunicorn:latest
```

This makes the container totally running at background, so you can do no interaction. Then you can stop it by:

```
docker stop example-name
```

This might take a while, because supervisor cannot terminate immediately. But don't panic, it will be soon.

### Runtime python packages

When building the image, it will finish most of the work, but all the python packages will be installed when running. This makes it possible to mount your directories at runtime, the container will still be able to install the packages in the `requirements.txt` file, although it's not highly suggested. To do this, you need to mount your directory `/deploy/app`. Here is an example:

```
sudo docker run -p 80:80 -v /your/folder/on/disc:/deploy/app --name test centos-nginx-gunicorn:latest
```

By the way, of course you can modify the image easily to do the same thing without mounting local directory.

### Run with proxy

It might be useful to use a proxy if you want to get better speed with pip. You can do the same as when building the image:

```
docker run -e HTTP_PROXY=x.x.x.x:x -p 80:80 centos-nginx-gunicorn:latest
```
