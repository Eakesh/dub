import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themeing/theming.dart';
import './defaultclasses.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Frontpage extends StatefulWidget {
  @override
  _FrontpageState createState() => _FrontpageState();
}

class _FrontpageState extends State<Frontpage> {
  FlutterTts flutterTts;
  String _newVoiceText;

  List<Map<String, Words>> word = [
    {
      "1": Words(title: "hello", inputtext: "Hello"),
      "2": Words(title: "Good night", inputtext: "Good night")
    }
  ];

  void _speak() async {
    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.speak(_newVoiceText);
      }
    }
  }

  void onchanged(String _newVoiceText) {
    _speak();
  }

  @override
  Widget build(BuildContext context) {
    return /*  ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => new ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, child) => */
        MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: theme.getTheme(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: _appbar,
        body: Container(
          height: 450,
          child: ListView(children: [
            Column(
              children: word.map(
                (wo) {
                  return Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _newVoiceText = wo['1'].inputtext;
                              _speak();
                            });
                          },
                          child: Card(
                            child: Text('${wo['1'].title}'),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _newVoiceText = wo['1'].inputtext;
                              onchanged(_newVoiceText);
                            });
                          },
                          child: Card(
                            child: Text('${wo['2'].title}'),
                          )),
                    ],
                  );
                },
              ).toList(),
            ),
          ]),
        ),
      ),
    );
  }
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
