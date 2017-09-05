# Docker Images

So this is my repository to host docker images that I use on the server. You can use or refer to them since they are designed for general purpose with ability for customization. Most of time I just use them directly without modification.

You can find all the resources in different branches. I do like this for the simplicity when cloning.

As is said, all images are made for my personal usage, but you are welcomed to use and I'll provide any kind of support as I can. Any kind of chats are welcomed as well.

Have fun!

## Specification

Most of the images are not very typical docker images. Long story short, most of time I will provide proxy settings (http only) and more customization settings. And most of time you can deploy it without modification, great!

Currently I will use Alpine as distribution whenever it's possible. It is super light weighted and the size is about 5 MB, unlike ubuntu images that are about 200 MB. So I think it's super cool to use on docker. In addition, the packages are quite new.

Please be informed, images will lose maintenance if I personally don't use them any more.

## Image list

Branch                     | Dist.  | Main Packages      | Usage
---------------------------|--------|--------------------|-----------------------
[alpine-vsftpd][1]         | Alpine | vsftpd             | Host FTP site
[alpine-nginx-gunicorn][2] | Alpine | py2+nginx+gunicorn | Host your python sites
[centos-nginx-gunicorn][3] | CentOS | py2+nginx+gunicorn | Host your python sites

## License

If not stated specially, ALL THE BRANCHES are licensed under Appache 2.0.

[1]: https://github.com/Towdium/DockerImages/tree/alpine-vsftpd
[2]: https://github.com/Towdium/DockerImages/tree/alpine-nginx-gunicorn
[3]: https://github.com/Towdium/DockerImages/tree/centos-nginx-gunicorn
