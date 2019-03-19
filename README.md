# 本docker的作用
试用于内网对外开放了服务，但IP经常变动，需要定期去修改dns解析的场景。
# 参数说明
1、ali_api/aliyun.ini下输入自己的阿里云dns解析账户。
2、需要自己获取dns解析的RecordId，一个解析一个。
3、每5分钟自动去判断一次，如需修改评率自行修改dockerfile值：
```
RUN echo "*/5 * * * * bash /root/changeIP.sh" 
```
# 操作步骤
```
git clone https://github.com/windanchaos/auto_dns_docker.git
cd auto_dns_docker
docker build .
#获取到构建的image镜像ID（也可以tag下），这里用“2e07195c4b8a”表示
docker image ls -a 
docker run -it --privileged=true  2e07195c4b8a "/usr/sbin/crond start"
```