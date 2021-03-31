import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Confetti extends StatefulWidget {
  @override
  _ConfettiState createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti> {
  ConfettiController _controllerCenterRight;
  ConfettiController _controllerCenterLeft;

  @override
  void initState() {
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 4));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 4));
    _controllerCenterLeft.play();
    _controllerCenterRight.play();
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.only(top: 50.0),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Align(alignment:Alignment.topCenter,child: Container(height:100.0,width: 100.0,child: Image.asset("assets/images/tickk.gif"))),
                    SizedBox(height: 50.0,),
                    Text("Congrats! Your photo has been successfully submitted for date",textAlign:TextAlign.center,style: TextStyle(fontSize: 22.0,color: Colors.black54),),
                    SizedBox(height: 50.0,),
                    Text("${DateFormat('yyyy-MM-dd').format(DateTime.now())}",style: TextStyle(fontWeight: FontWeight.bold,fontSize:30.0),),
                    SizedBox(height: 180.0,),
                    FloatingActionButton(
                      backgroundColor: Colors.grey[400],
                      elevation: 0.0,
                        onPressed:(){
                        Navigator.of(context).pop();
                      },
                        child: Icon(Icons.clear_rounded)
                    )
                  ]
                ),
                  Stack(
                    children: <Widget>[
                      Align(
                      alignment: Alignment.centerLeft,
                      child: ConfettiWidget(
                        blastDirectionality: BlastDirectionality.explosive,
                        maxBlastForce: 15,
                        confettiController: _controllerCenterLeft,
                        blastDirection: 170,
                        particleDrag: 0.05,
                        emissionFrequency: 0.05,
                        numberOfParticles: 20,
                        gravity: 0.2,
                      ),
                    ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ConfettiWidget(
                          blastDirectionality: BlastDirectionality.explosive,
                          maxBlastForce: 15,
                          confettiController: _controllerCenterRight,
                          blastDirection: 350,
                          particleDrag: 0.05,
                          emissionFrequency: 0.05,
                          numberOfParticles: 40,
                          gravity: 0.2,
                        ),
                      ),
                    ]
                  )
                ]
              ),
          ),
        ),
      ),
    );
  }
}
