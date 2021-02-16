import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:ibagudelivery_rider/under_review_page.dart';

class JoinCreate extends StatefulWidget {
  @override
  _JoinCreateState createState() => _JoinCreateState();
}

class _JoinCreateState extends State<JoinCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: const Color(0xffFFE600), //change your color here
        ),
        title: Text('회원가입', style: TextStyle(color: const Color(0xffFFE600)),),
        centerTitle: true,
        backgroundColor: const Color(0xff20283E),
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,8,8,16),
                              child: Text("기본정보", style: TextStyle(fontSize: 20,color: const Color(0xffFFE600)) ,),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0,0,0,8),
                              child: Text("아이디 입력", style: TextStyle(fontSize: 18,color: Colors.white)),
                            ),
                            Container(
                              width: 312, height: 48,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    child: TextField(
                                      cursorColor: Colors.white,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      child: TextButton(onPressed: (){},
                                          child: Text('중복확인',style: TextStyle(color: const Color(0xffFFE600),decoration: TextDecoration.underline),)
                                      ), alignment: Alignment.centerRight
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0,3,0,0),
                              child: Text("6-12자 영문, 숫자로 입력해주세요.", style: TextStyle(fontSize: 12,color: const Color(0xffFFE600))
                              ),
                            ),
                          ],
                        )
                    ),
                    Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0,10,0,8),
                              child: Text("비밀번호 입력", style: TextStyle(fontSize: 18,color: Colors.white)),
                            ),
                            SizedBox(
                              width: 312, height: 48,
                              child: TextField(
                                cursorColor: Colors.white,
                                obscureText: true,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0,3,0,0),
                              child: Text("비밀번호는 8-20자로 입력해주세요.", style: TextStyle(fontSize: 12,color: const Color(0xffFFE600))
                              ),
                            ),
                          ],
                        )
                    ),
                    Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0,10,0,8),
                              child: Text("비밀번호 재입력", style: TextStyle(fontSize: 18,color: Colors.white)),
                            ),
                            SizedBox(
                              width: 312, height: 48,
                              child: TextField(
                                cursorColor: Colors.white,
                                obscureText: true,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,14,0,0),
                      child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0,0,0,8),
                                child: Text("라이더 정보", style: TextStyle(fontSize: 20,color: const Color(0xffFFE600))),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0,0,0,8),
                                child: SizedBox(
                                  width: 220,
                                  child: Row(
                                    children: [
                                      Text("프로필사진", style: TextStyle(fontSize: 18,color: Colors.white)),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(72,0,0,0),
                                        child: Text("면허증", style: TextStyle(fontSize: 18,color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 220,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Stack(
                                      children: [
                                        SizedBox(
                                          width: 80, height: 80,
                                          child: CircleAvatar(
                                              backgroundImage: AssetImage('images/profile.png')),
                                        ),
                                        Container(
                                          width: 80, height: 80,
                                          alignment: Alignment.bottomRight,
                                          child: CircleAvatar(
                                                backgroundImage: AssetImage('images/camera.png'),
                                                radius: 15),
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        SizedBox(
                                          width: 80, height: 80,
                                          child: CircleAvatar(
                                              backgroundImage: AssetImage('images/mask.png')),
                                        ),
                                        Container(
                                          width: 80, height: 80,
                                          alignment: Alignment.bottomRight,
                                          child: CircleAvatar(
                                              backgroundImage: AssetImage('images/camera.png'),
                                              radius: 15),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,10,0,8),
                                      child: Text("이름", style: TextStyle(fontSize: 18,color: Colors.white)),
                                    ),
                                    SizedBox(
                                      width: 312, height: 48,
                                      child: TextField(
                                        cursorColor: Colors.white,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 2.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 2.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                      ),
                    )
                  ]
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: 344, height: 56,
                    child: RaisedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UnderReview()));
                          },
                          child: Text("가입하기", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          color: const Color(0xffFFE600),
                        ),
                  )
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
