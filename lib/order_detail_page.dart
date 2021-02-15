import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetail extends StatefulWidget {
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
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
      body: SingleChildScrollView(
        child: Container(
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
                                border: Border.all(color: const Color(0xffFF2098), width: 1),
                                color: const Color(0xffFF2098)),
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
                                  padding: const EdgeInsets.fromLTRB(5,0,45,0),
                                  child: Text('290M',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: const Color(0xffEBFF00)),),
                                  ),
                                Text('대독장',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color(0xffEBFF00)),)
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
                    Image.asset('images/arrow.png'),
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
                              children: [
                                Image.asset('images/Group 8.png'),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5,0,45,0),
                                  child: Text('300M',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: const Color(0xff62FF2B)),),
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
                  )
              ),
                    Container( height:1.0,
                width:344,
                color: const Color(0xffDBDBDB),),
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
                    Container( height:1.0,
                width:344,
                color: const Color(0xffDBDBDB),),
                    Container(
                child: Column(
                  children: [
                    SizedBox(
                    width: 344 ,
                        child: Text('지도보기',style: TextStyle(fontSize: 18,color: const Color(0xffFFE600)),)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 338, height: 338,
                        color: Colors.orange,
                      ),
                    ),

                  ],
                ),
              )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 344, height: 56,
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
              width: 328, height: 140,
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
                        child: RaisedButton(onPressed: (){
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
