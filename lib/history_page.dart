import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/history_detail_page.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: const Color(0xff20283E),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: MyListView(),
            ),
          ],
        ),
      ),
    );
  }
}

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryDetail()));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Column(
                    children: [
                      Stack(
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
                      Container(
                        height: 107,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), //모서리를 둥글게
                            border: Border.all(color: const Color(0xff9C9C9C), width: 1)),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8,8,0,0),
                                  child: Container(
                                      width: 95, height: 57,
                                      child: Text('대독장',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,)
                                  ),
                                ),
                                Container(
                                  height: 17,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(9,0,0,0),
                                    child: Row(
                                      children: [
                                        Text('290M',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.white),),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5,0,5,0),
                                          child: Image.asset('images/ss_a.png',width: 15,),
                                        ),
                                        Text('300M',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.white),),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5,0,0,0),
                              child: Column(
                                children: [
                                  Container(
                                    width: 228,
                                    child: Row(
                                      children: [
                                        Image.asset('images/st_a.png',width: 20,),
                                        SizedBox(
                                            width: 208,
                                            child: Text('부산시 부산진구 동천로116 한신밴오피스텔 1018호',style: TextStyle(fontSize: 18,color: Colors.white))
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 228,
                                    child: Row(
                                      children: [
                                        Image.asset('images/end_a.png',width: 20,),
                                        SizedBox(
                                            width: 208,
                                            child: Text('부산시 부산진구 동천로116 한신밴오피스텔 1018호',style: TextStyle(fontSize: 18,color: Colors.white))
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                ),
            ),
          ),
        );
      },
      itemCount: 2,
    );
  }
}