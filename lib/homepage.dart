import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './texttospeech.dart';
import './translate.dart';
import './predefinedwords.dart';
import './perdefinedwords2.dart';
import 'package:provider/provider.dart';
import './themeing/theming.dart';
import '../newcustomworsd/coverpage.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentindex = 0;
  bool islight = true;
  bool isdark = false;

  final List<Widget> _childern = [TextToSpeech(), Translate(), EmotePage1()];

  void ontappedbar(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    ThemeNotifier();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.blue, // navigation bar color
        statusBarColor: const Color(0xff231f20), // status bar color
        statusBarIconBrightness: Brightness.light));
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => new ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme.getTheme(),
          themeMode: ThemeMode.system,
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.black,
          ),
          home: WillPopScope(
              onWillPop: () async {
                if (_currentindex == 0) {
                  return _onBackPressed();
                }
                setState(() {
                  _currentindex = 0;
                });
                return false;
              },
              child: Scaffold(
                appBar: _appbar,
                drawer: Drawer(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        color: Colors.blue,
                        child: Center(
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(top: 30),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage("assets/play.png"),
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                Text(
                                  ' Welcome to DUB',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("darktheme"),
                        trailing: Icon(Icons.dark_mode),
                        onTap: () => {
                          theme.setDarkMode(),
                          print('set dark theme'),
                        },
                      ),
                      ListTile(
                        title: Text("Lighttheme"),
                        trailing: Icon(Icons.light_mode),
                        onTap: () => {
                          theme.setlightMode(),
                          print('set dark theme'),
                        },
                      ),
                      ListTile(
                          leading: Icon(Icons.home),
                          title: Text(
                            "Home",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Homepage()));
                          }),
                      ListTile(
                          leading: Icon(Icons.emoji_emotions),
                          title: Text(
                            "more emote",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Emotepage2()));
                          }),
                      ListTile(
                          leading: Icon(Icons.dashboard_customize),
                          title: Text(
                            "Customise Words",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Frontpage()));
                          }),
                    ],
                  ),
                ),
                body: _childern[_currentindex],
                bottomNavigationBar: Theme(
                  data: ThemeData(
                    //backgroundColor: ThemeNotifier().getTheme().primaryColor,
                    splashColor: Colors.blue,
                  ),
                  child: bottomNavigationBar(),
                ),
              )),
        ),
      ),
    );
  }

  Widget get _appbar {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/Logo strip top gap.png",
                    ),
                    fit: BoxFit.fill)),
          ),
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        )),
      ),
    );
  }

  Widget bottomNavigationBar() {
    return /* Container(
     /*  decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ]), */
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: */
        BottomNavigationBar(
      backgroundColor: Colors.red,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white,
      showUnselectedLabels: true,
      elevation: 10,
      onTap: ontappedbar,
      currentIndex: _currentindex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.speaker),
          title: Text('Speech'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.translate), title: Text('Translate')),
        BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions), title: Text('Emote')),
      ],
      /*  ),
      ), */
    );
  }
}
