import 'package:flutter/material.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/ui/button.dart';
import 'package:rider_app/ui/color.dart';
import 'package:rider_app/ui/text_field.dart';
import 'package:toast/toast.dart';


class PhoneUpdatePage extends StatefulWidget {
  Bloc bloc;

  PhoneUpdatePage(this.bloc);

  @override
  _PhoneUpdatePageState createState() => _PhoneUpdatePageState();
}

class _PhoneUpdatePageState extends State<PhoneUpdatePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController phone_ctrl = TextEditingController();
  TextEditingController authcode = TextEditingController();
  bool isAuth = false;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: AppColor.yellow),
        title: Text('휴대폰 인증',
            style: TextStyle(fontSize: 20, color: AppColor.yellow)),
        centerTitle: true,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(right: 20,left:20, top: 10, bottom: 20),
            height: screen.height - (110),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "휴대폰으로 인증코드를 받아\n전송된 인증코드를 입력해주세요.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("핸드폰 번호 입력",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: SizedBox(
                          height: 68,
                          child: MyTextField(
                            controller: phone_ctrl,
                            inputType: TextInputType.number,
                            color: Colors.white,
                            hintText: '숫자만 입력해주세요',
                            hintStyle: TextStyle(color: Colors.white),
                            onChanged: (text) {},
                          ),
                        ),
                      ),
                      MyButton(
                        width: screen.width,
                        height: 48,
                        child: Text("인증코드 받기",
                            style: TextStyle(fontSize: 18)),
                        color: Colors.white,
                        onPressed: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          widget.bloc.getJoinSms(num: phone_ctrl.text).then((res) {
                            if (res.success) {
                              scaffoldKey.currentState.showSnackBar(
                                  SnackBar(content: Text('인증코드가 발송되었습니다.')));
                            } else {
                              scaffoldKey.currentState.showSnackBar(
                                  SnackBar(content: Text(res.errorMsg)));
                            }
                          });
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("인증코드 입력",
                          style:
                          TextStyle(fontSize: 14, color: Colors.white)),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: SizedBox(
                          height: 68,
                          child: MyTextField(
                            controller: authcode,
                            color: Colors.white,
                            inputType: TextInputType.number,
                            onChanged: (text) {},
                          ),
                        ),
                      ),
                      MyButton(
                        width: screen.width,
                        height: 48,
                        color: Colors.white.withOpacity(0.1),
                        child: Text("인증코드 확인",
                            style: TextStyle(fontSize: 18, color: Colors.white)),
                        onPressed: () {
                          widget.bloc.checkAuthCode(num: phone_ctrl.text, code: authcode.text).then((res) {
                            if (res.success) {
                              scaffoldKey.currentState.showSnackBar(
                                  SnackBar(content: Text('인증 되었습니다.')));
                              setState(() {
                                isAuth = true;
                              });
                            } else {
                              scaffoldKey.currentState.showSnackBar(
                                  SnackBar(content: Text(res.errorMsg)));
                            }
                          });
                        },
                      )
                    ],
                  ),
                ),
                Expanded(child: Container()),
                SizedBox(
                  width: screen.width-16,
                  height: 56,
                  child: isAuth?
                  RaisedButton(
                    color: AppColor.yellow,
                    child: Text("수정하기",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      if (isAuth) {
                        widget.bloc.user.phone = phone_ctrl.text;
                        //
                      }
                    },
                  ):MyLineButton(
                    color: AppColor.yellow,
                    child: Text("수정하기",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColor.yellow)),
                    onPressed: () {
                      scaffoldKey.currentState.showSnackBar(
                                  SnackBar(content: Text('휴대폰 번호 인증이 필요합니다.')));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

