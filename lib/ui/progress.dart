import 'package:flutter/material.dart';
import 'package:rider_app/ui/color.dart';

Widget ProgressPage(width) {
  return Container(
    width: width,
    alignment: Alignment.center,
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              strokeWidth: 7,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xffc4c4c4)),
            ),
          ),
          SizedBox(height: 50),
          Text('잠시만 기다려주세요',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text('해당 페이지로 이동 중입니다.', style: TextStyle(fontSize: 14, color: Colors.grey)),
          SizedBox(height:150),
        ],
      ),
    ),
  );
}

Widget ErrorPage({width, text = '', subtext = ''}) {
  return Container(
    padding: EdgeInsets.only(top: 100),
    alignment: Alignment.topCenter,
    child: Column(
      children: [
        Container(
            height: 60,
            margin: EdgeInsets.all(10),
            child: Image.asset('assets/images/ic_error.png')),
        Text(text,
            style: TextStyle(
                fontSize: 20,
                color: AppColor.grey,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Text(subtext, style: TextStyle(fontSize: 14)),
      ],
    ),
  );
}
