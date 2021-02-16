import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/phone_authent_page.dart';

class AaccessTerms extends StatefulWidget {
  @override
  _AaccessTermsState createState() => _AaccessTermsState();
}

class _AaccessTermsState extends State<AaccessTerms> {
  var _checkboxa = false;
  var _checkbox1 = false;
  var _checkbox2 = false;
  var _checkbox3 = false;
  var _checkbox4 = false;
  var _chcolora;
  var _chcolor1;
  var _chcolor2;
  var _chcolor3;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
          iconTheme: IconThemeData(
            color:  const Color(0xffFFE600), //change your color here
          ),
          title: Text('이용약관', style: TextStyle(fontSize: 20,color: const Color(0xffFFE600)),),
          centerTitle: true,
          backgroundColor: const Color(0xff20283E),
        ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(0,26,0,0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                      ),
                    ),
                    width: 312,
                    height: 56,
                    child:
                        CheckboxListTile(value: _checkboxa, onChanged: (value) {
                          setState(() {
                            _checkboxa = value;
                            _checkbox1 = value;
                            _checkbox2 = value;
                            _checkbox3 = value;
                            _checkbox4 = value;
                            if (value==true){
                              _chcolora = const Color(0xffFFE600);
                              _chcolor1 = const Color(0xffFFE600);
                              _chcolor2 = const Color(0xffFFE600);
                              _chcolor3 = const Color(0xffFFE600);
                            }
                          });
                        },
                          activeColor: _chcolora,
                          title: Text("약관에 모두 동의", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white60 ),),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,24,0,0),
                        child: Column(
                          children: [
                                CheckboxListTile(value: _checkbox1, onChanged: (value) {
                                  setState(() {
                                    _checkbox1 = value;
                                    if (value==true){
                                      _chcolor1 = const Color(0xffFFE600);
                                    }
                                  });
                                },
                                  controlAffinity: ListTileControlAffinity.leading,
                                  activeColor: _chcolor1,
                                  title: Text("(필수) 개인정보 수집 및 이용안내", style: TextStyle(fontSize: 18, color: Colors.white)),
                                ),
                                CheckboxListTile(value: _checkbox2, onChanged: (value) {
                                  setState(() {
                                    _checkbox2 = value;
                                    if (value==true){
                                      _chcolor2 = const Color(0xffFFE600);
                                    }
                                  });
                                },
                                  controlAffinity: ListTileControlAffinity.leading,
                                  activeColor: _chcolor2,
                                  title: Text("(필수) 제 3자 제공 동의", style: TextStyle(fontSize: 18, color: Colors.white)),
                                ),
                                CheckboxListTile(value: _checkbox3, onChanged: (value) {
                                  setState(() {
                                    _checkbox3 = value;
                                    if (value==true){
                                      _chcolor3 = const Color(0xffFFE600);
                                    }
                                  });
                                },
                                  activeColor: _chcolor3,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  title: Text("(필수) 위치기반 서비스 이용약관 동의", style: TextStyle(fontSize: 18, color: Colors.white,letterSpacing: -1)),
                                ),
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
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,8),
                child: SizedBox(
                      width: 344,
                      height: 56,
                      child: RaisedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneAuthent()));
                        },
                        child: Text("다음", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        color: const Color(0xffFFE600),
                      )
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
