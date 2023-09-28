import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:go_chit_chat/models/ai_chat_model.dart';
import 'package:http/http.dart' as http;
class AiChatScreen extends StatefulWidget {
  const AiChatScreen({Key? key}) : super(key: key);

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {

  Future<String> AIResponse(String userMessage) async{
    String ai_response;
    String baseUrl="https://ai-chatbot.p.rapidapi.com/chat/free?message=$userMessage&uid=user1";
    //String baseUrl="https://lemurbot.p.rapidapi.com/chat";
    Map<String,String> headers={
      'Content-Type':'application/json',
      'X-RapidAPI-Key': '9535f33833msha2b14b7271a3ac4p1c82c6jsnf509b6785b54',
      'X-RapidAPI-Host': 'ai-chatbot.p.rapidapi.com'
    };
    // final dataBody={
    //   "bot": "dilly",
    //   "client": "d531e3bd-b6c3-4f3f-bb58-a6632cbed5e2",
    //   "message":userMessage
    // };
    // final response=await http.post(Uri.parse(baseUrl),headers: headers,body: jsonEncode(dataBody));
    final response=await http.get(Uri.parse(baseUrl),headers: headers);
    final data=response.body;
    if(response.statusCode==200){
      final result=jsonDecode(data);
      //ai_response=result['data']['conversation']['output'];
      ai_response=result['chatbot']['response'];
      print("Bot Message => "+ai_response);
      return ai_response;
    }else if(response.statusCode==502){
      return "Sorry...cannot answer at the moment";
    }else{
      return "An unknown error has occurred";
    }

  }

  double kDefaultPadding=20.0;
  TextEditingController messageController=TextEditingController();
  List<AIChat> listMessages=[];
  ScrollController scrollController=ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text('Amanda.AI',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
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
                  child: ListView.builder(
                    controller: scrollController,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(0.0),
                      shrinkWrap: true,
                      itemCount: listMessages.length,itemBuilder: (context,int index){
                    bool isUserMessage=listMessages[index].userMessage!=null;
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
                          listMessages[index].userMessage!,
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
                          listMessages[index].botMessage!,
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
                                            String userMessage=messageController.text;
                                            messageController.clear();
                                            if(userMessage.isNotEmpty){
                                              setState(() {
                                                listMessages.add(AIChat(botMessage: null, userMessage: userMessage));
                                              });
                                              Timer(Duration(milliseconds: 500), () {
                                                scrollController.jumpTo(scrollController.position.maxScrollExtent);
                                              });
                                              String botMessage=await AIResponse(userMessage);
                                              setState(() {
                                                listMessages.add(AIChat(botMessage: botMessage, userMessage: null));
                                              });
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
