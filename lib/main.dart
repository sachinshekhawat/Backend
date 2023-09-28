import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_chit_chat/firebase_options.dart';
import 'package:go_chit_chat/routes/routes.dart';
import 'package:go_chit_chat/routes/routes_name.dart';
import 'package:go_chit_chat/viewmodels/auth_screen_viewmodel.dart';
import 'package:go_chit_chat/viewmodels/home_view_model.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_){
          return AuthScreenViewModel();
        }),
        ChangeNotifierProvider(create: (_){
          return HomeViewModel();
        }),
      ],
      child: MaterialApp(
        title: 'GoChitChat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RoutesNames.login,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

