class UserModel {
  String? id;
  String? imageUrl;
  String? username;
  String? emailAddress;
  String? phone;
  String? gender;
  String? houseAprtmentNo;
  String? address;
  String? role;
  String? fcmToken;
  String? accessToken;
  List<int>? analytics;

  UserModel({
    this.id,
    this.imageUrl,
    this.username,
    this.emailAddress,
    this.phone,
    this.gender,
    this.houseAprtmentNo,
    this.address,
    this.role,
    this.fcmToken,
    this.accessToken = "",
    this.analytics,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    username = json['username'];
    emailAddress = json['email_address'];
    phone = json['phone'];
    gender = json['gender'];
    houseAprtmentNo = json['house_apartment_no'];
    address = json['address'];
    role = json['role'];
    fcmToken = json['fcm_token'];
    if (json['analytics'] != null) {
      analytics = <int>[];
      json['analytics'].forEach((v) {
        analytics!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_url'] = imageUrl;
    data['username'] = username;
    data['email_address'] = emailAddress;
    data['phone'] = phone;
    data['gender'] = gender;
    data['house_apartment_no'] = houseAprtmentNo;
    data['address'] = address;
    data['role'] = role;
    data['fcm_token'] = fcmToken;
    if (analytics != null) {
      data['analytics'] = analytics!.map((v) => v).toList();
    }

    return data;
  }
}

// class UserModel {
//   String? id;
//   String? username;
//   String? email;
//   String? role;
//   String? idAccount;
//   String? idBranch;
//   int? cameras;
//   int? analytics;
//   String? accessToken;

//   UserModel({this.id, this.username, this.email, this.role, this.idAccount, this.idBranch, this.cameras, this.analytics, this.accessToken});

//   UserModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     username = json['username'];
//     email = json['email'];
//     role = json['role'];
//     idAccount = json['id_account'];
//     idBranch = json['id_branch'];
//     cameras = json['cameras'];
//     analytics = json['analytics'];
//     accessToken = json['accessToken'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = id;
//     data['username'] = username;
//     data['email'] = email;
//     data['role'] = role;
//     data['id_account'] = idAccount;
//     data['id_branch'] = idBranch;
//     data['cameras'] = cameras;
//     data['analytics'] = analytics;
//     data['accessToken'] = accessToken;
//     return data;
//   }
// }
