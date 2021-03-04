class Notice {
  String flag;
  int serial;
  int adminSerial;
  String type;
  Null adminName;
  String title;
  String image;
  String description;
  String registeredDate;
  Null joinImage;

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
        this.joinImage});

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
    return data;
  }
}