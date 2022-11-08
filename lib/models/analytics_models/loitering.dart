class LoiteringModel {
  num? total;
  num? avgH;
  num? avgS;
  List<Raw>? raw;
  List<num>? dwell;
  List<String>? labelsD;
  Histogram? histogram;
  num? min;
  num? max;
  num? avg;

  LoiteringModel({this.total, this.avgH, this.avgS, this.raw, this.dwell, this.labelsD, this.histogram, this.min, this.max, this.avg});

  LoiteringModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    avgH = json['avgH'];
    avgS = json['avgS'];
    if (json['raw'] != null) {
      raw = <Raw>[];
      json['raw'].forEach((v) {
        raw!.add(Raw.fromJson(v));
      });
    }
    dwell = json['dwell'].cast<num>();
    labelsD = json['labelsD'].cast<String>();
    histogram = json['histogram'] != null ? Histogram.fromJson(json['histogram']) : null;
    min = json['min'];
    max = json['max'];
    avg = json['avg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['avgH'] = avgH;
    data['avgS'] = avgS;
    if (raw != null) {
      data['raw'] = raw!.map((v) => v.toJson()).toList();
    }
    data['dwell'] = dwell;
    data['labelsD'] = labelsD;
    if (histogram != null) {
      data['histogram'] = histogram!.toJson();
    }
    data['min'] = min;
    data['max'] = max;
    data['avg'] = avg;
    return data;
  }
}

class Raw {
  String? time;
  num? dwell;
  num? trackId;
  String? cameraName;
  String? camId;
  String? idBranch;
  String? idAccount;
  String? id;
  String? picture;
  String? picPath;
  num? severity;

  Raw(
      {this.time,
      this.dwell,
      this.trackId,
      this.cameraName,
      this.camId,
      this.idBranch,
      this.idAccount,
      this.id,
      this.picture,
      this.picPath,
      this.severity});

  Raw.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    dwell = json['dwell'];
    trackId = json['track_id'];
    cameraName = json['camera_name'];
    camId = json['cam_id'];
    idBranch = json['id_branch'];
    idAccount = json['id_account'];
    id = json['id'];
    picture = json['picture'];
    picPath = json['pic_path'];
    severity = json['severity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['dwell'] = dwell;
    data['track_id'] = trackId;
    data['camera_name'] = cameraName;
    data['cam_id'] = camId;
    data['id_branch'] = idBranch;
    data['id_account'] = idAccount;
    data['id'] = id;
    data['picture'] = picture;
    data['pic_path'] = picPath;
    data['severity'] = severity;
    return data;
  }
}

class Histogram {
  num? i4;
  num? i18;
  num? i19;
  num? i20;

  Histogram({this.i4, this.i18, this.i19, this.i20});

  Histogram.fromJson(Map<String, dynamic> json) {
    i4 = json['4'];
    i18 = json['18'];
    i19 = json['19'];
    i20 = json['20'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['4'] = i4;
    data['18'] = i18;
    data['19'] = i19;
    data['20'] = i20;
    return data;
  }
}
