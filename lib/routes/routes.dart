import 'package:flutter/material.dart';
import 'package:go_chit_chat/models/user_model.dart';
import 'package:go_chit_chat/routes/routes_name.dart';
import 'package:go_chit_chat/views/home.dart';
import 'package:go_chit_chat/views/login_screen.dart';
import 'package:go_chit_chat/views/register_screen.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesNames.home:{
        print("Args=> "+settings.arguments.toString());
        UserModel userModel=settings.arguments as UserModel;
        return MaterialPageRoute(builder: (BuildContext context)=> Home(userModel: userModel,));
      }
      case RoutesNames.signup:
        return MaterialPageRoute(builder: (BuildContext context)=> SignUp());
      case RoutesNames.login:
        return MaterialPageRoute(builder: (BuildContext context)=> LoginScreen());
      default:
        return MaterialPageRoute(builder: (BuildContext context){
          return Scaffold(
            body: Center(
              child: Text(
                'No screen found',
              ),
            ),
          );
        });
    }
  }
}