import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/bloc/bloc.dart';
import 'package:ibagudelivery_rider/ui/color.dart';

import 'package:ibagudelivery_rider/under_review_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class JoinCreate extends StatefulWidget {
  Bloc bloc;

  JoinCreate(this.bloc);

  @override
  _JoinCreateState createState() => _JoinCreateState();
}

class _JoinCreateState extends State<JoinCreate> {
  TextEditingController id = TextEditingController();
  TextEditingController pw = TextEditingController();
  TextEditingController pw2 = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  File _image;
  bool isIDCheck = false;
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.yellow),
        title: Text('회원가입', style: TextStyle(color: AppColor.yellow)),
        centerTitle: true,
        backgroundColor: AppColor.navy,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text("기본정보",
                            style: TextStyle(
                                fontSize: 20, color: AppColor.yellow)),
                        SizedBox(height: 10),
                        Text("아이디 입력",
                            style: TextStyle(fontSize: 18, color: Colors.white)),
                        SizedBox(height: 8),
                        Container(
                          width: 312,
                          height: 48,
                          child: Stack(
                            children: [
                              SizedBox(
                                child: TextField(
                                  controller: id,
                                  onChanged: (text) {},
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Colors.white),
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
                              Container(
                                  child: TextButton(
                                    onPressed: () {
                                      widget.bloc.checkId(id: id.text).then((res) {
                                        if(res.success) {
                                          Toast.show(
                                              '사용 가능한 이메일 입니다.', context);
                                          setState(() {
                                            isIDCheck = true;
                                          });
                                        }else{
                                          Toast.show(res.errorMsg, context);
                                        }
                                      });
                                    },
                                    child: Text('중복확인',
                                        style: TextStyle(
                                            color: AppColor.yellow,
                                            decoration:
                                                TextDecoration.underline)),
                                  ),
                                  alignment: Alignment.centerRight),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                          child: Text("6-12자 영문, 숫자로 입력해주세요.",
                              style: TextStyle(
                                  fontSize: 12, color: AppColor.yellow)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 8),
                          child: Text("비밀번호 입력",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                        SizedBox(
                          width: 312,
                          height: 48,
                          child: TextField(
                            controller: pw,
                            cursorColor: Colors.white,
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                          child: Text("비밀번호는 8-20자로 입력해주세요.",
                              style: TextStyle(
                                  fontSize: 12, color: AppColor.yellow)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                          child: Text("비밀번호 재입력",
                              style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                        SizedBox(
                          width: 312,
                          height: 48,
                          child: TextField(
                            controller: pw2,
                            cursorColor: Colors.white,
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
                          child: Text("라이더 정보",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: const Color(0xffFFE600))),
                        ),
                        Text("프로필사진",
                            style: TextStyle(
                                fontSize: 18, color: Colors.white)),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 220,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: CircleAvatar(
                                        backgroundImage: _image != null
                                            ? FileImage(_image)
                                            : AssetImage('images/profile.png')),
                                  ),
                                  InkWell(
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      alignment: Alignment.bottomRight,
                                      child: CircleAvatar(
                                          backgroundImage: AssetImage('images/camera.png'),
                                          radius: 15),
                                    ),
                                    onTap: () {
                                      _getImage(_image).then((value) {
                                        _image = value;
                                        print(_image);
                                        setState(() {});
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                                child: Text("이름",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ),
                              SizedBox(
                                width: 312,
                                height: 48,
                                child: TextField(
                                  controller: name,
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Colors.white),
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
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: SizedBox(
                    width: 344,
                    height: 56,
                    child: (id.text!=''&&pw.text!=''&&name.text!=''&&_image.path!=''&&isIDCheck)?
                    RaisedButton(
                      color: AppColor.yellow,
                      child: Text("가입하기",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        print(id.text);
                        print(pw.text);
                        print(name.text);
                        print(_image.path);
                        print(isIDCheck);
                        if(pw.text==pw2.text) {
                          widget.bloc.getJoin(id: id.text,
                              pw: pw.text,
                              phone: widget.bloc.user.phone,
                              name: name.text,
                              image: _image.path,
                              image2: widget.bloc.user.joinImage2).then((res) {
                            if (res.success) {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => UnderReview()));
                            } else {
                              Toast.show(res.errorMsg, context);
                            }
                          });
                        }else{
                          Toast.show('비밀번호가 같지 않습니다.', context);
                        }
                      },
                    ):OutlineButton(
                      onPressed: () {
                        print(id.text);
                        print(pw.text);
                        print(name.text);
                        print(_image.path);
                        print(widget.bloc.user.joinImage2);
                        print(isIDCheck);
                      },
                      color: AppColor.yellow,
                      child: Text("가입하기",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.yellow)),
                      borderSide: BorderSide(color: AppColor.yellow),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _getImage(image) async {
    var picked = await imagePicker.getImage(source: ImageSource.gallery);

    return File(picked.path);
  }
}
