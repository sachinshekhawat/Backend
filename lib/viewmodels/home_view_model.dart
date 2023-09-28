
import 'package:flutter/material.dart';
import 'package:go_chit_chat/database_service.dart';
import 'package:go_chit_chat/models/user_model.dart';

class HomeViewModel extends ChangeNotifier{
  UserModel _loggedInUserModel=UserModel( name: "",phoneNum: "", email: "", password: "", profilePicUrl: "");
  UserModel get loggedInUserModel=>_loggedInUserModel;
  List<UserModel> _users=[];
  List<UserModel> get users=>_users;
  bool _loading=false;
  bool get loading=>_loading;
  setLoading(bool value){
    _loading=value;
    notifyListeners();
  }
  setLoggedInUser(UserModel userModel){
    _loggedInUserModel=userModel;
    notifyListeners();
  }
  loadUsers() async{
    setLoading(true);
    _users=await DatabaseService().loadAllUsers();
    _users.remove(loggedInUserModel);
    setLoading(false);
    print("Home View Model => "+_users.toString());
    notifyListeners();
  }
}