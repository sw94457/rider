import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tttttttt/access_terms_page.dart';
import 'package:flutter_tttttttt/tab_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}



class _LoginpageState extends State<Loginpage> {
  final _idtextcon = TextEditingController();
  final _passtextcon = TextEditingController();

  SharedPreferences prefs;

  String idtext;

  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      backgroundColor: const Color(0xff20283E),
      body: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(43,32,43,49),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,16),
                        child: Container(
                          child: Text(
                            '부산동구딜리버리',
                            style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 36,
                                color: const Color(0xffFFE600)),
                          ),
                        ),
                      ),
                      Container(
                          child: Image.asset("images/logo_s.png", width: 81, height: 49,))
                    ],
                  ),
                ),
              ),
              Container(
                width: 312,
                child: Column (
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,16),
                      child: TextField(
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 2.0),
                          ),
                          hintText: "아이디를 입력해주세요", hintStyle: TextStyle(color: Colors.white)
                        ),
                        style: TextStyle(color: Colors.white),
                        controller: _idtextcon,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,41),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white, width: 2.0),
                            ),
                            hintText: "비밀번호를 입력해주세요",
                            hintStyle: TextStyle(color: Colors.white)
                            ),
                        controller: _passtextcon,
                      ),
                    ),
                    SizedBox(
                      height: 56,
                      width: 312,
                      child: RaisedButton(
                        onPressed: () async {

                          idtext = _idtextcon.text;

                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setString('uid', idtext);

                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TabPage()));
                        },
                        color: Colors.white,
                        child: Text("로그인",style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold,) ),

                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,104,0,0),
                      child: Text("아직 회원이 아니세요?", style: TextStyle(fontSize: 16 ,color: const Color(0xffFFE600))),
                    ),
                    SizedBox(
                      width: 312,
                      height: 56,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,19,0,0),
                        child: OutlineButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AaccessTerms()));
                        },
                          color: const Color(0xff20283E),
                          child: Text("회원가입하기",style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold, color: const Color(0xffFFE600))),
                          borderSide: BorderSide(
                            color: const Color(0xffFFE600)
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}