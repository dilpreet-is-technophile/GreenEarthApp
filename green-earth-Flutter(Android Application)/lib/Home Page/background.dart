import 'package:flutter/material.dart';
import 'dart:ui' as ui;

const Color backGround = Color(0xFF073730);
const Color circle_color = Color(0xFFAAC97B);


class circleDraw extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: CustomPaint(
          painter: DrawFig(context: context),
        ),
      ),

    );
  }
}

class DrawFig extends CustomPainter{
  final BuildContext context;

  DrawFig({this.context});
  void paint(Canvas canvas, Size size) {

    Paint paint =Paint()
      ..shader=ui.Gradient.linear(
        Offset(0,0),
        Offset(1000,2000),
        [
          circle_color,
          Colors.white.withOpacity(0.3),

        ],

      );
    //1
    canvas.drawCircle(Offset(MediaQuery.of(context).size.width/1.03, MediaQuery.of(context).size.height/26),60,paint);
    //2
    canvas.drawArc(Rect.fromCircle(center: Offset(0, MediaQuery.of(context).size.height/3.2), radius: 55),4.71,3.14, true, paint);

    //3
    canvas.drawCircle(Offset(MediaQuery.of(context).size.width+22,MediaQuery.of(context).size.height/1.9),58, paint);
    //4
    canvas.drawCircle(Offset(MediaQuery.of(context).size.width-265,MediaQuery.of(context).size.height/1.25 ),40, paint);
    //5
    canvas.drawCircle(Offset(MediaQuery.of(context).size.width+60, MediaQuery.of(context).size.height/0.95),180, paint);



  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class backLinear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops:[0.0, 0.7,0.9],
            colors: [
              backGround.withGreen(50),
              backGround.withOpacity(0.95),
              backGround.withOpacity(0.95),
              // backGround,
            ]
        )
    ),
    );
  }
}


