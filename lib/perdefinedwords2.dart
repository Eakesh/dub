import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import './homepage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import './themeing/theming.dart';

class Emotepage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => new ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme.getTheme(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system,
          home: Scaffold(
            appBar: _appbar,
            body: WillPopScope(
              onWillPop: () {
                return Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: Homepage()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Container(
                      /*  margin: EdgeInsets.fromLTRB(35, 0, 0, 0), */
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              //first row
                              children: [
                                SizedBox(
                                  width: 150,
                                  height: 60,
                                  child: RaisedButton(
                                    onPressed: () {
                                      final player = AudioCache();
                                      player.play('hlo ther.mp3');
                                    },
                                    color: Colors.greenAccent[200],
                                    child: Text('Hello There'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                    width: 150,
                                    height: 60,
                                    child: RaisedButton(
                                      onPressed: () {
                                        final player = AudioCache();
                                        player.play('brba.mp3');
                                      },
                                      color: Colors.greenAccent[200],
                                      child: Text('Goddamn right!'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              //second row
                              children: [
                                SizedBox(
                                  width: 150,
                                  height: 60,
                                  child: RaisedButton(
                                    onPressed: () {
                                      final player = AudioCache();
                                      player.play('bla bla.mp3');
                                    },
                                    color: Colors.greenAccent[200],
                                    child: Text('Blah Blah Blah'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                    width: 150,
                                    height: 60,
                                    child: RaisedButton(
                                      onPressed: () {
                                        final player = AudioCache();
                                        player.play('wow.mp3');
                                      },
                                      color: Colors.greenAccent[200],
                                      child: Text('Wow'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              //third row
                              children: [
                                SizedBox(
                                  width: 150,
                                  height: 60,
                                  child: RaisedButton(
                                    onPressed: () {
                                      final player = AudioCache();
                                      player.play('omg.mp3');
                                    },
                                    color: Colors.greenAccent[200],
                                    child: Text('Oh My Gaaaaahd!'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                    width: 150,
                                    height: 60,
                                    child: RaisedButton(
                                      onPressed: () {
                                        final player = AudioCache();
                                        player.play('mman.mp3');
                                      },
                                      color: Colors.greenAccent[200],
                                      child: Text('M\'Man'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              //fourth row
                              children: [
                                SizedBox(
                                  width: 150,
                                  height: 60,
                                  child: RaisedButton(
                                    onPressed: () {
                                      final player = AudioCache();
                                      player.play('do it.mp3');
                                    },
                                    color: Colors.greenAccent[200],
                                    child: Text('Just Do It!'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                    width: 150,
                                    height: 60,
                                    child: RaisedButton(
                                      onPressed: () {
                                        final player = AudioCache();
                                        player.play('ohh.mp3');
                                      },
                                      color: Colors.greenAccent[200],
                                      child: Text('OHHHH(meme)'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                                //fifth row
                                children: [
                                  SizedBox(
                                    width: 150,
                                    height: 60,
                                    child: RaisedButton(
                                      onPressed: () {
                                        final player = AudioCache();
                                        player.play('fine2.mp3');
                                      },
                                      color: Colors.greenAccent[200],
                                      child: Text('Fine(not)'),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                          width: 150,
                                          height: 60,
                                          child: RaisedButton(
                                              onPressed: () {
                                                final player = AudioCache();
                                                player.play('minute.mp3');
                                              },
                                              color: Colors.greenAccent[200],
                                              child: Text(
                                                'Wait a Minute',
                                                textAlign: TextAlign.center,
                                              )))),
                                ]),
                            Row(
                              //sixth row
                              children: [
                                SizedBox(
                                  width: 150,
                                  height: 60,
                                  child: RaisedButton(
                                    onPressed: () {
                                      final player = AudioCache();
                                      player.play('sure.mp3');
                                    },
                                    color: Colors.greenAccent[200],
                                    child: Text('Are You Sure About That',
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                    width: 150,
                                    height: 60,
                                    child: RaisedButton(
                                      onPressed: () {
                                        final player = AudioCache();
                                        player.play('wahapan.mp3');
                                      },
                                      color: Colors.greenAccent[200],
                                      child: Text(
                                        'Hey What Happened!',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _appbar {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: AppBar(
        automaticallyImplyLeading: true,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
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
              fit: BoxFit.fill,
            )),
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
}
