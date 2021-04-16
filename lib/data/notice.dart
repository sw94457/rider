class Notice {
  String flag;
  int serial;
  int adminSerial;
  String type;
  String adminName;
  String title;
  String image;
  String description;
  String registeredDate;
  String joinImage;
  String locationSerial;
  String groupSerial;
  String riderSerial;
  String companySerial;

  Notice(
      {this.flag,
        this.serial,
        this.adminSerial,
        this.type,
        this.adminName,
        this.title,
        this.image,
        this.description,
        this.registeredDate,
        this.joinImage,
        this.locationSerial,
        this.groupSerial,
        this.riderSerial,
        this.companySerial});

  Notice.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    serial = json['serial'];
    adminSerial = json['admin_serial'];
    type = json['type'];
    adminName = json['admin_name'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    registeredDate = json['registered_date'];
    joinImage = json['join_image'];
    locationSerial = json['location_serial'];
    groupSerial = json['group_serial'];
    riderSerial = json['rider_serial'];
    companySerial = json['company_serial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['serial'] = this.serial;
    data['admin_serial'] = this.adminSerial;
    data['type'] = this.type;
    data['admin_name'] = this.adminName;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['registered_date'] = this.registeredDate;
    data['join_image'] = this.joinImage;
    data['location_serial'] = this.locationSerial;
    data['group_serial'] = this.groupSerial;
    data['rider_serial'] = this.riderSerial;
    data['company_serial'] = this.companySerial;
    return data;
  }
}

