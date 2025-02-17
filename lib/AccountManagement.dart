import 'package:flutter/material.dart';

import '../main.dart';
import 'package:flutter_cheveaux/app_icon.dart';
import 'package:flutter_cheveaux/big_tex_widget.dart';
import 'package:flutter_cheveaux/dimension.dart';

import 'account_widget.dart';

class AccountManagement extends StatelessWidget {
  const AccountManagement({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
       child: Container(
    
      padding: const EdgeInsets.only(top: 320.0),
      child: Column(children: [
       SizedBox(height: 10.0), 
        // list of informations
        Center(
            child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              color: Colors.brown, borderRadius: BorderRadius.circular(100)),
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 100,
          ),
        )),

       SizedBox(height: 10.0), 
        // expanded column information
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // username
                AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.person,
                    iconColor: Colors.brown,
                    backgroundcolor: Color.fromARGB(255, 253, 250, 250),
                    size: 50,
                    iconsize: 30,
                  ),
                  bigText: BigTextWidget(
                    text: '',
                    size: 22,
                  ),
                ),
                // phone nember
                /*AccountWidget(
    appIcon: AppIcon(
    icon: Icons.phone,
    iconColor: Colors.white,
    backgroundcolor: AppColors.yellowColor,
    size: 50,
    iconsize: 30,
    ),
      bigText: BigTextWidget(
        text:sharedPreferences!.getString(AppConstants.USER_PHONE),
        size: 22,
      ),
    ),*/
                // email adress
                AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.mail,
                    iconColor: Colors.brown,
                    backgroundcolor: Color.fromARGB(255, 250, 249, 249),
                    size: 50,
                    iconsize: 30,
                  ),
                  bigText: BigTextWidget(
                    text: (''),
                    size: 20,
                  ),
                ),

                // logout
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: AccountWidget(
                    appIcon: AppIcon(
                      icon: Icons.logout,
                      iconColor: Colors.brown,
                      backgroundcolor: Color.fromARGB(255, 238, 237, 237),
                      size: 50,
                      iconsize: 30,
                    ),
                    bigText: BigTextWidget(
                      text: "Logout",
                      size: 22,
                    ),
                  ),
                ),
       SizedBox(height: 15.0), 
              ],
            ),
          ),
        )
      ]),
     ) ));
  }
}
