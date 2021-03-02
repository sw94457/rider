import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/find_id.dart';
import 'package:ibagudelivery_rider/find_password.dart';
import 'package:ibagudelivery_rider/ui/color.dart';

class FindTab extends StatefulWidget {
  @override
  _FindTabState createState() => _FindTabState();
}

class _FindTabState extends State<FindTab> {

  int _selectedIndx = 0;
  List _pages;
  var _tabcolor1 = AppColor.yellow;
  var _tabcolor2 = const Color(0x33FFE600);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndx = index;

      switch(_selectedIndx) {
        case 0:
          _tabcolor1 = AppColor.yellow;
          _tabcolor2 = const Color(0x33FFE600);
          break;
        case 1:
          _tabcolor1 = const Color(0x33FFE600);
          _tabcolor2 = AppColor.yellow;
          break;

        default:
          break;
      }

    });
  }

  @override
  // ignore: must_call_super
  void initState() {
    _pages = [
      FindId(),
      FindPassword(),
    ];

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.yellow),
        title: Text('아이디/비밀번호찾기',
            style: TextStyle(fontSize: 20, color: AppColor.yellow)),
        centerTitle: true,
        backgroundColor: AppColor.navy,
      ),
      body: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: AppColor.navy,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBar(
                  onTap: _onItemTapped,
                  tabs: [
                    Text('아이디찾기', style: TextStyle(fontSize: 20,color: _tabcolor1),textAlign: TextAlign.center,),
                    Text('비밀번호찾기', style: TextStyle(fontSize: 20,color: _tabcolor2),textAlign: TextAlign.center,),
                  ],
                  indicatorColor: AppColor.yellow,
                ),
              ),
              iconTheme: IconThemeData(color: AppColor.yellow),
              backgroundColor: AppColor.navy,
            ),
            body: Center(child: _pages[_selectedIndx]),
          ),
        ),

    );
  }
}
