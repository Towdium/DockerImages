# alpine-frps

## Build

```
docker build -t alpine-frps .
```

## Run

Run in iteractive mode:

```
sudo docker run -it -p 80:80 -p 7000:7000 --name example-name \
-v /your/config/frps.ini:/etc/frp/frps.ini \
alpine-frps:latest
```

Run as daemon:

```
sudo docker run -d -p 80:80 -p 7000:7000 --name example-name\
-v /your/config/frps.ini:/etc/frp/frps.ini \
--restart unless-stopped alpine-frps:latest
```

In this case, you can stop it by:

```
docker stop example-name
```

Additionally, you can interact with it in another way:

```
docker exec -it example-name -it sh
```
