---
title: BeautifulSoup的学习与使用
date: 2019-10-30 14:54:57
# tags:
# categories: tech
---

# 起因

因为在获取教务网站的数据时，很多数据都是要求我们自己去抓取的，在这种情况下使用Python爬虫进行数据爬取成为了一个极佳的选项。而我选择了BeautifulSoup库进行爬取，原因也比较简单——它的上手比较快。因此，接下来我将粗略的讲讲BeautifulSoup的使用。（因为Beautiful Soup 3 目前已经停止开发,所以以下皆为Beautiful Soup 4的使用）



# 让我们一起干了这碗美丽的汤

## 简介

[Beautiful Soup](http://www.crummy.com/software/BeautifulSoup/) 是一个可以从HTML或XML文件中提取数据的Python库.它能够通过你喜欢的转换器实现惯用的文档导航,查找,修改文档的方式.

## 安装

如果你用的是新版的Debain或ubuntu,那么可以通过系统的软件包管理来安装:

```
$ apt-get install Python-bs4
```

或者使用pip or easy_install 命令从PyPi上下载安装

```
$ easy_install beautifulsoup4
$ pip install beautifulsoup4
```



## 快速开始gkd

我们以下面这段文档为例进行学习，以下简称为**爱丽丝**

```
html_doc = """
<html><head><title>The Dormouse's story</title></head>
<body>
<p class="title"><b>The Dormouse's story</b></p>

<p class="story">Once upon a time there were three little sisters; and their names were
<a href="http://example.com/elsie" class="sister" id="link1">Elsie</a>,
<a href="http://example.com/lacie" class="sister" id="link2">Lacie</a> and
<a href="http://example.com/tillie" class="sister" id="link3">Tillie</a>;
and they lived at the bottom of a well.</p>

<p class="story">...</p>
"""
```

### soup对象实例化

```
soup = BeautifulSoup(html_doc, 'html.parser')
```

html_doc对应着爬取网页的html，后面的为相应的解析器

## 搜索文档树

### find_all方法

通常情况下我们使用find_all方法进行筛选。

#### name参数

它会寻找名字为name的tag，并且全部返回

简单的用法如下:

```
soup.find_all("title")
# [<title>The Dormouse's story</title>]
```

#### keyword参数

它会寻找具有参数的keyword的tag并且全部返回，

例如`<a href="http://example.com/lacie" class="sister" id="link2">Lacie</a>`中的href，class，id就是keyword参数。

```
soup.find_all(id='link2')
# [<a class="sister" href="http://example.com/lacie" id="link2">Lacie</a>]
```

请注意因为class是Python的内置关键字因此在使用时应在class后添加下划线，如

```
soup.find_all(class_="sister")
# [<a class="sister" href="http://example.com/elsie" id="link1">Elsie</a>,
#  <a class="sister" href="http://example.com/lacie" id="link2">Lacie</a>,
#  <a class="sister" href="http://example.com/tillie" id="link3">Tillie</a>]
```

#### 按CSS搜索

按照CSS类名搜索tag，并返回全部符合条件的语句

```
soup.find_all("a", attrs={"class": "sister"})
# [<a class="sister" href="http://example.com/elsie" id="link1">Elsie</a>,
#  <a class="sister" href="http://example.com/lacie" id="link2">Lacie</a>,
#  <a class="sister" href="http://example.com/tillie" id="link3">Tillie</a>]
```

### select方法

select方法的使用比较简单，只需要依次传入对应的标签名即可，其中搜索id为`#id`类名为`.class`

```
soup.select('a #link1')
#<a class="sister" href="http://example.com/elsie" id="link1">Elsie</a>
```

## 输出

输出时可以直接使用`.text`将文本输出

# 总结

其实这里我讲的很少，只是一些beautifulsoup的简单应用，但是万事开头难，相信你将这些都已经弄明白后，一些更深层次的知识也已经满足不了你了。最后是beautifulsoup官方文档的传送门:[即将前往官方文档](https://beautifulsoup.readthedocs.io/zh_CN/v4.4.0/#)

