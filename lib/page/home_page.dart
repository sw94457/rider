import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/data/order.dart';
import 'package:rider_app/page/delivery_detail_page.dart';
import 'package:rider_app/page/order_detail_page.dart';
import 'package:rider_app/ui/color.dart';
import 'package:rider_app/ui/drawer.dart';
import 'package:rider_app/ui/order_item.dart';
import 'package:rider_app/ui/progress.dart';

class HomePage extends StatefulWidget {
  Bloc bloc;

  HomePage(this.bloc);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tab_ctrl;
  List<Order2> orderList = [];
  List<Order2> newOrderList = [];
  List<Order2> deliveryOrderList = [];
  bool Loading = true;

  @override
  void initState() {
    super.initState();
    tab_ctrl = new TabController(vsync: this, length: 2);
    getList();
  }

  getList(){
    orderList.clear();
    newOrderList.clear();
    deliveryOrderList.clear();
    widget.bloc.getOrderList().then((value) {
      orderList = value;
      for(int i=0;i<orderList.length;i++){
        if(orderList[i].flag == 'W'){
          newOrderList.add(orderList[i]);
        }else{
          deliveryOrderList.add(orderList[i]);
        }
      }
      print(orderList.length);
      Loading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: MyDrawer(widget.bloc),
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: AppColor.yellow),
        bottom: TabBar(
          controller: tab_ctrl,
          indicatorColor: AppColor.yellow,
          labelColor: AppColor.yellow,
          unselectedLabelColor: AppColor.grey,
          tabs: [
            Tab(
              child: Text('신규(${newOrderList.length})',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Tab(
              child: Text('배달(${deliveryOrderList.length})',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      backgroundColor: AppColor.navy,
      body: Loading?
        ProgressPage(screenSize.width) :
        TabBarView(
        controller: tab_ctrl,
        children: [newOrder(), delivery()],
      ),
    );
  }

  newOrder() {
    return ListView(
      children: List.generate(newOrderList.length, (index) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: OrderItem(
            item: newOrderList[index],
            isNew: true,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => OrderDetailPage(
                            bloc: widget.bloc,
                            item: newOrderList[index]))).then((value) {
                getList();
              });
            },
          ),
        );
      }),
    );
  }

  delivery() {
    return ListView(
      children: List.generate(deliveryOrderList.length, (index) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: OrderItem(
            isNew: false,
            item: deliveryOrderList[index],
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => DeliveryDetailPage(
                          bloc:widget.bloc, item: deliveryOrderList[index]))).then((value){
                getList();
              });
            },
          ),
        );
      }),
    );
  }
}
