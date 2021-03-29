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

class HomePage extends StatefulWidget {
  Bloc bloc;

  HomePage(this.bloc);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tab_ctrl;
  List<Order> orderList = [];
  @override
  void initState() {
    super.initState();
    tab_ctrl = new TabController(vsync: this, length: 2);
    widget.bloc.getOrderList().then((value) {
      orderList = value;
      print(orderList.length);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(widget.bloc),
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.yellow),
        bottom: TabBar(
          controller: tab_ctrl,
          indicatorColor: AppColor.yellow,
          labelColor: AppColor.yellow,
          unselectedLabelColor: AppColor.grey,
          tabs: [
            Tab(child: Text('신규',style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold))),
            Tab(child: Text('배달',style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold))),
          ],
        ),
      ),
      backgroundColor: AppColor.navy,
      body: TabBarView(
        controller: tab_ctrl,
        children: [
          newOrder(),
          delivery()
        ],
      ),
    );
  }
  newOrder(){
    return ListView(
      children: List.generate(3, (index) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: OrderItem(
            //item:orderList[index],
            isNew: true,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderDetailPage(bloc: widget.bloc,
                      )));
            },
          ),
        );
      }),
    );
  }
  delivery(){
    return ListView(
      children: List.generate(13, (index) {
        Random random = Random();
        int randomNumber = random.nextInt(2);

        return Padding(
          padding: EdgeInsets.all(10),
          child: OrderItem(
            isNew: false,
            state:randomNumber,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DeliveryDetailPage(
                        state: randomNumber,
                      )));
            },
          ),
        );
      }),
    );
  }
}
