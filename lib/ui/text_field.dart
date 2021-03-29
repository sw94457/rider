import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rider_app/ui/color.dart';

/*
텍스트필드 ui
 */

class MyTextField extends StatelessWidget {
  TextEditingController textEditingController;
  Function onChanged;
  String hintText;
  double width;
  double height;
  TextStyle hintStyle;
  EdgeInsets margin;
  EdgeInsets padding;
  double left;
  TextInputType inputType;
  int maxLength;
  int maxLine;
  Color backgroundColor;
  Color color;
  List<TextInputFormatter> inputFormatters;

  bool obscureText;
  var contentPadding;

  MyTextField(
      {@required this.textEditingController,
        this.onChanged,
        this.width,
        this.height = 48,
        this.hintText,
        this.hintStyle = const TextStyle(fontSize: 12, color: Colors.white54),
        this.margin = const EdgeInsets.only(top: 5, bottom: 5),
        this.padding = const EdgeInsets.all(0),
        this.contentPadding = const EdgeInsets.only(left: 20),
        this.inputType,
        this.maxLength,
        this.maxLine = 1,
        this.backgroundColor = AppColor.navy,
        this.color = Colors.white,
        this.inputFormatters,

        this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: height,
      width: width == null ? screenSize.width : width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: this.backgroundColor),
      child: TextFormField(
        cursorColor: color == Colors.white70 ? AppColor.yellow : color,
        style: TextStyle(color: Colors.white),
        obscureText: obscureText,
        maxLines: maxLine,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          contentPadding: contentPadding,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: color, width: 1.0),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color, width: 1.0),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color, width: 1.0),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
        controller: textEditingController,
        onChanged: onChanged,
        keyboardType: inputType,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
      ),
    );
  }
}