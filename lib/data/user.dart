class User {
  String serial;
  String flag;
  String locationSerial;
  String location2;
  String locationName;
  String groupSerial;
  String groupName;
  String name;
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
  String term;
  String flagOnoff;
  String latitude;
  String longitude;
  var distance;
  String calculateCycle;

  User(
      {this.serial,
        this.flag,
        this.locationSerial,
        this.location2,
        this.locationName,
        this.groupSerial,
        this.groupName,
        this.name,
        this.faceImage,
        this.expireLicenseDate,
        this.accountName,
        this.accountNum,
        this.accountBank,
        this.licenseImage,
        this.joinImage,
        this.joinImage2,
        this.phone,
        this.term,
        this.pushToken,
        this.appPlatform,
        this.udid,
        this.flagOnoff,
        this.latitude,
        this.longitude,
        this.distance,
        this.calculateCycle});

  User.fromJson(Map<String, dynamic> json) {
    serial = json['serial'];
    flag = json['flag'];
    locationSerial = json['location_serial'];
    locationName = json['location_name'];
    groupSerial = json['group_serial'];
    groupName = json['group_name'];
    name = json['name'];
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
    flagOnoff = json['flag_onoff'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance'];
    calculateCycle = json['calculate_cycle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serial'] = this.serial;
    data['flag'] = this.flag;
    data['location_serial'] = this.locationSerial;
    data['location_name'] = this.locationName;
    data['group_serial'] = this.groupSerial;
    data['group_name'] = this.groupName;
    data['name'] = this.name;
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
    data['flag_onoff'] = this.flagOnoff;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['distance'] = this.distance;
    data['calculate_cycle'] = this.calculateCycle;
    return data;
  }
}