import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/data/order.dart';
import 'package:rider_app/ui/color.dart';

class OrderDetailPage extends StatefulWidget {
  Bloc bloc;
  Order order;

  OrderDetailPage({this.bloc, this.order});

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  Order order;
  Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    widget.bloc.getOrderDetail(request_serial: widget.order.serial).then((value) {
      order = value;
    });
    try{
      if(widget.bloc.position.latitude !=null &&widget.bloc.position.longitude !=null){
        _kGooglePlex = CameraPosition(
          target: LatLng(widget.bloc.position.latitude, widget.bloc.position.longitude),
          zoom: 14.4746,
        );
      }
    }catch(e) {
      _kGooglePlex = CameraPosition(
        target: LatLng(37.547598, 126.979931),
        zoom: 14.4746,
      );
    }
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
            child: SingleChildScrollView(
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
                                  Image.asset('assets/images/cash.png'),
                                  SizedBox(width: 5),
                                  Text(
                                    '배달비 3,800원',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                              Text('PM 12:08', style: TextStyle(fontSize: 20))
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
                                      Text('300m',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: AppColor.neon_yellow))
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                '대독장',
                                style: TextStyle(
                                    color: AppColor.neon_yellow,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    letterSpacing: 1.25),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '부산시 부산진구 동천로116 한신벤오피스텔 1018호',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    letterSpacing: 1.25),
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
                            Text('300m',
                                style: TextStyle(
                                    fontSize: 20, color: AppColor.neon_green))
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          '010-2211-1122',
                          style: TextStyle(
                              color: AppColor.neon_yellow,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              letterSpacing: 1.25),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '부산시 부산진구 동천로116 한신벤오피스텔 1018호',
                          style: TextStyle(
                              color: AppColor.grey,
                              fontSize: 24,
                              letterSpacing: 1.25),
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
                        '초인종을 누르지 말아주세요.초인종을 누르지 말아주세요.초인종을 누르지 말아주세요.초인종을 누르지 말아주세요.',
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
                      Text('#1211',
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
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColor.yellow),
                    overlayColor: MaterialStateProperty.all<Color>(
                        Colors.black.withOpacity(0.5))),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
