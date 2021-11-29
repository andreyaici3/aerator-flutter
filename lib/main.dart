
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switch_aerator/const.dart';
import 'package:switch_aerator/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

Future <void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var SessionID = prefs.getString('Session-ID');

  runApp(MaterialApp(
    home: SessionID != null ? Dashboard() : Login()
  ));
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  loginProses() async {
    var url = Uri.parse(urlApi+"auth");
    var request = await http
        .post(url, body: {'x-uname': username.text, 'x-passwd': password.text});
    var data = json.decode(request.body);

    if (data["status"] == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('Session-ID', data["Session-ID"]);

      print("Login successfully!"); // Toast harusnya
      Fluttertoast.showToast(
          msg: "Login successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(),),);
    } else {
      print("Error : "+ data["message"]); // Toast juga
      Fluttertoast.showToast(
          msg: data["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
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
