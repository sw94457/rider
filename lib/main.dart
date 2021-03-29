import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/page/login/login_page.dart';
import 'package:rider_app/ui/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<Bloc>(create: (_) => Bloc())],
      child: Consumer<Bloc>(
        builder: (context, bloc, _) {
          return MaterialApp(
            title: '부산동구배달앱',
            theme: ThemeData(primarySwatch: AppColor.main_navy),
            home: LoginPage(bloc),
            // home: TabRootPage(bloc),
          );
        },
      ),
    );
  }
}