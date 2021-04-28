import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/data/notice.dart';
import 'package:rider_app/ui/color.dart';
import 'package:rider_app/ui/progress.dart';
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
  List<Notice> reverseNoticeList = [];
  List a = ['a', 'b', 'c', 'd'];

  @override
  void initState() {
    SharedPreferences.getInstance().then((_prefs) {
      pref = _prefs;
    });
    widget.bloc.getNotice().then((value) {
      noticeList = value;
      _itemCount = noticeList.length;
      reverseNoticeList = List.from(noticeList.reversed);
      setState(() {
        isLoading = false;
      });
    });
  }

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
              color: isAlarm ? AppColor.yellow : Colors.grey,
            ),
            onPressed: () {
              if (isAlarm) {
                widget.bloc.settingAlarm(flag: 'N').then((res) {
                  if(res.success){
                    Toast.show('공지사항 알림 off', context, duration: 2);
                  }else{
                    Toast.show('공지사항 알림 설정에 실패했습니다.', context, duration: 2);
                  }
                });
              } else {
                widget.bloc.settingAlarm(flag: 'Y').then((res) {
                  if(res.success){
                    Toast.show('공지사항 알림 on', context, duration: 2);
                  }else{
                    Toast.show('공지사항 알림 설정에 실패했습니다.', context, duration: 2);
                  }
                });
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
        child: isLoading ? ProgressPage(screen.width) : notice(),
      ),
    );
  }

  notice() {
    Size screenSize = MediaQuery.of(context).size;
    return ListView(
      children: List.generate(reverseNoticeList.length, (i) {
        var type_text='';
        var type_color = AppColor.neon_green;
        switch(reverseNoticeList[i].type){
          case 'R':
            type_text = '1:1';
            type_color = AppColor.neon_green;
            break;
          case 'AR':
            type_text = '전체';
            type_color = AppColor.neon_yellow;
            break;
          case 'A':
            type_text = '시스템공지';
            type_color = AppColor.neon_yellow;
            break;
          case 'GR':
            type_text = '그룹공지';
            type_color = AppColor.neon_yellow;
            break;
          case 'LR':
            type_text = '지역공지';
            type_color = AppColor.neon_yellow;
            break;
        }
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
                              color: type_color,
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.only(right: 7),
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: Text(
                            type_text,
                            style: TextStyle(fontFamily: 'cafe24'),
                          ),
                        ),
                        Container(
                          child: Text(
                            reverseNoticeList[i].title,
                            //'title',
                            style: TextStyle(
                                fontSize: 14,
                                //fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      reverseNoticeList[i].registeredDate.substring(0, 10),
                      // 'register',
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NoticeDetailPage(notice: reverseNoticeList[i])));
          },
        );
      }),
    );
  }
}

class NoticeDetailPage extends StatelessWidget {
  Notice notice;

  NoticeDetailPage({this.notice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
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
                        notice.title,
                        style: TextStyle(
                            fontSize: 17,
                            //fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Text(
                  notice.registeredDate != null
                      ? notice.registeredDate.substring(0, 10)
                      : '',
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
                Image.network(notice.image),
                HtmlWidget(
                  '''
                  ${this.notice.description}
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
