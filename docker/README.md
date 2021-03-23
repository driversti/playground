# DOCKER - tips and tricks

- stop all containers
```shell
docker stop $(docker ps -aq)
```

- remove all containers
```shell
docker rm $(docker ps -aq)
```

- remove all images
```shell
docker rmi $(docker images -q)
```
