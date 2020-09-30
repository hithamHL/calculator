import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;

  MyButton({this.color, this.textColor, this.buttonText,this.buttonTapped});


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: buttonTapped ,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(//round rectangle
          borderRadius: BorderRadius.circular(20),
            child: Container(
              color: color,//container fill color for single button
              child: Center(
                child: Text(
                  buttonText,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: textColor,
                  fontSize: 24,),

                ),
              ) ,
            )),
      ),
    );
  }


}
