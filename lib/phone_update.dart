import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/ui/color.dart';
import 'package:toast/toast.dart';

import 'bloc/bloc.dart';

class PhoneUpdate extends StatefulWidget {
  Bloc bloc;

  PhoneUpdate(this.bloc);

  @override
  _PhoneUpdateState createState() => _PhoneUpdateState();
}

class _PhoneUpdateState extends State<PhoneUpdate> {
  bool isAuth = false;
  bool numconter = false;
  bool authconter = false;
  TextEditingController authcode = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
        backgroundColor: const Color(0xff20283E),
        title: Text('핸드폰번호수정',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color(0xffFFE600))),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xffFFE600)),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('핸드폰 번호 입력',style: TextStyle(fontSize: 16, color: Colors.white),),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,17,0,16),
                        child: Container(
                          width: 312,height: 48,
                          child: TextField(
                            controller: phone,maxLength: 11,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 2.0),
                              ),
                              counterText:'',
                            ),
                            style: TextStyle(color: Colors.white),
                            onChanged: (text){
                              setState(() {
                                if (text.length == 11){
                                  numconter = true;
                                } else {
                                  numconter = false;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                          width: 312,height: 48,
                          child: numconter?RaisedButton(
                            onPressed: () {
                              widget.bloc.getupdateSms(num: phone.text).then((res) {
                                if (res.success) {
                                  Toast.show('인증코드가 발송되었습니다.', context);
                                } else {
                                  Toast.show(res.errorMsg, context);
                                }
                              });
                            },
                            child: Text('인증코드 받기',style: TextStyle(fontSize: 18, color: Colors.black),),
                          ):RaisedButton(
                            onPressed: () {}, color: Colors.white12,
                            child: Text('인증코드 받기',style: TextStyle(fontSize: 18, color: Colors.black),),
                          )

                          ),
                      Text('인증 코드 입력',style: TextStyle(fontSize: 16, color: Colors.white),),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,10,0,16),
                        child: Container(
                          width: 312,height: 48,
                          child: TextField(
                            controller: authcode,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 2.0),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            onChanged: (text){
                              setState(() {
                                if (text.length == 6){
                                  authconter = true;
                                } else {
                                  authconter = false;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                          width: 312,height: 48,
                          child: authconter?RaisedButton(
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
                          child: Text('인증코드 확인',style: TextStyle(fontSize: 18, color: Colors.black))
                          ):
                          RaisedButton(
                            color: Colors.white12,
                            child: Text('인증코드 확인',style: TextStyle(fontSize: 18,color: Colors.black))
                          )
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 344,height: 56,
                  child:isAuth?RaisedButton(
                    onPressed: () {
                      Navigator.pop(context, phone.text);
                    },
                    child: Text("수정하기",style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    color: AppColor.yellow,
                  ):OutlineButton(
                    onPressed: () {},
                    color: AppColor.yellow,
                    child: Text("수정하기",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColor.yellow)),
                    borderSide: BorderSide(color: AppColor.yellow),
                  )
              ),
            ),
          ],
        ),
      )
    );
  }
}

