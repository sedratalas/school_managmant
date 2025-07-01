import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton(
       {Key? key,
          this.text,
         this.color,
         this.width,
         this.height,
       }) : super(key: key,);
late double? width;
double? height;
Color? color;
Text? text;
   late double ScreenWidth;
   late double ScreenHeight;
  @override
  Widget build(BuildContext context) {
    ScreenWidth = MediaQuery.sizeOf(context).width;
    ScreenHeight = MediaQuery.sizeOf(context).height;
    return Container(
      width: ScreenWidth*(318/375),
      height: ScreenHeight*(60/812),
      decoration: BoxDecoration(
        color: color,
      ),
      child: Center(
        child: text,
        ),
    );
  }
}
