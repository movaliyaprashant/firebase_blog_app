import 'package:comapny_task/src/home/view/home_screen.dart';
import 'package:comapny_task/src/login/provider/login_provider.dart';
import 'package:comapny_task/utilities/variable_utilities/variable_utilities.dart';
import 'package:comapny_task/utilities/widget/custom_snack_bar.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Consumer<LogInProvider>(
          builder: (context, _logInProvider, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  TextField(
                    controller: _logInProvider.emailController,
                    decoration: const InputDecoration(
                        hintText: "Email", border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                      controller: _logInProvider.passwordController,
                      decoration: const InputDecoration(
                          hintText: "Password", border: OutlineInputBorder())),
                  const SizedBox(height: 50),
                  ElevatedButton(
                      onPressed: () {
                        _logInProvider.logInWithEmail().then((value) {
                          final snack = customSnackBar(
                              title: value ?? "Server Error", isError: false);
                          ScaffoldMessenger.of(context).showSnackBar(snack);
                          if (value == "LogIn Successfully") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ));
                          }
                        });
                      },
                      child: const Text("Login")),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      _logInProvider.signInWithGoogle().then((value) {
                        final snack = customSnackBar(
                            title: value ?? "Server Error", isError: false);
                        ScaffoldMessenger.of(context).showSnackBar(snack);
                        if (value == "LogIn Successfully") {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ));
                        }
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "asset/images/google_logo.png",
                          height: VariableUtilities.size.width * 0.1,
                          width: VariableUtilities.size.width * 0.1,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 5,),
                        Text("Gmail Login",style: TextStyle(color: Colors.black,fontSize:17 ),)
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
