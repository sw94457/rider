import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
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
  var serial;
  var lat;
  var long;


  @override
  void initState() {
    super.initState();
    getCounterFromSharedPrefs();
    firebaseCloudMessaging_Listeners();
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
        print('on message');
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
