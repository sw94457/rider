class Calculate {
  String serial;
  String flag;
  String riderSerial;
  String startDate;
  String endDate;
  String totalDeliveryPrice;
  String systemPrice;
  String managerPrice;
  String systemFee;
  String managerFee;

  Calculate(
      {this.serial,
        this.flag,
        this.riderSerial,
        this.startDate,
        this.endDate,
        this.totalDeliveryPrice,
        this.systemPrice,
        this.managerPrice,
        this.systemFee,
        this.managerFee});

  Calculate.fromJson(Map<String, dynamic> json) {
    serial = json['serial'];
    flag = json['flag'];
    riderSerial = json['rider_serial'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    totalDeliveryPrice = json['total_delivery_price'];
    systemPrice = json['system_price'];
    managerPrice = json['manager_price'];
    systemFee = json['system_fee'];
    managerFee = json['manager_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serial'] = this.serial;
    data['flag'] = this.flag;
    data['rider_serial'] = this.riderSerial;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['total_delivery_price'] = this.totalDeliveryPrice;
    data['system_price'] = this.systemPrice;
    data['manager_price'] = this.managerPrice;
    data['system_fee'] = this.systemFee;
    data['manager_fee'] = this.managerFee;
    return data;
  }
}