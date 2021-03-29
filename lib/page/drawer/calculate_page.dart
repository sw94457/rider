import 'package:flutter/material.dart';
import 'package:rider_app/page/drawer/calculate_detail_page.dart';
import 'package:rider_app/ui/color.dart';

class CalculatePage extends StatefulWidget {
  @override
  _CalculatePageState createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldkey,
        backgroundColor: AppColor.navy,
        appBar: AppBar(
          title: Text(
            '정산',
            style: TextStyle(
                //fontSize: 24,
                //fontWeight: FontWeight.bold,
                color: AppColor.yellow),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColor.yellow),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ),
        body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 80),
            height: screenSize.height,
            child: ListView(
              children: List.generate(10, (index) {
                return Padding(
                  padding: EdgeInsets.only(top:10, right: 10,left: 10),
                  child: CalculateItem(),
                );
              }),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: 10,right: 10,bottom: 30),
              width: screenSize.width,
              height: 88,
              color: AppColor.navy,
              child: TextButton(
                child: Text('총 131,211원 정산하기',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(AppColor.yellow),
                    overlayColor: MaterialStateProperty.all<Color>(
                        Colors.black.withOpacity(0.5))),
                  onPressed: () {
                    _showDialog1();
                  },
                ),
              ),
          )
        ],
      )
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

class CalculateItem extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return InkWell(
      child: Container(
          width: screenSize.width,
          color: AppColor.white_navy,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4,vertical: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColor.grey
                  ),
                  child: Text('정산완료',style: TextStyle(fontFamily: 'cafe24')),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Text('1월 2주',
                        style: TextStyle(fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'cafe24',
                            color: Colors.white),
                      ),
                    ),
                    Row(
                      children: [
                        Text('131,211원',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColor.yellow,
                            fontFamily: 'cafe24'),
                        ),
                        SizedBox(child: Icon(Icons.arrow_right, size:45,color: AppColor.yellow))
                      ],
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Text('2021.01.04~2021.01.10',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          )
      ),
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CalculateDetailPage()));
      },
    );
  }
}



