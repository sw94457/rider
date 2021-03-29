import 'package:flutter/material.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/ui/color.dart';
import 'package:rider_app/ui/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class AccountCreatePage extends StatefulWidget {
  Bloc bloc;

  AccountCreatePage(this.bloc);

  @override
  _AccountCreatePageState createState() => _AccountCreatePageState();
}

class _AccountCreatePageState extends State<AccountCreatePage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final _items = [
    '은행 및 증권사를 선택해주세요.',
    '경남',
    '광주',
    '국민',
    '기업',
    '농협',
    '대구',
    '도이치',
    '부산',
    '산업',
    '상호저축',
    '새마을금고',
    '수협중앙회',
    '신한금융투자',
    '신한',
    '외한',
    '우리',
    '우체국',
    '전북',
    '제주',
    '카카오뱅크',
    '케이',
    '하나',
    '한국씨티',
    'HSBC',
    'SC제일'
  ];
  var _selected = '은행 및 증권사를 선택해주세요.';
  TextEditingController name_ctrl = TextEditingController();
  TextEditingController num_ctrl = TextEditingController();
  TextEditingController bank_ctrl = TextEditingController();
  var banktext;
  SharedPreferences prefs;
  var serial;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        title: Text('출금계좌관리',
            style: TextStyle(
                // fontSize: 24,
                // fontWeight: FontWeight.bold,
                color: AppColor.yellow)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.yellow),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: screenSize.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '예금주',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      MyTextField(
                        textEditingController: name_ctrl,
                        backgroundColor: AppColor.navy,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  width: screenSize.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '은행',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Container(
                        width: screenSize.width,
                        height: 48,
                        child: DropdownButton(
                          value: _selected,
                          items: _items.map((value) {
                            return DropdownMenuItem(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selected = value;
                              banktext = value;
                            });
                          },
                          style: TextStyle(color: Colors.white),
                          dropdownColor: const Color(0xff20283E),
                          icon: Image.asset(
                            'images/Union_b.png',
                            width: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: screenSize.width,
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '계좌번호',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      MyTextField(
                          textEditingController: num_ctrl,
                          backgroundColor: AppColor.navy,
                          inputType: TextInputType.number)
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: screenSize.width,
              height: 76,
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                onPressed: () {
                  print(name_ctrl.text);
                  print(banktext);
                  print(num_ctrl.text);
                  widget.bloc.registerAccount(
                          serial: serial,
                          account_name: name_ctrl.text,
                          account_num: num_ctrl.text,
                          account_bank: banktext)
                      .then((res) {
                    if (res.success) {
                      Toast.show('등록 되었습니다.', context);
                    } else {
                      Toast.show(res.errorMsg, context);
                    }
                  });
                },
                child: Text("계좌등록",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                color: const Color(0xffFFE600),
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
