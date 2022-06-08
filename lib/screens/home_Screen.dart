import 'dart:async';
import 'package:f_logs/f_logs.dart';
import 'package:crud/screens/logscreen.dart';
import 'package:crud/screens/login_screen.dart';
import 'package:crud/screens/view_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../Provider/Auth.dart';
import '../Provider/task_provider.dart';

class HomeScreen extends StatefulWidget {
  static const Routename = '/HomeScreen';
  final User? user;

  const HomeScreen({ this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User _user;
  bool _isSigningOut = false;

  @override
  void initState() {
    _user = widget.user!;

    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: OverlaySupport.global(
        child: MaterialApp(
          home: Scaffold(
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountEmail: Text("${_user.email}"),
                    accountName: Text("${_user.displayName}"),
                    currentAccountPicture: ClipRRect(
                      borderRadius: BorderRadius.circular(110),
                      child: Image.network(
                        _user.photoURL!,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    decoration: BoxDecoration(color: Colors.blue),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Sign out"),
                    onTap: () async {
                      setState(() {
                        _isSigningOut = true;
                      });
                      await Authentication.signOut(context: context);
                      setState(() {
                        _isSigningOut = false;
                      });
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.Routename);
                    },
                  )
                ],
              ),
            ),
            body: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/homescreen.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        top: 580,
                        left: 40,
                        height: 60,
                        width: 310,
                        child: Container(
                          color: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: SizedBox(
                              height: 30,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurple,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ),
                                onPressed: () async {

                                  Navigator.pushNamed(
                                      context, '/AddContactScreen');
                                },
                                child: Text('Add Task'),
                              ),
                            ),
                          ),
                        )),
                    Positioned(
                        top: 650,
                        left: 40,
                        height: 60,
                        width: 310,
                        child: Container(
                          color: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black45,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                              onPressed: () {

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomePage();
                                }));
                              },
                              child: Text('View All'),
                            ),
                          ),
                        ))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
