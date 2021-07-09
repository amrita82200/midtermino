import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  final Color color;

  ProfilePage(this.color);

  FirebaseAuth auth = FirebaseAuth.instance;

  late String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.green,
            ),
                onPressed: () {

                },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                    children: [
                      Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 4, color: Theme.of(context).scaffoldBackgroundColor
                              ),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2, blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0,10)
                                )
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage("https://www.thesprucepets.com/thmb/bvRBULPK0-z1Q3pWfZG9p_VWKwA=/1000x1000/smart/filters:no_upscale()/breed_profile_corgi_1117986_hero_917-6ed2ed41b6e641bb98221b13a1d83a86.jpg")
                              )
                          ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                    ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              TextField(
               onChanged: (value){               
                email = value.trim();            
               },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "E-Mail",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: auth.currentUser!.email,
                    hintStyle: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )
                ),
              ),
              TextField(
                onChanged: (value){             
                  password = value.trim();     
               },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Password",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "********",
                    hintStyle: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  //save button
                  ElevatedButton(
                    onPressed: () {
                      changePassword(password);
                      changeEmail(email);
                      print("ya stuff changed");
                    },
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.white),
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeEmail(String email) async{
    //Pass in the password to updatePassword.
    auth.currentUser!.updateEmail(email).then((_){
      print("Successfully changed email");
    }).catchError((error){
      print("email can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
  void changePassword(String password) async{
    //Pass in the password to updatePassword.
    auth.currentUser!.updatePassword(password).then((_){
      print("Successfully changed password");
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
}

