import 'package:flutter/material.dart';
import 'package:rider_app/data/order.dart';
import 'package:rider_app/ui/color.dart';
import 'package:intl/intl.dart';

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
  final formatter = new NumberFormat("#,###,###,###,###");
  Color mainColor;
  Color textColor;
  var phone = '';

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
    if(widget.item.userPhone.length==11){
      try{
        phone = widget.item.userPhone.substring(0,3)+'-'+
            widget.item.userPhone.substring(3,7)+'-'+
            widget.item.userPhone.substring(7,11);
      }catch(e){}
    }else{
      try{
        phone = widget.item.userPhone.substring(0,3)+'-'+
            widget.item.userPhone.substring(3,6)+'-'+
            widget.item.userPhone.substring(6,10);
      }catch(e){}
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
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColor.neon_yellow,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text('선불',
                            style: TextStyle(
                                fontFamily: 'cafe24', fontSize: 20)),
                      ),
                      SizedBox(width: 5),
                      Text('배달비 ${formatter.format(int.parse(widget.item.riderDeliveryPrice))}원',
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
                    widget.item.companyName!=null?
                    widget.item.companyName:'',
                    style: TextStyle(
                        color: AppColor.neon_yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        letterSpacing: 1.25),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.item.companyAddress!=null?
                    widget.item.companyAddress:'',
                    style: TextStyle(
                        color: Colors.white, fontSize: 24, letterSpacing: 0.85),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: screenSize.width,
                    child: Icon(Icons.arrow_downward, color: AppColor.yellow),
                  ),
                  SizedBox(height: 5),
                  Text(phone,
                    style: TextStyle(
                        color: AppColor.neon_yellow,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.25),
                  ),
                  SizedBox(height: 5),
                  Text(widget.item.userAddress!=null?
                    widget.item.userAddress:'',
                    style: TextStyle(
                        color: Colors.white, fontSize: 24, letterSpacing: 0.85),
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
