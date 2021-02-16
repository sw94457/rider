import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/notice_detail_page.dart';

class Notice extends StatefulWidget {
  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
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
        return  InkWell(
          child: Container(
            height: 44, width: 344,
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
                Container( height:0.5,color: const Color(0x80DBDBDB)),
              ],
            ),

          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => NoticeDetail()));
          },
        );
      },
      itemCount: 3,
    );
  }
}