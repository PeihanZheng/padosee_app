class MemberModel {
  String? id;
  String? imageUrl;
  String? username;
  String? emailAddress;
  String? phone;
  String? gender;
  String? houseAprtmentNo;
  String? address;

  MemberModel({this.id, this.imageUrl, this.username, this.emailAddress, this.phone, this.gender, this.houseAprtmentNo, this.address});

  MemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    username = json['username'];
    emailAddress = json['email_address'];
    phone = json['phone'];
    gender = json['gender'];
    houseAprtmentNo = json['house_aprtment_no'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_url'] = imageUrl;
    data['username'] = username;
    data['email_address'] = emailAddress;
    data['phone'] = phone;
    data['gender'] = gender;
    data['house_aprtment_no'] = houseAprtmentNo;
    data['address'] = address;
    return data;
  }
}
