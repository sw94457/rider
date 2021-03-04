import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'bloc/bloc.dart';

class AccountCreate extends StatefulWidget {
  Bloc bloc;

  AccountCreate(this.bloc);

  @override
  _AccountCreateState createState() => _AccountCreateState();
}

class _AccountCreateState extends State<AccountCreate> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final _items = ['은행 및 증권사를 선택해주세요.','경남','광주','국민','기업','농협','대구','도이치','부산','산업','상호저축','새마을금고','수협중앙회','신한금융투자','신한','외한','우리','우체국','전북','제주','카카오뱅크','케이','하나','한국씨티','HSBC','SC제일'];
  var _selected = '은행 및 증권사를 선택해주세요.';
  TextEditingController name = TextEditingController();
  TextEditingController num = TextEditingController();
  TextEditingController bank = TextEditingController();
  var banktext;
  SharedPreferences prefs;
  var serial;


  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
        backgroundColor: const Color(0xff20283E),
        title: Text('출금계좌관리',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color(0xffFFE600))),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xffFFE600)),
      ),
      body: Container(
        alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                            children: [
                              Container(
                                width: 328,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('예금주',style: TextStyle(fontSize: 18,color: Colors.white),),
                                    TextField(
                                      controller: name,
                                        style: TextStyle(color: Colors.white,)
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 328,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('은행',style: TextStyle(fontSize: 18,color: Colors.white),),
                                      Container(
                                        alignment: Alignment.center,
                                        child: DropdownButton(
                                          value: _selected,
                                          items: _items.map(
                                                  (value) {
                                                return DropdownMenuItem(
                                                    value: value,
                                                    child: Text(value)
                                                );
                                              }
                                          ).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _selected = value;
                                              banktext = value;
                                            });
                                          },
                                          style: TextStyle(color: Colors.white),
                                          dropdownColor: const Color(0xff20283E),
                                          icon: Image.asset('images/Union_b.png',width: 10,),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 328,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('계좌번호',style: TextStyle(fontSize: 18,color: Colors.white),),
                                    TextField(
                                      controller: num,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(color: Colors.white,),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 344, height: 56,
                    child: RaisedButton(
                      onPressed: (){
                        print(name.text);
                        print(banktext);
                        print(num.text);
                        widget.bloc.registeraccount(serial: serial,account_name: name.text, account_num: num.text,account_bank: banktext).then((res) {
                          if (res.success) {
                            Toast.show('등록 되었습니다.', context);
                          } else {
                            Toast.show(res.errorMsg, context);
                          }
                        });
                      },
                      child: Text("계좌등록", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      color: const Color(0xffFFE600),
                    )
                ),
              )
            ],
          ),
        ),
    );
  }


  getCounterFromSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      serial = prefs.getString('serial');
    });
  }
}