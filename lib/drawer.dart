import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ibagudelivery_rider/account_management_page.dart';
import 'package:ibagudelivery_rider/personal_information_page.dart';
import 'package:ibagudelivery_rider/setting_page.dart';
import 'package:ibagudelivery_rider/ui/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'account_create_page.dart';
import 'bloc/bloc.dart';
import 'calculate_page.dart';
import 'notice_page.dart';

class MyDrawer extends StatefulWidget {
  Bloc bloc;

  MyDrawer(this.bloc);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  SharedPreferences prefs;
  var serial;
  var userfaceImage;
  String _uid;
  Timer _timer;
  bool workState = false;
  bool isload = false;

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude.toString();
    var long = position.longitude.toString();
    print(position.latitude);
    print(position.longitude);


    widget.bloc.updateLocation(serial: serial, lat: lat, long: long).then((res){
      if(res.success){
        print('위치 보냄');
      }else{
        print('위치 못보냄');
      }
    });

    return position;
  }

  start(){
    print('출근');
    widget.bloc.riderOn(serial: serial).then((res){
      if(res.success){
        print('출근1');
        getCurrentLocation();
        _timer = Timer.periodic(Duration(seconds: 30), (timer) {
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
    print('퇴근');
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

  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColor.navy,
        child: ListView(
          padding: EdgeInsets.zero ,
          children: [
            SizedBox(
              height: 225,
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
                              backgroundImage: AssetImage('images/profile.png')
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
                              Image.asset("images/edit.png",width: 12,),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalInformation(widget.bloc)));
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
                                style: TextStyle(fontSize: 14, color: Colors.white)),
                              color: Colors.white12,
                            ):RaisedButton(onPressed: (){
                              start();
                            },child: Text("출근하기",
                                style: TextStyle(fontSize: 14,)),
                              color: AppColor.yellow,
                            )
                        ),
                        SizedBox(
                            width: 124, height: 56,
                            child: workState ? RaisedButton(onPressed: (){
                              stop();
                            },child: Text("퇴근하기",
                                style: TextStyle(fontSize: 14)),
                              color: AppColor.yellow,
                            ):RaisedButton(onPressed: (){
                            },child: Text("퇴근하기",
                                style: TextStyle(fontSize: 14,color: Colors.white)),
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
                  Image.asset("images/Group 67.png", width: 22,),
                  SizedBox(width: 4,),
                  Text('정산', style: TextStyle(fontSize: 14,color: Colors.white)),
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Calculate()));
              },
            ),
            Container( height:0.5,color:Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset("images/data-two.png", width: 22,),
                  SizedBox(width: 4,),
                  Text('출금 계좌 관리', style: TextStyle(fontSize: 14,color: Colors.white)),
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AccountCreate(widget.bloc)));
              },
            ),
            Container( height:0.5,color:Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset("images/attention.png", width: 22,),
                  SizedBox(width: 4,),
                  Text('공지사항', style: TextStyle(fontSize: 14,color: Colors.white)),
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Notice(widget.bloc)));
              },
            ),
            Container( height:0.5,color:Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset("images/uil_setting.png", width: 22,),
                  SizedBox(width: 4,),
                  Text('환경설정', style: TextStyle(fontSize: 14,color: Colors.white)),
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Setting()));
              },
            ),
            Container( height:0.5,color:Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset("images/Vector.png", width: 22,),
                  SizedBox(width: 4,),
                  Text('고객센터', style: TextStyle(fontSize: 14,color: Colors.white)),
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
