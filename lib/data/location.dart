class Location {
  String serial;
  String name;

  Location({this.serial, this.name});

  Location.fromJson(Map<String, dynamic> json) {
    serial = json['serial'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serial'] = this.serial;
    data['name'] = this.name;
    return data;
  }
}