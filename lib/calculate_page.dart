import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/calculate_detail_page.dart';

class Calculate extends StatefulWidget {
  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
        backgroundColor: const Color(0xff20283E),
        title: Text('정산',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color(0xffFFE600)),textAlign: TextAlign.center,),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xffFFE600)),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: MyListView(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 344, height: 56,
                child: RaisedButton(onPressed: (){
                  _showDialog1();
                },
                child: Text('총 131,211원 정산하기',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  color: const Color(0xffFFE600),
                ),
              ),
            )
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
            width: 328, height: 140,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,0,38),
                  child: Text('정산하시겠습니까?',style: TextStyle(fontSize: 24,color: Colors.white),),
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
                        _showDialog2();
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
  void _showDialog2() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: const Color(0xff3B4255),
            content: Container(
              height: 140,
              child: Row(
                children: [
                  Image.asset('images/ch.png',width: 24, height: 24,),
                  Text('정산이 완료 되었습니다.',style: TextStyle(fontSize: 20,color: Colors.white),),
                ],
              ),
            )
        );
      },
    );
  }
}



class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Container(
              height: 104, width: 344,
                color: const Color(0xff3B4255),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(child: Image.asset('images/Group 9.png'),alignment: Alignment.centerLeft,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(53,0,0,0),
                            child: Text('1월 2주',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                          ),
                          Row(
                            children: [
                              Text('131,211원',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: const Color(0xffFFE600),),),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('images/Union.png',width: 8,),
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,15,0,0),
                        child: Container(child: Text('2021.01.04~2021.01.10',style: TextStyle(fontSize: 14,color: Colors.white),),alignment: Alignment.centerLeft,),
                      )

                    ],
                  ),
                )
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CalculateDetail()));
            },
          ),
        );
      },
      itemCount: 9,
    );
  }
}

