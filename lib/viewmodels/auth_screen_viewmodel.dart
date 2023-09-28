import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_chit_chat/database_service.dart';
import 'package:go_chit_chat/models/user_model.dart';
import 'package:go_chit_chat/routes/routes_name.dart';
import 'package:http/http.dart' as http;

class AuthScreenViewModel extends ChangeNotifier{
  bool _loading=false;
  bool get loading => _loading;
  bool _isEmailCorrect=false;
  bool get isEmailCorrect=>_isEmailCorrect;
  setLoading(bool value){
    _loading=value;
    notifyListeners();
  }
  setEmailCorrect(bool value){
    _isEmailCorrect=value;
    notifyListeners();
  }
  void isValidEmail(String email){
     setEmailCorrect(EmailValidator.validate(email));
  }
  void RegisterUser(String name,String email,String password,String phoneNum,BuildContext context) async{
    setLoading(true);
    UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).onError((error, stackTrace) => setLoading(false));
    if(userCredential.user!=null){
      String userAuthId=userCredential.user!.uid;
      UserModel userModel=UserModel(name: name,phoneNum: phoneNum, email: email, password: password, profilePicUrl: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png");
      await DatabaseService().addUserData(userModel);
      setLoading(false);
      print("Register User => ${userModel}");
      Navigator.pushNamed(context, RoutesNames.home,arguments: userModel);
    }
  }
  void LoginUser(String email,String password,BuildContext context) async {
    setLoading(true);
    UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).onError((error, stackTrace) => setLoading(false));
    String userAuthId=userCredential.user!.uid;
    UserModel? userModel=await DatabaseService().getUserData(userAuthId);
    setLoading(false);
    print("Login User => ${userModel.toString()}");
    if(userModel!=null)
    Navigator.pushNamed(context, RoutesNames.home,arguments: userModel);
  }
  void MongooseRegisterUser(String name,String email,String password,String phoneNum,BuildContext context) async {
    setLoading(true);
    String url="https://iby-backend.onrender.com/api/auth/createUser";
    final response;
    final dataBody={
      "name":name,
      "email":email,
      "password":password,
      "phone":phoneNum
    };
    try{
      response=await http.post(Uri.parse(url),body: dataBody);
      print(response);
      Map data=jsonDecode(response.body);
      print(data);
      if(data['sucess'].toString()=="true"){
        UserModel? userModel=UserModel.fromJson(data['user'] as Map<String,dynamic>);
        setLoading(false);
        Navigator.pushNamed(context, RoutesNames.home,arguments: userModel);
      }else{
        setLoading(false);
      }
    }catch(e){
      setLoading(false);
      throw e;
    }
  }
  void MongooseLoginUser(String email,String password,BuildContext context) async {
    setLoading(true);
    String url="https://iby-backend.onrender.com/api/auth/login";
    final response;
    final dataBody={
      "email":email,
      "password":password,
    };
    try{
      response=await http.post(Uri.parse(url),body: dataBody);
      print(response);
      final data=jsonDecode(response.body);
      if(data['sucess'].toString()=="true"){
        UserModel? userModel=UserModel.fromJson(data['user']);
        setLoading(false);
        Navigator.pushNamed(context, RoutesNames.home,arguments: userModel);
      }else{
        setLoading(false);
      }
    }catch(e){
      setLoading(false);
      throw e;
    }
  }
}