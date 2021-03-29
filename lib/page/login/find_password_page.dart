import 'package:flutter/material.dart';
import 'package:rider_app/ui/color.dart';

class FindPasswordPage extends StatefulWidget {
  @override
  _FindPasswordPageState createState() => _FindPasswordPageState();
}

class _FindPasswordPageState extends State<FindPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppColor.yellow),
          title: Text('비밀번호찾기', style: TextStyle(color: AppColor.yellow)),
          centerTitle: true,
          backgroundColor: AppColor.navy),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 29, 0, 55),
                  child: Image.asset('images/ch.png',width: 24,),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 18, 0),
                  child: Text(
                    "입력한 비밀번호로 설정되었습니다.",
                    style: TextStyle(fontSize: 18, color: Colors.white),textAlign: TextAlign.center,),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: 344,
                    height: 56,
                    child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text("로그인하러가기",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        color: AppColor.yellow),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
