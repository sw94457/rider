import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/data/calculate.dart';
import 'package:rider_app/data/order.dart';
import 'package:rider_app/ui/color.dart';
import 'package:rider_app/ui/progress.dart';

class CalculateDetailPage extends StatefulWidget {
  Calculate item;
  Bloc bloc;

  CalculateDetailPage({this.bloc, this.item});

  @override
  _CalculateDetailPageState createState() => _CalculateDetailPageState();
}

class _CalculateDetailPageState extends State<CalculateDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final formatter = new NumberFormat("#,###,###,###,###");
  List<Order2> calculteList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.bloc.getCalculateDetail(
            startDate: widget.item.startDate, endDate: widget.item.endDate).then((value) {
      calculteList = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('상세내역', style: TextStyle(color: AppColor.yellow)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.yellow),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: isLoading?
          ProgressPage(screenSize.width):
      Column(
        children: [
          Container(
            color: AppColor.white_navy,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: screenSize.width / 4,
                  alignment: Alignment.center,
                  child: Text(
                    '날짜',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColor.yellow),
                  ),
                ),
                Container(
                  //color: Colors.blue,
                  width: screenSize.width / 5,
                  alignment: Alignment.center,
                  child: Text(
                    '배달비',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColor.yellow),
                  ),
                ),
                Container(
                  // color: Colors.red,
                  width: screenSize.width / 3.5,
                  alignment: Alignment.center,
                  child: Text(
                    '금액',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColor.yellow),
                  ),
                ),
                Container(
                  //color: Colors.blue,
                  width: screenSize.width / 4,
                  alignment: Alignment.center,
                  child: Text(
                    '업체명',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColor.yellow),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
                children: List.generate(calculteList.length, (index) {
              return Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: screenSize.width / 4,
                      alignment: Alignment.center,
                      child: Text(
                        calculteList[index].registeredDate,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            //fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      width: screenSize.width / 5,
                      alignment: Alignment.center,
                      child: Text(
                        '${formatter.format(int.parse(calculteList[index].riderDeliveryPrice))}원',
                        style: TextStyle(
                            fontSize: 16,
                            //fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      width: screenSize.width / 3.5,
                      alignment: Alignment.center,
                      child: Text(
                        '${formatter.format(int.parse(calculteList[index].finalPrice))}원',
                        style: TextStyle(
                            fontSize: 16,
                            //fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      width: screenSize.width / 4,
                      alignment: Alignment.center,
                      child: Text(
                        calculteList[index].companyName,
                        style: TextStyle(
                            fontSize: 16,
                            //fontWeight: FontWeight.bold,
                            color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            })),
          ),
        ],
      ),
    );
  }
}

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          height: 44,
          width: 344,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 0, 5),
                    child: Container(
                      //width: 70, height: 32,
                      child: Text(
                        '2020.01.13\n11:12:31',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      '2900원',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    child: Text(
                      '26,900원',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    child: Text(
                      '대독장',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              Container(height: 0.5, color: const Color(0x80DBDBDB)),
            ],
          ),
        );
      },
      itemCount: 9,
    );
  }
}
