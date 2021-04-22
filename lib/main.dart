import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/page/home_page.dart';
import 'package:rider_app/page/login/login_page.dart';
import 'package:rider_app/ui/color.dart';

import 'page/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Bloc bloc = Bloc();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '딜리버리',
      theme: ThemeData(primarySwatch: AppColor.main_navy),
      home: SplashScreen(bloc),
      // home: TabRootPage(bloc),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // // If you're going to use other Firebase services in the background, such as Firestore,
  // // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class SplashScreen extends StatefulWidget {
  Bloc bloc;

  SplashScreen(this.bloc);

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  Timer _timer;
  bool isLoading = true;

  _SplashState() {
    _timer = new Timer(const Duration(seconds: 1), () {
      goMain();
    });
  }

  void goMain(){
    Route route = MaterialPageRoute(builder: (context) => LoginPage(widget.bloc));
    Navigator.pushReplacement(context, route);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.navy,
          elevation: 0,
          brightness: Brightness.dark,
        ),
        body: Container(
          color: AppColor.navy,
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Image.asset('assets/images/icon.png', width: size.width/4),
              Image.asset('assets/images/icon_jinju.png', width: size.width/3),
              SizedBox(height: 20,),
              Text('마싯성딜리버리',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: 'cafe24',
                    color: AppColor.yellow),),
              SizedBox(height: 100,),
            ],
          )
        ),
      ),
    );
  }
}