import 'package:flutter/material.dart';
import 'package:rider_app/ui/color.dart';

class RegisterFinalPage extends StatefulWidget {
  @override
  _RegisterFinalPageState createState() => _RegisterFinalPageState();
}

class _RegisterFinalPageState extends State<RegisterFinalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppColor.yellow),
          title: Text('심사중', style: TextStyle(color: AppColor.yellow)),
          centerTitle: true,
          backgroundColor: AppColor.navy),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 29, 0, 55),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: CircleAvatar(
                            backgroundImage: AssetImage('images/stop.png')),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 18, 0),
                  child: Text(
                      "심사 기간은 공휴일 제외 최대 24시간 소요 예정입니다.\n심사가 완료되면 로그인 후 이용 가능합니다.",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: SizedBox(
                width: 344,
                height: 56,
                child: RaisedButton(
                    onPressed: () {},
                    child: Text("다음",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    color: AppColor.yellow),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
