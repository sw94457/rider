import 'package:flutter/material.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/page/login/register_page_3.dart';
import 'package:rider_app/ui/button.dart';
import 'package:rider_app/ui/color.dart';
import 'package:rider_app/ui/text_field.dart';
import 'package:toast/toast.dart';

/*휴대폰 등록*/

class RegisterPage2 extends StatefulWidget {
  Bloc bloc;

  RegisterPage2(this.bloc);

  @override
  _RegisterPage2State createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  TextEditingController phone_ctrl = TextEditingController();
  TextEditingController authcode = TextEditingController();
  bool isAuth = false;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.yellow),
        title: Text('휴대폰 인증',
            style: TextStyle(fontSize: 20, color: AppColor.yellow)),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                  padding: EdgeInsets.fromLTRB(0, 36, 0, 0),
                  width: screen.width-48,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("핸드폰 번호 입력",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: SizedBox(
                          height: 68,
                          child: MyTextField(
                            textEditingController: phone_ctrl,
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
                          widget.bloc.getJoinSms(num: phone_ctrl.text).then((res) {
                            if (res.success) {
                              Toast.show('인증코드가 발송되었습니다.', context);
                            } else {
                              Toast.show(res.errorMsg, context);
                            }
                          });
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 36, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("인증코드 입력",
                          style:
                              TextStyle(fontSize: 16, color: Colors.white)),
                      SizedBox(
                        width: screen.width-48,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: SizedBox(
                            height: 68,
                            child: MyTextField(
                              textEditingController: authcode,
                              color: Colors.white,
                              onChanged: (text) {},
                            ),
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
                            print(phone_ctrl.text);
                            print(authcode.text);
                            if (res.success) {
                              Toast.show('인증 되었습니다.', context);
                              setState(() {
                                isAuth = true;
                              });
                            } else {
                              Toast.show(res.errorMsg, context);
                            }
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: SizedBox(
                width: screen.width-16,
                height: 56,
                child: isAuth?RaisedButton(
                  onPressed: () {
                    if (isAuth) {
                      widget.bloc.user.phone = phone_ctrl.text;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage3(widget.bloc)));
                    }
                  },
                  child: Text("다음",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  color: AppColor.yellow,
                ):OutlineButton(
                        onPressed: () {},
                        color: AppColor.yellow,
                        child: Text("다음",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColor.yellow)),
                        borderSide: BorderSide(color: AppColor.yellow),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
