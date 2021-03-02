import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}
enum Gender {SMALL, MIDDLE, BIG}
enum Gender1 {NAddress, OAddress}


class _SettingState extends State<Setting>  {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final myController = TextEditingController();



  Gender _gender = Gender.MIDDLE;
  Gender1 _gender1 = Gender1.NAddress;

  bool _visible1 = false;
  bool _visible2 = false;
  bool _visible3 = false;
  bool _visible4 = false;
  var one1 = 'left-one';
  var one2 = 'left-one';
  var one3 = 'left-one';
  var one4 = 'left-one';
  var _isChecked = false;

  var sn = 0;
  var text1;
  var text2;
  var text3;
  var text4;
  var text5;


  @override
  void initState() {
    super.initState();

    getCounterFromSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
        backgroundColor: const Color(0xff20283E),
        title: Text('환경설정',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color(0xffFFE600))),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xffFFE600)),
      ),

      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16,0,0,0),
                            child: Container(
                              child: Text('간편메세지 설정',style: TextStyle(fontSize: 18,color: Colors.white),),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,24,0),
                            child: IconButton(
                              icon: Image.asset('images/${one4}.png',width: 16,),
                              onPressed: (){
                                setState(() {
                                  _visible4 = !_visible4;
                                  if (_visible4 == true){
                                    one4 = 'left-one_a';
                                  } else {
                                    one4 = 'left-one';
                                  }

                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Container(
                        child: Visibility(
                            visible: _visible4,
                            child: Column(
                              children: [
                                Container(
                                  width: 312,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 246,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30), //모서리를 둥글게
                                          border: Border.all(color: Colors.white, width: 1),),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(4,0,0,2),
                                          child: Text('${text1}',style: TextStyle(fontSize: 14,color: Colors.white),),
                                        ),

                                      ),
                                      InkWell(child: Image.asset('images/edit_m.png',width: 58, height: 24,),
                                      onTap: (){
                                        sn=1;
                                        myController.text = text1;
                                        _showDialog1();
                                      },
                                      )
                                    ],
                                  ),

                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 312,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 246,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30), //모서리를 둥글게
                                            border: Border.all(color: Colors.white, width: 1),),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(4,0,0,2),
                                            child: Text('${text2}',style: TextStyle(fontSize: 14,color: Colors.white),),
                                          ),

                                        ),
                                        InkWell(child: Image.asset('images/edit_m.png',width: 58, height: 24,),
                                          onTap: (){
                                            sn=2;
                                            myController.text = text2;
                                            _showDialog1();
                                          },
                                        )
                                      ],
                                    ),

                                  ),
                                ),
                                Container(
                                  width: 312,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 246,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30), //모서리를 둥글게
                                          border: Border.all(color: Colors.white, width: 1),),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(4,0,0,2),
                                          child: Text('${text3}',style: TextStyle(fontSize: 14,color: Colors.white),),
                                        ),

                                      ),
                                      InkWell(child: Image.asset('images/edit_m.png',width: 58, height: 24,),
                                        onTap: (){
                                          sn=3;
                                          myController.text = text3;
                                          _showDialog1();
                                        },
                                      )
                                    ],
                                  ),

                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 312,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 246,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30), //모서리를 둥글게
                                            border: Border.all(color: Colors.white, width: 1),),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(4,0,0,2),
                                            child: Text('${text4}',style: TextStyle(fontSize: 14,color: Colors.white),),
                                          ),

                                        ),
                                        InkWell(child: Image.asset('images/edit_m.png',width: 58, height: 24,),
                                          onTap: (){
                                            sn=4;
                                            myController.text = text4;
                                            _showDialog1();
                                          },
                                        )
                                      ],
                                    ),

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,0,8),
                                  child: Container(
                                    width: 312,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 246,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30), //모서리를 둥글게
                                            border: Border.all(color: Colors.white, width: 1),),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(4,0,0,2),
                                            child: Text('${text5}',style: TextStyle(fontSize: 14,color: Colors.white),),
                                          ),

                                        ),
                                        InkWell(child: Image.asset('images/edit_m.png',width: 58, height: 24,),
                                          onTap: (){
                                            sn=5;
                                            myController.text = text5;
                                            _showDialog1();
                                          },
                                        )
                                      ],
                                    ),

                                  ),
                                ),
                              ],
                            )),
                      ),
                      Container( height:0.5,color: const Color(0x80DBDBDB)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8,0,0,0),
                            child: Container(
                              child: TextButton(
                                child: Text('로그아웃',style: TextStyle(fontSize: 18,color: Colors.white),),
                                onPressed: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.remove('uid');
                                  Navigator.pop(context);
                                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                  //     builder: (BuildContext context) =>
                                  //         Loginpage()), (route) => false);
                                },
                              )

                            ),
                          ),
                        ],
                      ),
                      Container( height:0.5,color: const Color(0x80DBDBDB)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16,8,0,10),
                            child: Container(
                              child: Text('회원탈퇴',style: TextStyle(fontSize: 18,color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                      Container( height:0.5,color: const Color(0x80DBDBDB)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16,8,0,0),
                            child: Container(
                              child: Text('버전정보',style: TextStyle(fontSize: 18,color: Colors.white),),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,8,24,0),
                            child: Container(
                              child: Text('현재버전 1.1.0',style: TextStyle(fontSize: 14,color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16,0,0,37),
              child: Column(
                children: [
                  Container(
                    width: 328,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('주식회사',style: TextStyle(fontSize: 12,color: Colors.white),),
                        Text('개인정보',style: TextStyle(fontSize: 12,color: Colors.white),),
                        Text('사업자등록번호',style: TextStyle(fontSize: 12,color: Colors.white),),
                        Text('주소',style: TextStyle(fontSize: 12,color: Colors.white),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog1() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: const Color(0xff3B4255),
            content: Container(
              height: 280,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(child: Text('취소',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color(0xffFFE600)),),
                        onTap: (){
                          Navigator.pop(context);
                        },
                        ),
                        InkWell(child: Text('완료',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color(0xffFFE600)),),
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          setState(() {
                            switch(sn)  {
                              case 1:
                                text1=myController.text;
                                prefs.setString('simpletext1', text1);
                                break;
                              case 2:
                                text2=myController.text;
                                prefs.setString('simpletext2', text2);
                                break;
                              case 3:
                                text3=myController.text;
                                prefs.setString('simpletext3', text3);
                                break;
                              case 4:
                                text4=myController.text;
                                prefs.setString('simpletext4', text4);
                                break;
                              case 5:
                                text5=myController.text;
                                prefs.setString('simpletext5', text5);
                                break;
                              default:
                                break;
                            }
                          });
                          Navigator.pop(context);
                        },
                        )
                      ],
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), //모서리를 둥글게
                        border: Border.all(color: Colors.white, width: 1),),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: myController,
                      ),
                    ),
                  Container(

                  )
                ],
              ),
            )
        );
      },
    );
  }

  getCounterFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      text1 = prefs.getString('simpletext1') ?? '문 앞에 두고 갑니다.';
      text2 = prefs.getString('simpletext2') ?? '1분 후에 도착 예정입니다.';
      text3 = prefs.getString('simpletext3') ?? '5분 후에 도착 예정입니다.';
      text4 = prefs.getString('simpletext4') ?? '10분 후에 도착 예정입니다.';
      text5 = prefs.getString('simpletext5') ?? '조금 늦을것 같습니다.';
    });
  }


}

