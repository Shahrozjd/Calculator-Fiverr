import 'dart:io';
import 'package:audioplayers/audio_cache.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:auto_size_text/auto_size_text.dart';

const String testDevice = 'MobileId';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MaterialCalculator(),
    );
  }
}

class MaterialCalculator extends StatefulWidget {
  @override
  _MaterialCalculatorState createState() => _MaterialCalculatorState();
}

class _MaterialCalculatorState extends State<MaterialCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationfont = 38.0;
  double resultfont = 48.0;



  bool isSwitched = false;

  double _value = 20.0;

  PatternVibrate() {
    HapticFeedback.mediumImpact();
  }




  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  testDevices: testDevice != null ? <String>[testDevice] : null,
  nonPersonalizedAds: true,
  keywords: <String>['App', 'Calculator'],
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  //functionality
  buttonpressed(String buttonValue) {
    setState(() {
      HapticFeedback.mediumImpact();
      if (buttonValue == "C") {
        equationfont = 38;
        resultfont = 48;
        equation = "0";
        result = "0";
      } else if (buttonValue == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        equationfont = 48;
        resultfont = 38;
        if (equation == "") {
          equation = "0";
          result = "0";
          equationfont = 38;
          resultfont = 48;
        }
      } else if (buttonValue == "=") {
        equationfont = 38;
        resultfont = 48;

        expression = equation;
        expression = expression.replaceAll("x", "*");
        expression = expression.replaceAll("÷", "/");

        try {
          Parser parser = new Parser();
          Expression exp = parser.parse(expression);

          ContextModel contextModel = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, contextModel)}';
        } catch (e) {
          result = "ERROR";
        }
      } else if (equation == "0") {
        equationfont = 48;
        resultfont = 38;
        equation = buttonValue;
      } else {
        equationfont = 48;
        resultfont = 38;
        equation = equation + buttonValue;
      }
    });
  }

  Widget CalButtons(String ButtonValue, Color Buttoncolor, Color fontcolor,
      double Buttonheight, double ButtonWeights) {
    return Container(
      margin: EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height * 0.09 * Buttonheight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,// 10% of the width, so there are ten blinds.
            colors: <Color>[
            Color(0xffFF1B16),
            Color(0xff254EFF)]
        ),
      ),
      child: MaterialButton(
        splashColor: Colors.transparent,
        padding: EdgeInsets.all(16),
        onPressed: () {
          if(isSwitched) {
            Playsound();
          }
          buttonpressed(ButtonValue);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          ButtonValue,
          style: TextStyle(
              fontSize: 30, color: fontcolor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget EqualButton(String ButtonValue, Color Buttoncolor, double Buttonheight,
      double Buttonwidth) {
    return Container(
      margin: EdgeInsets.all(7),
      height: MediaQuery.of(context).size.height * 0.09 * Buttonheight,
      width: MediaQuery.of(context).size.width * Buttonwidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,// 10% of the width, so there are ten blinds.
            colors: <Color>[
              Color(0xffFF1B16),
              Color(0xff254EFF)]
        ),
      ),
      child: MaterialButton(
        splashColor: Colors.transparent,
        padding: EdgeInsets.all(16),
        onPressed: (){
          if(isSwitched) {
            Playsound();
          }
          buttonpressed(ButtonValue);
        },
        child: Text(
          ButtonValue,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget dividebutton(String ButtonValue, Color Buttoncolor, Color fontcolor,
      double Buttonheight, double Buttonwidth) {
    return Container(
      margin: EdgeInsets.all(7),
      height: MediaQuery.of(context).size.height * 0.09 * Buttonheight,
      width: MediaQuery.of(context).size.width * Buttonwidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,// 10% of the width, so there are ten blinds.
            colors: <Color>[
              Color(0xffFF1B16),
              Color(0xff254EFF)]
        ),
      ),
      child: MaterialButton(
        splashColor: Colors.transparent,
        padding: EdgeInsets.all(16),
        onPressed: () {
          if(isSwitched) {
            Playsound();
          }
          buttonpressed(ButtonValue);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          ButtonValue,
          style: TextStyle(
              fontSize: 50, color: fontcolor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget Multiplybutton(String ButtonValue, Color Buttoncolor, Color fontcolor,
      double Buttonheight, double Buttonwidth) {
    return Container(
      margin: EdgeInsets.all(7),
      height: MediaQuery.of(context).size.height * 0.09 * Buttonheight,
      width: MediaQuery.of(context).size.width * Buttonwidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,// 10% of the width, so there are ten blinds.
            colors: <Color>[
              Color(0xffFF1B16),
              Color(0xff254EFF)]
        ),
      ),
      child: MaterialButton(
        splashColor: Colors.transparent,
        padding: EdgeInsets.all(16),
        onPressed: () {
          if(isSwitched) {
            Playsound();
          }
          buttonpressed(ButtonValue);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          ButtonValue,
          style: TextStyle(
              fontSize: 50, color: fontcolor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget Addbutton(String ButtonValue, Color Buttoncolor, Color fontcolor,
      double Buttonheight,double Buttonwidth) {
    return Container(
      margin: EdgeInsets.all(7),
      height: MediaQuery.of(context).size.height * 0.09 * Buttonheight,
      width: MediaQuery.of(context).size.width * Buttonwidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,// 10% of the width, so there are ten blinds.
            colors: <Color>[
              Color(0xffFF1B16),
              Color(0xff254EFF)]
        ),
      ),
      child: MaterialButton(
        splashColor: Colors.transparent,
        padding: EdgeInsets.all(16),
        onPressed: () {
          if(isSwitched)
            {
              Playsound();
            }
          buttonpressed(ButtonValue);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          ButtonValue,
          style: TextStyle(
              fontSize: 50, color: fontcolor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget subtractbutton(String ButtonValue, Color Buttoncolor, Color fontcolor,
      double Buttonheight,double Buttonwidth) {
    return Container(
      margin: EdgeInsets.all(7),
      height: MediaQuery.of(context).size.height * 0.09 * Buttonheight,
      width: MediaQuery.of(context).size.width * Buttonwidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,// 10% of the width, so there are ten blinds.
            colors: <Color>[
              Color(0xffFF1B16),
              Color(0xff254EFF)]
        ),
      ),
      child: MaterialButton(
        splashColor: Colors.transparent,
        padding: EdgeInsets.all(16),
        onPressed: (){
          if(isSwitched)
          {
            Playsound();
          }
          buttonpressed(ButtonValue);
          },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          ButtonValue,
          style: TextStyle(
              fontSize: 50, color: fontcolor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  double height,width;


  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
    //Change appId With Admob Id
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  void Playsound() {
    final player = AudioCache();
    player.play("button_click_sound.mp3");
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.centerLeft,// 10% of the width, so there are ten blinds.
          colors: <Color>[
            Color(0xff19C1FF),
            Color(0xffF785FF)
          ], // red to yellow
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Center(child: Text("Calculator")),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: height*0.15,
              margin: EdgeInsets.only(left: 10,right: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFBB79E3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: AutoSizeText(
                        equation,
                        maxLines: 4,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: _value, color: Colors.white),
                      ),
                    ),
                  ),
//                  TextField(
//                    readOnly: true,
//                    showCursor: false,
//                    textAlign: TextAlign.right,
//                    style: TextStyle(fontSize: equationfont,color: Colors.white),
//                    cursorColor: Colors.white,
//                    decoration: new InputDecoration(
//
//                      border: InputBorder.none,
//                      focusedBorder: InputBorder.none,
//                      enabledBorder: InputBorder.none,
//                      errorBorder: InputBorder.none,
//                      disabledBorder: InputBorder.none,
//                      hintText: equation,
//                      hintStyle: TextStyle(fontSize: equationfont,color: Colors.white),
//                      contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 20),
//                    ),
//                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: AutoSizeText(
                        result,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: _value, color: Colors.white),
                      )
//                    Text(
//                      result,
//                      style:
//                          TextStyle(fontSize: resultfont, color: Colors.white),
//                    ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: height*0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    Container(
                      child: Row(
                        children: [
                          Text("Sound",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                          Switch(value: isSwitched,
                              onChanged: (value){
                                setState(() {
                                  isSwitched=value;
                                  print(isSwitched);
                                });
                          },

                            activeTrackColor: Colors.blue[800],
                            activeColor: Color(0xffF785FF),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Text("Font",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                          Slider(
                            activeColor: Color(0xffF785FF),
                            min: 5.0,
                            max: 50.0,
                            value: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value;
                                print(_value);
                              });
                            },
                          ),

                        ],
                      ),
                    ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Table(
                        children: [
                          TableRow(children: [
                            CalButtons(
                                "C", Color(0xFF243441), Colors.white, 1, 0),
                            CalButtons(
                                "⌫", Color(0xFF243441), Colors.white, 1, 0),
                            CalButtons(
                                "%", Color(0xFF243441), Colors.white, 1, 0),
                            dividebutton(
                                "÷", Color(0xFFC73D00), Colors.white, 1,0),
                          ]),
                          TableRow(children: [
                            CalButtons(
                                "1", Color(0xFF243441), Colors.white, 1, 0),
                            CalButtons(
                                "2", Color(0xFF243441), Colors.white, 1, 0),
                            CalButtons(
                                "3", Color(0xFF243441), Colors.white, 1, 0),
                            Multiplybutton(
                                "x", Color(0xFFC73D00), Colors.white, 1,0),

                          ]),
                          TableRow(children: [
                            CalButtons(
                                "4", Color(0xFF243441), Colors.white, 1, 0),
                            CalButtons(
                                "5", Color(0xFF243441), Colors.white, 1, 0),
                            CalButtons(
                                "6", Color(0xFF243441), Colors.white, 1, 0),
                            Addbutton("+", Color(0xFFC73D00), Colors.white, 1,0),
                          ]),
                          TableRow(children: [
                            CalButtons(
                                "7", Color(0xFF243441), Colors.white, 1, 0),
                            CalButtons(
                                "8", Color(0xFF243441), Colors.white, 1, 0),
                            CalButtons(
                                "9", Color(0xFF243441), Colors.white, 1, 0),
                            subtractbutton(
                                "-", Color(0xFFC73D00), Colors.white, 1,0),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * .50,
                      child: Table(
                        children: [
                          TableRow(children: [
                            CalButtons(
                                "0", Color(0xFF243441), Colors.white, 1, 0),
                            CalButtons(
                                ".", Color(0xFF243441), Colors.white, 1, 0),
                          ])
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .50,
                      child: Table(
                        children: [
                          TableRow(children: [
                              EqualButton("=", Color(0xFF009067), 1, 0),
                          ])
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

