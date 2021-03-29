import 'dart:async';
import 'dart:isolate';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/page/drawer/account_create_page.dart';
import 'package:rider_app/page/drawer/calculate_page.dart';
import 'package:rider_app/page/drawer/notice_page.dart';
import 'package:rider_app/page/drawer/personal_info_page.dart';
import 'package:rider_app/page/drawer/setting_page.dart';
import 'package:rider_app/ui/color.dart';
import 'package:shared_preferences/shared_preferences.dart';


class _MyDrawerState extends State<MyDrawer> with WidgetsBindingObserver {
  SharedPreferences prefs;
  var serial;
  var userfaceImage;
  String _uid;
  String lat;
  String long;
  Timer _timer;
  bool workState = false;
  bool isload = false;
  var a=0;

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude.toString();
    long = position.longitude.toString();

    widget.bloc.updateLocation(serial: serial, lat: lat, long: long).then((res){
      if(res.success) {
        print('위치 보냄');
      }else{
        print('위치 못보냄');
      }
    });

    return position;
  }

  start(){
    widget.bloc.riderOn(serial: serial).then((res){
      if(res.success){
        print('출근1');
        getCurrentLocation();
        _timer = Timer.periodic(Duration(seconds: 10), (timer) {
          getCurrentLocation();
        });
      }else{
        print('출근2');
      }
    });
    setState(() {
      workState = true;
    });
  }

  stop(){
    widget.bloc.riderOff(serial: serial).then((res){
      if(res.success){
        print('퇴근1');
        _timer?.cancel();
      }else{
        print('퇴근2');
      }
    });

    setState(() {
      workState = false;
    });

  }

  @override
  void initState() {
    super.initState();
    getCounterFromSharedPrefs();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColor.navy,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 250,
              child: DrawerHeader(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width:45, height: 45,
                          child: isload?CircleAvatar(
                              backgroundImage: NetworkImage('${userfaceImage}')
                          ):CircleAvatar(
                              backgroundImage: AssetImage('assets/images/profile.png')
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${_uid} 라이더님',
                                  style: TextStyle(fontSize: 18, color: Colors.white)),
                              Text('오늘도 안전운전하세요:)',
                                  style: TextStyle(fontSize: 16, color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 280,
                      child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset("assets/images/ic_edit.png",width: 12,),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalInfoPage(widget.bloc)));
                              }, child: Text("개인정보수정",
                                  style: TextStyle(fontSize: 14, color: AppColor.yellow),textAlign: TextAlign.end))
                            ],
                          )
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            width: 124, height: 56,
                            child: workState ? RaisedButton(onPressed: (){
                            },child: Text("출근하기",
                                style: TextStyle(fontSize: 17, color: Colors.white)),
                              color: Colors.white12,
                            ):RaisedButton(onPressed: (){
                              start();
                            },child: Text("출근하기",
                                style: TextStyle(fontSize: 17,)),
                              color: AppColor.yellow,
                            )
                        ),
                        SizedBox(
                            width: 124, height: 56,
                            child: workState ? RaisedButton(onPressed: (){
                              stop();
                            },child: Text("퇴근하기",
                                style: TextStyle(fontSize: 17)),
                              color: AppColor.yellow,
                            ):RaisedButton(onPressed: (){
                            },child: Text("퇴근하기",
                                style: TextStyle(fontSize: 17,color: Colors.white)),
                              color: Colors.white12,
                            )
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container( height:2.0,color:Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset("assets/images/ic_coin.png", width: 22,),
                  SizedBox(width: 10),
                  Text('정산', style: TextStyle(fontSize: 17,color: Colors.white)),
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CalculatePage()));
              },
            ),
            Container( height:0.5,color:Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset("assets/images/ic_dollar.png", width: 22,),
                  SizedBox(width: 10),
                  Text('출금 계좌 관리', style: TextStyle(fontSize: 17, color: Colors.white)),
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AccountCreatePage(widget.bloc)));
              },
            ),
            Container( height:0.5,color:Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset("assets/images/ic_info.png", width: 22,),
                  SizedBox(width: 10),
                  Text('공지사항', style: TextStyle(fontSize: 17,color: Colors.white)),
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NoticePage(widget.bloc)));
              },
            ),
            Container( height:0.5,color:Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset("assets/images/ic_setting.png", width: 22,),
                  SizedBox(width: 10),
                  Text('환경설정', style: TextStyle(fontSize: 17,color: Colors.white)),
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage(widget.bloc)));
              },
            ),
            Container(height:0.5,color:Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset("assets/images/ic_talk.png", width: 22),
                  SizedBox(width: 10),
                  Text('고객센터', style: TextStyle(fontSize: 17,color: Colors.white)),
                ],
              ),
              onTap: (){},
            ),
            Container( height:0.5,color:Colors.white60),
          ],
        ),
      ),
    );
  }

  getCounterFromSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _uid = prefs.getString('uid') ?? '김동구';
      serial = prefs.getString('serial');
      userfaceImage = prefs.getString('userfaceImage');
      isload = true;
    });
  }
}

class MyDrawer extends StatefulWidget {
  Bloc bloc;

  MyDrawer(this.bloc);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}
