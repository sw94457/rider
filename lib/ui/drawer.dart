import 'dart:async';
import 'dart:convert';
import 'package:background_location/background_location.dart';
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
import 'package:toast/toast.dart';

//import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  Bloc bloc;

  MyDrawer(this.bloc);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with WidgetsBindingObserver {
  SharedPreferences prefs;
  Logger logger = Logger();
  var serial;
  var userfaceImage;
  String _uid;
  bool workState = false;
  bool isload = false;
  bool isLoading = false;
  var a = 0;

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
              //height: 250,
              height: 210,
              child: DrawerHeader(
                child: Column(
                  children: [
                    Row(
                      children: [
                        // SizedBox(
                        //   width:45, height: 45,
                        //   child: isload?CircleAvatar(
                        //       backgroundImage: NetworkImage('${userfaceImage}')
                        //   ):CircleAvatar(
                        //       backgroundImage: AssetImage('assets/images/profile.png')
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${_uid} 라이더님',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                              Text('오늘도 안전운전하세요:)',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 124,
                          height: 56,
                          child: (workState)
                              ? RaisedButton(
                                  onPressed: () {
                                    start();
                                  },
                                  child: Text("출근하기",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white)),
                                  color: Colors.white12,
                                )
                              : RaisedButton(
                                  onPressed: () {
                                    start();
                                  },
                                  child: Text("출근하기",
                                      style: TextStyle(fontSize: 17)),
                                  color: AppColor.yellow,
                                ),
                        ),
                        SizedBox(
                          width: 124,
                          height: 56,
                          child: workState
                              ? RaisedButton(
                                  onPressed: () {
                                    stop();
                                  },
                                  child: Text("퇴근하기",
                                      style: TextStyle(fontSize: 17)),
                                  color: AppColor.yellow,
                                )
                              : RaisedButton(
                                  onPressed: () {
                                    stop();
                                  },
                                  child: Text("퇴근하기",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white)),
                                  color: Colors.white12,
                                ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(height: 2.0, color: Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset(
                    "assets/images/ic_coin.png",
                    width: 22,
                  ),
                  SizedBox(width: 10),
                  Text('정산',
                      style: TextStyle(fontSize: 17, color: Colors.white)),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CalculatePage(bloc: widget.bloc)));
              },
            ),
            Container(height: 0.5, color: Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset(
                    "assets/images/ic_info.png",
                    width: 22,
                  ),
                  SizedBox(width: 10),
                  Text('공지사항',
                      style: TextStyle(fontSize: 17, color: Colors.white)),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NoticePage(widget.bloc)));
              },
            ),
            Container(height: 0.5, color: Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset(
                    "assets/images/ic_edit.png",
                    width: 22,
                  ),
                  SizedBox(width: 10),
                  Text('고객정보수정',
                      style: TextStyle(fontSize: 17, color: Colors.white)),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PersonalInfoPage(widget.bloc))).then((value) {
                  getCounterFromSharedPrefs();
                  setState(() {});
                });
              },
            ),
            Container(height: 0.5, color: Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset("assets/images/ic_talk.png", width: 22),
                  SizedBox(width: 10),
                  Text('고객센터',
                      style: TextStyle(fontSize: 17, color: Colors.white)),
                ],
              ),
              onTap: () {
                _launchInBrowser("https://pf.kakao.com/_SuxlJK");
              },
            ),
            Container(height: 0.5, color: Colors.white60),
            ListTile(
              title: Row(
                children: [
                  Image.asset(
                    "assets/images/ic_logout.png",
                    width: 22,
                  ),
                  SizedBox(width: 10),
                  Text('로그아웃',
                      style: TextStyle(fontSize: 17, color: Colors.white)),
                ],
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('uid');
                prefs.remove('serial');
                stop();
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            LoginPage(widget.bloc)),
                    (route) => false);
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
      if (prefs.getBool('workState') == null) {
        workState = false;
      } else {
        workState = prefs.getBool('workState');
      }
      serial = prefs.getString('serial');
      isload = true;
    });
    _uid = widget.bloc.user.name != null ? widget.bloc.user.name : '김동구';
    userfaceImage =
        widget.bloc.user.faceImage != null ? widget.bloc.user.faceImage : '';
  }

  Future<void> getCurrentLocation(Location location) async {
    print(location.latitude.toString() + ', ' + location.longitude.toString());
    updateLocation(
            serial: widget.bloc.user.serial,
            lat: location.latitude.toString(),
            long: location.longitude.toString())
        .then((res) {
      if (res.success) {
        print('위치 보냄');
      } else {
        print('위치 못보냄');
      }
      return res.success;
    });
  }

  Future<ResponseData> updateLocation(
      {String serial, String lat, String long}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["serial"] = widget.bloc.user.serial;
    params["latitude"] = lat;
    params["longitude"] = long;

    isLoading = true;
    var response = await http.post(
        Uri.parse("http://api.busandelivery.com/onLocation"),
        body: params);
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

  start() {
    widget.bloc.riderOn(serial: serial).then((res) {
      if (res.success) {
        print('출근1');
        setState(() {
          workState = true;
          prefs.setBool('workState', workState);
        });
        Toast.show(widget.bloc.user.name+'라이더님 출근처리 되었습니다.', context, duration:2);
        BackgroundLocation.startLocationService();

        BackgroundLocation.getLocationUpdates((location) {
          // print(location.latitude.toString()+', '+location.longitude.toString());
          getCurrentLocation(location);
        });
        // bg.BackgroundGeolocation.ready(bg.Config(
        //     desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        //     distanceFilter: 10.0,
        //     stopOnTerminate: false,
        //     startOnBoot: true,
        //     debug: true,
        //     logLevel: bg.Config.LOG_LEVEL_VERBOSE
        // )).then((bg.State state) {
        //   if (!state.enabled) {
        //     print('start background');
        //     bg.BackgroundGeolocation.start();
        //   }
        // });

        // getCurrentLocation();
        // _timer = Timer.periodic(Duration(seconds: 10), (timer) {
        //   getCurrentLocation();
        // });
      } else {
        Toast.show(res.errorMsg+'', context, duration:2);
        print('출근2');
      }
    });
  }

  stop() {
    widget.bloc.riderOff(serial: serial).then((res) {
      if (res.success) {
        print('퇴근1');
        Toast.show(widget.bloc.user.name+'라이더님 퇴근처리 되었습니다.', context, duration:2);
        setState(() {
          workState = false;
          prefs.setBool('workState', workState);
        });
        //_timer?.cancel();
        BackgroundLocation.stopLocationService();
      } else {
        print('퇴근2');
        Toast.show(res.errorMsg+'', context, duration:2);
      }
    });
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
