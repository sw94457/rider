import 'package:flutter/material.dart';

class AccountManagement extends StatefulWidget {
  @override
  _AccountManagementState createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
        backgroundColor: const Color(0xff20283E),
        title: Text('출금계좌관리',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color(0xffFFE600))),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xffFFE600)),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: 328,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('예금주',style: TextStyle(fontSize: 18,color: Colors.white),),
                              TextField(
                                decoration: new InputDecoration(focusColor: Colors.white,
                                ),
                                style: TextStyle(color: Colors.white,),
                                )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 328,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('은행',style: TextStyle(fontSize: 18,color: Colors.white),),
                                TextField(
                                  style: TextStyle(color: Colors.white,),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 328,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('계좌번호',style: TextStyle(fontSize: 18,color: Colors.white),),
                              TextField(
                                style: TextStyle(color: Colors.white,),

                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: 344,
                  height: 56,
                  child: RaisedButton(
                    onPressed: (){
                      _showDialog1();
                    },
                    child: Text("계좌등록", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    color: const Color(0xffFFE600),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
  void _showDialog1() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: const Color(0xff3B4255),
            content: Container(
              width: 328, height: 140,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,38),
                    child: Text('계좌를 등록하시겠습니까?',style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 110, height: 48,
                        child: OutlineButton(onPressed: (){
                          Navigator.pop(context);
                        },
                          child: Text('취소',style: TextStyle(fontSize: 24,color: Colors.white),),
                          color: const Color(0xff3B4255),
                          borderSide: BorderSide(
                              color: Colors.white, width: 2
                          ),
                        ),
                      ),

                      Container(
                        width: 110, height: 48,
                        child: RaisedButton(onPressed: (){
                          Navigator.pop(context);
                          _showDialog2();
                        },
                          child: Text('확인',style: TextStyle(fontSize: 24),),
                          color: const Color(0xffFFE600),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
        );
      },
    );
  }
  void _showDialog2() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: const Color(0xff3B4255),
            content: Container(
              height: 140,
              child: Row(
                children: [
                  Image.asset('images/ch.png',width: 24, height: 24,),
                  Text('계좌가 등록되었습니다.',style: TextStyle(fontSize: 20,color: Colors.white),),
                ],
              ),
            )
        );
      },
    );
  }
}