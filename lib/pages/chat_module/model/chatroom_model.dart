class ChatRoomModel {
  String? chatroomid;
  Map<String, dynamic>? participants;
  String? lastMessage;
  String? updatedTime;

  ChatRoomModel({
    this.chatroomid,
    this.participants,
    this.lastMessage,
    this.updatedTime,
  });

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatroomid = map["chatroomid"];
    participants = map["participants"];
    lastMessage = map["lastMessage"];
    updatedTime = map["updated_time"];
  }
  Map<String, dynamic> toMap() {
    return {
      "chatroomid": chatroomid,
      "participants": participants,
      "lastMessage": lastMessage,
      "updated_time": updatedTime,
    };
  }
}
