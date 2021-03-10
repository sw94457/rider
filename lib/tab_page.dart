import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/delivery_list_page.dart';
import 'package:ibagudelivery_rider/drawer.dart';
import 'package:ibagudelivery_rider/history_page.dart';
import 'package:ibagudelivery_rider/new_order_list.dart';
import 'package:ibagudelivery_rider/ui/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/bloc.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class TabPage extends StatefulWidget {
  Bloc bloc;

  TabPage(this.bloc);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndx = 0;
  List _pages;
  var _tabcolor1 = const Color(0xffFFE600);
  var _tabcolor2 = Colors.white60;
  var orderlistcount = 0;
  SharedPreferences prefs;

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print('token:' + token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        print('on 2321312');
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
  void initState() {
    _pages = [
      NewOrderList(widget.bloc),
      DeliveryList(widget.bloc),
    ];

    getCounterFromSharedPrefs();
    updata();
  }

  updata() async {
    Future.delayed(Duration(seconds: 2), (){
      setState(() {
       orderlistcount = prefs.getInt('orderlistcount') ?? 0;
      });
    });
  }

  getCounterFromSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndx = index;
      orderlistcount = prefs.getInt('orderlistcount') ?? 0;

      switch(_selectedIndx) {
        case 0:
          _tabcolor1 = const Color(0xffFFE600);
          _tabcolor2 = Colors.white60;
      break;
      case 1:
        _tabcolor1 = Colors.white60;
        _tabcolor2 = const Color(0xffFFE600);
      break;

      default:
      break;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColor.navy,
          appBar: AppBar(
            title: TabBar(
              onTap: _onItemTapped,
              tabs: [
                Text('신규(${orderlistcount})', style: TextStyle(fontSize: 16,color: _tabcolor1),textAlign: TextAlign.center,),
                Text('배달중(12)', style: TextStyle(fontSize: 16,color: _tabcolor2),textAlign: TextAlign.center,),
              ],
              indicatorColor: AppColor.yellow,
            ),
              iconTheme: IconThemeData(color: AppColor.yellow),
            backgroundColor: AppColor.navy,
          ),
          body: Center(child: _pages[_selectedIndx]),
          drawer: MyDrawer(widget.bloc),
        ),
      ),
    );
  }



}