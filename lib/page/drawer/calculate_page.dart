import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/data/calculate.dart';
import 'package:rider_app/page/drawer/calculate_detail_page.dart';
import 'package:rider_app/ui/color.dart';
import 'package:rider_app/ui/progress.dart';

class CalculatePage extends StatefulWidget {
  Bloc bloc;

  CalculatePage({this.bloc});

  @override
  _CalculatePageState createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  List<Calculate> calculateList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.bloc.getCalculateList().then((value) {
      calculateList = value;
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
        title: Text('정산', style: TextStyle(color: AppColor.yellow)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.yellow),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: Container(
          height: screenSize.height,
          child: isLoading
              ? ProgressPage(screenSize.width)
              : calculateList.length > 0
                  ? (ListView(
                      children: List.generate(calculateList.length, (index) {
                        return Padding(
                          padding:
                              EdgeInsets.only(top: 10, right: 10, left: 10),
                          child: CalculateItem(
                              item: calculateList[index], bloc: widget.bloc),
                        );
                      }),
                    ))
                  : ErrorPage(width: screenSize.width, text: '정산 내역이 없습니다.')),
    );
  }
}

class CalculateItem extends StatelessWidget {
  final formatter = new NumberFormat("#,###,###,###,###");
  Calculate item;
  Bloc bloc;

  CalculateItem({this.item, this.bloc});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool done = false;
    if (item.flag == 'Y') {
      done = true;
    }
    return InkWell(
      child: Container(
          width: screenSize.width,
          color: AppColor.white_navy,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 65,
                  padding: EdgeInsets.symmetric(
                      //horizontal: 5,
                      vertical: 1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: done ? Colors.grey : AppColor.yellow),
                  alignment: Alignment.center,
                  child: Text(done ? '정산완료' : '미정산',
                      style: TextStyle(fontFamily: 'cafe24')),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        item.startDate + '\n~' + item.endDate,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${formatter.format(int.parse(item.totalDeliveryPrice))}원',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: done ? Colors.grey : AppColor.yellow,
                              fontFamily: 'cafe24'),
                        ),
                        SizedBox(
                            child: Icon(Icons.arrow_right,
                                size: 45,
                                color: done ? Colors.grey : AppColor.yellow))
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CalculateDetailPage(item: item, bloc: bloc)));
      },
    );
  }
}
