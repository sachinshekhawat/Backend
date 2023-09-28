import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:go_chit_chat/database_service.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/user_model.dart';
class ChatScreen extends StatefulWidget {

  late UserModel myModel,friendModel;
  ChatScreen({required this.myModel,required this.friendModel});

  @override
  State<ChatScreen> createState() => _ChatScreenState(myModel,friendModel);
}

class _ChatScreenState extends State<ChatScreen> {
  late UserModel myModel,friendModel;
  late String senderId;
  late String receiverId;
  late String usersTokenID;
  _ChatScreenState(UserModel myModel,UserModel friendModel){
    this.myModel=myModel;
    this.friendModel=friendModel;
    senderId=myModel.authId;
    receiverId=friendModel.authId;
    usersTokenID=senderId.compareTo(receiverId)>0?receiverId+senderId:senderId+receiverId;
  }
  double kDefaultPadding=20.0;
  TextEditingController messageController=TextEditingController();
  ScrollController scrollController=ScrollController();
  final dataRef=FirebaseDatabase.instance.ref("Chats");

  final AppId="9f753e67afc6437ab47b1096367719f4";
  final Token="257234967e734627be50955a6cb74a0b";
  TextEditingController _channelController=TextEditingController();
  bool _validateError=false;
  ClientRoleType _role=ClientRoleType.clientRoleBroadcaster;
  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
  Future<void> onJoin() async {
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // await Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => VideoCall(
      //       channelName: _channelController.text,
      //       role: _role,
      //     ),
      //   ),
      // );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _channelController.text="demo";
  }

  void callFunction() async{
    await FlutterPhoneDirectCaller.callNumber(friendModel.phoneNum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text(friendModel.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.video_call,color: Colors.white,)),
            IconButton(onPressed: (){callFunction();}, icon: Icon(Icons.call,color: Colors.white,)),
          ],
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height-200,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [

                  Container(
                      height: MediaQuery.of(context).size.height-200,
                      width: MediaQuery.of(context).size.width,
                    // decoration:const BoxDecoration(
                    //     image: DecorationImage(
                    //         image: NetworkImage(
                    //             'https://cdn.pixabay.com/photo/2021/08/05/06/52/internet-6523289_640.jpg'),
                    //         fit: BoxFit.cover,
                    //         opacity: 0.3)),
                    child: FirebaseAnimatedList(
                      controller: scrollController,
                      shrinkWrap: true,
                      query: dataRef.child(usersTokenID),
                      itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double> animation,int index){
                        Map? data=snapshot.value as Map?;
                        bool isUserMessage=data!['SendBy']==myModel.authId;
                        Timer(Duration(milliseconds: 500), () {
                          scrollController.jumpTo(scrollController.position.maxScrollExtent);
                        });
                        return isUserMessage?
                            ChatBubble(
                              clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(top: 20),
                              backGroundColor: Colors.blue,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                                ),
                                child: Text(
                                data['Message']!=null?data['Message']:"Waiting for the message...",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                                :
                            ChatBubble(
                              clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                              backGroundColor: Color(0xffE7E7ED),
                              margin: EdgeInsets.only(top: 20),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                                ),
                                child: Text(
                                  data['Message'] ?? "Waiting for the message...",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }),
                        ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        height: 69,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/2, vertical: kDefaultPadding / 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: [BoxShadow(blurRadius: 30, offset: Offset(0, 4), color: Color(0xff087949).withOpacity(0.7))]),
                        child: SafeArea(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.75),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: messageController,
                                            keyboardType: TextInputType.multiline,
                                            maxLines: null,
                                            decoration: InputDecoration(border: InputBorder.none, hintText: 'Type Message'),
                                          ),
                                        ),
                                        SizedBox(width: kDefaultPadding / 4),
                                        FloatingActionButton(
                                          backgroundColor: Colors.lightGreen,
                                          onPressed: () async{

                                              if(messageController.text.isNotEmpty){
                                                DatabaseService().addChatToDatabase(usersTokenID, messageController.text, senderId, receiverId);
                                                messageController.clear();
                                                Timer(Duration(milliseconds: 500), () {
                                                  scrollController.jumpTo(scrollController.position.maxScrollExtent);
                                                });
                                              }
                                          },
                                          child: Icon(Icons.send,color: Colors.white,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
