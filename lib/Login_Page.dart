import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_prefernce/page1.dart';

import 'Color_palette.dart';


void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    )
);

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  late SharedPreferences logindata;
  late bool newuser;


  @override
  void dispose() {
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('newuser') ?? true);
    print(newuser);

    if (newuser == false) {
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => MyDashboard()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              //end: Alignment.topRight,
                begin: Alignment.topCenter,
                colors: [
                  //green,
                  teal,
                  teal,
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 80,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Login", style: TextStyle(color: dark, fontSize: 40),),
                  const SizedBox(height: 10,),
                  Text("Stay Charged!", style: TextStyle(color: dark, fontSize: 18),),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 60,),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(
                                  color: teal,
                                  blurRadius: 5,
                                  offset: const Offset(0, 0.5)
                              )]
                          ),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: black10))
                                ),
                                child:  TextField(
                                  controller: username_controller,
                                  decoration: const InputDecoration(
                                      hintText: "Email or Phone number",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: black10))
                                ),
                                child:  TextField(
                                  controller: password_controller,
                                  decoration: const InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40,),
                        TextButton(onPressed: (){}, child: Text("Forgot password",style: TextStyle(color: black10),)),
                        //Text("Forgot Password?", style: TextStyle(color: Colors.grey),),
                        const SizedBox(height: 40,),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width/1,
                          child: ElevatedButton(
                            onPressed: () {
                              String username = username_controller.text;
                              String password = password_controller.text;
                              if (username != '' && password != '') {
                                print('Successfull');

                                logindata.setBool('newuser', false);
                                logindata.setString('username', username);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MyDashboard()));
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color:
                                //black10
                                teal,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: dark,
                              shadowColor: teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50,),
                        TextButton(onPressed: (){}, child: Text("Don't have an account? Sign UP",style: TextStyle(color: black10),))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}