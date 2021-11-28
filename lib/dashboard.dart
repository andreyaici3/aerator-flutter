import 'dart:convert';

import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import "package:switch_aerator/const.dart";
import "package:http/http.dart" as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'main.dart';

Future <void> main() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var Session_ID = prefs.getString('Session-ID');

  runApp(MaterialApp(
    home: Session_ID != null ? Dashboard() : Login(),
  ));
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Dashboard> {
  List<String> isi = ["ON", "OFF"];
  String machineName = "";
  String machineID = "";
  int toogleValue = 0;
  String status1 = "Loading...", status2 = "Loading...", status3 = "Loading...", status4 = "Loading...";
  bool aerator1 = false, aerator2 = false, aerator3 = false, aerator4 = false;
  String SessionID = "";

  getMachine() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      SessionID = prefs.getString('Session-ID')!;

      final responses = await http.post(
        Uri.parse(urlApi + 'machine'),
        // Send authorization headers to the backend.
        headers: <String, String>{
          'Session-ID': SessionID,
        },
      );
      final getData = jsonDecode(responses.body);
      if (getData["status"] == true) {
        var data = getData["data"];
        machineID = data['machine_id'];
        machineName = data["machine_name"];

        if (data["aerator1"] == "1") {
          aerator1  = true;
          status1   = "Aktif";
        } else {
          aerator1  = false;
          status1   = "Tidak Aktif";
        }

        if (data["aerator2"] == "1") {
          aerator2  = true;
          status2   = "Aktif";
        } else {
          aerator2  = false;
          status2   = "Tidak Aktif";
        }

        if (data["aerator3"] == "1") {
          aerator3  = true;
          status3   = "Aktif";
        } else {
          aerator3  = false;
          status3   = "Tidak Aktif";
        }

        if (data["aerator4"] == "1") {
          aerator4  = true;
          status4   = "Aktif";
        } else {
          aerator4  = false;
          status4   = "Tidak Aktif";
        }

        print("Fetch data successfully!");

        runApp(MaterialApp(
          home: Dashboard(),
        ));
      }
      else {
        print("Error : " + getData["message"]);

      }

    } catch (e) {
      print(e);
    }
  }

  Future updateMachine(int params, int status) async {
    try {
      var arr = {};
      if (params == 1){
        arr = {
          'machine_id' : machineID,
          'aerator1'  : status.toString(),
        };
      }else
      if (params == 2){
        arr = {
          'machine_id' : machineID,
          'aerator2'  : status.toString(),
        };
      }else
      if (params == 3){
        arr = {
          'machine_id' : machineID,
          'aerator3'  : status.toString(),
        };
      }else
      if (params == 4){
        arr = {
          'machine_id' : machineID,
          'aerator4'  : status.toString(),
        };
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      SessionID = prefs.getString('Session-ID')!;

      final responses = await http.put(
        Uri.parse(urlApi + 'machine'),
        // Send authorization headers to the backend.
        headers: <String, String>{
          'Session-ID': SessionID,
        },
        body: arr,
      );
      final dataResponse = jsonDecode(responses.body);
      if (dataResponse["status"] == true) {
        print(dataResponse["data"]);

        Fluttertoast.showToast(
            msg: dataResponse["data"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        getMachine();
      }else {
        print("Error : " + dataResponse["message"]);

        Fluttertoast.showToast(
            msg: dataResponse["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

    } catch (e) {
      print(e);
    }
  }


  @override
  void initState() {
    super.initState();
    getMachine();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Aerator Switch"),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width - 30.0,
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
              height: 20.0,
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
                      Text("Kandang "+machineName),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Aerator 1"),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: aerator1 ? Colors.blue : Colors.red,
                            ),
                            onPressed: () {
                              updateMachine(1, aerator1 ? 0 : 1);
                            },
                            child: Text(status1),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Aerator 2"),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: aerator2 ? Colors.blue : Colors.red,
                            ),
                            onPressed: () {
                              updateMachine(2, aerator2 ? 0 : 1);
                              },
                            child: Text(status2),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Aerator 3"),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: aerator3 ? Colors.blue : Colors.red,
                            ),
                            onPressed: () {
                              updateMachine(2, aerator3 ? 0 : 1);
                            },
                            child: Text(status3),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Aerator 4"),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: aerator4 ? Colors.blue : Colors.red,
                            ),
                            onPressed: () {
                              updateMachine(4, aerator4 ? 0 : 1);
                              },
                            child: Text(status4),
                          ),
                        ],
                      ),
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
