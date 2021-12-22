## 安装docker

取决于操作系统
## 添加用户到docker用户组
sudo usermod -aG docker $USER
## build docker镜像
docker build -t ubuntu_dev -f /path/Dockerfile .
.是工作目录不是Dockerfile目录

## 启动容器
docker run --name gyz_devs -d --cap-add SYS_PTRACE --network host --restart always -v /data/gyz:/root -w /root ubuntu_dev "/usr/sbin/sshd" "-D" "-p 9999"
"/usr/sbin/sshd" "-D" "-p 9991"可以省略

## 设置密码

docker exec -it gyz_dev bash
passwd

## ssh登录
ssh root@ip -p 9991
## scp复制需要的文件
scp -P 9996 -r root@10.100.10.19:/root/FilterKnn_release . 

## 其他
docker commit test-centos1 centos_sshd:7.0将容器提交为镜像
save镜像->load镜像