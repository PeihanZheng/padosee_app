class IntrusionModel {
  int? total;
  double? avgH;
  List<Raw>? raw;
  List<Donut>? donut;
  Over? over;

  IntrusionModel({this.total, this.avgH, this.raw, this.donut, this.over});

  IntrusionModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    avgH = json['avgH'];
    if (json['raw'] != null) {
      raw = <Raw>[];
      json['raw'].forEach((v) {
        raw!.add(Raw.fromJson(v));
      });
    }
    if (json['donut'] != null) {
      donut = <Donut>[];
      json['donut'].forEach((v) {
        donut!.add(Donut.fromJson(v));
      });
    }
    over = json['over'] != null ? Over.fromJson(json['over']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['avgH'] = avgH;
    if (raw != null) {
      data['raw'] = raw!.map((v) => v.toJson()).toList();
    }
    if (donut != null) {
      data['donut'] = donut!.map((v) => v.toJson()).toList();
    }
    if (over != null) {
      data['over'] = over!.toJson();
    }
    return data;
  }
}

class Raw {
  String? time;
  String? cameraName;
  int? zone;
  int? trackId;
  String? camId;
  String? idBranch;
  String? idAccount;
  String? id;
  String? picture;
  String? picPath;

  Raw({this.time, this.cameraName, this.zone, this.trackId, this.camId, this.idBranch, this.idAccount, this.id, this.picture, this.picPath});

  Raw.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    cameraName = json['camera_name'];
    zone = json['zone'];
    trackId = json['track_id'];
    camId = json['cam_id'];
    idBranch = json['id_branch'];
    idAccount = json['id_account'];
    id = json['id'];
    picture = json['picture'];
    picPath = json['pic_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['camera_name'] = cameraName;
    data['zone'] = zone;
    data['track_id'] = trackId;
    data['cam_id'] = camId;
    data['id_branch'] = idBranch;
    data['id_account'] = idAccount;
    data['id'] = id;
    data['picture'] = picture;
    data['pic_path'] = picPath;
    return data;
  }
}

class Donut {
  String? name;
  int? value;
  String? perc;

  Donut({this.name, this.value, this.perc});

  Donut.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    perc = json['perc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    data['perc'] = perc;
    return data;
  }
}

class Over {
  int? i2020101620;
  int? i2020101621;
  int? i2020101622;
  int? i2020101623;
  int? i202010170;
  int? i202010171;
  int? i202010172;
  int? i202010173;
  int? i202010174;

  Over(
      {this.i2020101620,
      this.i2020101621,
      this.i2020101622,
      this.i2020101623,
      this.i202010170,
      this.i202010171,
      this.i202010172,
      this.i202010173,
      this.i202010174});

  Over.fromJson(Map<String, dynamic> json) {
    i2020101620 = json['2020-10-16 20'];
    i2020101621 = json['2020-10-16 21'];
    i2020101622 = json['2020-10-16 22'];
    i2020101623 = json['2020-10-16 23'];
    i202010170 = json['2020-10-17 0'];
    i202010171 = json['2020-10-17 1'];
    i202010172 = json['2020-10-17 2'];
    i202010173 = json['2020-10-17 3'];
    i202010174 = json['2020-10-17 4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['2020-10-16 20'] = i2020101620;
    data['2020-10-16 21'] = i2020101621;
    data['2020-10-16 22'] = i2020101622;
    data['2020-10-16 23'] = i2020101623;
    data['2020-10-17 0'] = i202010170;
    data['2020-10-17 1'] = i202010171;
    data['2020-10-17 2'] = i202010172;
    data['2020-10-17 3'] = i202010173;
    data['2020-10-17 4'] = i202010174;
    return data;
  }
}
