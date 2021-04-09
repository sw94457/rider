import 'package:flutter/material.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/page/login/login_page.dart';
import 'package:rider_app/ui/color.dart';

class RegisterFinalPage extends StatefulWidget {
  Bloc bloc;

  RegisterFinalPage(this.bloc);

  @override
  _RegisterFinalPageState createState() => _RegisterFinalPageState();
}

class _RegisterFinalPageState extends State<RegisterFinalPage> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: AppColor.yellow),
          title: Text('심사중', style: TextStyle(color: AppColor.yellow)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColor.navy),
      body: Container(
        height: screen.height-100,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50, bottom: 30),
                  width: 90,
                  height: 90,
                  child: Image.asset('assets/images/stop.png'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 18, 0),
                  child: Text(
                      "심사 기간은 공휴일 제외 최대 24시간 소요 예정입니다.\n심사가 완료되면 로그인 후 이용 가능합니다.",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center),
                )
              ],
            ),
            SizedBox(
              width: screen.width,
              height: 56,
              child: RaisedButton(
                child: Text("완료",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                color: AppColor.yellow,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (BuildContext context) =>
                          LoginPage(widget.bloc)), (route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
