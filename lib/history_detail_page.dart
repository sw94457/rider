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
          color: const Color(0xffFFE600), //change your color here
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
                        borderRadius: BorderRadius.circular(5), //모서리를 둥글게
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
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xff9C9C9C), width: 1)),
              width: 344, height: 106,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,12,0,5),
                    child: Row(
                      children: [
                        Image.asset('images/Group 7.png'),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5,0,0,0),
                          child: Text('290M',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white)),
                        ),
                        Container(
                            width: 155,
                            child: Text('대독장',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,)
                        ),
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
              child: Image.asset('images/arrow_a.png',width: 48, height: 28 ,),
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
                      children: [
                        Image.asset('images/Group 8.png'),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5,0,45,0),
                          child: Text('300M',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),),
                        ),
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
