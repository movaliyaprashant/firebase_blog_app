import 'package:comapny_task/src/login/view/log_in_screen.dart';
import 'package:comapny_task/src/profile/provider/profile_provider.dart';
import 'package:comapny_task/utilities/variable_utilities/variable_utilities.dart';
import 'package:comapny_task/utilities/widget/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProfileProvider>(context, listen: false).getUserDetails();
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: Consumer<ProfileProvider>(
          builder: (context, ProfileProvider _profileProvider, child) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text("User Name"),
                const SizedBox(
                  height: 15,
                ),
            _profileProvider.userName?.isEmpty==true||
                _profileProvider.userName==""||
                _profileProvider.userName?.length==0? Text(
                 "Not Added",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: VariableUtilities.size.width * 0.045,
                      color: Colors.black),
                ):Text(
            _profileProvider.userName!,
            style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: VariableUtilities.size.width * 0.045,
            color: Colors.black),
            ),
                const SizedBox(
                  height: 40,
                ),
                const Text("User Email"),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  _profileProvider.userEmail??"Not Added",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: VariableUtilities.size.width * 0.045,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text("LogIn type"),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  _profileProvider.loginType??"Not Added",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: VariableUtilities.size.width * 0.045,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      _profileProvider.logOut().then((value) {
                        if (value == true) {
                          final snack =
                              customSnackBar(title: "Sign Out SuccessFully");
                          ScaffoldMessenger.of(context).showSnackBar(snack);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LogInScreen(),
                              ),
                              (route) => false);
                        } else {
                          final snack = customSnackBar(
                              title: "Sign Out Failed. Try Again");
                          ScaffoldMessenger.of(context).showSnackBar(snack);
                        }
                      });
                    },
                    child: const Text("Sign Out"))
              ],
            );
          },
        ),
      ),
    );
  }
}
