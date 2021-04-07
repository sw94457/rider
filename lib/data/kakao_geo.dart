class KakaoGeo {
  Meta meta;
  List<Documents> documents;

  KakaoGeo({this.meta, this.documents});

  KakaoGeo.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['documents'] != null) {
      documents = new List<Documents>();
      json['documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.documents != null) {
      data['documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  bool isEnd;
  int pageableCount;
  int totalCount;

  Meta({this.isEnd, this.pageableCount, this.totalCount});

  Meta.fromJson(Map<String, dynamic> json) {
    isEnd = json['is_end'];
    pageableCount = json['pageable_count'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_end'] = this.isEnd;
    data['pageable_count'] = this.pageableCount;
    data['total_count'] = this.totalCount;
    return data;
  }
}

class Documents {
  String regionType;
  String code;
  String addressName;
  String region1depthName;
  String region2depthName;
  String region3depthName;
  String region4depthName;
  double x;
  double y;

  Documents(
      {this.regionType,
        this.code,
        this.addressName,
        this.region1depthName,
        this.region2depthName,
        this.region3depthName,
        this.region4depthName,
        this.x,
        this.y});

  Documents.fromJson(Map<String, dynamic> json) {
    regionType = json['region_type'];
    code = json['code'];
    addressName = json['address_name'];
    region1depthName = json['region_1depth_name'];
    region2depthName = json['region_2depth_name'];
    region3depthName = json['region_3depth_name'];
    region4depthName = json['region_4depth_name'];
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region_type'] = this.regionType;
    data['code'] = this.code;
    data['address_name'] = this.addressName;
    data['region_1depth_name'] = this.region1depthName;
    data['region_2depth_name'] = this.region2depthName;
    data['region_3depth_name'] = this.region3depthName;
    data['region_4depth_name'] = this.region4depthName;
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}


