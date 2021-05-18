import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/page/home_page.dart';
import 'package:rider_app/page/login/register_page_1.dart';
import 'package:rider_app/page/login/relogin_page.dart';
import 'package:rider_app/ui/button.dart';
import 'package:rider_app/ui/color.dart';
import 'package:rider_app/ui/muti_formatter.dart';
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
  TextEditingController phone_ctrl = TextEditingController();
  SharedPreferences pref;
  Logger logger = Logger();
  String id_text;
  var phone_text;
  
  void initState() {
    super.initState();
    getCounterFromSharedPrefs();
  }

  getCounterFromSharedPrefs() async {
    SharedPreferences.getInstance().then((pref) {
      pref = pref;
      logger.d(pref.getString('serial'));
      if (pref.getString('serial') != null && pref.getString('serial') != '') {
        print('serial : ' + pref.getString('serial').toString());
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          height: screenSize.height,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: screenSize.width,
                  child: Column(
                    children: [
                      Container(
                        //padding: EdgeInsets.symmetric(vertical: 20),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          '마싯성딜리버리',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              fontFamily: 'cafe24',
                              color: AppColor.yellow),
                        ),
                      ),
                      Container(
                        child:
                        //Image.asset("assets/images/icon.png",
                        Image.asset("assets/images/icon_jinju.png",
                            width: screenSize.width / 5),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
                  width: screenSize.width,
                  child: MyTextField(
                    controller: phone_ctrl,
                    hintText: '휴대폰 번호를 입력해주세요',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.grey[400]),
                    inputType: TextInputType.number,
                    inputFormatters: [
                      MultiMaskedTextInputFormatter(masks: [
                        '010-xxxx-xxxx',
                        '01x-xxx-xxxx',
                        '01x-xxxx-xxxx'
                      ], separator: '-'),
                    ],
                    onChanged: (str){
                      var a = str.split("-");
                      phone_text='';
                      for (int i = 0; i < a.length; i++) {
                        phone_text += a[i];
                      }
                      print(phone_text);
                    },
                  ),
                ),
                MyButton(
                  height: 50,
                  width: screenSize.width - 40,
                  onPressed: () async {
                    widget.bloc.login(phone: phone_text).then((res) {
                      if (res.success) {
                        // pref.setString('serial', widget.bloc.user.serial);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    HomePage(widget.bloc)),
                            (route) => false);
                      } else {
                        if (res.code == 'E02') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ReLoginPage(bloc: widget.bloc, phone: phone_text,)));
                        }
                        Toast.show(res.errorMsg, context, duration: 2);
                      }
                    });

                    // await prefs.setString('uid', idtext);
                  },
                  color: Colors.white,
                  child: Text(
                    "로그인",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30, top: 10),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: AppColor.yellow))),
                      child: Text("앱 삭제 후 다시 로그인하시나요?",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          )),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReLoginPage(bloc:widget.bloc, phone: '',)));
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 40),
                  child: Text("아직 회원이 아니세요?",
                      style: TextStyle(fontSize: 14, color: AppColor.yellow)),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: screenSize.width,
                  height: 50,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: MyLineButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RegisterPage1(widget.bloc)));
                    },
                    color: AppColor.yellow,
                    child: Text("회원가입하기",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColor.yellow)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
