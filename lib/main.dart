import 'package:flutter/material.dart';
import 'package:switch_aerator/const.dart';
import 'package:switch_aerator/login.dart';
import 'toogle.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Dio dio = Dio();
  String urlAuth = "https://api.bengkelonline.org/api/auth";

  loginProses() async {
    Response response = await Dio().post(urlAuth,
        data: {'x-uname': "machine1@gmail.com", 'x-passwd': "machine123"});

    if (response.statusCode == 200) {
      print(response.data);
    }
  }

  Future getMachine() async {
    try {
      final response = await http.post(
        Uri.parse(
          "https://api.bengkelonline.org/api/machine",
        ),
        headers: {
          "Session-ID": "apKTdOjx9mtPSqiHkpzmOCQAaTOKTq1r",
        },
      );

      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getMachine();
  }

  List<String> isi = ["ON", "OFF"];
  int toogleValue = 1;
  String status = "Aktif";
  String sessionId = "61sQJ76oupoz84q8QTizmUw6ubfkgqjk";
  bool aerator1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Aerator Switch"),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width - 10.0,
        margin: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  width: MediaQuery.of(context).size.width / 4,
                  image: AssetImage("images/twh.png"),
                ),
                SizedBox(
                  width: 30.0,
                ),
                Image(
                  width: MediaQuery.of(context).size.width / 4,
                  image: AssetImage(
                    "images/km.png",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "PROGRAM HOLISTIK PEMBINAAN DAN PEMBERDAYAAN DESA",
              textAlign: TextAlign.center,
              style: TextStyle(
                overflow: TextOverflow.visible,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "PAGUYUBAN BARUDAK KOMPUTER",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("Kandang Bapak. Reza"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Aerator 1"),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: aerator1 ? Colors.red : Colors.blue,
                            ),
                            onPressed: () {},
                            child: Text("Aktif"),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Aerator 1"),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: aerator1 ? Colors.red : Colors.blue,
                            ),
                            onPressed: () {},
                            child: Text("Aktif"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("Kandang Bapak. Reza"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
