class UserModel {
  String userId;
  String username;
  String email;
  String password;
  String address;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.address,

});

  Map<String, dynamic> toMap(){
    return {
      "userId": userId,
      "username": username,
      "email": email,
      "password": password,
      "address": address,


    };
  }

  factory UserModel.fromMap(Map<String, dynamic>map){
    return UserModel(
        userId: map["userId"],
        username: map["username"],
        email: map["email"],
        password: map["password"],
        address:map["address"],
    );
  }
}