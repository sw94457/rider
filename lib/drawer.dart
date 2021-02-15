import 'package:flutter/material.dart';
import 'package:flutter_tttttttt/personal_information_page.dart';
import 'package:flutter_tttttttt/setting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'account_create_page.dart';
import 'calculate_page.dart';
import 'notice_page.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  SharedPreferences prefs;
  String _uid;

  @override
  void initState() {
    super.initState();

    getCounterFromSharedPrefs();

  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xff20283E),
        child: ListView(
          padding: EdgeInsets.zero ,
          children: [
            SizedBox(
              height: 225,
              child: DrawerHeader(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width:45, height: 45,
                          child: CircleAvatar(
                              backgroundImage: AssetImage('images/profile.png')
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${_uid} 라이더님',
                                  style: TextStyle(fontSize: 18, color: Colors.white)),
                              Text('오늘도 안전운전하세요:)',
                                  style: TextStyle(fontSize: 16, color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 280,
                      child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset("images/edit.png"),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalInformation()));
                              }, child: Text("개인정보수정",
                                  style: TextStyle(fontSize: 14, color: const Color(0xffFFE600)),textAlign: TextAlign.end))
                            ],
                          )
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            width: 124, height: 56,
                            child: RaisedButton(onPressed: (){},child: Text("출근하기",
                                style: TextStyle(fontSize: 14, color: Colors.white)),
                              color: Colors.white12,
                            )
                        ),
                        SizedBox(
                            width: 124, height: 56,
                            child: RaisedButton(onPressed: (){},child: Text("퇴근하기",
                                style: TextStyle(fontSize: 14)),
                              color: const Color(0xffFFE600),
                            )
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container( height:2.0,color:Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset("images/Group 67.png", width: 24, height: 24,),
                  SizedBox(width: 4,),
                  Text('정산', style: TextStyle(fontSize: 14,color: Colors.white)),
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Calculate()));
              },
            ),
            Container( height:0.5,color:Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset("images/data-two.png", width: 24, height: 24,),
                  SizedBox(width: 4,),
                  Text('출금 계좌 관리', style: TextStyle(fontSize: 14,color: Colors.white)),
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AccountCreate()));
              },
            ),
            Container( height:0.5,color:Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset("images/attention.png", width: 24, height: 24,),
                  SizedBox(width: 4,),
                  Text('공지사항', style: TextStyle(fontSize: 14,color: Colors.white)),
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Notice()));
              },
            ),
            Container( height:0.5,color:Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset("images/uil_setting.png", width: 24, height: 24,),
                  SizedBox(width: 4,),
                  Text('환경설정', style: TextStyle(fontSize: 14,color: Colors.white)),
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Setting()));
              },
            ),
            Container( height:0.5,color:Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset("images/Vector.png", width: 24, height: 24,),
                  SizedBox(width: 4,),
                  Text('고객센터', style: TextStyle(fontSize: 14,color: Colors.white)),
                ],
              ),
              onTap: (){},
            ),
            Container( height:0.5,color:Colors.white60),
          ],
        ),
      ),
    );
  }

  getCounterFromSharedPrefs() async {
    // 인스턴스를 가져오고
    prefs = await SharedPreferences.getInstance();
    setState(() {
      // 카운터를 가져옵니다.값이 없다면 0을 넣어줍니다.
      _uid = prefs.getString('uid') ?? '김동구';
    });
  }
}
