import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:rider_app/bloc/bloc.dart';
import 'package:rider_app/data/notice.dart';
import 'package:rider_app/ui/color.dart';

class NoticePage extends StatefulWidget {
  Bloc bloc;

  NoticePage(this.bloc);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  bool isLoading = true;
  int _itemCount = 0;
  List<Notice> noticeList = [];

  @override
  void initState() {
    widget.bloc.getNotice().then((value) {
      noticeList = value;
      print(noticeList.length);
      _itemCount = noticeList.length;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
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
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : MyListView(),
            ),
          ],
        ),
      ),
    );
  }

  MyListView() {
    Size screenSize = MediaQuery.of(context).size;
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return ListView.builder(
          itemCount: _itemCount,
          itemBuilder: (context, int i) {
            return InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: screenSize.width,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            noticeList[i].title,
                            style: TextStyle(
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          noticeList[i].registeredDate.substring(0,10),
                          style: TextStyle(
                              fontSize: 15,
                              //fontWeight: FontWeight.bold,
                              color: const Color(0xff959595)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () async {
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => NoticeDetailPage(
                              title: noticeList[i].title,
                              image: noticeList[i].image,
                              description: noticeList[i].description,
                              date: noticeList[i].registeredDate.substring(0, 10))));
              },
            );
          },
        );
      },
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
                border: Border(bottom: BorderSide(color: Colors.grey))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(title,
                    style: TextStyle(
                        fontSize: 17,
                        //fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Text(date,
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
                  textStyle:
                      TextStyle(fontSize: 14, color: Colors.white),
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
