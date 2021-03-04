import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryDetail extends StatefulWidget {
  @override
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
        backgroundColor: const Color(0xff20283E),
        iconTheme: IconThemeData(
          color: const Color(0xffFFE600),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              width: 344,
              child: Stack(
                children: [
                  Container(
                    height: 24,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color(0xff9C9C9C), width: 1),
                        color: const Color(0xff9C9C9C)),
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
                          child: Text('11:30:12',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 24, width: 36,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color(0xff62FF2B), width: 1),
                        color: const Color(0xff62FF2B)),
                    child: Text('카드',style: TextStyle(fontSize: 16, fontFamily: 'cafe24'),),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xff9C9C9C), width: 1)),
              width: 344,
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
                        child: Text('대독장',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white))
                    ),
                    Text('부산시 부산진구 동천로116 한신밴오피스텔 1018호',style: TextStyle(fontSize: 18,color: Colors.white))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,8),
              child: Image.asset('images/arrow_a.png', height: 50 ,),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xff9C9C9C), width: 1)),
              width: 344,
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
                                      child: Text('도착지',style: TextStyle(fontSize: 14, fontFamily: 'cafe24'),textAlign: TextAlign.center,)
                                  ),
                                ),
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
                                Image.asset('images/call.png',width: 55),
                                Image.asset('images/message.png',width: 55),
                                Image.asset('images/map.png',width: 55),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('01012345678',style: TextStyle(fontSize: 24,color: Colors.white))
                    ),
                    Text('부산시 부산진구 동천로116 한신밴오피스텔 1018호',style: TextStyle(fontSize: 18,color: Colors.white))
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
                          Text('초인종 누르지 말아주세요',style: TextStyle(fontSize: 18,color: Colors.white),),
                        ],
                      )
                    ],
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,8),
              child: Container( height:1.0,
                width:344,
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
          ],
        ),
      ),
    );
  }
}
