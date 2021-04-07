import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rider_app/ui/color.dart';

class DeliveryDetailPage extends StatefulWidget {
  var state;

  DeliveryDetailPage({this.state});

  @override
  _DeliveryDetailPageState createState() => _DeliveryDetailPageState();
}

class _DeliveryDetailPageState extends State<DeliveryDetailPage> {
  bool isPicked;
  Color startColor;
  Color endColor;
  Color buttonColor;
  String buttonText;

  @override
  void initState() {
    super.initState();
    setColor(widget.state);
  }

  setColor(state){
    if(state == 0){
      isPicked = true;
      startColor = AppColor.neon_yellow;
      endColor = AppColor.grey;
      buttonColor = AppColor.neon_yellow;
      buttonText = '픽업완료';
    }else{
      isPicked = false;
      startColor = AppColor.grey;
      endColor = AppColor.neon_green;
      buttonColor = AppColor.neon_green;
      buttonText = '배달완료';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        brightness: Brightness.dark,
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
            height: screenSize.height,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: screenSize.width,
                          height: 30,
                          padding: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              color: buttonColor, borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/images/cash.png'),
                                  SizedBox(width: 5),
                                  Text(
                                    '배달비 3,800원',
                                    style: TextStyle(
                                      //color: Colors.white,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              Text('PM 12:08',style: TextStyle(fontSize: 20))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          width: screenSize.width,
                          decoration: BoxDecoration(
                            border: Border.all(color: startColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 1),
                                        decoration: BoxDecoration(
                                          color: startColor,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Text('출발지',style: TextStyle(fontFamily: 'cafe24', fontSize: 20)),
                                      ),
                                      SizedBox(height: 5),
                                      Text('300m', style: TextStyle(fontSize: 20, color: startColor))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        customBorder: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.all(5),
                                          width: 70,
                                          child: isPicked?
                                          Image.asset('assets/images/ic_call_y.png'):
                                          Image.asset('assets/images/ic_call_b.png'),
                                        ),
                                        onTap: (){

                                        },
                                      ),
                                      InkWell(
                                        customBorder: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.all(5),
                                          width: 70,
                                          child: isPicked?
                                          Image.asset('assets/images/ic_map_y.png'):
                                          Image.asset('assets/images/ic_map_b.png'),
                                        ),
                                        onTap: (){

                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                '대독장',
                                style: TextStyle(
                                    color: startColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    letterSpacing: 1.25),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '부산시 부산진구 동천로116 한신벤오피스텔 1018호',
                                style: TextStyle(
                                    color: startColor, fontSize: 24, letterSpacing: 1.25),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: screenSize.width,
                    child: Icon(Icons.arrow_downward, color: AppColor.yellow),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.all(5),
                    width: screenSize.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: endColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4,vertical: 1),
                                  decoration: BoxDecoration(
                                    color: endColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text('도착지',style: TextStyle(fontFamily: 'cafe24', fontSize: 20)),
                                ),
                                SizedBox(height: 5),
                                Text('300m', style: TextStyle(fontSize: 20, color: endColor))
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    width: 70,
                                    child: isPicked?
                                    Image.asset('assets/images/ic_call_b.png'):
                                    Image.asset('assets/images/ic_call_g.png'),
                                  ),
                                  onTap: (){

                                  },
                                ),
                                InkWell(
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    width: 70,
                                    child: isPicked?
                                    Image.asset('assets/images/ic_mail_b.png'):
                                    Image.asset('assets/images/ic_mail_g.png'),
                                  ),
                                  onTap: (){

                                  },
                                ),
                                InkWell(
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    width: 70,
                                    child: isPicked?
                                    Image.asset('assets/images/ic_map_b.png'):
                                    Image.asset('assets/images/ic_map_g.png'),
                                  ),
                                  onTap: (){

                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          '010-2211-1122',
                          style: TextStyle(
                              color: endColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              letterSpacing: 1.25),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '부산시 부산진구 동천로116 한신벤오피스텔 1018호',
                          style: TextStyle(
                              color: endColor, fontSize: 24, letterSpacing: 1.25),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('요청사항 메세지',style: TextStyle(color: AppColor.yellow,fontSize: 24)),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('초인종을 누르지 말아주세요.초인종을 누르지 말아주세요.초인종을 누르지 말아주세요.초인종을 누르지 말아주세요.', style: TextStyle(fontSize: 24,color: Colors.white)),
                  ),
                  SizedBox(height: 5),
                  Divider(color: AppColor.grey),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('접수번호',style: TextStyle(color: AppColor.yellow,fontSize: 24)),
                      SizedBox(width: 20),
                      Text('#1211', style: TextStyle(fontSize: 24,color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 120)
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: 10,right: 10,bottom: 30),
              width: screenSize.width,
              color: AppColor.navy,
              height: 88,
              child: TextButton(
                child: Text(buttonText,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(buttonColor),
                    overlayColor: MaterialStateProperty.all<Color>(
                        Colors.black.withOpacity(0.5))),
                onPressed: () {
                  if(buttonText == '배달완료'){
                    buttonText = '현장결제';
                  }else if(buttonText == '현장결제'){

                  }else{
                    setColor(1);
                  }
                  setState(() {});
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
