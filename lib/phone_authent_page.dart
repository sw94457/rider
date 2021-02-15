import 'package:flutter/material.dart';
import 'package:flutter_tttttttt/join_create_page.dart';

class PhoneAuthent extends StatefulWidget {
  @override
  _PhoneAuthentState createState() => _PhoneAuthentState();
}

class _PhoneAuthentState extends State<PhoneAuthent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color:  const Color(0xffFFE600), //change your color here
        ),
        title: Text('휴대폰 인증', style: TextStyle(fontSize: 20,color: const Color(0xffFFE600)),),
        centerTitle: true,
        backgroundColor: const Color(0xff20283E),
      ),

      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,29,0,0),
              child: Column(
                children: [
                  Center(
                    child: Text("휴대폰으로 인증코드를 받아\n전송된 인증코드를 입력해주세요.",textAlign: TextAlign.center ,
                              style: TextStyle(fontSize: 18, color: Colors.white,))
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,36,0,0),
                    child: SizedBox(
                      width: 312,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("핸드폰 번호 입력",style: TextStyle(fontSize: 16, color: Colors.white)),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0,17,0,16),
                              child: SizedBox(
                                height: 48,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(color: Colors.white),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2.0),
                                    ),
                                    hintText: "숫자만 입력하세요",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 312, height: 48,
                                child: RaisedButton(onPressed: (){},
                                  child: Text("인증코드 받기",style: TextStyle(fontSize: 18)), color: Colors.white,
                                )
                            )
                          ],
                        ),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,36,0,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("인증코드 입력",style: TextStyle(fontSize: 16, color: Colors.white)),
                          SizedBox(
                            width: 312,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,17,0,16),
                              child: SizedBox(
                                height: 48,
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
                            ),
                          ),
                          SizedBox(
                              width: 312, height: 48,
                              child: RaisedButton(onPressed: (){},
                                child: Text("인증코드 확인",style: TextStyle(fontSize: 18, color: Colors.white)),
                              )
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,8),
              child: SizedBox(
                  width: 344,
                  height: 56,
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => JoinCreate()));
                    },
                    child: Text("다음", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    color: const Color(0xffFFE600),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
