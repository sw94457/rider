import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/page/drawer/phone_update_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfoPage extends StatefulWidget {
  Bloc bloc;

  PersonalInfoPage(this.bloc);

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  SharedPreferences prefs;
  bool isload = false;
  var userfaceImage;
  var username;
  var useruserphone;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
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
                          height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("프로필사진",style: TextStyle(fontSize: 18,color: Colors.white)),
                                Container(
                                  child: isload?Stack(
                                    children: [
                                      SizedBox(
                                        width: 80,height: 80,
                                        child: CircleAvatar(backgroundImage: NetworkImage('${userfaceImage}')),
                                      ),
                                      Container(
                                        width: 80,height: 80,
                                        alignment: Alignment.bottomRight,
                                        child: CircleAvatar(backgroundImage: AssetImage('images/camera.png'), radius: 15),
                                      ),
                                    ],
                                  ):Stack(
                                    children: [
                                      SizedBox(
                                        width: 80,height: 80,
                                        child: CircleAvatar(backgroundImage: AssetImage('images/profile.png')),
                                      ),
                                      Container(
                                        width: 80,height: 80,
                                        alignment: Alignment.bottomRight,
                                        child: CircleAvatar(backgroundImage: AssetImage('images/camera.png'), radius: 15),
                                      ),
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
                                  controller: name,
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
                                      controller: phone,
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
                                            onPressed: () async {
                                              final result = await Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => PhoneUpdatePage(widget.bloc)),
                                              );
                                              print(result);
                                              setState(() {
                                                phone.text = result;
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
                        ),
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
    getCounterFromSharedPrefs();
  }

  getCounterFromSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userfaceImage = prefs.getString('userfaceImage');
      username = prefs.getString('username');
      useruserphone = prefs.getString('userphone');
      phone.text = useruserphone;
      name.text = username;
      isload = true;
    });
  }

}