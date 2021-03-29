import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rider_app/ui/color.dart';

class MyButton extends StatelessWidget {
  Function onPressed;
  Widget child;
  Color color;
  double width;
  double height;

  MyButton(
      {this.onPressed,
      this.child,
      this.color = AppColor.yellow,
      this.width,
      this.height = 48});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(splashColor: Colors.black.withOpacity(0.3)),
      child: SizedBox(
          width: width,
          height: height,
          child: RaisedButton(color: color, child: child, onPressed: onPressed)),
    );
  }
}
