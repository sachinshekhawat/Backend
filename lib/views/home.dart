import 'package:flutter/material.dart';
import 'package:go_chit_chat/database_service.dart';
import 'package:go_chit_chat/models/user_model.dart';
import 'package:go_chit_chat/viewmodels/home_view_model.dart';
import 'package:go_chit_chat/views/ai_chat_screen.dart';
import 'package:go_chit_chat/views/chat_screen.dart';
import 'package:go_chit_chat/views/my_profile_screen.dart';
import 'package:provider/provider.dart';
class Home extends StatefulWidget {
  late UserModel userModel;
  Home({required this.userModel});

  @override
  State<Home> createState() => _HomeState(loggedInUserModel: userModel);
}

class _HomeState extends State<Home> {
  late UserModel loggedInUserModel;
  _HomeState({required this.loggedInUserModel});
  List<UserModel> users=[];
  void loadUsers() async{
    //final _users=await DatabaseService().loadAllUsers();
    final _users=await DatabaseService().MongooseLoadAllUsers();
    _users.removeWhere((element) => element.authId==loggedInUserModel.authId);
    setState(() {
      users=_users;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    //final homeViewModel=Provider.of<HomeViewModel>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> AiChatScreen()));
        },
          backgroundColor: Colors.blue,
          child: Icon(Icons.computer,color: Colors.black,),
        ),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text('Community',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> MyProfile(myModel: loggedInUserModel,)));
            }, icon: Icon(Icons.person,color: Colors.white,))
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // decoration:const BoxDecoration(
          //     image: DecorationImage(
          //         image: NetworkImage(
          //             'https://cdn.pixabay.com/photo/2021/08/05/06/52/internet-6523289_640.jpg'),
          //         fit: BoxFit.cover,
          //         opacity: 0.3)),
          child: ListView.builder(itemCount: users.length,itemBuilder: (context,int index){
            return Padding(
              padding: EdgeInsets.only(top: 10,bottom: 10),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                tileColor: Color.fromRGBO(64, 75, 96, .9),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> ChatScreen(myModel: loggedInUserModel,friendModel: users[index])));
                },
                title: Align(
                  alignment: Alignment.center,
                    child: Text(users[index].name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                ),
                leading: CircleAvatar(
                  radius: 25,
                  child: Image(image: NetworkImage(users[index].profilePicUrl),),
                ),
              ),
            );
          }),
        ),
    );
  }
}
