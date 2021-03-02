import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/delivery_delivery_page.dart';
import 'package:ibagudelivery_rider/delivery_pick_page.dart';

class DeliveryList extends StatefulWidget {
  @override
  _DeliveryListState createState() => _DeliveryListState();
}

class _DeliveryListState extends State<DeliveryList> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: const Color(0xff20283E),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: MyListView(),
            ),
          ],
        ),
      ),
    );
  }
}

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            //Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryDelivery()));
            Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryPick()));
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
                                border: Border.all(color: const Color(0xff62FF2B), width: 1),
                                color: const Color(0xff62FF2B)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(40,0,5,0),
                                    child: Text('배달비 3,800원',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                    ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,8,0),
                                  child: Text('PM 11:52',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 24, width: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5), //모서리를 둥글게
                                border: Border.all(color: const Color(0xff62FF2B), width: 1),
                                color: const Color(0xff62FF2B)),
                            child: Text('카드',style: TextStyle(fontSize: 16, fontFamily: 'cafe24'),),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), //모서리를 둥글게
                            border: Border.all(color: const Color(0xffFF2098), width: 1)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: const Color(0xffFF2098), width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text('대독장',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: const Color(0xffEBFF00)),)
                                ),
                                Text('부산시 부산진구 동천로116 한신밴오피스텔 1018호',style: TextStyle(fontSize: 20,color: Colors.white)),
                                Image.asset('images/arrow1.png',width: 18,),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text('01012341234',style: TextStyle(fontSize: 24,color: const Color(0xffEBFF00)))
                                ),
                                Text('부산시 부산진구 동천로116 한신밴오피스텔 1018호',style: TextStyle(fontSize: 20,color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
            ),
          ),
        );
      },
      itemCount: 3,
    );
  }
}