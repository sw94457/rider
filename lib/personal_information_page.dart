import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PersonalInformation extends StatefulWidget {
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  var _racolor = Colors.white12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
        backgroundColor: const Color(0xff20283E),
        title: Text('개인정보수정',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color(0xffFFE600))),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xffFFE600)),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                            width: 240,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                  child: SizedBox(
                                    width: 220,
                                    child: Row(
                                      children: [
                                        Text("프로필사진",
                                            style: TextStyle(fontSize: 18,color: Colors.white)),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              72, 0, 0, 0),
                                          child: Text("면허증",
                                              style: TextStyle(fontSize: 18,color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 220,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            width: 80,height: 80,
                                            child: CircleAvatar(backgroundImage: AssetImage('images/profile.png')),
                                          ),
                                          Container(
                                            width: 80,height: 80,
                                            alignment: Alignment.bottomRight,
                                            child: CircleAvatar(backgroundImage: AssetImage('images/camera.png'),
                                                radius: 15),
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          SizedBox(
                                            width: 80,height: 80,
                                            child: CircleAvatar(backgroundImage: AssetImage('images/mask.png')),
                                          ),
                                          Container(
                                            width: 80,height: 80,
                                            alignment: Alignment.bottomRight,
                                            child: CircleAvatar(
                                                backgroundImage: AssetImage('images/camera.png'),radius: 15),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          width: 312,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                                child: Text("이름",
                                    style: TextStyle(fontSize: 18, color: Colors.white)),
                              ),
                              Container(
                                height: 48,
                                child: TextField(
                                  cursorColor: Colors.white,
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
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 312,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 18, 0, 8),
                                child: Text("핸드폰번호",
                                    style: TextStyle(fontSize: 18, color: Colors.white)),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 48,
                                    width: 208,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      cursorColor: Colors.white,
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
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 0, 0, 0),
                                    child: Container(
                                          width: 92,height: 48,
                                          child: RaisedButton(
                                            onPressed: () {
                                              showModalBottomSheet(context: context, builder: (context){
                                                return Container(
                                                  height: 420,
                                                  color: const Color(0xff3B4255),
                                                  child: Column(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Container(
                                                            child: IconButton(
                                                              onPressed: (){
                                                                setState(() {
                                                                  Navigator.pop(context);
                                                                });
                                                              },
                                                            icon: Image.asset('images/exit.png', width: 20, height: 20,),
                                                              ),
                                                                alignment: Alignment.topRight,
                                                              ),
                                                              Container(
                                                                width: 312,
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text('핸드폰 번호 입력',style: TextStyle(fontSize: 16, color: Colors.white),),
                                                                    Padding(
                                                                      padding: const EdgeInsets.fromLTRB(0,17,0,16),
                                                                      child: Container(
                                                                        width: 312,height: 48,
                                                                        child: TextField(
                                                                          maxLength: 11,
                                                                          keyboardType: TextInputType.number,
                                                                          cursorColor: Colors.white,
                                                                          decoration: InputDecoration(
                                                                            enabledBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                                                                            ),
                                                                            focusedBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                                                                            ),
                                                                            counterText:'',
                                                                          ),
                                                                          style: TextStyle(color: Colors.white),
                                                                          onChanged: (text){
                                                                            setState(() {
                                                                              if (text.length == 11){
                                                                                _racolor = Colors.white;
                                                                              } else {
                                                                                _racolor = Colors.white12;
                                                                              }
                                                                              print(text.length);
                                                                            });

                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                        width: 312,height: 48,
                                                                        child: RaisedButton(
                                                                          onPressed: () {
                                                                          },
                                                                          child: Text('인증코드 받기',style: TextStyle(fontSize: 18, color: Colors.black),),
                                                                          color: _racolor,
                                                                        )),
                                                                    Text('인증 코드 입력',style: TextStyle(fontSize: 16, color: Colors.white),),

                                                                    Padding(
                                                                      padding: const EdgeInsets.fromLTRB(0,10,0,16),
                                                                      child: Container(
                                                                        width: 312,height: 48,
                                                                        child: TextField(
                                                                          keyboardType: TextInputType.number,
                                                                          cursorColor: Colors.white,
                                                                          decoration: InputDecoration(
                                                                            enabledBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                                                                            ),
                                                                            focusedBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                                                                            ),
                                                                          ),
                                                                          style: TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                        width: 312,height: 48,
                                                                        child: RaisedButton(
                                                                            onPressed: () {},
                                                                            child: Text('인증코드 확인',style: TextStyle(fontSize: 18, color: Colors.white),
                                                                            ),
                                                                            color: const Color(0x1Fffffff)))
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(width: 344,height: 56,
                                                                child: RaisedButton(
                                                                  color: const Color(0xffFFE600),
                                                                  onPressed: () {},
                                                                  child: Text('수정하기',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
                                                                  ),
                                                                ),
                                                              ),
                                                          ),
                                                        ],
                                                      ),
                                                );
                                              });
                                            },
                                            child: Text('변경하기',
                                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: -2),
                                            ),
                                            color: Colors.white,
                                          )),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 344,height: 56,
                child: RaisedButton(
                  color: const Color(0xffFFE600),
                  onPressed: () {},
                  child: Text('수정하기',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();



  }

  void call() {
    _racolor = Colors.white;
  }

  // final snackBar = SnackBar(
  //   backgroundColor: const Color(0xff3B4255),
  //   content: Container(
  //       height: 420,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Column(
  //             children: [
  //               Container(
  //                 child: IconButton(
  //                   onPressed: (){
  //
  //                   },
  //                   icon: Image.asset(
  //                     'images/exit.png', width: 24, height: 24,),
  //                 ),
  //                 alignment: Alignment.topRight,
  //               ),
  //               Container(
  //                 width: 312,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text('핸드폰 번호 입력',style: TextStyle(fontSize: 16, color: Colors.white),),
  //                     Padding(
  //                       padding: const EdgeInsets.fromLTRB(0,17,0,16),
  //                       child: Container(
  //                           width: 312,height: 48,
  //                           child: TextField(
  //                             keyboardType: TextInputType.number,
  //                             cursorColor: Colors.white,
  //                             decoration: InputDecoration(
  //                               enabledBorder: OutlineInputBorder(
  //                                 borderSide:
  //                                     BorderSide(color: Colors.white, width: 2.0),
  //                               ),
  //                               focusedBorder: OutlineInputBorder(
  //                                 borderSide:
  //                                     BorderSide(color: Colors.white, width: 2.0),
  //                               ),
  //                             ),
  //                             style: TextStyle(color: Colors.white),
  //                             onChanged: (text){
  //                               if (text.length <= 9){
  //
  //                                 }
  //                             },
  //                           ),
  //                         ),
  //                     ),
  //                     Container(
  //                         width: 312,height: 48,
  //                         child: RaisedButton(
  //                           onPressed: () {},
  //                           child: Text('인증코드 받기',style: TextStyle(fontSize: 18, color: Colors.black),),
  //                           color: Colors.white12,
  //                         )),
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Text('인증 코드 입력',style: TextStyle(fontSize: 16, color: Colors.white),),
  //                     ),
  //
  //                     Padding(
  //                       padding: const EdgeInsets.fromLTRB(0,10,0,16),
  //                       child: Container(
  //                         width: 312,height: 48,
  //                         child: TextField(
  //                           keyboardType: TextInputType.number,
  //                           cursorColor: Colors.white,
  //                           decoration: InputDecoration(
  //                             enabledBorder: OutlineInputBorder(
  //                               borderSide:
  //                                   BorderSide(color: Colors.white, width: 2.0),
  //                             ),
  //                             focusedBorder: OutlineInputBorder(
  //                               borderSide:
  //                                   BorderSide(color: Colors.white, width: 2.0),
  //                             ),
  //                           ),
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                     Container(
  //                         width: 312,height: 48,
  //                         child: RaisedButton(
  //                             onPressed: () {},
  //                             child: Text('인증코드 확인',style: TextStyle(fontSize: 18, color: Colors.white),
  //                             ),
  //                             color: const Color(0x1Fffffff)))
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Container(width: 344,height: 56,
  //               child: RaisedButton(
  //                 color: const Color(0xffFFE600),
  //                 onPressed: () {},
  //                 child: Text('수정하기',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
  //                 ),
  //               ),
  //             ),
  //
  //         ],
  //       )),
  //   duration: Duration(minutes: 10),
  // );

}
