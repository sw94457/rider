import 'package:flutter/material.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/page/login/register_page_2.dart';
import 'package:rider_app/ui/color.dart';

/*약관 동의*/

class RegisterPage1 extends StatefulWidget {
  Bloc bloc;

  RegisterPage1(this.bloc);

  @override
  _RegisterPage1State createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  var _checkboxa = false;
  var _checkbox1 = false;
  var _checkbox2 = false;
  var _checkbox3 = false;
  var _checkbox4 = false;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.yellow),
        title: Text('이용약관', style: TextStyle(color: AppColor.yellow)),
        centerTitle: true,
        backgroundColor: AppColor.navy,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.white60,
                      ),
                    ),
                    width: screen.width,
                    height: 65,
                    child: Row(
                      children: [
                        Checkbox(
                          value: _checkboxa,
                          //contentPadding: EdgeInsets.zero,
                          onChanged: (value) {
                            setState(() {
                              _checkboxa = value;
                              _checkbox1 = value;
                              _checkbox2 = value;
                              _checkbox3 = value;
                              //_checkbox4 = value;
                            });
                          },
                          activeColor: AppColor.yellow,
                        ),
                        Text(
                          "약관에 모두 동의",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white60),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            width: screen.width,
                            height: 50,
                            child: Row(
                              children: [
                                Checkbox(
                                  value: _checkbox1,
                                  //contentPadding: EdgeInsets.zero,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkbox1 = value;
                                    });
                                  },
                                  activeColor: AppColor.yellow,
                                ),
                                Text("(필수) 개인정보 수집 및 이용안내",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ],
                            )),
                        Container(
                            width: screen.width,
                            height: 50,
                            child: Row(
                              children: [
                                Checkbox(
                                  value: _checkbox2,
                                  //contentPadding: EdgeInsets.zero,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkbox2 = value;
                                    });
                                  },
                                  activeColor: AppColor.yellow,
                                ),
                                Text("(필수) 제 3자 제공 동의",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ],
                            )),
                        Container(
                            width: screen.width,
                            height: 50,
                            child: Row(
                              children: [
                                Checkbox(
                                  value: _checkbox3,
                                  //contentPadding: EdgeInsets.zero,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkbox3 = value;
                                    });
                                  },
                                  activeColor: AppColor.yellow,
                                ),
                                Text("(필수) 위치기반 서비스 이용약관 동의",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ],
                            )),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(0,16,0,16),
                        //   child: Container( height:1.0,
                        //     width:312.0,
                        //     color:Colors.white,),
                        // ),
                        // Row(
                        //   children: [
                        //     Checkbox(value: _checkbox4, onChanged: (value) {
                        //       setState(() {
                        //         _checkbox4 = value;
                        //       });
                        //     },),
                        //     Text("(선택) 마케딩 정보 수신 동의", style: TextStyle(fontSize: 18, color: Colors.white))
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: SizedBox(
                  width: screen.width - 16,
                  height: 56,
                  child: (_checkbox1 && _checkbox2 && _checkbox3)
                      ? RaisedButton(
                          color: AppColor.yellow,
                          child: Text("다음",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegisterPage2(widget.bloc)));
                          },
                        )
                      : OutlineButton(
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
      ),
    );
  }
}
