import 'package:flutter/material.dart';
import 'package:flutter_tttttttt/access_terms_page.dart';
import 'package:flutter_tttttttt/account_create_page.dart';
import 'package:flutter_tttttttt/account_management_page.dart';
import 'package:flutter_tttttttt/calculate_detail_page.dart';
import 'package:flutter_tttttttt/calculate_page.dart';
import 'package:flutter_tttttttt/delivery_delivery_page.dart';
import 'package:flutter_tttttttt/delivery_list_page.dart';
import 'package:flutter_tttttttt/delivery_pick_page.dart';
import 'package:flutter_tttttttt/history_detail_page.dart';
import 'package:flutter_tttttttt/history_page.dart';
import 'package:flutter_tttttttt/join_create_page.dart';
import 'package:flutter_tttttttt/login_page.dart';
import 'package:flutter_tttttttt/new_order_list.dart';
import 'package:flutter_tttttttt/notice_detail_page.dart';
import 'package:flutter_tttttttt/notice_page.dart';
import 'package:flutter_tttttttt/order_detail_page.dart';
import 'package:flutter_tttttttt/personal_information_page.dart';
import 'package:flutter_tttttttt/phone_authent_page.dart';
import 'package:flutter_tttttttt/setting_page.dart';
import 'package:flutter_tttttttt/tab_page.dart';
import 'package:flutter_tttttttt/under_review_page.dart';
import 'dart:ui';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';


final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      //Loginpage(),
      //AaccessTerms(),
      //PhoneAuthent(),
      //JoinCreate(),
      //UnderReview(),
      //NewOrderList(),
      //OrderDetail(),
      //DeliveryList(),
      //DeliveryPick(),
      //DeliveryDelivery(),
      //History(),
      //HistoryDetail(),
      //Calculate(),
      //CalculateDetail(),
      //AccountCreate(),
      //AccountManagement(),
      //Notice(),
      //NoticeDetail(),
      //Setting(),
      //PersonalInformation(),
      //TabPage(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String chid;

  SharedPreferences prefs;


  @override
  void initState() {
    super.initState();
    firebaseCloudMessaging_Listeners();
    getCounterFromSharedPrefs();
  }

  getCounterFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      chid = prefs.getString('uid');
    });
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token){
      print('token:'+token);
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
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context){
      if (chid == null) {
        return Loginpage();
      } else {
        return TabPage();
      }
    }
    );
      
    //   Scaffold(
    //   // backgroundColor: const Color(0xff20283E),
    //   // body: Center(
    //   //   child: Column(
    //   //     children: <Widget>[
    //   //       Text('displaySize : ${MediaQuery.of(context).size}'),
    //   //       Padding(
    //   //         padding: const EdgeInsets.fromLTRB(0,137,0,48),
    //   //         child: Container(
    //   //           //margin: const EdgeInsets.fromLTRB(43, 32, 43, 566),
    //   //           child: Text(
    //   //               '부산동구딜리버리',
    //   //                 style: TextStyle(fontWeight: FontWeight.bold,
    //   //                     fontSize: 36,
    //   //                     color: const Color(0xffFFE600)),
    //   //             ),
    //   //         ),
    //   //       ),
    //   //       Container(
    //   //           //margin: const EdgeInsets.fromLTRB(102, 0, 101, 318),
    //   //           child: Image.asset("images/logo_m.png", width: 157, height: 95,))
    //   //     ],
    //   //   )
    //   // ),
    // );
  }
}
