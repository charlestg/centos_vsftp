## Description

Single User FTP Server on CentOS 7

## Docker Run

```
docker run -d \
    -p 21:21 \
    -p 20:20 \
    -p 21100-21110:21100-21110 \
    -e FTP_USER='ftpuser' \
    -e FTP_PASS='ftpuser' \
    -e FTP_ADDRESS='10.10.10.10' \
    -e FTP_MIN_PORT=21100 \
    -e FTP_MAX_PORT=21110 \
    -v /home/ftpuser:/home/ftpuser
    charlestg/centos_vsftp
```

## Docker-Compose

```
version: '2'
services:
  ftp:
    build: charlestg/centos_vsftp
    container_name: vsftp
    environment:
      - FTP_USER=ftpuser
      - FTP_PASS=ftpuser
      - FTP_ADDRESS=10.10.10.10
      - FTP_MIN_PORT=21100
      - FTP_MAX_PORT=21110
      - FTP_BANNER="Welcome to UDC FTP service."
    volumes:
      - /home/ftpuser:/home/udcuser/
    ports:
      - "21:21"
      - "20:20"
      - "21100-21110:21100-21110"
    privileged: true
    restart: always
```

