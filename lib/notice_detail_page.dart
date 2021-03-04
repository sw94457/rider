import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/notice_page.dart';

class NoticeDetail extends StatefulWidget {

  @override
  _NoticeDetailState createState() => _NoticeDetailState();
}

class _NoticeDetailState extends State<NoticeDetail> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
        backgroundColor: const Color(0xff20283E),
        title: Text('공지사항',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color(0xffFFE600))),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xffFFE600)),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text('시스템점검안내',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text('2020.11.12',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: const Color(0xff959595)),),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container( height:0.5,color: const Color(0x80DBDBDB)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('안녕하세요. 동구라이더앱을 이용하시는 라이더분들께 감사드립니다.\n\n시스템점검으로 서비스 이용이 2020년 12월 11일 00:00 ~ 08:00(8시간) 중지됩니다.\n이용에 불편을 드려 죄송합니다.',
                    style: TextStyle(fontSize: 14,color: Colors.white),
                    ),
                  )

                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
}


