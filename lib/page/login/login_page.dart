import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/page/home_page.dart';
import 'package:rider_app/page/login/find_tab_page.dart';
import 'package:rider_app/page/login/register_page_1.dart';
import 'package:rider_app/ui/button.dart';
import 'package:rider_app/ui/color.dart';
import 'package:rider_app/ui/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  Bloc bloc;

  LoginPage(this.bloc);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController id_ctrl = TextEditingController();
  TextEditingController phone_ctrl = TextEditingController();

  String id_text;

  void initState() {
    super.initState();
    getCounterFromSharedPrefs();
  }

  getCounterFromSharedPrefs() async {
    SharedPreferences.getInstance().then((pref) {
      if (pref.getString('serial') != null && pref.getString('serial') != '') {
        widget.bloc.autoLogin(serial: pref.getString('serial')).then((res) {
          if (res.success) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomePage(widget.bloc)));
          } else {
            pref.clear();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.navy,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenSize.width,
            child: Column(
              children: [
                Container(
                  child: Text(
                    '부산동구딜리버리',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 38,
                        fontFamily: 'cafe24',
                        color: AppColor.yellow),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset("assets/images/icon.png",
                      width: screenSize.width/5),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: screenSize.width,
              child: MyTextField(
                textEditingController: phone_ctrl,
                hintText: '휴대폰 번호를 입력해주세요',
                hintStyle: TextStyle(fontSize: 20, color: Colors.grey[400]),
              )),
          MyButton(
            //margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            height: 56,
            width: screenSize.width-40,
            onPressed: () async {
              widget.bloc.login(id: id_ctrl.text, pw: phone_ctrl.text).then((res) {
                if (res.success) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (BuildContext context) =>
                          HomePage(widget.bloc)), (route) => false);
                } else {
                  Toast.show(res.errorMsg, context);
                }
              });

              // await prefs.setString('uid', idtext);
            },
            color: Colors.white,
            child: Text("로그인",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            child: Text(
              '아이디/비밀번호 찾기',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  decoration: TextDecoration.underline),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FindPage(widget.bloc)));
            },
          ),
          Container(
            padding: EdgeInsets.only(top: 40),
            child: Text("아직 회원이 아니세요?",
                style: TextStyle(fontSize: 16, color: AppColor.yellow)),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: screenSize.width,
            height: 56,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: OutlineButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterPage1(widget.bloc)));
              },
              color: AppColor.yellow,
              child: Text("회원가입하기",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.yellow)),
              borderSide: BorderSide(color: AppColor.yellow),
            ),
          )
        ],
      ),
    );
  }
}