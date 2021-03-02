import 'package:flutter/material.dart';
import 'package:ibagudelivery_rider/bloc/bloc.dart';
import 'package:ibagudelivery_rider/ui/color.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class LincenseUpdate extends StatefulWidget {
  Bloc bloc;


  LincenseUpdate(this.bloc);

  @override
  _LincenseUpdateState createState() => _LincenseUpdateState();
}

class _LincenseUpdateState extends State<LincenseUpdate> {
  File _image2;
  bool isFile = false;
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColor.navy,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColor.yellow),
          backgroundColor: AppColor.navy,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 29, 0, 85),
                        child: Text('면허증을 업로드해주세요.',style: TextStyle(fontSize: 18, color: Colors.white))
                    ),
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(context: context, builder: (context){
                          return Container(
                            height: 200,
                            color: const Color(0xff3B4255),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(width: 344,height: 56,
                                  color: const Color(0xffFFE600),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                          child: Image.asset('images/VectorStroke.png',width: 18,)
                                      ),
                                      Text('면허증 업로드',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),),
                                      Container()
                                    ],
                                  ),
                                ),
                                Container(width: 344,height: 56,
                                  child: RaisedButton(
                                    color: const Color(0xffFFE600),
                                    onPressed: () {
                                      _getImage2(_image2).then((value) {
                                        _image2 = value;
                                        print(_image2);
                                        setState(() {
                                          isFile = true;
                                        });
                                      });
                                    },
                                    child: Text('사진찍기',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
                                    ),
                                  ),
                                ),
                                Container(width: 344,height: 56,
                                  child: RaisedButton(
                                    color: const Color(0xffFFE600),
                                    onPressed: () {
                                      _getImage(_image2).then((value) {
                                        _image2 = value;
                                        print(_image2);
                                        setState(() {
                                          isFile = true;
                                        });
                                      });
                                    },
                                    child: Text('앨범에서 선택',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                      },
                      child: Container(
                        width: 288,height: 162,
                        child: _image2 != null
                         //? FileImage(_image2)
                            ? Image.file(File(_image2.path),)
                            : Image.asset('images/Group 77.png'),
                      ),
                    ),
                    SizedBox(height: 10),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: SizedBox(
                  width: 344,
                  height: 56,
                  child: RaisedButton(
                    onPressed: () {
                    },
                    child: Text("다음",
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    color: AppColor.yellow,
                  )
                ),
              ),
            ],
          ),
        )
    );
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
