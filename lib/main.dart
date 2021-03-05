import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ibagudelivery_rider/bloc/bloc.dart';
import 'package:ibagudelivery_rider/login_page.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/response_data.dart';
import 'login_page.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<Bloc>(create: (_) => Bloc())],
      child: Consumer<Bloc>(
        builder: (context, bloc, _) {
          return MaterialApp(
            title: '부산동구배달앱',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: MyHomePage(bloc),
            // home: TabRootPage(bloc),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  Bloc bloc;

  MyHomePage(this.bloc);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  String chid;
  SharedPreferences prefs;
  bool isLogin = false;
  Timer _timer;
  var serial;
  var a=0;
  var lat;
  var long;
  Position position;

  @override
  void initState() {
    super.initState();
    getCounterFromSharedPrefs();
    firebaseCloudMessaging_Listeners();
    WidgetsBinding.instance.addObserver(this);
  }

  getCounterFromSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      chid = prefs.getString('uid');
      serial = prefs.getString('serial');
    });
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print('token:' + token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Loginpage(widget.bloc);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("resumed");
        break;
      case AppLifecycleState.inactive:
        print("inactive");
        break;
      case AppLifecycleState.paused:
        print("paused");
         //callLocation();
        break;
      case AppLifecycleState.detached:
        print("detached");
        break;
    }
  }

  callLocation() async {

    _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      print(a);
      a++;
      await updateLocation(serial: serial,lat: lat,long: long);
    });

  }


  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude.toString();
    var long = position.longitude.toString();
    serial = prefs.getString('serial');

    // updateLocation(serial: serial, lat: lat, long: long).then((res){
    //   if(res.success){
    //     print('위치 보냄1');
    //     print(formatDate(DateTime.now(), [hh, ':', nn, ':', ss, ' ', am]));
    //   }else{
    //     print('위치 못보냄');
    //   }
    // });

    return position;
  }

  getCurrentLocation2() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude.toString();
    long = position.longitude.toString();
    serial = 'LfQJ7+bsbor0ZLCGok4T/g==';

    print(lat);
    print(long);
    print(a);
    print(serial);

  }

  updateLocation({String serial, String lat, String long}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["serial"] = serial;
    params["latitude"] = lat;
    params["longitude"] = long;

    var response = await http.post(
        Uri.encodeFull("http://13.125.11.129:8080/busan_donggu_web/api/rider/onLocation"), body: params);
    print(response.body);
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
  }

}
