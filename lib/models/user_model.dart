class UserModel{
  late String email;
  late String name;
  late String password;
  late String authId;
  late String profilePicUrl;
  late String phoneNum;
  UserModel({required this.name,required this.phoneNum,required this.email,required this.password,required this.profilePicUrl});
  Map<String,dynamic> toJson(UserModel userModel){
    return {
      'email':userModel.email,
      'name':userModel.name,
      'phone':userModel.phoneNum,
      'password':userModel.password,
      'picURL':userModel.profilePicUrl
    };
  }
  static UserModel fromJson(Map<String,dynamic> json){
    return UserModel(name: json['name'],phoneNum: json['phone'], email: json['email'], password: json['password'], profilePicUrl: json['picURL']);
  }
}