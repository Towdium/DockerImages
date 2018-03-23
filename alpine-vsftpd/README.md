# alpine-vsftpd

This image provides an FTP server, which is build by vsftpd on Alpine. The size of the image should be less than 10 MB. Good job Alpine!

## Specification

The server uses self-signed certificate to enable TLS transmission. I know you might think it's not safe enough, but it's sufficient for my personal use. All I need it the transmission is encrypted, much better than unencrypted right?

The FTP server is configured to operate in passive mode since it's very tricky to make it run in active mode. So you need to expose port 20-21, for traditional FTP port, and 9000-9099, as extra data port.

## Usage

### Basic build

For a basic build, you can do:

```
docker build -t alpine-vsftpd .
```

But as always, I'll give more arguments for you to use, which will be given in following sections. I understand it's not the best choice since it's suggested to extend your image on existing images because docker images are expected to have exactly identical behavior everywhere, while building arguments can break the identity. But for me, I hate to have so many images everywhere. I want to host one copy on VCS, and build immediately whenever I want.

### Build with proxy

Similar to all my images, you can build with proxy. This can make easier for Alpine to install packages, especially in mainland china. To do this, add extra parameter when building:

```
--build-arg HTTP_PROXY=http://x.x.x.x:x
```

As always, I suggest to add `http://` to avoid some strange behavior. And you should use internal IP (usually start by 192.168) rather than localhost (127.0.0.1) to ensure the connection.

### Certificate info

You might want to add more info to the certificate, because... You know the certificate need some personal information for confirmation. You can use following argument when building.

```
--build-arg CSR_INFO=/C=CN/CN=example.com
```

There are several fields you can choose from:

Field | Meaning       | Example
------|---------------|-------------
/C    | Country(code) | JP
/ST   | State         | Tokyo
/L    | Location      | Unnamed St.
/O    | Organization  | Unnamed Org.
/OU   | Org. Unit     | Some Dept.
/CN   | Commom Name   | example.com

### Run container

You can do the following to run as a program.

```
docker run -it -p 20-21:20-21 -p 9000-9099:9000-9099 alpine-vsftpd
```

Or do following to run as service.

```
docker run -d -p 20-21:20-21 -p 9000-9099:9000-9099 \
--restart unless-stopped alpine-vsftpd
```

Then visit `ftp://localhost`, you will find an example site there. It contains directory `Upload`, which users can upload to freely but cannot download from, directory `Download`， which users are supposed to download from, and an example readme. You can use FileZilla to make it easier and get more information.

### Customize

You can mount your files to the site. To do this, use this argument when running:

```
-v /your/folder:/srv/ftp
```

To let user to upload, you need to give write permission of certain folder to others by following:

```
chmod o+w /your/folder/upload
```

But keep in mind, the root folder of FTP server must be unwritable.

By default, the uploaded files have no permission, so users are not able to download it back.
