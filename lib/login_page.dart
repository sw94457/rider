import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/access_terms_page.dart';
import 'package:ibagudelivery_rider/bloc/bloc.dart';
import 'package:ibagudelivery_rider/find_tab_page.dart';
import 'package:ibagudelivery_rider/tab_page.dart';
import 'package:ibagudelivery_rider/ui/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Loginpage extends StatefulWidget {
  Bloc bloc;

  Loginpage(this.bloc);

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController id = TextEditingController();
  TextEditingController pw = TextEditingController();

  String idtext;

  void initState() {
    super.initState();
    getCounterFromSharedPrefs();

  }
  getCounterFromSharedPrefs() async {
    SharedPreferences.getInstance().then((pref){
      if(pref.getString('serial')!=null&&pref.getString('serial')!=''){
        widget.bloc.autoLogin(serial: pref.getString('serial')).then((res){
          if(res.success){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => TabPage(widget.bloc)));
          }
          else{
            pref.clear();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff20283E),
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(43, 32, 43, 49),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: Container(
                      child: Text(
                        '부산동구딜리버리',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                            color: AppColor.yellow),
                      ),
                    ),
                  ),
                  Container(
                      child: Image.asset(
                    "images/logo_s.png",
                    width: 81,
                    height: 49,
                  ))
                ],
              ),
            ),
          ),
          Container(
            width: 312,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                  child: TextField(
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        hintText: "아이디를 입력해주세요",
                        hintStyle: TextStyle(color: Colors.white)),
                    style: TextStyle(color: Colors.white),
                    controller: id,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 41),
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        hintText: "비밀번호를 입력해주세요",
                        hintStyle: TextStyle(color: Colors.white)),
                    controller: pw,
                  ),
                ),
                SizedBox(
                  height: 56,
                  width: 312,
                  child: RaisedButton(
                    onPressed: () async {
                      idtext = id.text;
                      widget.bloc.login(id: id.text, pw: pw.text).then((res) {
                        if(res.success){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => TabPage(widget.bloc)));
                        }else{
                          Toast.show(res.errorMsg,context);
                        }
                      });

                      // await prefs.setString('uid', idtext);
                    },
                    color: Colors.white,
                    child: Text("로그인",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FindTab()));
                  },
                      child: Text('아이디/비밀번호 찾기',style: TextStyle(fontSize: 18,color: Colors.white,decoration:
                  TextDecoration.underline),)),
                )
                
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 84, 0, 0),
                  child: Text("아직 회원이 아니세요?",
                      style: TextStyle(fontSize: 16, color: AppColor.yellow)),
                ),
                Container(
                  width: 312,
                  height: 56,
                  margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: OutlineButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AaccessTerms(widget.bloc)));
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
          )
        ],
      )),
    );
  }
}
