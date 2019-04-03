import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Navigation with Routes',
    routes: <String, WidgetBuilder>{
      '/': (_) => new Splash(),
      '/login': (_) => new Login(),
      '/home': (_) => new Home(),
      '/next': (_) => new Next(),
    },
  ));
}

// ---------
// スプラッシュ
// ---------
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    new Future.delayed(const Duration(seconds: 3))
        .then((value) => handleTimeout());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        // TODO: スプラッシュアニメーション
        child: const CircularProgressIndicator(),
      ),
    );
  }

  void handleTimeout() {
    // ログイン画面へ
    Navigator.of(context).pushReplacementNamed("/login");
  }
}

// ---------
// ログイン画面
// ---------
class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  final myController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  
  String email,password;
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("Login"),
      ),
      body: new Center(
        child: new Form(
          child: new SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 24.0),
                new TextField(
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'email',
                  ),
                  onChanged: (text){
                    setState(() {
                      this.email = text;
                    });
                  },
                  //validator: (input) => !input.contains('@') ? 'emailじゃないだろ' :null,
                  //onSaved: (input) => email = (input),
                ),
                const SizedBox(height: 24.0),
                new TextField(
                  maxLength: 8,
                  decoration: new InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onChanged:(text){
                    setState(() {
                      this.password = text;
                    });
                  }
                  //onSaved: (input) => password = (input),
                  //validator: (input) => input.length < 8  ? '違う':null,
                ),
                const SizedBox(height: 24.0),
                new Center(
                  child: new RaisedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      
                      //formkey.currentState.save();
                      _HomeState(name:email);
                      //Navigator.of(context).pushNamed("/home"); 
                      // TODO: ログイン処理
                      // ホーム画面へ
                      //Navigator.of(context).pushReplacementNamed("/home");
                      
                      Navigator.push(context, new MaterialPageRoute<Null>(
                        settings: const RouteSettings(name: "/home"),
                        builder: (BuildContext context) => new Home(name:email)
                      ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------
// ホーム画面
// ---------
class Home extends StatefulWidget {
  final String name;
  Home({this.name});
  @override
  _HomeState createState() => new _HomeState(name: name);
}
class _HomeState extends State<Home> {
  final String name;
  int i=0;

  _HomeState({this.name});
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(name),
      ),
      body: new Center(
        child: new RaisedButton(
          child: const Text("Launch Next Screen"),
          onPressed: () {
            // その他の画面へ
            Navigator.of(context).pushNamed("/next");
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget>[
                  new Container(
                    margin: const EdgeInsets.only(right: 1.0),
                    child: new CircleAvatar(
                      child: new Text(name[0]),
                      maxRadius: 30,
                    ),
                  ),
                  Container(  // 3.1.2行目
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 20.0, color: Colors.white70),
                    ),
                  ),
                  Container(  // 3.1.2行目
                    child: Text(
                      "@hoshinari",
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey[800],
              ),

            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: new BottomNavigationBar(
      currentIndex: i,
      type: BottomNavigationBarType.fixed,
      onTap:(int index) {
        setState(() {
          i= index;
        });
      },
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text("Home"),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.search),
          title: new Text("Search"),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.add_alert),
          title: new Text("Alert"),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.mail),
          title: new Text("Mail"),
        ),
      ],
    ),
    
    );
    
  }

}

// ---------
// その他画面
// ---------
class Next extends StatefulWidget {
  @override
  _NextState createState() => new _NextState();
}

class _NextState extends State<Next> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("Next"),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            const SizedBox(height: 24.0),
            new RaisedButton(
              child: const Text("Launch Next Screen"),
              onPressed: () {
                // その他の画面へ
                Navigator.of(context).pushNamed("/next");
              },
            ),
            const SizedBox(height: 24.0),
            new RaisedButton(
              child: const Text("Home"),
              onPressed: () {
                // ホーム画面へ戻る　
                Navigator.popUntil(context, ModalRoute.withName("/home"));
              },
            ),
            const SizedBox(height: 24.0),
            new RaisedButton(
              child: const Text("Logout"),
              onPressed: () {
                // 確認ダイアログ表示
                showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return new AlertDialog(
                      content: const Text('Do you want logout?'),
                      actions: <Widget>[
                        new FlatButton(
                          child: const Text('No'),
                          onPressed: () {
                            // 引数をfalseでダイアログ閉じる
                            Navigator.of(context).pop(false);
                          },
                        ),
                        new FlatButton(
                          child: const Text('Yes'),
                          onPressed: () {
                            // 引数をtrueでダイアログ閉じる
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    );
                  },
                ).then<void>((aBool) {
                  // ダイアログがYESで閉じられたら...
                  if (aBool) {
                    // 画面をすべて除いてスプラッシュを表示
                    Navigator.pushAndRemoveUntil(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Splash()),
                        (_) => false);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}