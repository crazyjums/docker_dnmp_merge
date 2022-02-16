### 0 下载镜像

如果嫌麻烦，可以直接从远程仓库下载已经打包好的[镜像](https://hub.docker.com/repository/docker/crazyjums/nginx-php-fpm-alpine)：
```bash
$ docker pull crazyjums/nginx-php-fpm-alpine
```
可以根据`Dockerfile`定制化镜像，然后自己手动打包:
```bash
$ cd dnmp_in_one
$ docker build -t <image_name> .
//或者直接使用docker-compose来启动
$ docker-compose up -d nginx-php-fpm
```
等待几分钟，镜像就打包好了，然后在通过`docker-compose`来管理镜像即可。

### 1 开启服务

```bash
$ docker-compose up <service_name>
$ docker-compose up <service_name> -d  //以守护进程的方式运行
```

举例：

这里以`redis`为例：

```bash
$ docker-compose up redis
$ docker-compose up reids -d  //以守护进程的方式运行
```

开启`nginx-php-fpm`服务：

```bash
docker run -it -d -p 885:80 --name=nginx-php-fpm222 -v /f/docker/dnmp/dnmp2/nginx/html/vue_nginx:/usr/local/nginx/html/vue_nginx -v /f/docker/dnmp/dnmp2/nginx/include:/usr/local/nginx/conf/include -v /f/docker/dnmp/dnmp2/nginx/html/php_nginx:/usr/local/nginx/html/php_nginx -v /f/docker/dnmp/dnmp2/nginx/logs:/data/nginx/logs -v /f/docker/dnmp/dnmp2/nginx/nginx.conf:/usr/local/nginx/conf/nginx.conf  nginx-php-fpm-alpine-3 /bin/sh /start.sh
```

### 2 关闭或重启服务

```bash
$ docker ps  //查看服务的container id
$ docker restart <service_container_id>  //重启服务
$ docker stop <service_container_id>  //停止服务
$ docker start <service_container_id>  //开启服务
```

举例：

以`redis`为例：

```bash
$ docker ps  //查看redis服务的container id
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                    NAMES
54f64de09cd9   redis     "docker-entrypoint.s…"   38 seconds ago   Up 35 seconds   0.0.0.0:6380->6379/tcp   dnmp-redis-1

$docker stop 5  //停止redis服务   container id可以简写，只要能区分就行
$docker start 5 //开启redis服务
```

