import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/data/response_data.dart';
import 'package:rider_app/page/drawer/calculate_page.dart';
import 'package:rider_app/page/drawer/notice_page.dart';
import 'package:rider_app/page/drawer/personal_info_page.dart';
import 'package:rider_app/page/login/login_page.dart';
import 'package:rider_app/ui/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;

class MyDrawer extends StatefulWidget {
  Bloc bloc;

  MyDrawer(this.bloc);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

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
  bool isLoading = false;
  var a=0;
  Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    getCounterFromSharedPrefs();
    WidgetsBinding.instance.removeObserver(this);

    bg.BackgroundGeolocation.ready(bg.Config(
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        distanceFilter: 10.0,
        stopOnTerminate: false,
        startOnBoot: true,
        debug: true,
        logLevel: bg.Config.LOG_LEVEL_VERBOSE
    )).then((bg.State state) {
      if (!state.enabled) {
        print('start background');
        bg.BackgroundGeolocation.start();
      }
    });
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
              //height: 250,
              height: 210,
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
                    SizedBox(height: 10),
                    // SizedBox(
                    //   width: 280,
                    //   child: Container(
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.end,
                    //         children: [
                    //           Image.asset("assets/images/ic_edit.png",width: 12,),
                    //           TextButton(onPressed: (){
                    //             Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalInfoPage(widget.bloc)));
                    //           }, child: Text("개인정보수정",
                    //               style: TextStyle(fontSize: 14, color: AppColor.yellow),textAlign: TextAlign.end))
                    //         ],
                    //       )
                    //   ),
                    // ),
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
            // ListTile(
            //   title: Row(
            //     children: [
            //       Image.asset("assets/images/ic_dollar.png", width: 22,),
            //       SizedBox(width: 10),
            //       Text('출금 계좌 관리', style: TextStyle(fontSize: 17, color: Colors.white)),
            //     ],
            //   ),
            //   onTap: (){
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => AccountCreatePage(widget.bloc)));
            //   },
            // ),
            // Container( height:0.5,color:Colors.white60),
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
                  Image.asset("assets/images/ic_edit.png", width: 22,),
                  SizedBox(width: 10),
                  Text('고객정보수정', style: TextStyle(fontSize: 17,color: Colors.white)),
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalInfoPage(widget.bloc)));
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
            ListTile(
              title: Row(
                children: [
                  Image.asset("assets/images/ic_logout.png", width: 22,),
                  SizedBox(width: 10),
                  Text('로그아웃', style: TextStyle(fontSize: 17,color: Colors.white)),
                ],
              ),
              onTap: () async {
                SharedPreferences prefs =
                await SharedPreferences.getInstance();
                prefs.remove('uid');
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (BuildContext context) =>
                        LoginPage(widget.bloc)), (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }

  getCounterFromSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      workState = prefs.getBool('workState');
      _uid = prefs.getString('uid') ?? '김동구';
      serial = prefs.getString('serial');
      userfaceImage = prefs.getString('userfaceImage');
      isload = true;
    });
    print(workState);
    print(prefs.getBool('workState'));
  }

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude.toString();
    long = position.longitude.toString();
    // widget.bloc.reverseGeo(lat: double.parse(lat), lon: double.parse(long)).then((value) {
    //   print(value);
    // });

    updateLocation(serial: serial, lat: lat, long: long).then((res){
      if(res.success) {
        print('위치 보냄');
      }else{
        print('위치 못보냄');
      }
    });

    return position;
  }

  Future<ResponseData> updateLocation({String serial, String lat, String long}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["serial"] = serial;
    params["latitude"] = lat;
    params["longitude"] = long;

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull("http://api.busandelivery.com/onLocation"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
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
      prefs.setBool('workState', workState);
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
      prefs.setBool('workState', workState);
    });

  }

}


