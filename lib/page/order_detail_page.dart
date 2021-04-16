import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/data/order.dart';
import 'package:rider_app/ui/color.dart';
import 'package:rider_app/ui/progress.dart';
import 'package:toast/toast.dart';

class OrderDetailPage extends StatefulWidget {
  Bloc bloc;
  Order2 item;

  OrderDetailPage({this.bloc, this.item});

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  Order2 order;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();
  bool paid = false;
  bool Loading = true;
  var startDistance;
  var endDistance;
  String phone = '';

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    widget.bloc.getOrderDetail(request_serial: widget.item.serial).then((value) {
      order = value;
      var companyLatLng = LatLng(double.parse(order.companyLatitude), double.parse(order.companyLongitude));
      var userLatLng = LatLng(double.parse(order.userLatitude), double.parse(order.userLongitude));

      try{
        if(order.companyLatitude !=null && order.companyLongitude !=null){
          _kGooglePlex = CameraPosition(
            target: companyLatLng,
            zoom: 14.4746);
          markers.add(
            Marker(
              infoWindow: InfoWindow(title: '출발지', ),
              //icon: getDustIcon(list[i]),
              markerId: MarkerId(order.serial),
              position: companyLatLng,
            ),
          );
          markers.add(
            Marker(
              infoWindow: InfoWindow(title: '도착지', ),
              //icon: getDustIcon(list[i]),
              markerId: MarkerId(order.orderSerial),
              position: userLatLng,
            ),
          );
        }
      }catch(e) {
        _kGooglePlex = CameraPosition(
          target: LatLng(37.547598, 126.979931),
          zoom: 14.4746,
        );
      }
      if(order.userPhone.length==11){
        try{
          phone = order.userPhone.substring(0,3)+'-'+
              order.userPhone.substring(3,7)+'-'+
              order.userPhone.substring(7,11);
        }catch(e){}
      }else{
        try{
          phone = order.userPhone.substring(0,3)+'-'+
              order.userPhone.substring(3,6)+'-'+
              order.userPhone.substring(6,10);
        }catch(e){}
      }
      if(order.paid =='Y') {
        paid = true;
      }else{
        paid = false;
      }
      Loading = false;
      startDistance = Geolocator.distanceBetween(
          double.parse(order.companyLatitude),
          double.parse(order.companyLongitude),
          widget.bloc.position.latitude,
          widget.bloc.position.longitude).floor();
      endDistance = Geolocator.distanceBetween(
          double.parse(order.userLatitude),
          double.parse(order.userLongitude),
          widget.bloc.position.latitude,
          widget.bloc.position.longitude).floor();

      if(startDistance>=1000.0){
        startDistance = startDistance/1000;
      }
      if(endDistance>=1000.0){
        endDistance = endDistance/1000;
      }
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        brightness: Brightness.dark,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.yellow),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: screenSize.height,
            child:
            Loading?
            ProgressPage(screenSize.width):
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: screenSize.width,
                          height: 30,
                          padding: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              color: AppColor.red,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: paid? AppColor.neon_yellow:AppColor.neon_green,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(paid?'선불':'현장결제',
                                        style: TextStyle(
                                            fontFamily: 'cafe24', fontSize: 20)),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '배달비 3,800원',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                              Text(
                                  widget.item.registeredDate!=null?
                                  widget.item.registeredDate.substring(11,16):'',
                              style: TextStyle(fontSize: 20))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          width: screenSize.width,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: AppColor.grey,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Text('출발지',
                                            style: TextStyle(
                                                fontFamily: 'cafe24',
                                                fontSize: 20)),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                          startDistance<1000.0?
                                      '${startDistance}m':
                                      '${startDistance.toStringAsFixed(2)}km',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: AppColor.neon_yellow))
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                order.companyName!=null?
                                order.companyName:'',
                                style: TextStyle(
                                    color: AppColor.neon_yellow,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    letterSpacing: 1.25),
                              ),
                              SizedBox(height: 5),
                              Text(
                                order.companyAddress!=null?
                                order.companyAddress:'',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    letterSpacing: 0.85),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: screenSize.width,
                    child: Icon(Icons.arrow_downward, color: AppColor.yellow),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.all(5),
                    width: screenSize.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 1),
                              decoration: BoxDecoration(
                                color: AppColor.grey,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text('도착지',
                                  style: TextStyle(
                                      fontFamily: 'cafe24', fontSize: 20)),
                            ),
                            SizedBox(width: 5),
                            Text( endDistance<1000.0?
                            '${endDistance.round()}m':
                            '${endDistance.toStringAsFixed(2)}km',
                                style: TextStyle(
                                    fontSize: 20, color: AppColor.neon_green))
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(phone,
                          style: TextStyle(
                              color: AppColor.neon_yellow,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              letterSpacing: 1.25),
                        ),
                        SizedBox(height: 5),
                        Text(
                          order.userAddress!=null?
                          order.userAddress:'',
                          style: TextStyle(
                              color: AppColor.grey,
                              fontSize: 24,
                              letterSpacing: 0.85),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('요청사항 메세지',
                      style: TextStyle(color: AppColor.yellow, fontSize: 24)),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                    order.riderMemo!=null?
                    order.riderMemo:'',
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                  ),
                  SizedBox(height: 5),
                  Divider(color: AppColor.grey),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('접수번호',
                          style:
                              TextStyle(color: AppColor.yellow, fontSize: 24)),
                      SizedBox(width: 20),
                      Text('#${widget.item.orderSerial}',
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Divider(color: AppColor.grey),
                  SizedBox(height: 5),
                  Text('지도보기',
                      style: TextStyle(color: AppColor.yellow, fontSize: 24)),
                  SizedBox(height: 5),
                  SizedBox(
                    height: screenSize.width,
                    width: screenSize.width,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: _kGooglePlex,
                      markers: markers,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),
                  SizedBox(height: 130)
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 30),
              width: screenSize.width,
              color: AppColor.navy,
              height: 88,
              child: TextButton(
                child: Text('수락하기',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColor.yellow),
                    overlayColor: MaterialStateProperty.all<Color>(
                        Colors.black.withOpacity(0.5))),
                onPressed: () {
                  widget.bloc.acceptOrder(
                    request_serial: order.serial,
                    order_serial: order.serial,
                    serial: widget.bloc.user.serial).then((res){
                      if(res.success){
                        Navigator.pop(context);
                        Toast.show(res.errorMsg+'',context, duration: 2);
                      }else{
                        Toast.show(res.errorMsg+'',context, duration: 2);
                      }
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
