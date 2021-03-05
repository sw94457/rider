import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/bloc/bloc.dart';
import 'package:ibagudelivery_rider/find_password_page.dart';
import 'package:ibagudelivery_rider/ui/color.dart';
import 'package:toast/toast.dart';

class PasswordChange extends StatefulWidget {
  Bloc bloc;
  var data;
  PasswordChange(this.bloc, {Key key,this.data}) : super(key: key);

  @override
  _PasswordChangeState createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  TextEditingController pw = TextEditingController();
  TextEditingController pw2 = TextEditingController();


  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.yellow),
        title: Text('비밀번호찾기', style: TextStyle(color: AppColor.yellow)),
        centerTitle: true,
        backgroundColor: AppColor.navy,
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Text("인증이 완료되었습니다.\n새로운 비밀번호를 설정해주세요.",
                        textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 18,color: Colors.white,)
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 8),
                          child: Text("비밀번호 입력",
                              style:
                              TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                        SizedBox(
                          width: 312,
                          height: 48,
                          child: TextField(
                            controller: pw,
                            cursorColor: Colors.white,
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                          child: Text("비밀번호는 8-20자로 입력해주세요.",
                              style: TextStyle(
                                  fontSize: 12, color: AppColor.yellow)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                          child: Text("비밀번호 재입력",
                              style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                        SizedBox(
                          width: 312,
                          height: 48,
                          child: TextField(
                            controller: pw2,
                            cursorColor: Colors.white,
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: SizedBox(
                    width: 344,
                    height: 56,
                    child: OutlineButton(
                      onPressed: () {
                        widget.bloc.findchangePw(pw: pw.text,serial : widget.data.toString()).then((res) {
                          if (res.success) {
                            Toast.show('변경 되었습니다.', context);
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FindPasswordPage()));
                          } else {
                            Toast.show(res.errorMsg, context);
                          }
                        });
                      },
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
              ),
            ],
          ),
        ),
    );
  }
}
