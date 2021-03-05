import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/password_change_page.dart';
import 'package:ibagudelivery_rider/ui/color.dart';
import 'package:toast/toast.dart';

import 'bloc/bloc.dart';

class FindPassword extends StatefulWidget {
  Bloc bloc;

  FindPassword(this.bloc);

  @override
  _FindPasswordState createState() => _FindPasswordState();
}

class _FindPasswordState extends State<FindPassword> {
  TextEditingController id = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController authcode = TextEditingController();
  bool isAuth = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff20283E),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Center(
                  child: Text("가입하신 아이디와\n 휴대폰 번호를 입력해주세요.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    ))
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: SizedBox(
                      width: 312,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("아이디 입력",
                              style:
                              TextStyle(fontSize: 16, color: Colors.white)),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 17, 0, 16),
                            child: SizedBox(
                              height: 48,
                              child: TextField(
                                controller: id,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                onChanged: (text) {},
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
                                ),
                              ),
                            ),
                          ),
                          Text("핸드폰 번호 입력",
                              style:
                              TextStyle(fontSize: 16, color: Colors.white)),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 17, 0, 16),
                            child: SizedBox(
                              height: 48,
                              child: TextField(
                                controller: phone,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                onChanged: (text) {},
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
                            width: 312,
                            height: 48,
                            child: RaisedButton(
                              child: Text("인증코드 받기",
                                  style: TextStyle(fontSize: 18)),
                              color: Colors.white,
                              onPressed: () {
                                widget.bloc.getfindSms(num: phone.text).then((res) {
                                  if (res.success) {
                                    Toast.show('인증코드가 발송되었습니다.', context);
                                  } else {
                                    Toast.show(res.errorMsg, context);
                                  }
                                });
                              },
                            ),
                          )
                        ],
                      ),
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
                          width: 312,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 17, 0, 16),
                            child: SizedBox(
                              height: 48,
                              child: TextField(
                                controller: authcode,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                onChanged: (text) {},
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
                          width: 312,
                          height: 48,
                          child: RaisedButton(
                            color: Colors.black.withOpacity(0.25),
                            child: Text("인증코드 확인",
                                style: TextStyle(fontSize: 18, color: Colors.white)),
                            onPressed: () {
                              widget.bloc.findcheckauthcodePw(authcode: authcode.text, phone: phone.text).then((res) {
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
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: SizedBox(
                width: 344,
                height: 56,
                child:isAuth?RaisedButton(
                  onPressed: () async {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordChange()));
                    widget.bloc.findcheckIdAuth(phone: phone.text,id: id.text).then((res) {
                      if (res.success) {
                        Toast.show('인증 되었습니다.', context);
                        setState(() {
                          isAuth = true;
                        });
                        var data = res.data;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordChange(widget.bloc,data: data,)));
                      } else {
                        Toast.show(res.errorMsg, context);
                      }
                    });
                  },
                  child: Text("다음",style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  color: AppColor.yellow,
                ):OutlineButton(
                  onPressed: () {},
                  color: AppColor.yellow,
                  child: Text("다음",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColor.yellow)),
                  borderSide: BorderSide(color: AppColor.yellow),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
