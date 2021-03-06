import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:sensors/sensors.dart';
import 'dart:ui' as prefix0;

void main() => runApp(CodeTR());

class CodeTR extends StatefulWidget {
  @override
  MGState createState() => MGState();
}

class MGState extends State<CodeTR> with TickerProviderStateMixin {
  Animation<double> bA, tA;
  AnimationController bC, tC;
  double bYP = 0, tYP = 0, bXP = 0, tXP = 0, x = 0;
  int c = 1;
  int eG = 0;
  var r = Random();
  static const Color w = Colors.white;
  Widget d = Container(
    height: 60,
    width: 60,
    decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(20)
    ),
    child:  Container(
      width: 54.0,
      height: 54.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        image: DecorationImage(
            image: AssetImage("assets/plane.png"),
            fit: BoxFit.cover
        ),
      ),
    ),
  );

  Widget e = Container(
    height: 60,
    width: 60,
    decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(20)
    ),
    child:  Container(
      width: 54.0,
      height: 54.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        image: DecorationImage(
            image: AssetImage("assets/asteroid.png"),
            fit: BoxFit.cover
        ),
      ),
    ),
  );

  void id() {
    bC =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    accelerometerEvents.listen((AccelerometerEvent e) {
      if ((-x * 5 - e.x).abs() > 0.1) {
        if (e.x < -5)
          s.addValue(1);
        else if (e.x > 5)
          s.addValue(-1);
        else
          x = -double.parse(e.x.toStringAsFixed(1)) / 5;
        s.addValue(x);
      }
    });
    i();
  }

  void i() {
    bYP = 1;
    tYP = -1;
    bA = Tween(begin: 1.0, end: -1.0).animate(bC)
      ..addStatusListener((e) {
        if (e == AnimationStatus.completed) {
          bC.reset();
          bC.forward();
        }
      })
      ..addListener(() {
        s.bS.add(bA.value);
      });
    bC.forward();
    tC = AnimationController(
        duration: Duration(milliseconds: c < 45 ? 10000 - (c * 200) : 1000),
        vsync: this);
    tA = Tween(begin: -1.0, end: 1.0).animate(tC)
      ..addListener(() {
        setState(() {
          tYP = tA.value;
        });
        if (tA.value == 1) {
          eG = 2;
        }
      });
    tC.forward();
  }

  @override
  Widget build(BuildContext ctx) {
    if (bXP > tXP - 0.15 && bXP < tXP + 0.15) {
      if (bYP < tYP) {
        setState(() {
          c++;
          if (r.nextBool())
            tXP = r.nextDouble();
          else
            tXP = -r.nextDouble();
        });
        bC.reset();
        i();
      }
    }
    if (eG == 1 && bA.value == 1) {
      bXP = x;
    }


    return MaterialApp(
      home: Scaffold(
//        backgroundColor: Colors.grey,
        body: eG != 1
            ? Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/bg.jpg"),fit:BoxFit.cover)
                  ),
                ),
                BackdropFilter(
                  filter: prefix0.ImageFilter.blur(sigmaX: 4,sigmaY: 4),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6)
                    ),
                  ),
                ),
                ListView(
                  children: <Widget>[
                    Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("assets/flight.png"),
//                    Icon(Icons.airplanemode_active,color: Colors.red,size: 320,),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "xForce Shooter",
                                style: TextStyle(color: Colors.blue, fontSize: 42),
                              ),
                            ),
                            Text(
                              "Score: ${c - 1}",
                              style: TextStyle(color: w, fontSize: 62),
                            ),
                            GestureDetector(
                              onTap: () {
                                id();
                                eG = 1;
                                c = 1;
                                i();
                              },
                              child: Icon(
                                (eG == 2) ? Icons.refresh : Icons.play_arrow,
                                color: w,
                                size: 62,
                              ),
                            )
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),

              ],
            )
            : Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/bg.jpg"),fit:BoxFit.cover)
                  ),
                ),
                BackdropFilter(
                  filter: prefix0.ImageFilter.blur(sigmaX: 4,sigmaY: 4),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6)
                    ),
                  ),
                ),
                Column(
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment(0.8, -0.9),
                              child: Text(
                                "${c - 1}",
                                style: TextStyle(fontSize: 32, color: w),
                              ),
                            ),
                            StreamBuilder(
                              initialData: 1.0,
                              stream: s.bSG,
                              builder: (context, s) {
                                bYP = s.data;
                                return Align(
                                  alignment: Alignment(bXP, s.data),
                                  child: Container(
                                    width: 54.0,
                                    height: 54.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      image: DecorationImage(
                                          image: AssetImage("assets/comet.png"),
                                          fit: BoxFit.cover
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Align(
                              alignment: Alignment(tXP, tYP),
                              child: e,
                            )
                          ],
                        ),
                      ),
                      StreamBuilder(
                        initialData: 0.0,
                        stream: s.hSG,
                        builder: (ctx, s) {
                          x = s.data;
                          return Align(
                            alignment: Alignment(s.data, 1),
                            child: d,
                          );
                        },
                      )
                    ],
                  ),
              ],
            ),
      ),
    );
  }
}

class S {
  StreamController hSC = StreamController<double>.broadcast(),
      bSC = StreamController<double>.broadcast();

  Sink get sS => hSC.sink;
  Sink get bS => bSC.sink;

  Stream<double> get hSG => hSC.stream;
  Stream<double> get bSG => bSC.stream;

  addValue(double v) {
    sS.add(v);
  }

  addBulletValue(double v) {
    bS.add(v);
  }

  voiddispose() {
    hSC.close();
    bSC.close();
  }
}

S s = S();
