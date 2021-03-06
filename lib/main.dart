import 'dart:html';

import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:math';

void main() {
  runApp(Landing());
}

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Admin(),
      routes: {
        MyApp.routeName: (context) => MyApp(),
      },
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  static const routeName = '/admin';
}

class _MyAppState extends State<MyApp> {
  bool _visibility = false;
  late Timer timer;
  Future<void> fetchAndSyncValue() async {
    const url = 'https://lamp-lighten-default-rtdb.firebaseio.com/visible.json';

    var encoded = Uri.parse(url);
    try {
      final response = await http.get(encoded);
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);

      setState(() {
        _visibility = extractedData.values.last.values.elementAt(0);
        print('visiblity = ${_visibility}');
      });
    } catch (onError) {
      //throw onError;
      print(onError.toString());
    }
  }

  Future<void> updateValue() async {
    const url = 'https://lamp-lighten-default-rtdb.firebaseio.com/visible.json';

    var encoded = Uri.parse(url);
    try {
      final response = await http.post(
        encoded,
        body: json.encode(
          {
            'visible': _visibility,
          },
        ),
      );
      print(json.decode(response.body));
    } catch (onError) {
      print(onError.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(Duration(seconds: 1), (Timer t) => fetchAndSyncValue());
  }

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width;
    double cheight = MediaQuery.of(context).size.height;
    double mwidth = cWidth / 1536;
    double mheight = cheight / 763.2000122070312;

    return Scaffold(
      body: Container(
        //height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.expand,
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              child: Image.asset(
                'assets/images/stagedim.png',
                fit: BoxFit.cover,
              ),
            ),
            AnimatedOpacity(
              opacity: _visibility ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Container(
                child: Image.asset(
                  'assets/images/stagelit.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 190.0 * mheight,
              left: 710.0 * mwidth,
              child: Container(
                height: 350 * mheight,
                child: Image.asset(
                  'assets/images/3.png',
                ),
              ),
            ),
            Positioned(
              bottom: 423.0 * mheight,
              left: (715.0 * mwidth) + 67,
              child: AnimatedOpacity(
                opacity: _visibility ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Container(
                  height: 70 * mheight,
                  child: Image.asset(
                    'assets/images/4.gif',
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 423.0 * mheight,
              left: (715.0 * mwidth) + 32,
              child: AnimatedOpacity(
                opacity: _visibility ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Container(
                  height: 70 * mheight,
                  child: Image.asset(
                    'assets/images/4.gif',
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 423.0 * mheight,
              left: 715.0 * mwidth,
              child: AnimatedOpacity(
                opacity: _visibility ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Container(
                  height: 70 * mheight,
                  child: Image.asset(
                    'assets/images/4.gif',
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: !_visibility ? 23.0 * mheight : 79.0 * mheight,
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: _visibility
                    ? null
                    : () {
                        setState(() {
                          _visibility = true;
                        });
                        updateValue();
                        print(cWidth);
                        print(cheight);
                      },
                child: !_visibility
                    ? AvatarGlow(
                        glowColor: Colors.red,
                        endRadius: 90.0,
                        duration: Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: Duration(milliseconds: 100),
                        child: CircleAvatar(
                          radius: 40 * mheight,
                          backgroundColor: Colors.red,
                          child: FittedBox(
                            child: Text('Lighten'),
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 40 * mheight,
                        backgroundColor: Colors.red,
                        child: FittedBox(
                          child: Text('Thank You'),
                        ),
                      ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _visibility = false;
                  });
                  updateValue();
                },
                child: Text('Reset'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  bool _visibility = false;
  late Timer timer;
  Future<void> fetchAndSyncValue() async {
    const url = 'https://lamp-lighten-default-rtdb.firebaseio.com/visible.json';

    var encoded = Uri.parse(url);
    try {
      final response = await http.get(encoded);
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);

      setState(() {
        _visibility = extractedData.values.last.values.elementAt(0);
        print('visiblity = ${_visibility}');
      });
    } catch (onError) {
      //throw onError;
      print(onError.toString());
    }
  }

  Future<void> updateValue() async {
    const url = 'https://lamp-lighten-default-rtdb.firebaseio.com/visible.json';

    var encoded = Uri.parse(url);
    try {
      final response = await http.post(
        encoded,
        body: json.encode(
          {
            'visible': _visibility,
          },
        ),
      );
      print(json.decode(response.body));
    } catch (onError) {
      print(onError.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(Duration(seconds: 1), (Timer t) => fetchAndSyncValue());
  }

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width;
    double cheight = MediaQuery.of(context).size.height;
    double mwidth = cWidth / 1536;
    double mheight = cheight / 763.2000122070312;

    return Scaffold(
      body: Container(
        //height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.expand,
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              child: Image.asset(
                'assets/images/stagedim.png',
                fit: BoxFit.cover,
              ),
            ),
            AnimatedOpacity(
              opacity: _visibility ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Container(
                child: Image.asset(
                  'assets/images/stagelit.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 190.0 * mheight,
              left: 710.0 * mwidth,
              child: Container(
                height: 350 * mheight,
                child: Image.asset(
                  'assets/images/3.png',
                ),
              ),
            ),
            Positioned(
              bottom: 423.0 * mheight,
              left: (715.0 * mwidth) + 67,
              child: AnimatedOpacity(
                opacity: _visibility ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Container(
                  height: 70 * mheight,
                  child: Image.asset(
                    'assets/images/4.gif',
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 423.0 * mheight,
              left: (715.0 * mwidth) + 32,
              child: AnimatedOpacity(
                opacity: _visibility ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Container(
                  height: 70 * mheight,
                  child: Image.asset(
                    'assets/images/4.gif',
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 423.0 * mheight,
              left: 715.0 * mwidth,
              child: AnimatedOpacity(
                opacity: _visibility ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Container(
                  height: 70 * mheight,
                  child: Image.asset(
                    'assets/images/4.gif',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
