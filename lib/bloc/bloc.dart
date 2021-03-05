import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:ibagudelivery_rider/data/notice.dart';
import 'package:ibagudelivery_rider/data/response_data.dart';
import 'package:http/http.dart' as http;
import 'package:ibagudelivery_rider/data/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bloc with ChangeNotifier {
  String baseURL = 'http://ibagudelivery.com/api/rider';//운영서버
  String baseURL2 = 'http://13.125.11.129:8080/busan_donggu_web/api/rider';//개발서버

  FirebaseMessaging fcm = FirebaseMessaging();
  bool isLoading;
  String uuid;
  String token;
  Map<String, String> header;
  User user = User();
  //MyLocation currentLocation;
  String place;
  SharedPreferences pref;
  Notice notice = Notice();
  bool isdev = true;


  Bloc() {
    if (isdev){
      baseURL = 'http://13.125.11.129:8080/busan_donggu_web/api/rider';
    } else{
      baseURL = 'http://ibagudelivery.com/api/rider';
    }
    fcm.getToken().then((value) {
      this.token = value;
      print(token);
    });
    FlutterUdid.consistentUdid.then((udid) {
      uuid = udid;
    });
    SharedPreferences.getInstance().then((_prefs) {
      pref = _prefs;
    });

    // Location location = new Location();
    // header = {"Authorization": "KakaoAK dae06dfd15c0d4a6bbf865a8efc7538a"};
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
    //     print(currentLocation.latitude.toString() + ',' +
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


  Future<ResponseData> getJoinSms({var num}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["phone"] = num;
    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/sendauthcode"), body: params);
    isLoading = false;
    print(response.body);
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
        Uri.encodeFull(baseURL + "/user/sendloginsms"), body: params);
    isLoading = false;
    print(response.body);
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
    print(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        // _login();
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
        print(res.errorMsg);
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
    print(id);
    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/id_check"), body: params);
    isLoading = false;
    print(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        // _login();
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
        print(res.errorMsg);
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return res;
  }

  Future<ResponseData> getJoin({String id, String pw, String name, String phone,
    String image='', String image2=''}) async {
    ResponseData res = ResponseData();
    print(id);
    print(pw);
    print(name);
    print(phone);
    print(image);
    print(image2);
    print(Platform.isAndroid ? 'and' : 'ios');
    print(uuid);
    print(token);

    isLoading = true;
    var uri = Uri.parse(baseURL+"/register");
    var request;

    request = http.MultipartRequest('POST', uri)
      ..fields['app_platform'] = Platform.isAndroid ? 'and' : 'ios'
      ..fields["udid"] = uuid
      ..fields["push_token"] = token

      ..fields["phone"] = phone
      ..fields["id"] = id
      ..fields["pw"] = pw
      ..fields["name"] = name
      ..fields["phone"] = phone
      // ..fields["expire_license_date"] = license_date
      // ..fields["account_name"] = account_name
      // ..fields["account_num"] = account_num
      // ..fields["account_bank"] = account_bank

      ..files.add(await http.MultipartFile.fromPath(
          'join_image', image, filename: image.split('/').last))
      ..files.add(await http.MultipartFile.fromPath(
      'join_image2', image2, filename: image2.split('/').last));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print(response.body);
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

  Future<ResponseData> login({String id, String pw}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["id"] = id;
    params["pw"] = pw;
    params["udid"] = uuid;
    params["push_token"] = token;

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/login"), body: params);
    isLoading = false;
    print(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        if (jsonObj['data'] != null) {
          user = User.fromJson(jsonObj['data']);
          print(user.serial);
          pref.setString('serial',user.serial);
          pref.setString('username',user.name);
          pref.setString('userphone',user.phone);
          pref.setString('userfaceImage',user.faceImage);
          print(pref.getString('serial'));
          print(pref.getString('username'));
          print(pref.getString('userphone'));
          print(pref.getString('userfaceImage'));
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

  // Future<ResponseData> loginWithAuth({String authcode, String phone}) async {
  //   ResponseData res = ResponseData();
  //   Map<String, dynamic> params = Map<String, String>();
  //   params["authcode"] = authcode;
  //   params["phone"] = phone;
  //   params["udid"] = uuid;
  //   params["push_token"] = token;
  //
  //   isLoading = true;
  //   var response = await http.post(
  //       Uri.encodeFull(baseURL + "/user/loginwithauth"), body: params);
  //   isLoading = false;
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     dynamic jsonObj = json.decode(response.body);
  //     String code = jsonObj['code'];
  //     if (code == "S01") {
  //       res.success = true;
  //       if (jsonObj['data'] != null) {
  //         user = User.fromJson(jsonObj['data']);
  //       }
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
  //
  Future<ResponseData> autoLogin({String serial}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["serial"] = serial;
    params["udid"] = uuid;
    params["push_token"] = token;

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/autologin"), body: params);
    isLoading = false;
    print(response.body);
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
  //   print(response.body);
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
    print(response.body);
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
    print(response.body);
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
    print(response.body);
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

  Future<List> noticeget() async {
    List noticelist = [];
    ResponseData res = ResponseData();

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/notice/get"));
    isLoading = false;
    print(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        if (jsonObj['data'] != null) {
          noticelist = jsonObj['data'];
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
    return noticelist;
  }

  Future<ResponseData> getupdateSms({var num}) async {
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["phone"] = num;
    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/updateauthcode"), body: params);
    isLoading = false;
    print(response.body);
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

  Future<ResponseData> registeraccount({String serial, String account_name, String account_num,String account_bank}) async {
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
    print(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
        print(res.errorMsg);
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
    print(response.body);
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
    print(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        pref.setString("findid", jsonObj['data']);
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
        print(res.errorMsg);
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
    print(response.body);
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
    print(response.body);
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

    print('aa');
    print(pw);
    print(serial);
    print('aa');

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/find/changePw"), body: params);
    isLoading = false;
    print(response.body);
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

  Future<List> orderlist({String serial}) async {
    List orderlist = [];
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["serial"] = serial;

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/order_list"), body: params);
    isLoading = false;
    print(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        orderlist = jsonObj['data'];
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return orderlist;
  }

  Future<Map> orderdetail({String serial,String request_serial}) async {
    Map orderdetail = {};
    ResponseData res = ResponseData();
    Map<String, dynamic> params = Map<String, String>();
    params["serial"] = serial;
    params["request_serial"] = request_serial;

    isLoading = true;
    var response = await http.post(
        Uri.encodeFull(baseURL + "/order_detail"), body: params);
    isLoading = false;
    print(response.body);
    if (response.statusCode == 200) {
      dynamic jsonObj = json.decode(response.body);
      String code = jsonObj['code'];
      if (code == "S01") {
        res.success = true;
        orderdetail = jsonObj['data'];
      } else {
        res.success = false;
        res.errorMsg = jsonObj['message'];
      }
    } else {
      res.success = false;
      res.errorMsg = "http response code=${response.statusCode}";
    }
    return orderdetail;
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
    print(response.body);
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
    print(response.body);
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
    print(response.body);
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
    print(response.body);
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