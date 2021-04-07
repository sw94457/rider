import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/data/notice.dart';
import 'package:rider_app/ui/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class NoticePage extends StatefulWidget {
  Bloc bloc;

  NoticePage(this.bloc);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  SharedPreferences pref;
  bool isLoading = true;
  bool isAlarm = true;
  int _itemCount = 0;
  List<Notice> noticeList = [];
  List a = ['a', 'b', 'c', 'd'];

  // @override
  // void initState() {
  //   SharedPreferences.getInstance().then((_prefs) {
  //     pref = _prefs;
  //   });
  //   widget.bloc.getNotice().then((value) {
  //     noticeList = value;
  //     print(noticeList.length);
  //     _itemCount = noticeList.length;
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
        title: Text('공지사항',
            style: TextStyle(
                //fontSize: 24,
                //fontWeight: FontWeight.bold,
                color: AppColor.yellow)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.yellow),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: isAlarm?
              AppColor.yellow : Colors.grey,
            ),
            onPressed: () {
              if(isAlarm){
                Toast.show('공지사항 알림 off', context, duration: 2);
              }else{
                Toast.show('공지사항 알림 on', context, duration: 2);
              }
              isAlarm = !isAlarm;
              pref.setBool('notice_alarm', isAlarm);
              setState(() {});
            },
          ),
        ],
      ),
      body: Container(
        height: screen.height,
        child: // isLoading
            //     ? Expanded(child: Center(child: CircularProgressIndicator()))
            //    :
            notice(),
      ),
    );
  }

  notice() {
    Size screenSize = MediaQuery.of(context).size;
    return ListView(
      children: List.generate(a.length, (i) {
        return InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 50,
            width: screenSize.width,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColor.neon_yellow,
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.only(right: 7),
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: Text(
                            '전체',
                            style: TextStyle(fontFamily: 'cafe24'),
                          ),
                        ),
                        Container(
                          child: Text(
                            //noticeList[i].title,
                            'title',
                            style: TextStyle(
                                fontSize: 14,
                                //fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      // noticeList[i].registeredDate.substring(0, 10),
                      'register',
                      style: TextStyle(
                          fontSize: 13,
                          //fontWeight: FontWeight.bold,
                          color: AppColor.grey),
                    )
                  ],
                ),
              ],
            ),
          ),
          onTap: () async {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => NoticeDetailPage(
            //             title: noticeList[i].title,
            //             image: noticeList[i].image,
            //             description: noticeList[i].description,
            //             date: noticeList[i].registeredDate.substring(0, 10))));
          },
        );
      }),
    );
  }
}

class NoticeDetailPage extends StatelessWidget {
  var title;
  var image;
  var description;
  var date;

  NoticeDetailPage({this.title, this.image, this.description, this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        title: Text('공지사항',
            style: TextStyle(
                //fontSize: 20,
                //fontWeight: FontWeight.bold,
                color: AppColor.yellow)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.yellow),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(),
                    Container(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 17,
                            //fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Text(
                  date,
                  style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: const Color(0xff959595)),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Image.network(image),
                HtmlWidget(
                  '''
                  ${this.description}
                  ''',
                  textStyle: TextStyle(fontSize: 14, color: Colors.white),
                  webView: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
