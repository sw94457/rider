class Order {
  String serial;
  String orderSerial;
  String companyAddress;
  String userAddress;
  String companyName;
  String userPhone;
  String registeredDate;
  String payType;
  String riderDeliveryPrice;
  String finalPrice;
  String companyLatitude;
  String companyLongitude;
  String userLatitude;
  String userLongitude;
  String riderMemo;
  String receiptNumber;


  Order(
      {this.serial,
        this.orderSerial,
        this.companyAddress,
        this.userAddress,
        this.companyName,
        this.userPhone,
        this.registeredDate,
        this.payType,
        this.riderDeliveryPrice,
        this.finalPrice,
        this.companyLatitude,
        this.companyLongitude,
        this.userLatitude,
        this.userLongitude,
        this.riderMemo,
        this.receiptNumber});

  Order.fromJson(Map<String, dynamic> json) {
    serial = json['serial'];
    orderSerial = json['order_serial'];
    companyAddress = json['company_address'];
    userAddress = json['user_address'];
    companyName = json['company_name'];
    userPhone = json['user_phone'];
    registeredDate = json['registered_date'];
    payType = json['pay_type'];
    riderDeliveryPrice = json['rider_delivery_price'];
    finalPrice = json['final_price'];
    companyLatitude = json['company_latitude'];
    companyLongitude = json['company_longitude'];
    userLatitude = json['user_latitude'];
    userLongitude = json['user_longitude'];
    riderMemo = json['rider_memo'];
    receiptNumber = json['receipt_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serial'] = this.serial;
    data['order_serial'] = this.orderSerial;
    data['company_address'] = this.companyAddress;
    data['user_address'] = this.userAddress;
    data['company_name'] = this.companyName;
    data['user_phone'] = this.userPhone;
    data['registered_date'] = this.registeredDate;
    data['pay_type'] = this.payType;
    data['rider_delivery_price'] = this.riderDeliveryPrice;
    data['final_price'] = this.finalPrice;
    data['company_latitude'] = this.companyLatitude;
    data['company_longitude'] = this.companyLongitude;
    data['user_latitude'] = this.userLatitude;
    data['user_longitude'] = this.userLongitude;
    data['rider_memo'] = this.riderMemo;
    data['receipt_number'] = this.receiptNumber;
    return data;
  }
}