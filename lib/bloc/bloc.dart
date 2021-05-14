import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:rider_app/data/calculate.dart';
import 'package:rider_app/data/kakao_geo.dart';
import 'package:rider_app/data/notice.dart';
import 'package:rider_app/data/location.dart';
import 'package:rider_app/data/order.dart';
import 'package:rider_app/data/response_data.dart';
import 'package:rider_app/data/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bloc{
  String baseURL;//개발서버
  SharedPreferences pref;
  User user = User();
  Logger logger = Logger();
  //Map<String, String> header = {"Authorization": "KakaoAK a7b2324e5526da03326a0684c37e37ff"};
  bool isLoading;
  String place;
  bool isdev = false;
  // Position position;
  static double LATITUDE = 35.16041032189371;
  static double LONGITUDE = 129.06268053114317;


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
      Bloc.LATITUDE = value.latitude;
      Bloc.LONGITUDE = value.longitude;

      if(value.latitude<0){
        Bloc.LATITUDE = (-1)*value.latitude;
      }
      if(value.longitude<0){
        Bloc.LATITUDE = (-1)*value.longitude;
      }
    });
  }

  Future<List<Location>> getLocation() async {
    List<Location> list = [];
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    isLoading = true;
    var response = await http.post(
        Uri.parse(baseURL + "/getlocation"), body: params);
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
        Uri.parse(baseURL + "/sendauthcode"), body: params);
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
        Uri.parse(baseURL + "/sendloginauthcode"), body: params);
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
        Uri.parse(baseURL + "/checkauthcode"), body: params);
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
        Uri.parse(baseURL + "/id_check"), body: params);
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
    //logger.d(FlutterUdid.consistentUdid);
    //logger.d(fcm.getToken());
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
      ..fields["push_token"] = await FirebaseMessaging.instance.getToken()
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
    params["push_token"] = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.instance.getToken().then((value) {
      logger.d(value);
    });

    isLoading = true;
    var response = await http.post(
        Uri.parse(baseURL + "/relogin"), body: params);
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
          pref.setString('serial', user.serial);
          pref.setString('uid', user.name);
          if(user.flagOnoff == 'Y'){
            pref.setBool('workState', true);
          }else{
            pref.setBool('workState', false);
          }

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
    params["push_token"] = await FirebaseMessaging.instance.getToken();

    isLoading = true;
    var response = await http.post(
        Uri.parse(baseURL + "/loginwithauth"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        if (jsonObj['data'] != null) {
          user = User.fromJson(jsonObj['data']);
          pref.setString('serial', user.serial);
          pref.setString('uid', user.name);
          if(user.flagOnoff == 'Y'){
            pref.setBool('workState', true);
          }else{
            pref.setBool('workState', false);
          }
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
    var udid = await FlutterUdid.consistentUdid;
    logger.d(udid);
    Map<String, dynamic> params = Map<String, String>();
    params["serial"] = serial;
    params["udid"] = await FlutterUdid.consistentUdid;
    params["push_token"] = await FirebaseMessaging.instance.getToken();

    isLoading = true;
    var response = await http.post(
        Uri.parse(baseURL + "/autologin"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        if (jsonObj['data'] != null) {
          user = User.fromJson(jsonObj['data']);
          pref.setString('serial', user.serial);
          pref.setString('uid', user.name);
          if(user.flagOnoff == 'Y'){
            pref.setBool('workState', true);
          }else{
            pref.setBool('workState', false);
          }
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
  //       Uri.parse(baseURL + "/onLocation"), body: params);
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
        Uri.parse(baseURL + "/onLocation"), body: params);
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
    //params["serial"] = pref.getString('serial');
    params["serial"] = user.serial;

    isLoading = true;
    var response = await http.post(
        Uri.parse(baseURL + "/riderOn"), body: params);
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
    //params["serial"] = pref.getString('serial');
    params["serial"] = user.serial;

    isLoading = true;
    var response = await http.post(
        Uri.parse(baseURL + "/riderOff"), body: params);
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
        Uri.parse(baseURL + "/notice/get"));
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
        Uri.parse(baseURL + "/updateauthcode"), body: params);
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
        Uri.parse(baseURL + "/register_account"), body: params);
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
        Uri.parse(baseURL + "/find/sendauthcode"), body: params);
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
        Uri.parse(baseURL + "/find/checkauthcode"), body: params);
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
        Uri.parse(baseURL + "/find/checkIdAuth"), body: params);
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
        Uri.parse(baseURL + "/find/checkauthcodePw"), body: params);
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
        Uri.parse(baseURL + "/find/changePw"), body: params);
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

  Future<List<Order2>> getOrderList() async {
    List<Order2> orderList = [];
    isLoading = true;
    Map<String, dynamic> params = Map<String, String>();
    //params["serial"] = pref.getString('serial');
    params["serial"] = user.serial;
    //logger.d(pref.getString('serial'));

    var response = await http.post(
        Uri.parse(baseURL + "/order_list"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        if (jsonObj['data'] != null) {
          jsonObj['data'].forEach((v) {
            orderList.add(new Order2.fromJson(v));
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

  Future<Order2> getOrderDetail({String request_serial}) async {
    Order2 order = Order2();
    Map<String, dynamic> params = Map<String, String>();
   // params["serial"] = pref.getString('serial');
    params["serial"] = user.serial;
    params["request_serial"] = request_serial;

    isLoading = true;
    var response = await http.post(
        Uri.parse(baseURL + "/order_detail"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        if(jsonObj['data'] != null){
          order = Order2.fromJson(jsonObj['data']);
        }
      } else {
        logger.e(jsonObj['message']);
      }
    } else {
       logger.e("http response code=${response.statusCode}");
    }
    return order;
  }

  Future<ResponseData> acceptOrder({String request_serial, String order_serial, String serial}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();

    params["request_serial"] = request_serial;
    params["order_serial"] = order_serial;
    params["serial"] = serial;

    isLoading = true;
    var response = await http.post(
        Uri.parse(baseURL + "/accept_order"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        res.errorMsg = jsonObj['message'];
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

  Future<ResponseData> pickUp({String requestserial, String order_serial}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();

    params["request_serial"] = requestserial;
    params["order_serial"] = order_serial;
    params["serial"] = user.serial;

    isLoading = true;
    var response = await http.post(
        Uri.parse(baseURL + "/pickUp"), body: params);
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

  Future<ResponseData> finishDelivery({String requestserial, String order_serial}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();

    params["request_serial"] = requestserial;
    params["order_serial"] = order_serial;
    params["serial"] = user.serial;

    isLoading = true;
    var response = await http.post(
        Uri.parse(baseURL + "/finish_delivery"), body: params);
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

  Future<ResponseData> updateInfo({String phone, String name, String account_name, String account_num, String account_bank, String calculate_cycle}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();

    //params["phone"] = user.phone;
    params["name"] = name;
    params["serial"] = user.serial;
    params["calculate_cycle"] = calculate_cycle;
    params["account_name"] = account_name;
    params["account_num"] = account_num;
    params["account_bank"] = account_bank;

    logger.d(user.serial);
    logger.d(name);
    logger.d(calculate_cycle);
    logger.d(account_name);
    logger.d(account_num);
    logger.d(account_bank);

    isLoading = true;
    var response = await http.post(
        Uri.parse(baseURL + "/update"), body: params);
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

  Future<ResponseData> sendMessage({String phone, String message}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();

    params["phone"] = phone;
    params["rider_message"] = message;

    isLoading = true;
    var response = await http.post(
        Uri.parse(baseURL + "/send_message"), body: params);
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

  Future<List<Calculate>> getCalculateList() async {
    List<Calculate> list = [];
    Map<String, dynamic> params = Map<String, String>();
    params["serial"] = user.serial;

    isLoading = true;
    var response = await http.post(
        Uri.parse(baseURL + "/rider_cal"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        if (jsonObj['data'] != null) {
          jsonObj['data'].forEach((v) {
            list.add(new Calculate.fromJson(v));
          });
        }
      } else {
        logger.d(jsonObj['message']);
      }
    } else {
      logger.d("http response code=${response.statusCode}");
    }
    return list;
  }

  Future<List<Order2>> getCalculateDetail({String startDate, String endDate}) async {
    List<Order2> list = [];
    Map<String, dynamic> params = Map<String, String>();
    params["serial"] = user.serial;
    params["start_date"] = startDate;
    params["end_date"] = endDate;

    isLoading = true;
    var response = await http.post(
        Uri.parse(baseURL + "/delivery_history"), body: params);
    isLoading = false;
    logger.d(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        if(jsonObj['data'] != null){
          jsonObj['data'].forEach((v) {
            list.add(new Order2.fromJson(v));
          });
        }
      } else {
        logger.e(jsonObj['message']);
      }
    } else {
      logger.e("http response code=${response.statusCode}");
    }
    return list;
  }

  Future<ResponseData> settingAlarm({String flag}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();

    params["serial"] = user.serial;
    params["flag"] = flag;

    isLoading = true;
    var response = await http.post(
        Uri.parse(baseURL + "/set_notice_alarm"), body: params);
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