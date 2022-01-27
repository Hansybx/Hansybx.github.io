---
title: 关于我运气差被迫想办法重新配置博客这档事
date: 2020-08-07 01:31:39
# categories: tech
---

### 前言

​	近期因为，运气原因电脑送去维修了，当时没怎么细想，现在看来那完全就是如今悲苦生活的伏笔。

​	因为电脑坏了，而且C盘实在是太满了，所以顺便让他重装了系统，本来以为就是把环境变量重新配置一下的问题，后来发现我还是太年轻了。因为我的博客在本地又双叒叕不能正常预览了，我这才发现原先下载好的hexo是放在C盘的。😭😭😭

​	好在这次的程度还可以接受，不像上回直接重新配置，只需要改一点就可以了，但是我下定了决心，一定要好好备份，毕竟电脑一年修了两次，我不想接着暴雷了。



### 选择

​	关于这个我选择了使用Travis ci + GitHub 分支的方法来解决问题。

​	GitHub分支用来存储已经修改好的配置，Travis CI来自动构建，毕竟每git push一次之后再手动使用hexo命令部署实在是太蠢了。



### 过程

#### 新建GitHub仓库分支

#### 在travis进入仓库同步管理

在Repositories里选择对应的仓库，设置大部分直接默认即可。

![样例图片](https://pic.downk.cc/item/5f2c431b14195aa5949b73ec.jpg)

#### 环境变量的配置

在GitHub的setting下的如图界面，添加相应权限，生成access token ，生成后记得马上复制，这个token只会显示这一次。

![GitHub token生成](https://pic.downk.cc/item/5f2c528e14195aa5949f0abc.jpg)



之后在Travis CI的对应仓库的环境变量中将这个token添加进去，不要点开`DISPLAY VALUE IN BUILD LOG`，这会暴露你的token，十分危险。

![环境变量配置](https://pic.downk.cc/item/5f2c521114195aa5949ed5e2.jpg)

#### 修改_config.yml文件的deploy节点：

```
# 修改前后
deploy:
  - type: git
    repo: git@github.com:xxx/xxx.github.io.git
    branch: gh-pages
```

```
# 修改后
deploy:
  - type: git
    repo: https://gh_token@github.com/xxx/xxx.github.io.git
    branch: gh-pages
```



#### Travis CI脚本编写

```
# 指定语言环境
language: node_js
# 指定需要sudo权限
sudo: required
# 指定node_js版本
node_js: stable
# 指定缓存模块，可选。缓存可加快编译速度。
cache:
  directories:
    - node_modules

# 指定博客源码分支，因人而异。hexo博客源码托管在独立repo则不用设置此项
branches:
  only:
    - blog_hexo

before_install:
  - npm install -g hexo-cli

# Start: Build Lifecycle
install:
  - npm install
  - npm install hexo-deployer-git --save

# 执行清缓存，生成网页操作
script:
  - hexo clean
  - hexo generate

deploy:
  provider: pages
  skip-cleanup: true
  github-token: $GH_Token
  keep-history: true
  on:
    branch: blog_hexo
  local-dir: public
# End: Build LifeCycle
```

之后执行相关代码直接将写好的博客push到对应的分支上就可以了。