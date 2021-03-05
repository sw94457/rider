import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/bloc/bloc.dart';
import 'package:ibagudelivery_rider/ui/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class DeliveryDelivery extends StatefulWidget {
  Bloc bloc;
  var data;
  var serial;

  DeliveryDelivery(this.bloc, {Key key,this.data,this.serial}) : super(key: key);

  @override
  _DeliveryDeliveryState createState() => _DeliveryDeliveryState();
}

class _DeliveryDeliveryState extends State<DeliveryDelivery> {
  var memo='';

  var text1;
  var text2;
  var text3;
  var text4;
  var text5;

  @override
  void initState() {
    getCounterFromSharedPrefs();
    if (widget.data['rider_memo'] != ''){
      setState(() {
        memo = widget.data['rider_memo'];
      });
    }
    print(widget.data);
    print(widget.serial);
  }

  finishdelivery() async {
    await widget.bloc.finishdelivery(serial: widget.serial.toString(),requestserial: widget.data['serial']).then((res){
      if (res.success) {
        Toast.show('배달 완료 되었습니다.', context);
      } else {
        Toast.show(res.errorMsg, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
        backgroundColor: const Color(0xff20283E),
        iconTheme: IconThemeData(
          color: const Color(0xffFFE600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          Container(
                            height: 24,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: const Color(0xff62FF2B), width: 1),
                                color: const Color(0xff62FF2B)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(70,0,5,0),
                                        child: Text('배달비 3,800원',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,8,0),
                                  child: Text('PM 12:08',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 24, width: 66,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5), //모서리를 둥글게
                                border: Border.all(color: const Color(0xff62FF2B), width: 1),
                                color: const Color(0xff62FF2B)),
                            child: Text('현장결제',style: TextStyle(fontSize: 16, fontFamily: 'cafe24'),),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: const Color(0xff9C9C9C), width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Container(
                                    height: 55,
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0,0,6,0),
                                          child:Container(
                                              width: 45, height: 20, alignment: Alignment.bottomCenter,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(30),
                                                  border: Border.all(color: const Color(0xff9C9C9C), width: 1),color: const Color(0xff9C9C9C)),
                                              child: Text('출발지',style: TextStyle(fontSize: 14, fontFamily: 'cafe24'),textAlign: TextAlign.center,)
                                          ),
                                        ),
                                        Text('290M',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: const Color(0xff9C9C9C)),),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,8,0),
                                  child: Container(
                                    width: 118,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset('images/call.png',width: 55),
                                        Image.asset('images/map.png',width: 55),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text('${widget.data['company_name']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color(0xff9C9C9C)))
                            ),
                            Text('${widget.data['company_address']}',style: TextStyle(fontSize: 18,color: const Color(0xff9C9C9C)))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,8),
                      child: Image.asset('images/arrow.png',width: 24),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: const Color(0xff62FF2B), width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Container(
                                    height: 55,
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0,0,6,0),
                                          child:Container(
                                              width: 45, height: 20, alignment: Alignment.bottomCenter,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(30), color: const Color(0xff62FF2B)),
                                              child: Text('도착지',style: TextStyle(fontSize: 14, fontFamily: 'cafe24'),textAlign: TextAlign.center,)
                                          ),
                                        ),
                                        Text('300M',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: const Color(0xff62FF2B)),),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,8,0),
                                  child: Container(
                                    width: 181,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset('images/call_b.png',width: 55),
                                        InkWell(
                                          onTap: (){
                                            _showDialog1();
                                          },
                                            child: Image.asset('images/message_b.png',width: 55)
                                        ),
                                        Image.asset('images/map_b.png',width: 55),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text('${widget.data['user_phone']}',style: TextStyle(fontSize: 20,color: const Color(0xff62FF2B)))
                            ),
                            Text('${widget.data['user_address']}',style: TextStyle(fontSize: 18,color: const Color(0xff62FF2B)))
                          ],
                        ),
                      ),
                    ),
                    Container(
                        width: 324,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0,10,0,8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('요청사항 메세지',style: TextStyle(fontSize: 18,color: const Color(0xffFFE600)),),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(2,0,0,0),
                                    child: Image.asset('images/mail.png',width: 16, height: 16,),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(width: 8,),
                                  Text('${memo}',style: TextStyle(fontSize: 18,color: Colors.white),),
                                ],
                              )
                            ],
                          ),
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,8),
                      child: Container( height:1.0,color: const Color(0x80DBDBDB),),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text('접수번호',style: TextStyle(fontSize: 18,color: const Color(0xffFFE600)),),
                          Container(width: 34,),
                          Text('#${widget.data['order_serial']}',style: TextStyle(fontSize: 18,color: Colors.white),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: screen, height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5)),
                child: RaisedButton(onPressed: (){
                  finishdelivery();
                },
                  child: Text("배달완료",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  color: const Color(0xff62FF2B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog1() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: const Color(0xff3B4255),
            content: Container(
              height: 340,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       InkWell(
                         onTap: (){
                           Navigator.pop(context);
                         },
                           child: Image.asset('images/close.png',width: 20)
                       ),
                       Text('간편메세지',style: TextStyle(fontSize: 24,color: AppColor.yellow)),
                       Container()
                      ],
                    ),
                  ),
                  Container( height:1.0,width:344,
                    color: const Color(0x80DBDBDB),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${text1}',style: TextStyle(fontSize: 18,color: Colors.white),),
                  ),
                  Container( height:1.0,width:344,
                    color: const Color(0x80DBDBDB),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${text2}',style: TextStyle(fontSize: 18,color: Colors.white),),
                  ),
                  Container( height:1.0,width:344,
                    color: const Color(0x80DBDBDB),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${text3}',style: TextStyle(fontSize: 18,color: Colors.white),),
                  ),
                  Container( height:1.0,width:344,
                    color: const Color(0x80DBDBDB),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${text4}',style: TextStyle(fontSize: 18,color: Colors.white),),
                  ),
                  Container( height:1.0,width:344,
                    color: const Color(0x80DBDBDB),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${text5}',style: TextStyle(fontSize: 18,color: Colors.white),),
                  ),
                  Container( height:1.0,width:344,
                    color: const Color(0x80DBDBDB),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 48, width: 290,
                      child: RaisedButton(onPressed: (){
                        sendmessage();
                      },
                        child: Text('보내기',style: TextStyle(fontSize: 24),),
                        color: const Color(0xffFFE600),
                      ),
                    ),
                  )
                ],
              ),
            )
        );
      },
    );
  }


  getCounterFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      text1 = prefs.getString('simpletext1') ?? '문 앞에 두고 갑니다.';
      text2 = prefs.getString('simpletext2') ?? '1분 후에 도착 예정입니다.';
      text3 = prefs.getString('simpletext3') ?? '5분 후에 도착 예정입니다.';
      text4 = prefs.getString('simpletext4') ?? '10분 후에 도착 예정입니다.';
      text5 = prefs.getString('simpletext5') ?? '조금 늦을것 같습니다.';
    });
  }

  sendmessage() async {
    await widget.bloc.sendmessage(phone: widget.data['user_phone'],rider_message: text1).then((res){
      if (res.success) {
        Toast.show('메세지가 전송 되었습니다.', context);
      } else {
        Toast.show(res.errorMsg, context);
      }
    });
  }


}
