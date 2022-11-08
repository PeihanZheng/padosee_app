class NotificationModel {
  String? type;
  String? senderId;
  String? receiverId;
  String? title;
  String? subtitle;
  String? profileImage;
  String? status;

  NotificationModel({this.type, this.senderId, this.receiverId, this.title, this.subtitle, this.profileImage, this.status});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    title = json['title'];
    subtitle = json['subtitle'];
    profileImage = json['profile_image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['profile_image'] = profileImage;
    data['status'] = status;
    return data;
  }
}
