import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/delivery_list_page.dart';
import 'package:ibagudelivery_rider/drawer.dart';
import 'package:ibagudelivery_rider/history_page.dart';
import 'package:ibagudelivery_rider/new_order_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndx = 0;
  List _pages;
  var _tabcolor1 = const Color(0xffFFE600);
  var _tabcolor2 = Colors.white60;
  var _tabcolor3 = Colors.white60;
  String _uid;

  SharedPreferences prefs;

  @override
  // ignore: must_call_super
  void initState() {
    _pages = [
      NewOrderList(),
      DeliveryList(),
      History(),
    ];

    getCounterFromSharedPrefs();
  }

  getCounterFromSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _uid = prefs.getString('uid') ?? '김동구';
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndx = index;

      switch(_selectedIndx) {
        case 0:
          _tabcolor1 = const Color(0xffFFE600);
          _tabcolor2 = Colors.white60;
          _tabcolor3 = Colors.white60;
      break;
      case 1:
        _tabcolor1 = Colors.white60;
        _tabcolor2 = const Color(0xffFFE600);
        _tabcolor3 = Colors.white60;
      break;

      case 2:
        _tabcolor1 = Colors.white60;
        _tabcolor2 = Colors.white60;
        _tabcolor3 = const Color(0xffFFE600);
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
        length: 3,
        child: Scaffold(
          backgroundColor: const Color(0xff20283E),
          appBar: AppBar(
            title: TabBar(
              onTap: _onItemTapped,
              tabs: [
                Text('신규(12)', style: TextStyle(fontSize: 16,color: _tabcolor1,letterSpacing: -1),textAlign: TextAlign.center,),
                Text('배달중(12)', style: TextStyle(fontSize: 16,color: _tabcolor2),textAlign: TextAlign.center,),
                Text('내역(18)', style: TextStyle(fontSize: 16,color: _tabcolor3,letterSpacing: -1),textAlign: TextAlign.center,),
              ],
              indicatorColor: const Color(0xffFFE600),
            ),
              iconTheme: IconThemeData(color: Color(0xffFFE600)),
            backgroundColor: const Color(0xff20283E),
          ),
          body: Center(child: _pages[_selectedIndx]),
          drawer: MyDrawer(),
        ),
      ),
    );
  }



}