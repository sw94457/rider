import 'package:flutter/material.dart';
import 'package:rider_app/ui/color.dart';

class CalculateDetailPage extends StatefulWidget {
  @override
  _CalculateDetailPageState createState() => _CalculateDetailPageState();
}

class _CalculateDetailPageState extends State<CalculateDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        title: Text('상세내역',
            style: TextStyle(
                // fontSize: 24,
                // fontWeight: FontWeight.bold,
                color: AppColor.yellow)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.yellow),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            color: AppColor.white_navy,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width:screenSize.width/4,
                  alignment: Alignment.center,
                  child: Text(
                    '날짜',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColor.yellow),
                  ),
                ),
                Container(
                  //color: Colors.blue,
                  width:screenSize.width/5,
                  alignment: Alignment.center,
                  child: Text(
                    '배달비',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColor.yellow),
                  ),
                ),
                Container(
                 // color: Colors.red,
                  width:screenSize.width/3.5,
                  alignment: Alignment.center,
                  child: Text('금액',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColor.yellow),
                  ),
                ),
                Container(
                  //color: Colors.blue,
                  width:screenSize.width/4,
                  alignment: Alignment.center,
                  child: Text('업체명',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColor.yellow),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: List.generate(10, (index) {
                return Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width:screenSize.width/4,
                        alignment: Alignment.center,
                        child: Text('2020.01.13\n11:12:31',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              //fontWeight: FontWeight.bold,
                              color: Colors.white),

                        ),
                      ),
                      Container(
                        width:screenSize.width/5,
                        alignment: Alignment.center,
                        child: Text('2900원',
                          style: TextStyle(
                              fontSize: 16,
                              //fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        width:screenSize.width/3.5,
                        alignment: Alignment.center,
                        child: Text('26,900원',
                          style: TextStyle(
                              fontSize: 16,
                              //fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        width:screenSize.width/4,
                        alignment: Alignment.center,
                        child: Text('대독장',
                          style: TextStyle(
                              fontSize: 16,
                              //fontWeight: FontWeight.bold,
                              color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              })
            ),
          ),
        ],
      ),
    );
  }
}

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          height: 44,
          width: 344,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 0, 5),
                    child: Container(
                      //width: 70, height: 32,
                      child: Text(
                        '2020.01.13\n11:12:31',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      '2900원',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    child: Text(
                      '26,900원',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    child: Text(
                      '대독장',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              Container(height: 0.5, color: const Color(0x80DBDBDB)),
            ],
          ),
        );
      },
      itemCount: 9,
    );
  }
}
