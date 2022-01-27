---
title: "基于qduoj的二次开发"
date: 2020-05-19 10:20:04
# categories: tech
---



## 部署
### 操作步骤

这个部分没什么特别要强调的，就是按照 [QDUOJ部署](https://github.com/QingdaoU/OnlineJudgeDeploy)上的方法跟着复制粘贴就好了，根本不用动脑子。

### 可能遇见的问题

#### 部署前

由于在2020年一月后官方正式宣布放弃了对py2的维护，所以现在使用pip时会遇到一些小问题，以下是解决方法。

#### python3与pip3安装

```
sudo add-apt-repository ppa:fkrull/deadsnakes
sudo apt-get update
sudo apt-get install python3.7
sudo apt-get install python3-pip #装pip3
```
若提示`add-apt-repository: command not found`则运行`sudo apt-get install python-software-properties`即可。

##### python3版本切换

输入`alias python='/usr/bin/python3.7'`即可切换python对应版本

##### 其它可能出现的问题

1.ModuleNotFoundError: No module named 'pip._internal'

```
wget https://bootstrap.pypa.io/get-pip.py https://bootstrap.pypa.io/get-pip.py --no-check-certificate
sudo python3.7 get-pip.py http://get-pip.py/
```

2.若有以下报错
```
Building wheels for collected packages: cffi
  Building wheel for cffi (setup.py) ... error
  ERROR: Command errored out with exit status 1:
   command: /home/starx/pythonvirtualenv/starxteam/bin/python3 -u -c 'import sys, setuptools, tokenize; sys.argv[0] = '"'"'/tmp/pip-install-0xuyhqlj/cffi/setup.py'"'"'; __file__='"'"'/tmp/pip-install-0xuyhqlj/cffi/setup.py'"'"';f=getattr(tokenize, '"'"'open'"'"', open)(__file__);code=f.read().replace('"'"'\r\n'"'"', '"'"'\n'"'"');f.close();exec(compile(code, __file__, '"'"'exec'"'"'))' bdist_wheel -d /tmp/pip-wheel-4glw5w36 --python-tag cp37
       cwd: /tmp/pip-install-0xuyhqlj/cffi/
  Complete output (36 lines):
  running bdist_wheel
  running build
  running build_py
  creating build
  creating build/lib.linux-x86_64-3.7
  creating build/lib.linux-x86_64-3.7/cffi
  copying cffi/__init__.py -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/cparser.py -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/error.py -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/vengine_cpy.py -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/commontypes.py -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/vengine_gen.py -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/pkgconfig.py -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/lock.py -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/cffi_opcode.py -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/model.py -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/recompiler.py -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/verifier.py -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/api.py -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/setuptools_ext.py -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/ffiplatform.py -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/backend_ctypes.py -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/_cffi_include.h -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/parse_c_type.h -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/_embedding.h -> build/lib.linux-x86_64-3.7/cffi
  copying cffi/_cffi_errors.h -> build/lib.linux-x86_64-3.7/cffi
  running build_ext
  building '_cffi_backend' extension
  creating build/temp.linux-x86_64-3.7
  creating build/temp.linux-x86_64-3.7/c
  x86_64-linux-gnu-gcc -pthread -DNDEBUG -g -fwrapv -O2 -Wall -g -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -fPIC -DUSE__THREAD -DHAVE_SYNC_SYNCHRONIZE -I/usr/include/ffi -I/usr/include/libffi -I/usr/include/python3.7m -I/home/starx/pythonvirtualenv/starxteam/include/python3.7m -c c/_cffi_backend.c -o build/temp.linux-x86_64-3.7/c/_cffi_backend.o
  c/_cffi_backend.c:15:10: fatal error: ffi.h: No such file or directory
   #include <ffi.h>
            ^~~~~~~
  compilation terminated.
  error: command 'x86_64-linux-gnu-gcc' failed with exit status 1
  ----------------------------------------
  ERROR: Failed building wheel for cffi
  Running setup.py clean for cffi
Failed to build cffi
```

尝试安装拓展包`sudo apt install build-essential libffi-dev python-dev`



#### 部署后

问题 ：部署成功 使用docker ps -a 查看容器状态均为healthy，但是直接访问ip无法查看，显示状态码503。
解决：可能是因为对应端口没有开放导致的，在云服务器安全组设置中增加对应端口（80或者443）

## 前端

### 本地运行方法

1.安装node.js 
这里需要注意一下，因为QDUOJ使用的版本是nodejs version 8.12.0，版本过高可能会产生一些不必要的错误。
2.运行

```
npm install
# we use webpack DllReference to decrease the build time,
# this command only needs execute once unless you upgrade the package in build/webpack.dll.conf.js
NODE_ENV=development npm run build:dll

# the dev-server will set proxy table to your backend
export TARGET=http://Your-backend

# serve with hot reload at localhost:8080
npm run dev
```
上面是官方文档的方法，但是推荐使用cnpm来代替npm，cnpm是国内淘宝的镜像，速度相对来说会快一点。
[这里是官方的演示视频](https://www.bilibili.com/video/av37051523/)

## 后端

### 安装所需 Python 模块

```
cd OnlineJudge
sudo pip install --no-cache-dir -r ./deploy/requirements.txt
```
如果pip install过慢可使用一下命令，将pip源换至阿里云
```
sudo pip install --no-cache-dir -r ./deploy/requirements.txt -i https://mirrors.aliyun.com/pypi/simple/
```
### 初始化数据库和后端
修改./init_db.sh文件的第17和18行修改为
```
python3.7 manage.py migrate
python3.7 manage.py inituser --username root --password rootroot --action create_super_admin
```
然后执行一下命令
```
sudo chmod +x init_db.sh
./init_db.sh --migrate
```
一样无报错即可

## docker 镜像制作

### 使用正常方法推送到docker仓库

去阿里云那里申请一个仓库，免费的，把仓库名称写成oj-backend即可。创建成功他会给你一个页面提示你如何上传，很详细。

```
sudo docker login --username=你的用户名 registry.cn-beijing.aliyuncs.com
```

你刚才创建的镜像ID，可以使用docker images查一下，顺便能查到镜像版本号TAG

```
sudo docker tag [ImageId] registry.这里用阿里云给你提供的即可/oj-backend:[镜像版本号]
sudo docker push registry.这里用阿里云给你提供的即可/oj-backend:[镜像版本号]
```
TAG就是上边需要写的版本号，还有IMAGE ID就是镜像ID。
然后就会开始push完毕就成功上传了。

### 使用Travis CI 推送到docker仓库

Travis CI 是在软件开发领域中的一个在线的，分布式的持续集成服务，用来构建及测试在GitHub托管的代码。
[阮一峰的Travis CI使用教程](http://www.ruanyifeng.com/blog/2017/12/travis_ci_tutorial.html)

#### 使用

1.使用Github账号在Travis CI登录
2.在more options中的setting设置自己的docker账号与密码
然后添加两个环境变量，这个用户名和密码和你的DockerHub账户是对应的：
`DOCKER_USERNAME和DOCKER_PASSWORD`
![](https://pic.downk.cc/item/5ec34d41c2a9a83be5751dc8.jpg)
接着在Travis CI的script里写入

```
script:
  - echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
  - docker build -t 用户名/包名:latest .
  - docker push 用户名/包名:latest
```
通过使用`docker ps -a`来查看已经运行的镜像状态，`docker images`来查看本地已经存在的镜像。

#### 推荐阅读

[使用GitHub+Travis-CI+Docker打造自动化流水线](https://www.cnblogs.com/rope/archive/2020/02/23/12350607.html)
[Docker的使用--制作自己的镜像](https://blog.csdn.net/u010663021/article/details/70641879?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-11.nonecase&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-11.nonecase)

### 注意事项

在使用docker制作镜像时，如果修改了数据库字段，记得运行`python manage.py makemigrations`和`python manage.py migrate`，否则在运行`docker-compose up -d`之后会发现容器一直自启动。