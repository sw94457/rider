import 'package:flutter/material.dart';
import 'package:rider_app/data/order.dart';
import 'package:rider_app/ui/color.dart';

class OrderItem extends StatefulWidget {
  Function onTap;
  Order item;
  var state;
  bool isNew;
  OrderItem({this.onTap,this.item, this.state, this.isNew = false});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  Color mainColor;
  Color textColor;

  @override
  void initState() {
    super.initState();
    if(widget.isNew){
      mainColor = AppColor.red;
      textColor = Colors.white;
    }else{
      if(widget.state==0){
        mainColor = AppColor.neon_yellow;
      }else{
        mainColor = AppColor.neon_green;
      }
      textColor = Colors.black;
    }
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return InkWell(
      child: Container(
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              height: 30,
              padding: EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                  color: mainColor, borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/cash.png'),
                      SizedBox(width: 5),
                      Text('배달비 3,800원',
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Text('PM 12:08',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              width: screenSize.width,
              decoration: BoxDecoration(
                border: Border.all(color: mainColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    '대독장',
                    style: TextStyle(
                        color: AppColor.neon_yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        letterSpacing: 1.25),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '부산시 부산진구 동천로116 한신벤오피스텔 1018호',
                    style: TextStyle(
                        color: Colors.white, fontSize: 24, letterSpacing: 1.25),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: screenSize.width,
                    child: Icon(Icons.arrow_downward, color: AppColor.yellow),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '010-2211-1122',
                    style: TextStyle(
                        color: AppColor.neon_yellow,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.25),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '부산시 부산진구 동천로116 한신벤오피스텔 1018호',
                    style: TextStyle(
                        color: Colors.white, fontSize: 24, letterSpacing: 1.25),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: widget.onTap,
    );
  }
}
