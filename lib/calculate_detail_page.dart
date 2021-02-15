import 'package:flutter/material.dart';

class CalculateDetail extends StatefulWidget {
  @override
  _CalculateDetailState createState() => _CalculateDetailState();
}

class _CalculateDetailState extends State<CalculateDetail> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
        backgroundColor: const Color(0xff20283E),
        title: Text('상세내역',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color(0xffFFE600))),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xffFFE600)),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18,9,8,0),
                    child: Text('날짜',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: const Color(0xffFFE600)),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,0,0,0),
                    child: Text('배달비',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: const Color(0xffFFE600)),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4,0,4,0),
                    child: Text('금액',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: const Color(0xffFFE600)),),
                  ),
                  Text('업체명',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: const Color(0xffFFE600)),),
                ],
              ),
            ),
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
        return  Container(
              height: 44, width: 344,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4,0,0,5),
                          child: Container(
                           //width: 70, height: 32,
                            child: Text('2020.01.13\n  11:12:31',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),),
                          ),
                        ),
                        Container(
                          child: Text('2900원',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),),
                        ),
                        Container(
                          child: Text('26,900원',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),),
                        ),
                        Container(
                          child: Text('대독장',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),),
                        )
                      ],
                    ),
                  Container( height:0.5,color: const Color(0x80DBDBDB)),
                ],
              ),

          );
      },
      itemCount: 9,
    );
  }
}