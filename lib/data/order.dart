class Order2 {
  String flag;
  String serial;
  String orderSerial;
  String companyAddress;
  String companyTel;
  String userAddress;
  String companyName;
  String userPhone;
  String registeredDate;
  String paid;
  String riderDeliveryPrice;
  String totalDeliveryPrice;
  String finalPrice;
  String companyLatitude;
  String companyLongitude;
  String userLatitude;
  String userLongitude;
  String riderMemo;

  Order2(
      {this.flag,
        this.serial,
        this.orderSerial,
        this.companyAddress,
        this.companyTel,
        this.userAddress,
        this.companyName,
        this.userPhone,
        this.registeredDate,
        this.paid,
        this.riderDeliveryPrice,
        this.totalDeliveryPrice,
        this.finalPrice,
        this.companyLatitude,
        this.companyLongitude,
        this.userLatitude,
        this.userLongitude,
        this.riderMemo});

  Order2.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    serial = json['serial'];
    orderSerial = json['order_serial'];
    companyAddress = json['company_address'];
    companyTel = json['company_tel'];
    userAddress = json['user_address'];
    companyName = json['company_name'];
    userPhone = json['user_phone'];
    registeredDate = json['registered_date'];
    paid = json['paid'];
    riderDeliveryPrice = json['rider_delivery_price'];
    try{
      finalPrice = json['final_price'];
      totalDeliveryPrice = json['total_delivery_price'];
      companyLatitude = json['company_latitude'];
      companyLongitude = json['company_longitude'];
      companyLongitude = json['company_longitude'];
      userLatitude = json['user_latitude'];
      userLongitude = json['user_longitude'];
    }catch(e){
      finalPrice = json['final_price'].toString();
      totalDeliveryPrice = json['total_delivery_price'].toString();
      companyLatitude = json['company_latitude'].toString();
      companyLongitude = json['company_longitude'].toString();
      companyLongitude = json['company_longitude'].toString();
      userLatitude = json['user_latitude'].toString();
      userLongitude = json['user_longitude'].toString();
    }



    riderMemo = json['rider_memo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['serial'] = this.serial;
    data['order_serial'] = this.orderSerial;
    data['company_address'] = this.companyAddress;
    data['company_tel'] = this.companyTel;
    data['user_address'] = this.userAddress;
    data['company_name'] = this.companyName;
    data['user_phone'] = this.userPhone;
    data['registered_date'] = this.registeredDate;
    data['paid'] = this.paid;
    data['rider_delivery_price'] = this.riderDeliveryPrice;
    data['final_price'] = this.finalPrice;
    data['company_latitude'] = this.companyLatitude;
    data['company_longitude'] = this.companyLongitude;
    data['user_latitude'] = this.userLatitude;
    data['user_longitude'] = this.userLongitude;
    data['rider_memo'] = this.riderMemo;
    return data;
  }
}