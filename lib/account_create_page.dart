import 'package:flutter/material.dart';

class AccountCreate extends StatefulWidget {
  @override
  _AccountCreateState createState() => _AccountCreateState();
}

class _AccountCreateState extends State<AccountCreate> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final _items = ['은행 및 증권사를 선택해주세요.','신한', '국민', '기업'];
  var _selected = '은행 및 증권사를 선택해주세요.';

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
                      onPressed: (){},
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
}