import 'package:flutter/material.dart';

class DeliveryDelivery extends StatefulWidget {
  @override
  _DeliveryDeliveryState createState() => _DeliveryDeliveryState();
}

class _DeliveryDeliveryState extends State<DeliveryDelivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
        backgroundColor: const Color(0xff20283E),
        iconTheme: IconThemeData(
          color: const Color(0xffFFE600), //change your color here
        ),
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
                    width: 344,
                    child: Stack(
                      children: [
                        Container(
                          height: 24,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5), //모서리를 둥글게
                              border: Border.all(color: const Color(0xff62FF2B), width: 1),
                              color: const Color(0xff62FF2B)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(40,0,5,0),
                                      child: Text('29,800원',style: TextStyle(fontSize: 16,)),
                                    ),
                                    Text('배달비 3,800원',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
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
                          height: 24, width: 36,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5), //모서리를 둥글게
                              border: Border.all(color: const Color(0xff62FF2B), width: 1),
                              color: const Color(0xff62FF2B)),
                          child: Text('카드',style: TextStyle(fontSize: 16, fontFamily: 'cafe24'),),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), //모서리를 둥글게
                        border: Border.all(color: const Color(0xff9C9C9C), width: 1)),
                    width: 344, height: 106,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15,12,0,5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,6,0),
                                      child:
                                      Container(
                                          width: 45, height: 20, alignment: Alignment.bottomCenter,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30), //모서리를 둥글게
                                            border: Border.all(color: const Color(0xffC4C4C4), width: 1),color: const Color(0xffC4C4C4)),
                                          child: Text('출발지',style: TextStyle(fontSize: 14, fontFamily: 'cafe24'),textAlign: TextAlign.center,)
                                      ),
                                    ),
                                    Text('290M',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: const Color(0xffEBFF00)),),
                                  ],
                                ),
                              ),
                              Container(
                                  child: Text('대독장',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color(0xffEBFF00)),textAlign: TextAlign.center,)
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0,0,8,0),
                                child: Container(
                                  width: 74,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset('images/call.png',width: 33, height: 33,),
                                      Image.asset('images/map.png',width: 33, height: 33,),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            width: 312,
                            child: Text('부산시 부산진구 동천로116 한신밴오피스텔 1018호',style: TextStyle(fontSize: 18,color: Colors.white))
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,8),
                    child: Image.asset('images/arrow.png'),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), //모서리를 둥글게
                      border: Border.all(color: const Color(0xff9C9C9C), width: 1)),
                    width: 344, height: 106,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15,8,0,5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,6,0),
                                      child:
                                      Container(
                                        width: 45, height: 20, alignment: Alignment.bottomCenter,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30), //모서리를 둥글게
                                              border: Border.all(color: const Color(0xff62FF2B), width: 1)),
                                          child: Text('도착지',style: TextStyle(fontSize: 14, fontFamily: 'cafe24',color: const Color(0xff62FF2B)),textAlign: TextAlign.center,)
                                      ),
                                    ),
                                    Text('300M',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: const Color(0xff62FF2B)),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0,0,8,0),
                                child: Container(
                                  width: 110,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset('images/call_b.png',width: 33, height: 33,),
                                      InkWell(
                                        onTap: (){
                                          _showDialog1();
                                        },
                                          child: Image.asset('images/message_b.png',width: 33, height: 33,)
                                      ),
                                      Image.asset('images/map_b.png',width: 33, height: 33,),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 312,
                          child: Text('부산시 부산진구 동천로116 한신밴오피스텔 1018호',style: TextStyle(fontSize: 18,color: Colors.white))
                        )
                      ],
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
                              Text('초인종 누르지 말아주세요',style: TextStyle(fontSize: 18,color: Colors.white),),
                            ],
                          )
                        ],
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,8),
                    child: Container( height:1.0,width:344,
                      color: const Color(0x80DBDBDB),),
                  ),
                  Container(
                    width: 344,
                    child: Row(
                      children: [
                        Text('접수번호',style: TextStyle(fontSize: 18,color: const Color(0xffFFE600)),),
                        Container(width: 34,),
                        Text('#1211',style: TextStyle(fontSize: 18,color: Colors.white),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container( height:1.0,width:344,
                      color: const Color(0x80DBDBDB),),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container( width: 168, height: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: RaisedButton(onPressed: (){},
                          child: Text("픽업완료",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                          color: const Color(0x1fffffff),
                        ),
                      ),
                      Container( width: 168, height: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: RaisedButton(onPressed: (){},
                          child: Text("배달완료",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          color: const Color(0xff62FF2B),
                        ),
                      )
                    ],
                  ),
                ),
            ),

          ],
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
                      children: [
                        Image.asset('images/call_b.png',width: 33, height: 33,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8,0,0,0),
                          child: Image.asset('images/message_b.png',width: 33, height: 33,),
                        )
                      ],
                    ),
                  ),
                  Container( height:1.0,width:344,
                    color: const Color(0x80DBDBDB),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('문 앞에 두고 갑니다.',style: TextStyle(fontSize: 18,color: Colors.white),),
                  ),
                  Container( height:1.0,width:344,
                    color: const Color(0x80DBDBDB),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('1분 후에 도착 예정입니다.',style: TextStyle(fontSize: 18,color: Colors.white),),
                  ),
                  Container( height:1.0,width:344,
                    color: const Color(0x80DBDBDB),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('5분 후에 도착 예정입니다.',style: TextStyle(fontSize: 18,color: Colors.white),),
                  ),
                  Container( height:1.0,width:344,
                    color: const Color(0x80DBDBDB),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('10분 후에 도착 예정입니다.',style: TextStyle(fontSize: 18,color: Colors.white),),
                  ),
                  Container( height:1.0,width:344,
                    color: const Color(0x80DBDBDB),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('조금 늦을것 같습니다.',style: TextStyle(fontSize: 18,color: Colors.white),),
                  ),
                  Container( height:1.0,width:344,
                    color: const Color(0x80DBDBDB),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100, height: 48,
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
                          width: 100, height: 48,
                          child: RaisedButton(onPressed: (){

                          },
                            child: Text('확인',style: TextStyle(fontSize: 24),),
                            color: const Color(0xffFFE600),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
        );
      },
    );
  }


}
