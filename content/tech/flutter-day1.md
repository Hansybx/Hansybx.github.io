---
title: 使用flutter来构造自己的App-登录逻辑
date: 2020-02-04 12:55:21
# categories: tech
---



## 成果演示：

![演示Demo](https://pic.downk.cc/item/5e3901722fb38b8c3c9d5b77.gif)

# 前期准备：

## 1.dio 用于发送http请求

用法：

 发起一个 `GET` 请求 : 

```dart
Response response;
Dio dio = Dio();
response = await dio.get("/test?id=12&name=wendu")
print(response.data.toString());
// 请求参数也可以通过对象传递，上面的代码等同于：
response = await dio.get("/test", queryParameters: {"id": 12, "name": "wendu"});
print(response.data.toString());
```

 发起一个 `POST` 请求: 

```dart
response = await dio.post("/test", data: {"id": 12, "name": "wendu"});
```

 发送 FormData: 

```dart
FormData.fromMap({
    "name": "wendux",
    "age": 25,
    "file": await MultipartFile.fromFile("./text.txt",filename: "upload.txt"),
    "files": [
      await MultipartFile.fromFile("./text1.txt", filename: "text1.txt"),
      await MultipartFile.fromFile("./text2.txt", filename: "text2.txt"),
    ]
 });
response = await dio.post("/info", data: formData);
```

更多实例请前往 [Dio Github样例](https://github.com/flutterchina/dio/blob/master/README-ZH.md)



## 2.shared_preferences 用于本地数据共享

增：

```
SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setString(key, value)
prefs.setBool(key, value)
prefs.setDouble(key, value)
prefs.setInt(key, value)
prefs.setStringList(key, value)
```

删：

```
SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.remove(key); //删除指定键
prefs.clear();//清空键值对
```



改：

```
改和增是一样的，只需要再执行一次setXXX()方法即可覆盖之前的数据。
```



查：

```
SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.getString(key)
prefs.getBool(key)
prefs.getDouble(key)
prefs.getInt(key)
prefs.getStringList(key)
```



ps:

这些方法都是异步的，使用其查找数据时应当使用then()方法。

```
Future<void> get()  async {
    print('1');
    SharedPreferences pref = await SharedPreferences.getInstance();
    flag = pref.getBool(key);
}

get().then((value){
	//TODO
});
```



# 实现思路

![实现思路](https://pic.downk.cc/item/5e3906d32fb38b8c3c9dfee8.png)



## 代码实现：

```

// splashPage
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool flag;
  Future<void> get()  async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    flag = pref.getBool(key);
  }
  
  // 延时跳转
  jumpPage() {
    return Timer(Duration(milliseconds: 100), () {
      get().then((value) {
        if(flag != null && flag == true){
          Navigator.pushReplacementNamed(context, '/main');
        }else{
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    });
  }


  @ override
  void initState()  {
    super.initState();
    jumpPage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      color: Colors.white,
      child: Text("test"),
    );
  }
}

//main.dart
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Welcome to Flutter',
        home: SplashPage(),
        initialRoute: '/',
        routes: {
          '/login':(context)=> Login(),
          '/main':(context)=> Tabs(),
        },
    );
  }
}

//双击返回键退出
@override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          return false;
        }

        return true;
      },
```



## 需要注意的地方：

由于在flutter中，路由导航是以栈的形式存放的，所以在 splash页进行跳转时应使用**Navigator.pushReplacementNamed()**方法来进行路由跳转，他会替换当前栈的元素，这样就可以防止双击返回键时不会返回到桌面。







