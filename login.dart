import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";
  var key = GlobalKey<FormState>();

  login(){
    key.currentState!.save();
    FirebaseAuth.
    instance.
    signInWithEmailAndPassword(email: email, password: password)
    .then((data){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Log in Successfully"))
      );
      Navigator.of(context).pushNamed("home");
    })
    .catchError((err){
      // print("Sorry Something went Wrong ${err}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sorry Something went Wrong ${err} "))
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Back"),
      ),
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: ListView(
            children: [
              TextFormField(
                onSaved: (newValue) {
                  setState(() {
                    email = newValue!;
                  });
                },
              ),
              TextFormField(
                obscureText: true,
                onSaved: (newValue) {
                  setState(() {
                    password = newValue!;
                  });
                },
              ),
              SizedBox(height: 50,),
              ElevatedButton(onPressed: login, child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}