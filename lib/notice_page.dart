import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:ibagudelivery_rider/notice_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/bloc.dart';

class Notice extends StatefulWidget {
  Bloc bloc;

  Notice(this.bloc);

  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {

  bool _isloadind = true;
  int _itemCount = 0;
  List noticelist = [];

  @override
  void initState() {
    getnotice();
  }

  void getnotice() async {
    await widget.bloc.noticeget().then((res) {
      noticelist = res;
    });
    _itemCount = noticelist.length;
    setState(() {
      _isloadind = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
        backgroundColor: const Color(0xff20283E),
        title: Text('공지사항',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color(0xffFFE600))),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xffFFE600)),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: _isloadind ? Center(child: CircularProgressIndicator()):MyListView(),
            ),
          ],
        ),
      ),
    );
  }

  MyListView(){
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return ListView.builder(
          itemCount: _itemCount,
          itemBuilder: (context, int i) {
            return  InkWell(
              child: Container(
                height: 44, width: 344,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text('${noticelist[i]['title']}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text('${noticelist[i]['registered_date'].toString().substring(0,10)}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: const Color(0xff959595)),),
                          ),
                        )
                      ],
                    ),
                    Container( height:0.5,color: const Color(0x80DBDBDB)),
                  ],
                ),

              ),
              onTap: () async {
                var title = noticelist[i]['title'];
                var image = noticelist[i]['image'];
                var description = noticelist[i]['description'];
                var date = noticelist[i]['registered_date'].toString().substring(0,10);
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NoticeDetails(
                      arguments:Arguments(title: title, image : image,description : description,date : date))
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}



class Arguments {
  var title;
  var image;
  var description;
  var date;
  Arguments({this.title,this.image,this.description,this.date});
}

class NoticeDetails extends StatelessWidget {
  NoticeDetails({Key key, this.arguments}) : super(key: key);
  final arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff20283E),
      appBar: AppBar(
        backgroundColor: const Color(0xff20283E),
        title: Text('공지사항',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color(0xffFFE600))),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xffFFE600)),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text('${arguments.title}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text('${arguments.date}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: const Color(0xff959595)),),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container( height:0.5,color: const Color(0x80DBDBDB)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Image.network(arguments.image),
                        HtmlWidget(
                          '''
                          ${arguments.description}
                          ''',
                          textStyle: TextStyle(fontSize: 14,color: Colors.white),
                          webView: true,
                        ),

                      ],
                    ),
                  )

                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
}