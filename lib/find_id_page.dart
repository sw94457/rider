import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/ui/color.dart';

class FindIdPage extends StatefulWidget {
  @override
  _FindIdPageState createState() => _FindIdPageState();
}

class _FindIdPageState extends State<FindIdPage> {
  String idtext = 'a';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppColor.yellow),
          title: Text('아이디찾기', style: TextStyle(color: AppColor.yellow)),
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
                      "가입하신 아이디는\n${idtext}\n입니다.",
                      style: TextStyle(fontSize: 18, color: Colors.white),textAlign: TextAlign.center,),
                )
              ],
            ),
            Column(
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('비밀번호 찾기',style: TextStyle(fontSize: 18,color: Colors.white,decoration:
                TextDecoration.underline),)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: SizedBox(
                    width: 344,
                    height: 56,
                    child: RaisedButton(
                        onPressed: () {},
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
