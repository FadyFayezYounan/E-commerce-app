class UserModal{
  String? userId;
  String? userName;
  String? userEmail;
  String? userPhone;

  UserModal({
    this.userId,
    this.userName,
    this.userEmail,
    this.userPhone,
});

  UserModal.fromJson(json) {
    userId = json['userId'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userPhone = json['userPhone'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userPhone': userPhone,
    };
  }

}