class UserModel {
  String firstName;
  String secondName;
  String mobile;

  UserModel(this.firstName, this.secondName, this.mobile);

   Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "secondName": secondName,
      "mobile": mobile,
    };
  }

   factory UserModel.fromJson(Map<String, dynamic> json) {
   return UserModel(
    json['firstName'],
    json['secondName'],
    json['mobile'],
    
    );

  }
}
