### 0 下载镜像

如果嫌麻烦，可以直接从远程仓库下载已经打包好的镜像：
```bash
$ docker pull crazyjums/nginx-php-fpm-alpine
```
可以根据`Dockerfile`定制化镜像，然后自己手动打包:
```bash
$ cd dnmp_in_one
$ docker build -t <image_name> .
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

