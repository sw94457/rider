import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/find_id_page.dart';
import 'package:ibagudelivery_rider/ui/color.dart';

class FindId extends StatefulWidget {
  @override
  _FindIdState createState() => _FindIdState();
}

class _FindIdState extends State<FindId> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff20283E),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 29, 0, 0),
              child: Column(
                children: [
                  Center(
                      child: Text("가입하신 휴대폰 번호를 입력해주세요.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: SizedBox(
                      width: 312,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("핸드폰 번호 입력",
                              style:
                              TextStyle(fontSize: 16, color: Colors.white)),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 17, 0, 16),
                            child: SizedBox(
                              height: 48,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                onChanged: (text) {},
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  hintText: "숫자만 입력하세요",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 312,
                            height: 48,
                            child: RaisedButton(
                              child: Text("인증코드 받기",
                                  style: TextStyle(fontSize: 18)),
                              color: Colors.white,
                              onPressed: () {
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 36, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("인증코드 입력",
                            style:
                            TextStyle(fontSize: 16, color: Colors.white)),
                        SizedBox(
                          width: 312,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 17, 0, 16),
                            child: SizedBox(
                              height: 48,
                              child: TextField(
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                onChanged: (text) {},
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 312,
                          height: 48,
                          child: RaisedButton(
                            color: Colors.black.withOpacity(0.25),
                            child: Text("인증코드 확인",
                                style: TextStyle(fontSize: 18, color: Colors.white)),
                            onPressed: () {

                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: SizedBox(
                width: 344,
                height: 56,
                child: OutlineButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FindIdPage()));
                  },
                  color: AppColor.yellow,
                  child: Text("다음",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColor.yellow)),
                  borderSide: BorderSide(color: AppColor.yellow),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}