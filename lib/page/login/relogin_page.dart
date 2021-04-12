import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/page/home_page.dart';
import 'package:rider_app/ui/button.dart';
import 'package:rider_app/ui/color.dart';
import 'package:rider_app/ui/text_field.dart';
import 'package:toast/toast.dart';

class ReLoginPage extends StatefulWidget {
  Bloc bloc;

  ReLoginPage(this.bloc);

  @override
  _ReLoginPageState createState() => _ReLoginPageState();
}

class _ReLoginPageState extends State<ReLoginPage> {
  var logger = Logger();
  TextEditingController phone_ctrl = TextEditingController();
  TextEditingController code_ctrl = TextEditingController();
  bool next = false;
  bool getCode = false;
  String text_phone = '';

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        brightness: Brightness.light,
        centerTitle: true,
        elevation: 0.0,
        title: Text('재로그인', style: TextStyle(color: AppColor.yellow)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.yellow),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: GestureDetector(
        //다른 곳 누르면 키보드 숨김
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: screenSize.height - 160,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Center(
                          child: Text('휴대폰으로 인증코드를 받아\n전송된 인증코드를 입력해주세요.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17, color: Colors.white)),
                        ),
                      ),
                      SizedBox(height: 40),
                      Text('핸드폰 번호 입력', style: TextStyle(fontSize: 17, color: Colors.white)),
                      SizedBox(height: 10),
                      MyTextField(
                        controller: phone_ctrl,
                        inputType: TextInputType.phone,
                        hintText: '숫자만 입력해주세요',
                        color: AppColor.grey,
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                        // inputFormatters: [
                        //   MultiMaskedTextInputFormatter(masks: [
                        //     '010-xxxx-xxxx',
                        //     '01x-xxx-xxxx',
                        //     '01x-xxxx-xxxx'
                        //   ], separator: '-')
                        // ],
                        onChanged: (str) {
                          var a = str.split("-");
                          text_phone='';
                          for (int i = 0; i < a.length; i++) {
                            text_phone += a[i];
                          }
                          logger.d('phone number : ' + text_phone);
                        },
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: screenSize.width,
                        child: MyButton(
                          child: Text('인증 번호 받기', style: TextStyle(fontSize: 18)),
                          color: AppColor.yellow,
                          onPressed: () {
                            //키보드 없애기
                            FocusScope.of(context).requestFocus(new FocusNode());
                            //기기 달라서 다시 로그인시 인증코드 요청
                            widget.bloc.getLoginSms(num: text_phone).then((res) {
                              if (res.success) {
                                Toast.show('인증 코드가 발송되었습니다.', context);
                                getCode = true;
                              } else {
                                Toast.show(res.errorMsg, context);
                                getCode = false;
                              }
                              setState(() {});
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      Text('인증 코드 입력', style: TextStyle(fontSize: 17, color: Colors.white)),
                      SizedBox(height: 5),
                      MyTextField(
                        controller: code_ctrl,
                        inputType: TextInputType.phone,
                        color: Colors.grey,
                        hintText: '인증 코드를 입력해주세요',
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                        onChanged: (str) {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 10)
                    ],
                  ),
                  //인증코드가 발송됐으면 true, 버튼 활성화
                  SizedBox(
                    width: screenSize.width,
                    child: getCode?
                    MyButton(
                      color: AppColor.yellow,
                      child: Text('로그인', style: TextStyle(fontSize: 18),),
                      onPressed: () {
                        widget.bloc.user.phone = text_phone;
                        widget.bloc.loginWithAuth(phone: text_phone, authcode: code_ctrl.text).then((res) {
                          if(res.success){
                            Navigator.pushAndRemoveUntil(
                                context, CupertinoPageRoute(
                                builder: (context) => HomePage(widget.bloc)),
                                    (route) => false);
                          }else{
                            Toast.show(''+res.errorMsg, context);
                          }
                        });
                      },
                    ):
                    MyLineButton(
                      color: AppColor.yellow,
                      child: Text('로그인', style: TextStyle(fontSize: 18)),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
