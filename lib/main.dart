import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/bloc/bloc.dart';
import 'package:ibagudelivery_rider/login_page.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

class _MyHomePageState extends State<MyHomePage> {
  String chid;
  SharedPreferences prefs;
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    firebaseCloudMessaging_Listeners();
    getCounterFromSharedPrefs();
  }

  getCounterFromSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      chid = prefs.getString('uid');
      print(prefs.getString('serial'));
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
}
