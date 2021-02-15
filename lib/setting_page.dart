import 'package:flutter/material.dart';
import 'package:flutter_tttttttt/login_page.dart';
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
  var text1 = '문 앞에 두고 갑니다.';
  var text2 = '1분 후에 도착 예정입니다.';
  var text3 = '5분 후에 도착 예정입니다.';
  var text4 = '10분 후에 도착 예정입니다.';
  var text5 = '조금 늦을것 같습니다.';


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
                              child: Text('폰트 크기 설정',style: TextStyle(fontSize: 18,color: Colors.white),),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,24,0),
                            child: IconButton(
                              icon: Image.asset('images/${one1}.png'),
                              onPressed: (){
                                setState(() {
                                  _visible1 = !_visible1;
                                  if (_visible1 == true){
                                    one1 = 'left-one_a';
                                  } else {
                                    one1 = 'left-one';
                                  }
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Container(
                        child: Visibility(
                            visible: _visible1,
                            child: Column(
                              children: [
                                RadioListTile(
                                  title: Text('작은글씨',style: TextStyle(fontSize: 12,color: Colors.white),),
                                  value: Gender.SMALL,
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value;
                                    });
                                  },
                                  activeColor: Colors.white,
                                ),
                                RadioListTile(
                                  title: Text('중간글씨',style: TextStyle(fontSize: 14,color: Colors.white),),
                                  value: Gender.MIDDLE,
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value;
                                    });
                                  },
                                  activeColor: Colors.white,
                                ),
                                RadioListTile(
                                  title: Text('큰글씨',style: TextStyle(fontSize: 18,color: Colors.white),),
                                  value: Gender.BIG,
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value;
                                    });
                                  },
                                  activeColor: Colors.white,
                                ),
                              ],
                            )),
                      ),
                      Container( height:0.5,color: const Color(0x80DBDBDB)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16,8,0,10),
                            child: Container(
                              child: Text('알림설정',style: TextStyle(fontSize: 18,color: Colors.white),),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,24,0),
                            child: IconButton(
                              icon: Image.asset('images/${one2}.png'),
                              onPressed: (){
                                setState(() {
                                  _visible2 = !_visible2;
                                  if (_visible2 == true){
                                    one2 = 'left-one_a';
                                  } else {
                                    one2 = 'left-one';
                                  }
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Container(
                        child: Visibility(
                            visible: _visible2,
                            child: Row(
                              children: [
                                Switch(
                                  value: _isChecked,
                                  onChanged: (value){
                                    setState(() {
                                      _isChecked = value;
                                    });
                                  },
                                  inactiveTrackColor: const Color(0xff20283E),
                                  inactiveThumbColor: const Color(0xff595959),
                                  activeColor: Colors.white,
                                ),
                                Text('신규 주문 알림팝업 허용',style: TextStyle(fontSize: 14,color: Colors.white),),
                              ],
                            )),
                      ),
                      Container( height:0.5,color: const Color(0x80DBDBDB)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16,8,0,10),
                            child: Container(
                              child: Text('주소보기',style: TextStyle(fontSize: 18,color: Colors.white),),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,24,0),
                            child: IconButton(
                              icon: Image.asset('images/${one3}.png'),
                              onPressed: (){
                                setState(() {
                                  _visible3 = !_visible3;
                                  if (_visible3 == true){
                                    one3 = 'left-one_a';
                                  } else {
                                    one3 = 'left-one';
                                  }

                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Container(
                        child: Visibility(
                            visible: _visible3,
                            child: Column(
                              children: [
                                RadioListTile(
                                  title: Text('구주소',style: TextStyle(fontSize: 14,color: Colors.white),),
                                  value: Gender1.OAddress,
                                  groupValue: _gender1,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender1 = value;
                                    });
                                  },
                                  activeColor: Colors.white,
                                ),
                                RadioListTile(
                                  title: Text('신주소',style: TextStyle(fontSize: 14,color: Colors.white),),
                                  value: Gender1.NAddress,
                                  groupValue: _gender1,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender1 = value;
                                    });
                                  },
                                  activeColor: Colors.white,
                                ),
                              ],
                            )),
                      ),
                      Container( height:0.5,color: const Color(0x80DBDBDB)),
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
                              icon: Image.asset('images/${one4}.png'),
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
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Loginpage()), (route) => false);
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,16,0,0),
                    child: Text('현재버전 10.1.1',style: TextStyle(fontSize: 12,color: Colors.white),textAlign: TextAlign.center,),
                  )
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
                        onTap: (){
                          setState(() {
                            switch(sn){
                              case 1:
                                text1=myController.text;
                                break;
                              case 2:
                                text2=myController.text;
                                break;
                              case 3:
                                text3=myController.text;
                                break;
                              case 4:
                                text4=myController.text;
                                break;
                              case 5:
                                text5=myController.text;
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


}

