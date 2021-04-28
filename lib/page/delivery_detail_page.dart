import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/data/order.dart';
import 'package:rider_app/ui/button.dart';
import 'package:rider_app/ui/color.dart';
import 'package:rider_app/ui/progress.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryDetailPage extends StatefulWidget {
  Bloc bloc;
  Order2 item;
  DeliveryDetailPage({this.bloc, this.item});

  @override
  _DeliveryDetailPageState createState() => _DeliveryDetailPageState();
}

class _DeliveryDetailPageState extends State<DeliveryDetailPage> {
  final formatter = new NumberFormat("#,###,###,###,###");
  Order2 order;
  bool isPicked;
  Color startColor;
  Color endColor;
  Color buttonColor;
  String buttonText;
  bool Loading = true;
  bool paid = false;
  bool message_dialog = false;
  String phone = '';
  var dialog_selecet = 0;

  Position position;
  var startDistance;
  var endDistance;
  var start_Distance;
  var end_Distance;

  var message1 = false;
  var message2 = false;
  var message3 = false;
  var message4 = false;
  var message5 = false;
  var message_text = '';

  @override
  void initState() {
    super.initState();
    //색변경
    setColor(widget.item.flag);
    //카카오네비 세팅
    // String kakaoAppKey = "fd1e5f69c505814fb8dbd278443fc0f0";
    // KakaoContext.clientId = kakaoAppKey;

    //디테일 불러오기
    widget.bloc.getOrderDetail(request_serial: widget.item.serial).then((value) {
      order = value;
      if(order.userPhone.length==11){
        try{
          phone = order.userPhone.substring(0,3)+'-'+
              order.userPhone.substring(3,7)+'-'+
              order.userPhone.substring(7,11);
        }catch(e){}
      }else{
        try{
          phone = order.userPhone.substring(0,3)+'-'+
              order.userPhone.substring(3,6)+'-'+
              order.userPhone.substring(6,10);
        }catch(e){}
      }
      if(order.paid =='Y') {
        paid = true;
      }else{
        paid = false;
      }
      start_Distance = Geolocator.distanceBetween(
          double.parse(order.companyLatitude),
          double.parse(order.companyLongitude),
          widget.bloc.position.latitude,
          widget.bloc.position.longitude).floor();
      end_Distance = Geolocator.distanceBetween(
          double.parse(order.userLatitude),
          double.parse(order.userLongitude),
          widget.bloc.position.latitude,
          widget.bloc.position.longitude).floor();

      if(start_Distance>=1000.0){
        startDistance = start_Distance/1000;
      }else{
        startDistance = start_Distance;
      }
      if(end_Distance>=1000.0){
        endDistance = end_Distance/1000;
      }else{
        endDistance = end_Distance;
      }

      Loading = false;
      setState(() {});
    });
  }

  setColor(flag){
    if(flag == 'A'){
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
        children:[
          Stack(
            children: [
              Loading?
              ProgressPage(screenSize.width):
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
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: paid? AppColor.neon_yellow:AppColor.neon_green,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Text(paid?'선불':'현장결제',
                                            style: TextStyle(
                                                fontFamily: 'cafe24', fontSize: 20)),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '배달비 ${formatter.format(int.parse(order.riderDeliveryPrice))}원',
                                        style: TextStyle(
                                          //color: Colors.white,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  Text( widget.item.registeredDate!=null?
                                  widget.item.registeredDate.substring(11,16):'',
                                      style: TextStyle(fontSize: 20))
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
                                          Text(
                                              startDistance<1000.0?
                                              '${startDistance}m':
                                              '${startDistance.toStringAsFixed(2)}km',
                                              style: TextStyle(fontSize: 20, color: startColor))
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
                                              launch("tel://${order.companyTel}");
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
                                    order.companyName!=null?
                                    order.companyName:'',
                                    style: TextStyle(
                                        color: startColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28,
                                        letterSpacing: 1.25),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    order.companyAddress!=null?
                                    order.companyAddress:'',
                                    style: TextStyle(
                                        color: startColor, fontSize: 24, letterSpacing: 0.85),
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
                                    Text(endDistance<1000.0?
                                        '${endDistance}m':
                                        '${endDistance.toStringAsFixed(2)}km',
                                        style: TextStyle(fontSize: 20, color: endColor))
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
                                        launch("tel://${order.userPhone}");
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
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>MyDialog(screenSize));
                                        setState(() {});
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
                                        launch("kakaonavi://route?y=${order.userLongitude}&x=${order.userLatitude}"
                                            "&sX=${order.userLatitude}&sY=${order.userLongitude}");//출발, 위에는 도착
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(phone,
                              style: TextStyle(
                                  color: endColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                  letterSpacing: 1.25),
                            ),
                            SizedBox(height: 5),
                            Text(
                              order.userAddress!=null?
                              order.userAddress:'',
                              style: TextStyle(
                                  color: endColor, fontSize: 24, letterSpacing: 0.85),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Text('요청사항 메세지',style: TextStyle(color: AppColor.yellow,fontSize: 24)),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text( order.riderMemo!=null?
                        order.riderMemo:'없음',
                            style: TextStyle(fontSize: 24,color: order.riderMemo!=null?Colors.white:Colors.grey)),
                      ),
                      SizedBox(height: 5),
                      Divider(color: AppColor.grey),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text('접수번호',style: TextStyle(color: AppColor.yellow,fontSize: 24)),
                          SizedBox(width: 20),
                          Text('#${order.orderSerial}', style: TextStyle(fontSize: 24,color: Colors.white)),
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
                      if(buttonText == '픽업완료'){
                        widget.bloc.pickUp(
                            requestserial: widget.item.serial,
                            order_serial: widget.item.orderSerial).then((res) {
                          if(res.success){
                            buttonText = '배달완료';
                            setColor('D');
                            setState(() {});
                            Toast.show('픽업이 완료되었습니다.', context, duration:2);
                          }else{
                            Toast.show(''+res.errorMsg, context, duration:2);
                          }
                        });
                      }
                      else if(buttonText == '배달완료'){
                        widget.bloc.finishDelivery(
                            requestserial: widget.item.serial,
                            order_serial: widget.item.orderSerial).then((res) {
                          if(res.success){
                            //buttonText = '현장결제';
                            Toast.show('배달이 완료되었습니다.', context, duration:2);
                            Navigator.pop(context);
                          }else{
                            Toast.show(''+res.errorMsg, context, duration:2);
                          }
                        });
                      }
                    },
                  ),
                ),
              )
            ],
          ),
          //message_dialog? MyDialog(screenSize):SizedBox()
        ]
      ),
    );
  }

  Widget MyDialog(size){
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Dialog(
        backgroundColor: AppColor.navy,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              Text(
                '간편메세지',
                style: TextStyle(color: AppColor.yellow, fontSize: 25),
              ),
              Divider(color: Colors.grey),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 30,
                        margin: EdgeInsets.only(right: 5),
                        child: Theme(
                          data: ThemeData(unselectedWidgetColor: AppColor.grey),
                          child: Checkbox(
                              value: message1,
                              onChanged: (value) {
                                message1 = value;
                                message2 = false;
                                message3 = false;
                                message4 = false;
                                message5 = false;
                                message_text = '문 앞에 두고 갑니다.';
                                setState(() {});
                              },
                              activeColor: AppColor.yellow),
                        ),
                      ),
                      Text(
                        '문 앞에 두고 갑니다.',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  message1 = !message1;
                  message2 = false;
                  message3 = false;
                  message4 = false;
                  message5 = false;
                  message_text = '문 앞에 두고 갑니다.';
                  setState(() {});
                },
              ),
              Divider(color: Colors.grey),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 30,
                        margin: EdgeInsets.only(right: 5),
                        child: Theme(
                          data: ThemeData(unselectedWidgetColor: AppColor.grey),
                          child: Checkbox(
                              value: message2,
                              onChanged: (value) {
                                message1 = false;
                                message2 = value;
                                message3 = false;
                                message4 = false;
                                message5 = false;
                                message_text = '5분 후에 도착 예정입니다.';
                                setState(() {});
                              },
                              activeColor: AppColor.yellow),
                        ),
                      ),
                      Text(
                        '1분 후에 도착 예정입니다.',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  message1 = false;
                  message2 = !message2;
                  message3 = false;
                  message4 = false;
                  message5 = false;
                  message_text = '1분 후에 도착 예정입니다.';
                  setState(() {});
                },
              ),
              Divider(color: Colors.grey),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 30,
                        margin: EdgeInsets.only(right: 5),
                        child: Theme(
                          data: ThemeData(unselectedWidgetColor: AppColor.grey),
                          child: Checkbox(
                              value: message3,
                              onChanged: (value) {
                                message1 = false;
                                message2 = false;
                                message3 = value;
                                message4 = false;
                                message5 = false;
                                message_text = '5분 후에 도착 예정입니다.';
                                setState(() {});
                              },
                              activeColor: AppColor.yellow),
                        ),
                      ),
                      Text(
                        '5분 후에 도착 예정입니다.',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  message1 = false;
                  message2 = false;
                  message3 = !message3;
                  message4 = false;
                  message5 = false;
                  message_text = '5분 후에 도착 예정입니다.';
                  setState(() {});
                },
              ),
              Divider(color: Colors.grey),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 30,
                        margin: EdgeInsets.only(right: 5),
                        child: Theme(
                          data: ThemeData(unselectedWidgetColor: AppColor.grey),
                          child: Checkbox(
                              value: message4,
                              onChanged: (value) {
                                message1 = false;
                                message2 = false;
                                message3 = false;
                                message4 = value;
                                message5 = false;
                                message_text =  '10분 후에 도착 예정입니다.';
                                setState(() {});
                              },
                              activeColor: AppColor.yellow),
                        ),
                      ),
                      Text(
                        '10분 후에 도착 예정입니다.',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  message1 = false;
                  message2 = false;
                  message3 = false;
                  message4 = !message4;
                  message5 = false;
                  message_text =  '10분 후에 도착 예정입니다.';
                  setState(() {});
                },
              ),
              Divider(color: Colors.grey),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 30,
                        margin: EdgeInsets.only(right: 5),
                        child: Theme(
                          data: ThemeData(unselectedWidgetColor: AppColor.grey),
                          child: Checkbox(
                              value: message5,
                              onChanged: (value) {
                                message1 = false;
                                message2 = false;
                                message3 = false;
                                message4 = false;
                                message5 = value;
                                message_text =   '조금 늦을것 같습니다.';
                                setState(() {});
                              },
                              activeColor: AppColor.yellow),
                        ),
                      ),
                      Text(
                        '조금 늦을것 같습니다.',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  message1 = false;
                  message2 = false;
                  message3 = false;
                  message4 = false;
                  message5 = !message5;
                  message_text =   '조금 늦을것 같습니다.';
                  setState(() {});
                },
              ),
              SizedBox(height: 15),
              SizedBox(
                width: size.width - 80,
                child: MyButton(
                  color: AppColor.yellow,
                  child: Text('보내기', style: TextStyle(color: Colors.black, fontWeight:FontWeight.bold, fontSize: 25) ),
                  onPressed: (){
                    if(!(message1||message2||message3||message4||message5)){
                      Toast.show('전송할 메세지를 선택하세요.', context, duration: 2);
                      return;
                    }
                    widget.bloc.sendMessage(message:message_text, phone: order.userPhone).then((res) {
                      if(res.success){
                        message_dialog = false;
                        Toast.show('메세지를 전송하였습니다.', context, duration: 2);
                        setState(() {});
                      }else{
                        Toast.show('메세지를 전송에 실패하였습니다.\n'+res.errorMsg, context, duration: 2);
                      }
                    });

                  },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

}
