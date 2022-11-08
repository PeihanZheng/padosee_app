class FRModel {
  num? total;
  List<Raw>? raw;

  FRModel({this.total, this.raw});

  FRModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['raw'] != null) {
      raw = <Raw>[];
      json['raw'].forEach((v) {
        raw!.add(Raw.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    if (raw != null) {
      data['raw'] = raw!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Raw {
  String? id;
  String? time;
  String? name;
  String? gender;
  String? age;
  String? camId;
  String? camName;
  String? idAccount;
  String? idBranch;
  String? picture;
  String? picPath;

  Raw({this.id, this.time, this.name, this.gender, this.age, this.camId, this.camName, this.idAccount, this.idBranch, this.picture, this.picPath});

  Raw.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    name = json['name'];
    gender = json['gender'];
    age = json['age'];
    camId = json['cam_id'];
    camName = json['cam_name'];
    idAccount = json['id_account'];
    idBranch = json['id_branch'];
    picture = json['picture'];
    picPath = json['pic_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['time'] = time;
    data['name'] = name;
    data['gender'] = gender;
    data['age'] = age;
    data['cam_id'] = camId;
    data['cam_name'] = camName;
    data['id_account'] = idAccount;
    data['id_branch'] = idBranch;
    data['picture'] = picture;
    data['pic_path'] = picPath;
    return data;
  }
}

class FRRelModel {
  num? id;
  String? cameraId;
  num? algoId;
  String? roiId;
  List<Atributes>? atributes;
  String? idAccount;
  String? idBranch;
  String? stream;
  String? httpOut;
  String? createdAt;
  String? updatedAt;

  FRRelModel(
      {this.id,
      this.cameraId,
      this.algoId,
      this.roiId,
      this.atributes,
      this.idAccount,
      this.idBranch,
      this.stream,
      this.httpOut,
      this.createdAt,
      this.updatedAt});

  FRRelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cameraId = json['camera_id'];
    algoId = json['algo_id'];
    roiId = json['roi_id'];
    if (json['atributes'] != null) {
      atributes = <Atributes>[];
      json['atributes'].forEach((v) {
        atributes!.add(Atributes.fromJson(v));
      });
    }
    idAccount = json['id_account'];
    idBranch = json['id_branch'];
    stream = json['stream'];
    httpOut = json['http_out'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['camera_id'] = cameraId;
    data['algo_id'] = algoId;
    data['roi_id'] = roiId;
    if (atributes != null) {
      data['atributes'] = atributes!.map((v) => v.toJson()).toList();
    }
    data['id_account'] = idAccount;
    data['id_branch'] = idBranch;
    data['stream'] = stream;
    data['http_out'] = httpOut;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Atributes {
  num? conf;
  bool? save;
  num? time;

  Atributes({this.conf, this.save, this.time});

  Atributes.fromJson(Map<String, dynamic> json) {
    conf = json['conf'];
    save = json['save'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conf'] = conf;
    data['save'] = save;
    data['time'] = time;
    return data;
  }
}
