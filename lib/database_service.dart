import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:go_chit_chat/models/user_model.dart';
import 'package:http/http.dart' as http;

class DatabaseService{
  FirebaseDatabase database=FirebaseDatabase.instance;
  Future<void> addUserData(UserModel userModel) async{
      await FirebaseFirestore.instance.collection("Users").doc(userModel.authId).set({
        'name':userModel.name,
        'authId':userModel.authId,
        'email':userModel.email,
        'password':userModel.password,
        'profilePicUrl':userModel.profilePicUrl
      });
  }
  Future<UserModel?> getUserData(String uid) async{
    UserModel? userModel=null;
    await FirebaseFirestore.instance.collection("Users").doc(uid).get().then((value) {
      late String name,authId,email,password,profilePicUrl,phoneNum;
      value.data()!.forEach((key, value) {
        if(key=='name'){
          name=value;
        }
        else if(key=='authId'){
          authId=value;
        }
        else if(key=='email'){
          email=value;
        }
        else if(key=='password'){
          password=value;
        }
        else if(key=='profilePicUrl'){
          profilePicUrl=value;
        }
        else if(key=='phoneNum'){
          phoneNum=value;
        }
      });
      userModel=UserModel(name: name,phoneNum: phoneNum, email: email, password: password, profilePicUrl: profilePicUrl);
    });
    return userModel;
  }
  Future<List<UserModel>> loadAllUsers() async{
    final querySnapshot=await FirebaseFirestore.instance.collection("Users").get();
    final documents=querySnapshot.docs;
    List<UserModel> list=[];
    documents.forEach((element) {
      final jsonData=element.data();
      print(jsonData);
      list.add(UserModel.fromJson(jsonData));
    });
    return list;
  }
  void addChatToDatabase(String usersTokenId,String chatMessage,String senderId,String receiverId){
    final dataRef=database.ref("Chats");
    final epox=DateTime.now().millisecondsSinceEpoch.toString();
    dataRef.child(usersTokenId).child(epox).child('SendBy').set(senderId);
    dataRef.child(usersTokenId).child(epox).child('ReceivedBy').set(receiverId);
    dataRef.child(usersTokenId).child(epox).child('Message').set(chatMessage);
  }
  Future<List<UserModel>> MongooseLoadAllUsers() async{
    String url="https://iby-backend.onrender.com/api/auth/getUsers";
    final response;
    try{
      response=await http.get(Uri.parse(url));
      print(response);
      Map data=jsonDecode(response.body);
      if(data['sucess'].toString()=="true"){
        List<UserModel> list=[];
        final jsonList=data['users'] as List;
        jsonList.forEach((element) {
          list.add(UserModel.fromJson(element));
        });
        return list;
      }else{
        return [];
      }
    }catch(e){
      return [];
    }
  }
}