import 'dart:io';
import 'dart:ui';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/data/location.dart';
import 'package:rider_app/page/login/register_page_4.dart';
import 'package:rider_app/ui/button.dart';
import 'package:rider_app/ui/color.dart';
import 'package:rider_app/ui/text_field.dart';
import 'package:toast/toast.dart';

// 회원가입 페이지
// 기본정보, 계좌정보 입력

class RegisterPage3 extends StatefulWidget {
  Bloc bloc;

  RegisterPage3(this.bloc);

  @override
  _RegisterPage3State createState() => _RegisterPage3State();
}

class _RegisterPage3State extends State<RegisterPage3> {
  Logger logger = Logger();
  TextEditingController name_ctrl = TextEditingController();
  TextEditingController name2_ctrl = TextEditingController();
  TextEditingController account_ctrl = TextEditingController();
  File _image;
  final ImagePicker imagePicker = ImagePicker();
  var location_serial='';
  var period='';
  var choice_place1 = '지역1을 선택해주세요';
  var choice_place2 = '지역2를 선택해주세요';
  var choice_bank = '은행을 선택해주세요';
  var choice_period = '정산주기를 선택해주세요';
  List<Location> locationList = [];

  @override
  void initState() {
    super.initState();
    widget.bloc.getLocation().then((value) {
      locationList = value;
      logger.d(locationList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: AppColor.yellow),
        title: Text('회원가입', style: TextStyle(color: AppColor.yellow)),
        centerTitle: true,
        backgroundColor: AppColor.navy,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          height: screen.height - 80,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 20),
                Text("기본 정보",
                    style: TextStyle(fontSize: 18, color: AppColor.yellow)),
                Divider(color: AppColor.yellow),
                Text("이름", style: TextStyle(fontSize: 14, color: Colors.white)),
                Container(
                    width: screen.width,
                    height: 68,
                    child: MyTextField(
                      controller: name_ctrl,
                      color: AppColor.grey,
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 8),
                  child: Text("지역",
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                ),
                ChoiceBox(
                  text: choice_place1,
                  margin: EdgeInsets.only(bottom: 15, top: 5),
                  onTap: () {
                    showConfirmationDialog(
                        context: context,
                        title: '지역1을 선택해주세요',
                        cancelLabel: '취소',
                        actions: [
                          //AlertDialogAction(label: '서울특별시', key: 1),
                          //AlertDialogAction(label: '부산광역시', key: 2),
                          AlertDialogAction(label: '진주시', key: 3),
                        ]).then((value) {
                      switch (value) {
                        // case 1:
                        //   choice_place1 = '부산광역시';
                        //   break;
                        // case 2:
                        //   choice_place1 = '부산광역시';
                        //   break;
                        case 3:
                          choice_place1 = '진주시';
                          break;
                      }
                      setState(() {});
                      logger.d(value);
                    });
                  },
                ),
                ChoiceBox(
                  text: choice_place2,
                  onTap: () {
                    showConfirmationDialog(
                        context: context,
                        title: '지역2을 선택해주세요',
                        cancelLabel: '취소',
                        actions: List.generate(locationList.length, (index) {
                          return AlertDialogAction(label: locationList[index].name, key: index);
                        })
                    ).then((value) {
                      if(value!=null){
                        choice_place2 = locationList[value].name;
                        location_serial = locationList[value].serial;
                      }
                      setState(() {});
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("프로필 사진",
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                ),
                Row(
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
                                  : AssetImage('assets/images/profile.png')),
                        ),
                        InkWell(
                          child: Container(
                            width: 80,
                            height: 80,
                            alignment: Alignment.bottomRight,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                                border:
                                    Border.all(color: AppColor.yellow, width: 2),
                              ),
                              child: Image.asset(
                                'assets/images/ic_camera.png',
                                width: 20,
                              ),
                            ),
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
                SizedBox(height: 20),
                Text("계좌 정보",
                    style: TextStyle(fontSize: 18, color: AppColor.yellow)),
                Divider(color: AppColor.yellow),
                Text("예금주", style: TextStyle(fontSize: 14, color: Colors.white)),
                Container(
                    width: screen.width,
                    height: 68,
                    child: MyTextField(
                      controller: name2_ctrl,
                      color: AppColor.grey,
                    )),
                Text("은행", style: TextStyle(fontSize: 14, color: Colors.white)),
                ChoiceBox(
                  text: choice_bank,
                  margin: EdgeInsets.only(bottom: 15, top: 5),
                  onTap: () {
                    showConfirmationDialog(
                        context: context,
                        title: '은행 및 증권사를 선택해주세요',
                        cancelLabel: '취소',
                        actions: [
                          AlertDialogAction(label: '경남', key: 1),
                          AlertDialogAction(label: '광주', key: 2),
                          AlertDialogAction(label: '국민', key: 3),
                          AlertDialogAction(label: '기업', key: 4),
                          AlertDialogAction(label: '농협', key: 5),
                          AlertDialogAction(label: '대구', key: 6),
                          AlertDialogAction(label: '도이치', key: 7),
                          AlertDialogAction(label: '부산', key: 8),
                          AlertDialogAction(label: '산업', key: 9),
                          AlertDialogAction(label: '상호저축', key: 10),
                          AlertDialogAction(label: '새마을금고', key: 11),
                          AlertDialogAction(label: '수협중앙회', key: 12),
                          AlertDialogAction(label: '신한금융투자', key: 13),
                          AlertDialogAction(label: '신한', key: 14),
                          AlertDialogAction(label: '외한', key: 15),
                          AlertDialogAction(label: '우리', key: 16),
                          AlertDialogAction(label: '우체국', key: 17),
                          AlertDialogAction(label: '전북', key: 18),
                          AlertDialogAction(label: '제주', key: 19),
                          AlertDialogAction(label: '카카오뱅크', key: 20),
                          AlertDialogAction(label: '케이', key: 21),
                          AlertDialogAction(label: '하나', key: 22),
                          AlertDialogAction(label: '한국씨티', key: 23),
                          AlertDialogAction(label: 'HSBC', key: 24),
                          AlertDialogAction(label: 'SC제일', key: 25),
                        ]).then((value) {
                      logger.d(value);
                      switch(value){
                        case 1:
                          choice_bank = '경남';
                          break;
                        case 2:
                          choice_bank = '광주';
                          break;
                        case 3:
                          choice_bank = '국민';
                          break;
                        case 4:
                          choice_bank = '기업';
                          break;
                        case 5:
                          choice_bank = '농협';
                          break;
                        case 6:
                          choice_bank = '대구';
                          break;
                        case 7:
                          choice_bank = '도이치';
                          break;
                        case 8:
                          choice_bank = '부산';
                          break;
                        case 9:
                          choice_bank = '산업';
                          break;
                        case 10:
                          choice_bank = '상호저축';
                          break;
                        case 11:
                          choice_bank = '새마을금고';
                          break;
                        case 12:
                          choice_bank = '수협중앙회';
                          break;
                        case 13:
                          choice_bank = '신한금융투자';
                          break;
                        case 14:
                          choice_bank = '신한';
                          break;
                        case 15:
                          choice_bank = '외한';
                          break;
                        case 16:
                          choice_bank = '우리';
                          break;
                        case 17:
                          choice_bank = '우체국';
                          break;
                        case 18:
                          choice_bank = '전북';
                          break;
                        case 19:
                          choice_bank = '제주';
                          break;
                        case 20:
                          choice_bank = '카카오뱅크';
                          break;
                        case 21:
                          choice_bank = '케이';
                          break;
                        case 22:
                          choice_bank = '하나';
                          break;
                        case 23:
                          choice_bank = '한국씨티';
                          break;
                        case 24:
                          choice_bank = 'HSBC';
                          break;
                        case 25:
                          choice_bank = 'SC제일';
                          break;
                      }
                      setState(() {});
                    });
                  },
                ),
                Text("계좌번호", style: TextStyle(fontSize: 14, color: Colors.white)),
                Container(
                    width: screen.width,
                    height: 68,
                    child: MyTextField(
                      controller: account_ctrl,
                      color: AppColor.grey,
                      inputType: TextInputType.number,
                    )),
                Text("정산주기", style: TextStyle(fontSize: 14, color: Colors.white)),
                ChoiceBox(
                  text: choice_period,
                  margin: EdgeInsets.only(bottom: 15, top: 5),
                  onTap: () {
                    showConfirmationDialog(
                        context: context,
                        title: '정산주기를 선택해주세요',
                        cancelLabel: '취소',
                        actions: [
                          AlertDialogAction(label: '1주', key: 1),
                          AlertDialogAction(label: '2주', key: 2),
                          AlertDialogAction(label: '4주', key: 3),
                        ]).then((value) {
                      switch (value) {
                        case 1:
                          choice_period = '1주';
                          period = '1';
                          break;
                        case 2:
                          choice_period = '2주';
                          period = '2';
                          break;
                        case 3:
                          choice_period = '4주';
                          period = '4';
                          break;
                      }
                      setState(() {});
                      logger.d(value);
                    });
                  },
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: screen.width - 16,
                  height: 56,
                  child: RaisedButton(
                    onPressed: () {
                      if (name_ctrl.text == null || name_ctrl.text == '') {
                        Toast.show('이름을 입력해주세요', context);
                        return;
                      }
                      if (choice_place1 == '지역1을 선택해주세요') {
                        Toast.show('지역1을 선택해주세요', context);
                        return;
                      }
                      if(choice_place1 == '부산광역시'){
                        if (choice_place2 == '지역2를 선택해주세요') {
                          Toast.show('지역2를 선택해주세요', context);
                          return;
                        }
                      }
                      if (_image == null) {
                        Toast.show('프로필 사진을 추가해주세요', context);
                        return;
                      }
                      if (name2_ctrl.text == null || name2_ctrl.text == '') {
                        Toast.show('예금주를 입력해주세요', context);
                        return;
                      }
                      if (choice_bank == '은행을 선택해주세요') {
                        Toast.show('은행을 선택해주세요', context);
                        return;
                      }
                      if (account_ctrl.text == null || account_ctrl.text == '') {
                        Toast.show('계좌번호를 입력해주세요', context);
                        return;
                      }
                      if (choice_period == '정산주기를 선택해주세요') {
                        Toast.show('정산주기를 선택해주세요', context);
                        return;
                      }
                      widget.bloc.user.name = name_ctrl.text;
                      widget.bloc.user.locationSerial = location_serial;
                      widget.bloc.user.location2 = choice_place2;
                      widget.bloc.user.faceImage = _image.path;
                      widget.bloc.user.accountName = name2_ctrl.text;
                      widget.bloc.user.accountBank = choice_bank;
                      widget.bloc.user.accountNum = account_ctrl.text;
                      widget.bloc.user.term = period;

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage4(widget.bloc)));
                    },
                    child: Text("다음",
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    color: AppColor.yellow,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
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
