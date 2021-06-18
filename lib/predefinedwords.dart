import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class EmotePage1 extends StatefulWidget {
  @override
  _EmotePage1State createState() => _EmotePage1State();
}

class _EmotePage1State extends State<EmotePage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                              player.play('gm.mp3');
                            },
                            color: Colors.greenAccent[200],
                            child: Text('Good Morning'),
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
                                player.play('gnsd.mp3');
                              },
                              color: Colors.greenAccent[200],
                              child: Text('Good Night'),
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
                              player.play('hello.mp3');
                            },
                            color: Colors.greenAccent[200],
                            child: Text('Hello'),
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
                                player.play('okay.mp3');
                              },
                              color: Colors.greenAccent[200],
                              child: Text('Okay'),
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
                              player.play('how r u.mp3');
                            },
                            color: Colors.greenAccent[200],
                            child: Text('How are you?'),
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
                                player.play('fine.mp3');
                              },
                              color: Colors.greenAccent[200],
                              child: Text('I\'m fine'),
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
                              player.play('tq.mp3');
                            },
                            color: Colors.greenAccent[200],
                            child: Text('Thank You!'),
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
                                player.play('welcome.mp3');
                              },
                              color: Colors.greenAccent[200],
                              child: Text('You\'re welcome'),
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
                              player.play('sorry.mp3');
                            },
                            color: Colors.greenAccent[200],
                            child: Text('I am so sorry!'),
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
                                  player.play('one moment.mp3');
                                },
                                color: Colors.greenAccent[200],
                                child: Text(
                                  'One Moment Please',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )),
                      ],
                    ),
                    Row(
                      //sixth row
                      children: [
                        SizedBox(
                          width: 150,
                          height: 60,
                          child: RaisedButton(
                            onPressed: () {
                              final player = AudioCache();
                              player.play('doctor.mp3');
                            },
                            color: Colors.greenAccent[200],
                            child: Text('I need a Doctor!'),
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
                                player.play('help.mp3');
                              },
                              color: Colors.greenAccent[200],
                              child: Text('Help me! (sos)'),
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
    );
  }
}
