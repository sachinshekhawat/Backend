import 'package:flutter/material.dart';
import 'package:go_chit_chat/viewmodels/auth_screen_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController phoneNumController=TextEditingController();
  @override
  void dispose() {
    namecontroller.clear();
    emailcontroller.clear();
    passwordcontroller.clear();
    phoneNumController.clear();
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authViewModel=Provider.of<AuthScreenViewModel>(context);
    return authViewModel.loading?LinearProgressIndicator():Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
                fit: BoxFit.cover,
                opacity: 0.3)
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                      'https://assets6.lottiefiles.com/packages/lf20_k9wsvzgd.json',
                      animate: true,
                      height: 100,
                      width: 600),
                  Text(
                    'Register Now',
                    style: GoogleFonts.indieFlower(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Text(
                    'Please register to continue using our app',
                    style: GoogleFonts.indieFlower(
                      textStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w300,
                          // height: 1.5,
                          fontSize: 15),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: authViewModel.isEmailCorrect ? namecontroller.text.isNotEmpty?480:400 : 400,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 5, top: 20),
                          child: TextFormField(
                            controller: namecontroller,
                            onChanged: (val) {

                            },
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.purple,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Name",
                              hintText: 'Satwik',
                              labelStyle: TextStyle(color: Colors.purple),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 5, top: 20),
                          child: TextFormField(
                            controller: phoneNumController,
                            onChanged: (val) {

                            },
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.purple,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Phone Number",
                              hintText: '9002212***',
                              labelStyle: TextStyle(color: Colors.purple),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20, top: 20),
                          child: TextFormField(
                            controller: emailcontroller,
                            onChanged: (val) {
                              authViewModel.isValidEmail(val);
                              // setState(() {
                              //   isEmailCorrect = isEmail(val);
                              // });
                            },
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.purple,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Email",
                              hintText: 'your-email@domain.com',
                              labelStyle: TextStyle(color: Colors.purple),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20,bottom: 10),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: passwordcontroller,
                              obscuringCharacter: '*',
                              obscureText: true,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.purple,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Password",
                                hintText: '*********',
                                labelStyle: TextStyle(color: Colors.purple),
                              ),
                              validator: (value) {
                                if (value!.isEmpty && value.length < 8) {
                                  return 'Enter a valid password';
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        authViewModel.isEmailCorrect&&(!namecontroller.text.isEmpty)&&(!phoneNumController.text.isEmpty)
                            ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
                                backgroundColor: (authViewModel.isEmailCorrect == false)||namecontroller.text.isEmpty
                                    ? Colors.red
                                    : Colors.purple,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 120, vertical: 20),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {

                                //register function call
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                                //authViewModel.RegisterUser(namecontroller.text,emailcontroller.text, passwordcontroller.text,phoneNumController.text,context);
                                print(namecontroller.text+emailcontroller.text+ passwordcontroller.text+phoneNumController.text);
                                authViewModel.MongooseRegisterUser(namecontroller.text,emailcontroller.text, passwordcontroller.text,phoneNumController.text,context);
                              }
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold),
                            ))
                            : Container(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'LogIN',
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
