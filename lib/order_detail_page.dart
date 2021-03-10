import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class OrderDetail extends StatefulWidget {
  Bloc bloc;
  var data;

  OrderDetail(this.bloc, {Key key,this.data}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  Map detaillist = {};
  bool _isloadind = true;
  SharedPreferences prefs;
  var serial;
  var memo='';
  var paytype;

  orderdetailcall() async {

    prefs = await SharedPreferences.getInstance();
    setState(() {
      serial = prefs.getString('serial');
    });

    await widget.bloc.orderdetail(serial: serial,request_serial: widget.data.toString()).then((res){
      detaillist = res;
    });

    setState(() {
      _isloadind = false;

    });

    if (detaillist['rider_memo'] != '' && detaillist['rider_memo'] != null){
      setState(() {
        memo = detaillist['rider_memo'];
      });
    }
    print(detaillist);

    switch(detaillist['pay_type']) {
      case 'A':
        paytype = '카드결제';
        break;
      case 'B':
        paytype = '카드결제';
        break;
      case 'C':
        paytype = '카드결제';
        break;
      default:
        break;
    }

  }

  acceptorder(){
    widget.bloc.acceptorder(serial: serial,orderserial: detaillist['order_serial'],requestserial: detaillist['serial']).then((res){
      if (res.success) {
        Toast.show('수락 되었습니다.', context);
      } else {
        Toast.show(res.errorMsg, context);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    orderdetailcall();

  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
        backgroundColor: const Color(0xff20283E),
        iconTheme: IconThemeData(
        color: const Color(0xffFFE600), //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: _isloadind ? Center(child: CircularProgressIndicator()) : Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8,0,8,0),
                      child: Container(
                        child: Stack(
                          children: [
                            Container(
                              height: 24,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: const Color(0xffFF2020), width: 1),
                                  color: const Color(0xffFF2020)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(70,0,5,0),
                                          child: Text('${detaillist['final_price']}원',style: TextStyle(fontSize: 16,)),
                                        ),
                                        Text('배달비 ${detaillist['rider_delivery_price']}원',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,0,8,0),
                                    child: Text('7분전',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 24, width: 66,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: const Color(0xff62FF2B), width: 1),
                                  color: const Color(0xff62FF2B)),
                              child: Text('${paytype}',style: TextStyle(fontSize: 16, fontFamily: 'cafe24'),),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8,0,8,0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: const Color(0xff9C9C9C), width: 1)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                            width: 45, height: 20, alignment: Alignment.bottomCenter,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: const Color(0xffC4C4C4), width: 1),color: const Color(0xffC4C4C4)),
                                            child: Text('출발지',style: TextStyle(fontSize: 14, fontFamily: 'cafe24'),textAlign: TextAlign.center,)
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5,0,0,0),
                                          child: Text('290M',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: const Color(0xffEBFF00))),
                                        ),
                                      ],
                                    ),
                                    Text('${detaillist['company_name']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color(0xffEBFF00)),),
                                    Container()
                                  ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text('${detaillist['company_address']}',style: TextStyle(fontSize: 18,color: Colors.white))
                              ),
                            )
                        ],
                      ),
                  ),
                    ),
                    Image.asset('images/arrow.png',width: 24,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8,0,8,0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: const Color(0xff9C9C9C), width: 1)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 45, height: 20, alignment: Alignment.bottomCenter,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: const Color(0xffC4C4C4), width: 1),color: const Color(0xffC4C4C4)),
                                          child: Text('도착지',style: TextStyle(fontSize: 14, fontFamily: 'cafe24'),textAlign: TextAlign.center,)
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(5,0,0,0),
                                        child: Text('300M',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: const Color(0xff62FF2B))),
                                      ),
                                    ],
                                  ),
                                  Text('${detaillist['user_phone']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color(0xffEBFF00)),),
                                  Container()
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                  child: Text('${detaillist['user_address']}',style: TextStyle(fontSize: 18,color: Colors.white))
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                children: [
                                  Text('요청사항 메세지',style: TextStyle(fontSize: 20,color: const Color(0xffFFE600)),),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(2,0,0,0),
                                    child: Image.asset('images/mail.png',width: 16, height: 16,),
                                  ),
                                ],
                              ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10,0,0,0),
                              child: Text('${memo}',style: TextStyle(fontSize: 20,color: Colors.white)),
                            ),
                            Container( height:1.0,color: const Color(0xffDBDBDB)),
                            Row(
                              children: [
                                Text('접수번호',style: TextStyle(fontSize: 18,color: const Color(0xffFFE600)),),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(26,0,0,0),
                                  child: Text('#${detaillist['order_serial']}',style: TextStyle(fontSize: 20,color: Colors.white),),
                                ),
                              ],
                            ),
                            Container( height:1.0,color: const Color(0xffDBDBDB)),
                            Text('지도보기',style: TextStyle(fontSize: 20,color: const Color(0xffFFE600)),)
                          ],
                       )
                      ),
                    ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       height: 338,color: Colors.orange,
                     ),
                   ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: screen-16, height: 56,
                  child: RaisedButton(onPressed: (){
                    _showDialog1();
                  },
                    child: Text('수락하기',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),color: const Color(0xffFFE600),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog1() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: const Color(0xff3B4255),
            content: Container(
              height: 140,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,20),
                    child: Text('수락 후 취소는 불가합니다. 수락하시겠습니까?',style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 110, height: 48,
                        child: OutlineButton(onPressed: (){
                          Navigator.pop(context);
                        },
                          child: Text('취소',style: TextStyle(fontSize: 24,color: Colors.white),),
                          color: const Color(0xff3B4255),
                          borderSide: BorderSide(
                              color: Colors.white, width: 2
                          ),
                        ),
                      ),

                      Container(
                        width: 110, height: 48,
                        child: RaisedButton(onPressed: () async {
                          await acceptorder();
                          Navigator.pop(context);
                        },
                          child: Text('확인',style: TextStyle(fontSize: 24),),
                          color: const Color(0xffFFE600),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
        );
      },
    );
  }


}
