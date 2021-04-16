import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/page/login/register_page_3.dart';
import 'package:rider_app/page/login/register_page_final.dart';
import 'package:rider_app/ui/color.dart';
import 'package:toast/toast.dart';

/* 면허증 등록 */

class RegisterPage4 extends StatefulWidget {
  Bloc bloc;

  RegisterPage4(this.bloc);

  @override
  _RegisterPage4State createState() => _RegisterPage4State();
}

class _RegisterPage4State extends State<RegisterPage4> {
  Logger logger = Logger();
  File _image2;
  bool isFile = false;
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColor.navy,
        appBar: AppBar(
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: AppColor.yellow),
          backgroundColor: AppColor.navy,
          title: Text('면허정보',
              style: TextStyle(fontSize: 20, color: AppColor.yellow)),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          height: screen.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Text('면허증을 업로드해주세요.',
                      style: TextStyle(fontSize: 16, color: Colors.white))),
              InkWell(
                child: Container(
                  width: 288,
                  height: 162,
                  child: _image2 != null
                      //? FileImage(_image2)
                      ? Image.file(File(_image2.path))
                      : Image.asset('assets/images/certification.png'),
                ),
                onTap: () {
                  showModalBottomSheet<dynamic>(
                      context: context,
                      //backgroundColor: AppColor.yellow,
                      builder: (context) {
                        return Wrap(children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: screen.width,
                                height: 56,
                                color: AppColor.yellow,
                                alignment: Alignment.center,
                                child: Text(
                                  '면허증 업로드',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                width: screen.width,
                                height: 56,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey[200]),
                                    //top: BorderSide(color: Colors.grey[200]),
                                  ),
                                ),
                                child: RaisedButton(
                                  color: AppColor.yellow,
                                  child: Text(
                                    '사진찍기',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  onPressed: () {
                                    _getImage2(_image2).then((value) {
                                      _image2 = value;
                                      print(_image2);
                                      setState(() {
                                        isFile = true;
                                      });
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: screen.width,
                                height: 56,
                                child: RaisedButton(
                                  color: AppColor.yellow,
                                  child: Text(
                                    '앨범에서 선택',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  onPressed: () {
                                    _getImage(_image2).then((value) {
                                      _image2 = value;
                                      print(_image2);
                                      setState(() {
                                        isFile = true;
                                      });
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ]);
                      });
                },
              ),
              SizedBox(height: 10),
              SizedBox(
                  width: screen.width,
                  height: 56,
                  child: isFile
                      ? RaisedButton(
                          onPressed: () {
                            if (isFile) {
                              widget.bloc.user.licenseImage = _image2.path;
                              widget.bloc.getJoin(
                                phone: widget.bloc.user.phone,
                                name: widget.bloc.user.name,
                                account_name: widget.bloc.user.accountName,
                                account_bank: widget.bloc.user.accountBank,
                                account_num: widget.bloc.user.accountNum,
                                location_serial: widget.bloc.user.locationSerial,
                                term: widget.bloc.user.term,
                                image: widget.bloc.user.faceImage,
                                image2: widget.bloc.user.licenseImage
                              ).then((res) {
                                logger.d(res.success);
                                if(res.success){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterFinalPage(widget.bloc)));
                                }else{
                                  logger.d(res.errorMsg);
                                  Toast.show(res.errorMsg+'',context);
                                }
                              });
                            }
                          },
                          child: Text("다음",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          color: AppColor.yellow,
                        )
                      : OutlineButton(
                          onPressed: () {},
                          color: AppColor.yellow,
                          child: Text("다음",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.yellow)),
                          borderSide: BorderSide(color: AppColor.yellow),
                        )),
            ],
          ),
        ));
  }

  Future _getImage(image) async {
    var picked = await imagePicker.getImage(source: ImageSource.gallery);

    return File(picked.path);
  }

  Future _getImage2(image) async {
    var picked = await imagePicker.getImage(source: ImageSource.camera);

    return File(picked.path);
  }
}
