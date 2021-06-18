import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share/share.dart';

class TextToSpeech extends StatefulWidget {
  @override
  _TextToSpeechState createState() => _TextToSpeechState();
}

enum TtsState { playing, stopped, paused, continued }

class _TextToSpeechState extends State<TextToSpeech> {
  FlutterTts flutterTts;
  var result;
  String language;
  String dropdownvalue;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;
  final TextEditingController _controller = new TextEditingController();

  String _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    if (isAndroid) {
      _getEngines();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    if (isWeb || isIOS) {
      flutterTts.setPauseHandler(() {
        setState(() {
          print("Paused");
          ttsState = TtsState.paused;
        });
      });

      flutterTts.setContinueHandler(() {
        setState(() {
          print("Continued");
          ttsState = TtsState.continued;
        });
      });
    }

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future<dynamic> _getLanguages() => flutterTts.getLanguages;

  Future _getEngines() async {
    var engines = await flutterTts.getEngines;
    if (engines != null) {
      for (dynamic engine in engines) {
        print(engine);
      }
    }
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.speak(_newVoiceText);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

/*   Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  } */

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  /* List<DropdownMenuItem<String>> getLanguageDropDownMenuItems(
      dynamic languages) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in languages) {
      items.add(
          DropdownMenuItem(value: type as String, child: Text(type as String)));
    }
    return items;
  }*/

  void changedLanguageDropDownItem(String selectedType) {
    setState(() {
      language = selectedType;
      flutterTts.setLanguage(language);
      if (isAndroid) {
        flutterTts
            .isLanguageInstalled(language)
            .then((value) => isCurrentLanguageInstalled = (value as bool));
      }
    });
  }

  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
    print(_newVoiceText);
  }

  static const Map<String, String> langa = {
    "Afrikaans (South Africa)": "af-ZA",
    "Arabic": "ar",
    "Amharic": "am",
    "Albanian ": "sq-AL",
    "Assamese": "as",
    "Azerbaijani": "az",
    "Belarusian": "be",
    "Bulgarian": "bg",
    "Bengali(Bangla)": "bn",
    "Bosnian": "bs",
    "Catalan Valencian": "ca",
    "Czech": "cs",
    "Danish": "da",
    "English(India)": "en-IN",
    "English (Hong Kong)": "en-HK",
    "English(US)": "en-US",
    "English (New Zealand)": "en-NZ",
    "English (Singapore)": "en-SG",
    "French": "fr-FR",
    "German": "de",
    "Gujarati": "gu-IN",
    "Hindi": "hi-IN",
    "Italian": "it-IT",
    "Japanese": "ja-JP",
    "Kannada ": "kn-IN",
    "Kazakh": "kk-KZ",
    "Korean": "ko-KR",
    "Malayalam": "ml-IN",
    "Marathi": "mr-IN",
    "Nepali": "ne-NP",
    "Portuguese": "pt-BR",
    "Punjabi": "pa-Guru-IN",
    "Russian ": "ru-RU",
    "Spanish": "es",
    "Telugu": "te-IN",
    "Tamil": "ta-IN",
    "Thai": "th-TH",
    "Turkish": "tr-TR",
    "Urdu": "ur",
    "Vietnamese": "vi-VN",
    "Zulu": "zu-ZA"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              _inputSection(),
              _btnSection(),
              _share(),
              _futureBuilder(),
              _buildSliders()
            ])));
  }

  Widget _futureBuilder() => FutureBuilder<dynamic>(
      future: _getLanguages(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _languageDropDownSection(snapshot.data);
        } else if (snapshot.hasError) {
          return Text('Error loading languages...');
        } else
          return Text('Loading Languages...');
      });

  Widget _inputSection() => Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter the Text',
            suffixIcon: IconButton(
              icon: Icon(Icons.clear_rounded),
              onPressed: () => _controller.clear(),
            )),
        maxLines: 10,
        onChanged: (String value) {
          _onChange(value);
        },
      ));

  Widget _btnSection() {
    if (isAndroid) {
      return Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _speak,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  icon: Image.asset(
                    "assets/play button transp.png",
                    fit: BoxFit.cover,
                  ),
                  iconSize: 75,
                  padding: EdgeInsets.all(16),
                ),
                Text("play",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _stop,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  icon: Image.asset(
                    "assets/stop.png",
                    fit: BoxFit.cover,
                  ),
                  iconSize: 70,
                  padding: EdgeInsets.all(16),
                ),
                Text("stop",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container(
          padding: EdgeInsets.only(top: 50.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _speak,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  icon: Image.asset(
                    "assets/play button transp.png",
                    fit: BoxFit.cover,
                  ),
                  iconSize: 75,
                  padding: EdgeInsets.all(16),
                ),
                Text("play",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _stop,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  icon: Image.asset(
                    "assets/stop.png",
                    fit: BoxFit.cover,
                  ),
                  iconSize: 69,
                  padding: EdgeInsets.all(16),
                ),
                Text("stop",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ]));
    }
  }

  Widget _languageDropDownSection(dynamic languages) => Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(15.0)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text("choose language"),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36.0,
                  style: TextStyle(color: Colors.deepPurple, fontSize: 15),
                  //value: language,
                  //items: getLanguageDropDownMenuItems(languages),
                  //onChanged: changedLanguageDropDownItem,
                  value: dropdownvalue,
                  onChanged: (String newvalue) {
                    setState(() {
                      print("${flutterTts.getLanguages}");
                      dropdownvalue = newvalue;
                      changedLanguageDropDownItem(dropdownvalue);
                    });
                  },
                  items: langa
                      .map((string, value) {
                        return MapEntry(
                          string,
                          DropdownMenuItem<String>(
                            value: value,
                            child: Text(string),
                          ),
                        );
                      })
                      .values
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ]));

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
          Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(label,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: color)))
        ]);
  }

  Widget _buildSliders() {
    return Column(
      children: [_volume(), _pitch(), _rate()],
    );
  }

  Widget _volume() {
    return Container(
        child: Column(children: [
      Container(
        child: Text('Volume'),
      ),
      Slider(
          value: volume,
          onChanged: (newVolume) {
            setState(() => volume = newVolume);
          },
          min: 0.0,
          max: 1.0,
          divisions: 10,
          label: "Volume: $volume")
    ]));
  }

  Widget _pitch() {
    return Container(
        child: Column(children: [
      Container(
        child: Text('Pitch'),
      ),
      Slider(
        value: pitch,
        onChanged: (newPitch) {
          setState(() => pitch = newPitch);
        },
        min: 0.5,
        max: 2.0,
        divisions: 15,
        label: "Pitch: $pitch",
        activeColor: Colors.red,
      )
    ]));
  }

  Widget _rate() {
    return Container(
        child: Column(children: [
      Container(
        child: Text('Speed Rate'),
      ),
      Slider(
        value: rate,
        onChanged: (newRate) {
          setState(() => rate = newRate);
        },
        min: 0.0,
        max: 1.0,
        divisions: 10,
        label: "Rate: $rate",
        activeColor: Colors.green,
      )
    ]));
  }

  Widget _share() {
    return RaisedButton(
        color: Colors.blue,
        child: const Text(
          "Share",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
          ),
        ),
        onPressed: _newVoiceText == null
            ? null
            : () {
                final RenderBox box = context.findRenderObject();
                Share.share(_newVoiceText,
                    sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size);
              });
  }
}
