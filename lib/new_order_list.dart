import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/order_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/bloc.dart';

class NewOrderList extends StatefulWidget {
  Bloc bloc;

  NewOrderList(this.bloc);

  @override
  _NewOrderListState createState() => _NewOrderListState();
}

class _NewOrderListState extends State<NewOrderList> {
  List orderlist = [];
  bool _isloadind = true;
  int _itemCount = 0;
  var serial;
  var paytype;

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getCounterFromSharedPrefs();
  }

  getCounterFromSharedPrefs() async {

    await SharedPreferences.getInstance().then((pref) {
     serial = pref.getString('serial');
    });

    await widget.bloc.orderlist(serial: serial).then((res){
      orderlist = res;
      _itemCount = orderlist.length;
    });

    setState(() {
      _isloadind = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: const Color(0xff20283E),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child:_isloadind ? Center(child: CircularProgressIndicator()): MyListView(),
            ),
          ],
          ),
      ),
    );
  }

  MyListView(){
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return ListView.builder(
          itemCount: _itemCount,
          itemBuilder: (context, int i) {
            switch(orderlist[i]['pay_type']) {
              case 'A':
                paytype = '카드결제';
                break;
              case 'B':
                paytype = '카드결제';
                break;
              case 'C':
                paytype = '카드결제';
                break;
              default:
                break;
            }
            return  InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderDetail(widget.bloc,data : orderlist[i]['serial'])));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 24,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: const Color(0xffFF2020),
                                    width: 1),
                                color: const Color(0xffFF2020)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            70, 0, 5, 0),
                                        child: Text('배달비 ${orderlist[i]['rider_delivery_price']}원', style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  child: Text('${orderlist[i]['registered_date'].substring(10,16)}', style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 24,
                            width: 66,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: const Color(0xff62FF2B),
                                    width: 1),
                                color: const Color(0xff62FF2B)),
                            child: Text('${paytype}', style: TextStyle(fontSize: 16,
                                fontFamily: 'cafe24'),),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: const Color(0xffFF2020), width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text('${orderlist[i]['company_name']}', style: TextStyle(fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xffEBFF00)),)
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text('${orderlist[i]['company_address']}',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ),
                              Image.asset('images/arrow1.png', width: 18,),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text('${orderlist[i]['user_phone']}', style: TextStyle(
                                      fontSize: 24, color: const Color(0xffEBFF00)))
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text('${orderlist[i]['user_address']}',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

