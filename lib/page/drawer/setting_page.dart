import 'package:flutter/material.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/page/login/login_page.dart';
import 'package:rider_app/ui/color.dart';
import 'package:rider_app/ui/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  Bloc bloc;

  SettingPage(this.bloc);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final message1_ctrl = TextEditingController();
  final message2_ctrl = TextEditingController();
  final message3_ctrl = TextEditingController();
  final message4_ctrl = TextEditingController();
  final message5_ctrl = TextEditingController();
  bool isClick = false;

  bool _visibletext = false;
  bool _visible4 = false;

  var _textcolor = Colors.white;

  var one4 = 'left-one';

  var sn = 0;
  var text1;
  var text2;
  var text3;
  var text4;
  var text5;
  var textcounter;

  @override
  void initState() {
    super.initState();

    getCounterFromSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        title: Text('환경설정',
            style: TextStyle(
                // fontSize: 24,
                // fontWeight: FontWeight.bold,
                color: AppColor.yellow)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.yellow),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: Container(
        height: screenSize.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        InkWell(
                          child: Container(
                            width: screenSize.width,
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey))
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '간편메세지 설정',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 25,
                                      child: isClick?
                                          Image.asset('assets/images/arrow_bottom.png'):
                                          Image.asset('assets/images/arrow_top.png'),
                                    )
                                  ],
                                ),
                                !isClick?
                                Container(
                                  width: screenSize.width-40,
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyTextField(
                                        width: screenSize.width-120,
                                        height: 50,
                                        color: Colors.white,
                                        backgroundColor: AppColor.navy,
                                        textEditingController: message1_ctrl,
                                      ),
                                      SizedBox(
                                        width: 70,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10))),
                                                  backgroundColor:
                                              MaterialStateProperty.all<Color>(Colors.white),
                                              overlayColor: MaterialStateProperty.all<Color>(
                                                  Colors.black.withOpacity(0.5)),
                                          ),
                                          child: Text('수정',style: TextStyle(color: AppColor.navy,
                                              fontSize: 17),
                                          ),
                                          onPressed: () {

                                            },
                                        ),
                                      ),
                                    ],
                                  ),
                                ):SizedBox(),
                                !isClick?
                                Container(
                                  width: screenSize.width-40,
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyTextField(
                                        width: screenSize.width-120,
                                        height: 50,
                                        color: Colors.white,
                                        backgroundColor: AppColor.navy,
                                        textEditingController: message2_ctrl,
                                      ),
                                      SizedBox(
                                        width: 70,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10))),
                                            backgroundColor:
                                            MaterialStateProperty.all<Color>(Colors.white),
                                            overlayColor: MaterialStateProperty.all<Color>(
                                                Colors.black.withOpacity(0.5)),
                                          ),
                                          child: Text('수정',style: TextStyle(color: AppColor.navy,
                                              fontSize: 17),
                                          ),
                                          onPressed: () {

                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ):SizedBox(),
                                !isClick?
                                Container(
                                  width: screenSize.width-40,
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyTextField(
                                        width: screenSize.width-120,
                                        height: 50,
                                        color: Colors.white,
                                        backgroundColor: AppColor.navy,
                                        textEditingController: message3_ctrl,
                                      ),
                                      SizedBox(
                                        width: 70,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10))),
                                            backgroundColor:
                                            MaterialStateProperty.all<Color>(Colors.white),
                                            overlayColor: MaterialStateProperty.all<Color>(
                                                Colors.black.withOpacity(0.5)),
                                          ),
                                          child: Text('수정',style: TextStyle(color: AppColor.navy,
                                              fontSize: 17),
                                          ),
                                          onPressed: () {

                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ):SizedBox(),
                                !isClick?
                                Container(
                                  width: screenSize.width-40,
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyTextField(
                                        width: screenSize.width-120,
                                        height: 50,
                                        color: Colors.white,
                                        backgroundColor: AppColor.navy,
                                        textEditingController: message4_ctrl,
                                      ),
                                      SizedBox(
                                        width: 70,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10))),
                                            backgroundColor:
                                            MaterialStateProperty.all<Color>(Colors.white),
                                            overlayColor: MaterialStateProperty.all<Color>(
                                                Colors.black.withOpacity(0.5)),
                                          ),
                                          child: Text('수정',style: TextStyle(color: AppColor.navy,
                                              fontSize: 17),
                                          ),
                                          onPressed: () {

                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ):SizedBox(),
                                !isClick?
                                Container(
                                  width: screenSize.width-40,
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyTextField(
                                        width: screenSize.width-120,
                                        height: 50,
                                        color: Colors.white,
                                        backgroundColor: AppColor.navy,
                                        textEditingController: message5_ctrl,
                                      ),
                                      SizedBox(
                                        width: 70,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10))),
                                            backgroundColor:
                                            MaterialStateProperty.all<Color>(Colors.white),
                                            overlayColor: MaterialStateProperty.all<Color>(
                                                Colors.black.withOpacity(0.5)),
                                          ),
                                          child: Text('수정',style: TextStyle(color: AppColor.navy,
                                              fontSize: 17),
                                          ),
                                          onPressed: () {

                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ):SizedBox(),
                              ],
                            ),
                          ),
                          onTap: (){
                            setState(() {
                              isClick = !isClick;
                            });
                          },
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                            width: screenSize.width,
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey))
                            ),
                            child: Text('로그아웃',
                            style: TextStyle(
                              fontSize: 20, color: Colors.white),
                            ),
                          ),
                          onTap: () async {
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            prefs.remove('uid');
                            Navigator.pop(context);
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginPage(widget.bloc)), (route) => false);
                          },
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                            width: screenSize.width,
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey))
                            ),
                            child: Text('회원 탈퇴',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                          onTap: () {},
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '버전정보',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                '현재버전 1.1.0',
                                style: TextStyle(
                                    fontSize: 18, color: AppColor.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                width: screenSize.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('주식회사 타키 ㅣ 대표자 : 노성환\n'
                    '개인정보보호책임자 : 노성환\n'
                    '사업자등록번호 : 645-87-01111\n'
                    '주소 : 부산시 부산진구 광평로211 1018호',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog1() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
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
                          InkWell(
                            child: Text(
                              '취소',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xffFFE600)),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          InkWell(
                            child: Text(
                              '완료',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xffFFE600)),
                            ),
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              setState(() {
                                switch (sn) {
                                  case 1:
                                    text1 = message1_ctrl.text;
                                    prefs.setString('simpletext1', text1);
                                    break;
                                  case 2:
                                    text2 = message1_ctrl.text;
                                    prefs.setString('simpletext2', text2);
                                    break;
                                  case 3:
                                    text3 = message1_ctrl.text;
                                    prefs.setString('simpletext3', text3);
                                    break;
                                  case 4:
                                    text4 = message1_ctrl.text;
                                    prefs.setString('simpletext4', text4);
                                    break;
                                  case 5:
                                    text5 = message1_ctrl.text;
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
                    Column(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Visibility(
                              visible: _visibletext,
                              child: Row(
                                children: [
                                  Image.asset(
                                    'images/alt.png',
                                    width: 20,
                                  ),
                                  Text('글자 수를 초과했습니다.',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: AppColor.yellow)),
                                ],
                              ),
                            )),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${textcounter}/40 byte',
                              style: TextStyle(fontSize: 20, color: _textcolor),
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: TextField(
                              maxLines: 4,
                              minLines: 1,
                              style: TextStyle(color: Colors.white),
                              controller: message1_ctrl,
                              maxLength: 40,
                              onChanged: (text) {
                                setState(() {
                                  textcounter = text.length;
                                  if (text.length >= 40) {
                                    _visibletext = true;
                                    _textcolor = const Color(0xffFFE600);
                                  } else {
                                    _visibletext = false;
                                    _textcolor = Colors.white;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                counterText: '',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container()
                  ],
                ),
              ),
            );
          },
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
