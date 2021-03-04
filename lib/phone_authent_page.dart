import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/addLicense.dart';
import 'package:ibagudelivery_rider/bloc/bloc.dart';
import 'package:ibagudelivery_rider/join_create_page.dart';
import 'package:ibagudelivery_rider/ui/color.dart';
import 'package:toast/toast.dart';

class PhoneAuthent extends StatefulWidget {
  Bloc bloc;

  PhoneAuthent(this.bloc);

  @override
  _PhoneAuthentState createState() => _PhoneAuthentState();
}

class _PhoneAuthentState extends State<PhoneAuthent> {
  TextEditingController phone = TextEditingController();
  TextEditingController authcode = TextEditingController();
  bool isAuth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.yellow),
        title: Text('휴대폰 인증',
            style: TextStyle(fontSize: 20, color: AppColor.yellow)),
        centerTitle: true,
        backgroundColor: const Color(0xff20283E),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 29, 0, 0),
              child: Column(
                children: [
                  Center(
                      child: Text("휴대폰으로 인증코드를 받아\n전송된 인증코드를 입력해주세요.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 36, 0, 0),
                    child: SizedBox(
                      width: 312,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                widget.bloc.getJoinSms(num: phone.text).then((res) {
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
                              widget.bloc.checkAuthCode(num: phone.text, code: authcode.text).then((res) {
                                print(phone.text);
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
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: SizedBox(
                width: 344,
                height: 56,
                child: isAuth?RaisedButton(
                  onPressed: () {
                    if (isAuth) {
                      widget.bloc.user.phone = phone.text;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddLicensePage(widget.bloc)));
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
