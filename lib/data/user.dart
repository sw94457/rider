class User {
  String serial;
  String flag;
  String id;
  String pw;
  String name;
  String location_serial;
  String location2;
  String term;
  String faceImage;
  String expireLicenseDate;
  String accountName;
  String accountNum;
  String accountBank;
  String licenseImage;
  String joinImage;
  String joinImage2;
  String phone;
  String pushToken;
  String appPlatform;
  String udid;

  User(
      {this.serial,
        this.flag,
        this.id,
        this.pw,
        this.name,
        this.location_serial,
        this.location2,
        this.term,
        this.faceImage,
        this.expireLicenseDate,
        this.accountName,
        this.accountNum,
        this.accountBank,
        this.licenseImage,
        this.joinImage,
        this.joinImage2,
        this.phone,
        this.pushToken,
        this.appPlatform,
        this.udid});

  User.fromJson(Map<String, dynamic> json) {
    serial = json['serial'];
    flag = json['flag'];
    id = json['id'];
    pw = json['pw'];
    term = json['calculate_cycle'];
    name = json['name'];
    location_serial = json['location_serial'];
    location2 = json['location2'];
    faceImage = json['face_image'];
    expireLicenseDate = json['expire_license_date'];
    accountName = json['account_name'];
    accountNum = json['account_num'];
    accountBank = json['account_bank'];
    licenseImage = json['license_image'];
    joinImage = json['join_image'];
    joinImage2 = json['join_image2'];
    phone = json['phone'];
    pushToken = json['push_token'];
    appPlatform = json['app_platform'];
    udid = json['udid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serial'] = this.serial;
    data['flag'] = this.flag;
    data['id'] = this.id;
    data['pw'] = this.pw;
    data['calculate_cycle'] = this.term;
    data['name'] = this.name;
    data['location_serial'] = this.location_serial;
    data['location2'] = this.location2;
    data['face_image'] = this.faceImage;
    data['expire_license_date'] = this.expireLicenseDate;
    data['account_name'] = this.accountName;
    data['account_num'] = this.accountNum;
    data['account_bank'] = this.accountBank;
    data['license_image'] = this.licenseImage;
    data['join_image'] = this.joinImage;
    data['join_image2'] = this.joinImage2;
    data['phone'] = this.phone;
    data['push_token'] = this.pushToken;
    data['app_platform'] = this.appPlatform;
    data['udid'] = this.udid;
    return data;
  }
}