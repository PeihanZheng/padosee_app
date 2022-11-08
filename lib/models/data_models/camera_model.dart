class CameraModel {
  String? userId;
  num? camId;
  String? camName;
  String? camLocation;
  String? rtspLink;

  CameraModel({
    this.userId,
    this.camId,
    this.camName,
    this.camLocation,
    this.rtspLink,
  });

  CameraModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    camId = json['cam_id'];
    camName = json['cam_name'];
    camLocation = json['cam_location'];
    rtspLink = json['rtsp_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['cam_id'] = camId;
    data['cam_name'] = camName;
    data['cam_location'] = camLocation;
    data['rtsp_link'] = rtspLink;
    return data;
  }
}
