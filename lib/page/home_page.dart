import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:background_location/background_location.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/data/order.dart';
import 'package:rider_app/page/delivery_detail_page.dart';
import 'package:rider_app/page/order_detail_page.dart';
import 'package:rider_app/ui/color.dart';
import 'package:rider_app/ui/drawer.dart';
import 'package:rider_app/ui/order_item.dart';
import 'package:rider_app/ui/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  Bloc bloc;

  HomePage(this.bloc);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  RefreshController refresh_ctrl;
  DateTime currentBackPressTime;
  SharedPreferences prefs;
  TabController tab_ctrl;
  List<Order2> orderList = [];
  List<Order2> newOrderList = [];
  List<Order2> reverseNewOrderList = [];
  List<Order2> deliveryOrderList = [];
  List<Order2> reverseDeliveryOrderList = [];
  bool Loading = true;

  @override
  void initState() {
    super.initState();
    refresh_ctrl = RefreshController(initialRefresh: true);
    tab_ctrl = new TabController(vsync: this, length: 2);

    getList();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.category);
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      Toast.show('새로운 주문이 도착했습니다.', context, duration: 2);
      getList();
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification.title}');
      }
    });
    BackgroundLocation.getPermissions(
      onGranted: () {
        // Start location service here or do something else
      },
      onDenied: () {
        // Show a message asking the user to reconsider or do something else
      },
    );
    getSharedPrefs();
  }

  getSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  getList() {
    widget.bloc.getOrderList().then((value) {
      orderList.clear();
      newOrderList.clear();
      deliveryOrderList.clear();
      orderList = value;
      for(int i=0;i<orderList.length;i++){
        if(orderList[i].flag == 'W'){
          newOrderList.add(orderList[i]);
        }else{
          deliveryOrderList.add(orderList[i]);
        }
      }
      reverseDeliveryOrderList = List.from(deliveryOrderList.reversed);
      reverseNewOrderList = List.from(newOrderList.reversed);

      Loading = false;
      setState(() {});
    });
  }

  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    getList();
    setState(() {});
    refresh_ctrl.refreshCompleted();
  }

  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    if(mounted) setState(() {});
    refresh_ctrl.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: MyDrawer(widget.bloc),
      onDrawerChanged: (isOpen){
        print(isOpen);
        getList();
        setState(() {});
      },
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
              child: Text('신규(${reverseNewOrderList.length})',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Tab(
              child: Text('배달(${reverseDeliveryOrderList.length})',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      backgroundColor: AppColor.navy,
      body: WillPopScope(
        onWillPop: () => doubleBackTap(),
        child: Loading?
          ProgressPage(screenSize.width) :
          TabBarView(
            controller: tab_ctrl,
            children: [newOrder(), delivery()],
          ),
      )
    );
  }

  newOrder() {
    return SmartRefresher(
      controller: refresh_ctrl,
      enablePullDown: true,
      enablePullUp: false,
      header: ClassicHeader(
        refreshingText: '로딩중',
        idleText: '',
        failedText: '로딩 실패',
        completeText: '로딩 완료',
        releaseText: '',
      ),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView(
        // shrinkWrap: true,
        // reverse: true,
        children: List.generate(reverseNewOrderList.length, (index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: OrderItem(
              item: reverseNewOrderList[index],
              isNew: true,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => OrderDetailPage(
                              bloc: widget.bloc,
                              item: reverseNewOrderList[index]))).then((value) {
                  getList();
                });
              },
            ),
          );
        }),
      ),
    );
  }

  delivery() {
    return SmartRefresher(
      controller: refresh_ctrl,
      enablePullDown: true,
      enablePullUp: false,
      header: ClassicHeader(
        refreshingText: '로딩중',
        idleText: '',
        failedText: '로딩 실패',
        completeText: '로딩 완료',
        releaseText: '',
      ),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView(
        // shrinkWrap: true,
        // reverse: true,
        children: List.generate(reverseDeliveryOrderList.length, (index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: OrderItem(
              isNew: false,
              item: reverseDeliveryOrderList[index],
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => DeliveryDetailPage(
                            bloc:widget.bloc, item: reverseDeliveryOrderList[index]))).then((value){
                  getList();
                });
              },
            ),
          );
        }),
      ),
    );
  }

  Future<bool> doubleBackTap() {
    // DateTime now = DateTime.now();
    // if (currentBackPressTime == null ||
    //     now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    //   currentBackPressTime = now;
    //   //Toast.show('앱을 종료하려면 다시 누르세요.', context);
    // }
    showOkCancelAlertDialog(
        context: context,
        title: '앱 종료',
        message: '앱 종료 시 위치를 더이상 업데이트 할 수 없습니다. 그래도 종료하시겠습니까?',
        cancelLabel: '취소',
        okLabel: '확인'
    ).then((value) {
      if(value == OkCancelResult.ok){
        SystemNavigator.pop();
      }else{
        Navigator.of(context).pop();
      }
    })?? false;
  }

}
