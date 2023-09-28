import 'package:flutter/material.dart';
import 'package:go_chit_chat/models/user_model.dart';
class MyProfile extends StatefulWidget {
  late UserModel myModel;
  MyProfile({required this.myModel});

  @override
  State<MyProfile> createState() => _MyProfileState(myModel:myModel);
}

class _MyProfileState extends State<MyProfile> {
  late  UserModel myModel;
  _MyProfileState({required this.myModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text('Profile',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(20),
                  child: CircleAvatar(
                    radius: 70.0,
                    child: Image(image: NetworkImage(myModel.profilePicUrl),),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 30,
                    width: 30,
                    child: FloatingActionButton(onPressed: (){

                    },
                      backgroundColor: Colors.lightBlueAccent,
                      child: Icon(Icons.edit,color: Colors.white,),
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(20),
            child: Text(myModel.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
            ),
            Padding(padding: EdgeInsets.all(20),
              child: Text(myModel.email,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
            ),
          ],
        ),
      ),
    );
  }
}
