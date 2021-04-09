import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:rider_app/data/kakao_geo.dart';
import 'package:rider_app/data/notice.dart';
import 'package:rider_app/data/location.dart';
import 'package:rider_app/data/order.dart';
import 'package:rider_app/data/response_data.dart';
import 'package:rider_app/data/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bloc with ChangeNotifier {
  String baseURL;//개발서버

  Logger logger = Logger();
  FirebaseMessaging fcm = FirebaseMessaging();
  Map<String, String> header = {"Authorization": "KakaoAK a7b2324e5526da03326a0684c37e37ff"};
  bool isLoading;
  User user = User();
  //MyLocation currentLocation;
  String place;
  SharedPreferences pref;
  bool isdev = false;
  Position position;

  Bloc() {
    if (isdev){
      //개발서버
      baseURL = 'http://api.busandelivery.com';
      Logger.level = Level.debug;
    } else{
      //운영서버
      baseURL = 'http://api.busandelivery.com';
      //Logger.level = Level.error;
      Logger.level = Level.debug;
    }

    SharedPreferences.getInstance().then((_prefs) {
      pref = _prefs;
      pref.setBool("workState", false);
    });

    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
      position = value;
      var lat = position.latitude;
      var long = position.longitude;

      if(position.latitude<0){
        lat = (-1)*position.latitude;
      }
      if(position.longitude<0){
        long = (-1)*position.longitude;
      }
      reverseGeo(lat: lat, lon: long).then((value) {
        print('kakao location : '+value);
      });
    });
    //Location location = new Location();
    // currentLocation =
    //     MyLocation(37.547598, 126.979931, address: "서울특별시", short: "서울특별시");
    //
    // location.getLocation().then((onValue) {
    //   if (onValue != null) {
    //     if (onValue.longitude < 0) {
    //       currentLocation =
    //           MyLocation(37.547598, 126.979931, address: "", short: "");
    //     } else {
    //       currentLocation = MyLocation(onValue.latitude, onValue.longitude,
    //           address: "", short: "");
    //     }
    //     logger.d(currentLocation.latitude.toString() + ',' +
    //         currentLocation.longitude.toString());
    //   }
    //
    //   reverseGeo(lat: currentLocation.latitude, lon: currentLocation.longitude);
    // }).catchError((err) {
    //   FlutterUdid.consistentUdid.then((udid) {
    //     uuid = udid;
    //   });
    //   reverseGeo(lat: currentLocation.latitude, lon: currentLocation.longitude);
    // });
  }

  Future<String> reverseGeo({double lat, double lon}) async {
    String _chagnedAddress = "";
    String _shortAddress = "";
    String _shortAddress2 = "";
    List<Documents> resultList;

    if (lat == 0 || lon == 0) return '';
    var response = await http.get(
        Uri.encodeFull(
            "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=${lon}&y=${lat}"),
        headers: header);
    if (response.statusCode == 200) {
      logger.d('[kakao]' + response.body);
      dynamic jsonObj = json.decode(response.body);
      if (jsonObj['documents'] != null) {
        resultList = new List<Documents>();
        jsonObj['documents'].forEach((dynamic v) {
          resultList.add(new Documents.fromJson(v));
        });
        if (resultList.length > 0) {
          for (int i = 0; i < resultList.length; i++) {
            if (resultList[i].regionType == 'H') {
              _shortAddress = resultList[i].addressName;
              _shortAddress2 = resultList[i].region2depthName + " " +
                  resultList[i].region3depthName + " " +
                  resultList[i].region4depthName;
              _chagnedAddress = resultList[i].addressName;
              print(_shortAddress2);
            }
          }
        }
      } else {
        logger.d('{}' + response.body);
      }
    } else {
      logger.d(response.body);
    }
    return _shortAddress2;
  }

  Future<List<Location>> getLocation() async {
    List<Location> list = [];
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/getlocation"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        if (jsonObj['data'] != null) {
          jsonObj['data'].forEach((v) {
            list.add(new Location.fromJson(v));
          });
        }
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return list;
  }

  Future<ResponseData> getJoinSms({var num}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["phone"] = num;
    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/sendauthcode"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        // _login();
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> getLoginSms({var num}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["phone"] = num;
    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/sendloginauthcode"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> checkAuthCode({String num, String code}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["phone"] = num;
    params["authcode"] = code;

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/checkauthcode"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        // _login();
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
        logger.d(res.errorMsg);
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> checkId({String id}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["id"] = id;
    logger.d(id);
    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/id_check"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        // _login();
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
        logger.d(res.errorMsg);
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> getJoin({String name, String phone,
    String location_serial='', String term='',
    String image='', String image2='', String account_name, String account_num, String account_bank}) async {
    ResponseData res = ResponseData();
    logger.d(Platform.isAndroid ? 'and' : 'ios');
    logger.d(FlutterUdid.consistentUdid);
    logger.d(fcm.getToken());
    logger.d(name);
    logger.d(phone);
    logger.d(location_serial);
    logger.d(term);
    logger.d(account_name);
    logger.d(account_num);
    logger.d(account_bank);
    logger.d(image);
    logger.d(image2);

    isLoading = true;
    var uri = Uri.parse(baseURL+"/register");
    var request;

    request = http.MultipartRequest('POST', uri)
      ..fields['app_platform'] = Platform.isAndroid ? 'and' : 'ios'
      ..fields["udid"] = await FlutterUdid.consistentUdid
      //..fields["push_token"] = await fcm.getToken()
      ..fields["push_token"] = 'aaaaa'
      ..fields["phone"] = phone
      ..fields["name"] = name
      ..fields["location_serial"] = location_serial
      ..fields["calculate_cycle"] = term
      // ..fields["expire_license_date"] = license_date
      ..fields["account_name"] = account_name
      ..fields["account_num"] = account_num
      ..fields["account_bank"] = account_bank

      ..files.add(await http.MultipartFile.fromPath(
          'join_image', image, filename: image.split('/').last))
      ..files.add(await http.MultipartFile.fromPath(
      'join_image2', image2, filename: image2.split('/').last));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    logger.d(response.body);
    isLoading = false;
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        user.serial = jsonObj['data'];
        //pref.setString("serial", user.serial);
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> login({String phone}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    logger.d(phone);
    params["phone"] = phone;
    params["udid"] = await FlutterUdid.consistentUdid;
    params["push_token"] = 'asdfasdfaa';
    // params["push_token"] = await fcm.getToken();

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/relogin"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        if (jsonObj['data'] != null) {
          user = User.fromJson(jsonObj['data']);
          logger.d(user.serial);
          pref.setString('serial',user.serial);
          pref.setString('username',user.name);
          pref.setString('userphone',user.phone);
          pref.setString('userfaceImage',user.faceImage);
          logger.d(pref.getString('serial'));
        }
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
        if (code == "E02") {
          res.code = "E02";
        }
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> loginWithAuth({String authcode, String phone}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["authcode"] = authcode;
    params["phone"] = phone;
    params["udid"] = await FlutterUdid.consistentUdid;
   // params["push_token"] = fcm.getToken();
    params["push_token"] = 'aaaaa';

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/loginwithauth"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        if (jsonObj['data'] != null) {
          user = User.fromJson(jsonObj['data']);
        }
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> autoLogin({String serial}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["serial"] = serial;
    params["udid"] = FlutterUdid.consistentUdid;
    params["push_token"] = fcm.getToken();

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/autologin"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        if (jsonObj['data'] != null) {
          user = User.fromJson(jsonObj['data']);
        }
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  // Future<ResponseData> updateLocation({String serial, String lat, String long}) async {
  //   ResponseData res = ResponseData();
  //   Map<String, dynamic> params = Map<String, String>();
  //   params["serial"] = serial;
  //   params["latitude"] = lat;
  //   params["longitude"] = long;
  //
  //   isLoading = true;
  //   var response = await http.post(
  //       Uri.encodeFull(baseURL + "/onLocation"), body: params);
  //   isLoading = false;
  //   logger.d(response.body);
  //   if (response.statusCode == 200) {
  //     dynamic jsonObj = json.decode(response.body);
  //     String code = jsonObj['code'];
  //     if (code == "S01") {
  //       res.success = true;
  //     } else {
  //       res.success = false;
  //       res.errorMsg = jsonObj['message'];
  //     }
  //   } else {
  //     res.success = false;
  //     res.errorMsg = "http response code=${response.statusCode}";
  //   }
  //   return res;
  // }

  Future<ResponseData> updateLocation({String serial, String lat, String long}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["serial"] = serial;
    params["latitude"] = lat;
    params["longitude"] = long;

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/onLocation"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }


  Future<ResponseData> riderOn({String serial}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["serial"] = pref.getString('serial');

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/riderOn"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> riderOff({String serial}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["serial"] = pref.getString('serial');

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/riderOff"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<List<Notice>> getNotice() async {
    List<Notice> noticeList = [];
    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/notice/get"));
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        if (jsonObj['data'] != null) {
          jsonObj['data'].forEach((v) {
            noticeList.add(new Notice.fromJson(v));
          });
        }
      } else {
        logger.d(jsonObj['message']);
      }
    } else {
      logger.d("http response code=${response.statusCode}");
    }
    return noticeList;
  }

  Future<ResponseData> getUpdateSms({var num}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["phone"] = num;
    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/updateauthcode"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> registerAccount({String serial, String account_name, String account_num,String account_bank}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["serial"] = pref.getString('serial');
    params["account_name"] = account_name;
    params["account_num"] = account_num;
    params["account_bank"] = account_bank;

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/register_account"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
        logger.d(res.errorMsg);
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> getfindSms({var num}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["phone"] = num;
    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/find/sendauthcode"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> findcheckauthcode({String phone, String authcode}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["phone"] = phone;
    params["authcode"] = authcode;

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/find/checkauthcode"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        pref.setString("findid", jsonObj['data']);
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
        logger.d(res.errorMsg);
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> findcheckIdAuth({String phone,String id}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["phone"] = phone;
    params["id"] = id;

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/find/checkIdAuth"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        res.data = jsonObj['data'];
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> findcheckauthcodePw({var phone,var authcode}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["phone"] = phone;
    params["authcode"] = authcode;

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/find/checkauthcodePw"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> findchangePw({String pw,String serial}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["pw"] = pw;
    params["serial"] = serial;

    logger.d('aa');
    logger.d(pw);
    logger.d(serial);
    logger.d('aa');

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/find/changePw"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<List<Order>> getOrderList() async {
    List<Order> orderList = [];
    isLoading = true;
    Map<String, dynamic> params = Map<String, String>();
    params["serial"] = pref.getString('serial');
    logger.d(pref.getString('serial'));

    var response = await http.post(
        Uri.encodeFull(baseURL + "/order_list"));
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        if (jsonObj['data'] != null) {
          jsonObj['data'].forEach((v) {
            orderList.add(new Order.fromJson(v));
          });
        }
      } else {
        logger.d(jsonObj['message']);
      }
    } else {
      logger.d("http response code=${response.statusCode}");
    }
    return orderList;
  }

  Future<Order> getOrderDetail({String request_serial}) async {
    Order order = Order();
    Map<String, dynamic> params = Map<String, String>();
    params["serial"] = pref.getString('serial');
    params["request_serial"] = request_serial;

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/order_detail"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        if(jsonObj['data'] != null){
          order = Order.fromJson(jsonObj['data']);
        }
      } else {
        logger.e(jsonObj['message']);
      }
    } else {
       logger.e("http response code=${response.statusCode}");
    }
    return order;
  }

  Future<ResponseData> acceptorder({String requestserial,String orderserial,String serial}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();

    params["request_serial"] = requestserial;
    params["order_serial"] = orderserial;
    params["serial"] = serial;

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/accept_order"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> pickUp({String requestserial,String serial}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();

    params["request_serial"] = requestserial;
    params["serial"] = serial;

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/pickUp"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> finishdelivery({String requestserial,String serial}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();

    params["request_serial"] = requestserial;
    params["serial"] = serial;

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/finish_delivery"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> sendmessage({String phone,String rider_message}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();

    params["phone"] = phone;
    params["rider_message"] = rider_message;

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/send_message"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }




}