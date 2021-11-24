import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String urlAuth = "https://api.bengkelonline.org/api/auth";

  loginProses() async {
    Response response = await Dio().post(urlAuth,
        data: {'x-uname': username.text, 'x-passwd': password.text});

    if (response.statusCode == 200) {
      print(response.data);
    }
  }

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  "SILAHKAN MASUK",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: username,
                decoration: InputDecoration(
                  hintText: "Masukan Username",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  prefixIcon: Icon(Icons.person),
                  labelText: "Username",
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Masukan Password",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.blue,
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    onPressed: () {
                      loginProses();
                    },
                  ),
                  SizedBox(width: 20.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
