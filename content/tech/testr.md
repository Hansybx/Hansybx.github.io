---
title: Nginx 配置HTTPS
date: 2019-10-30 15:01:36
# categories: tech
---

#前提
在购买完SSL证书并补全信息后，选择下载证书for Nginx。
#配置
1.使用`nginx -t`命令来获取 nginx.conf文件的路径
2.将之前下载证书的zip文件解压，解压得到的xxx.pem 和xxx.key文件放到新建的目录cert下
3.打开nginx.conf文件在最后一个`}`前添加一下语句
```
server {
    listen 443;
    server_name localhost;
    ssl on;
    root html;
    index index.html index.htm;
    ssl_certificate   cert/xxx.pem;
    ssl_certificate_key  cert/xxx.key;
    ssl_session_timeout 5m;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_prefer_server_ciphers on;
    location / {
        root html;
        index index.html index.htm;
    }
}
```

4.添加安全组规则
服务器一般情况下默认是不开放443端口的
应添加安全组规则，协议类型选择HTTPS(443)即可

5.应用配置更改
使用`nginx -s reload`命令重启nginx服务即可

6.日志查看
`vi /var/log/nginx/error.log`

#我的异常解决
如果你没有找到上面内段的对应代码，可以重新下载，将里面的nginx.conf文件修改后替换之前的nginx.conf即可，方法如下:
```
# 下载安装包到 src 目录
$ cd /usr/local/src
$ wget http://nginx.org/download/nginx-1.14.1.tar.gz
#解压安装包。
$ tar -zxvf nginx-1.14.1.tar.gz
```
