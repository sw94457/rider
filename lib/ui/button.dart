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
          child:
              RaisedButton(color: color, child: child, onPressed: onPressed)),
    );
  }
}

class MyLineButton extends StatelessWidget {
  Function onPressed;
  Widget child;
  Color color;
  double width;
  double height;

  MyLineButton(
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
        child: ElevatedButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.5)),
                backgroundColor: MaterialStateProperty.all<Color>(AppColor.navy),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: color)))),
            child: child,
            onPressed: onPressed),
      ),
    );
  }
}

class ChoiceBox extends StatelessWidget {
  var onTap;
  String text;
  var margin;

  ChoiceBox({this.onTap, this.text, this.margin=EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Padding(
      padding: margin,
      child: InkWell(
        child: Container(
          width: screen.width,
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.grey),
              borderRadius: BorderRadius.circular(5)),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 20),
              Text(text,
                  style: TextStyle(color: Colors.white)),
              Icon(Icons.arrow_drop_down, color: AppColor.yellow)
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

