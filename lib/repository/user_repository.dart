import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pendidikan_milenial/model/user.dart';
import 'package:pendidikan_milenial/ui/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// String url = "http://192.168.1.5/pendidikan-milenial-api";
String url = "https://sukucadang.encepmotor.com/pendidikan/api";

class UserRepository {
  static Future login(String username, String password, context) async {
    Uri endPoint = Uri.parse('$url/login.php');

    var response = await post(
      endPoint,
      body: {
        "username": username,
        "password": password,
      },
    );

    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse == null || jsonResponse.length == 0) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Username atau password salah!'),
          ),
        );
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString('nama', jsonResponse[0]['nama']);
        prefs.setString('username', jsonResponse[0]['username']);
        prefs.setString('tingkatSekolah', jsonResponse[0]['tingkatSekolah']);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login berhasil'),
          ),
        );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => HomePage(
                      tingkatSekolah: prefs.getString('tingkatSekolah')!,
                    )),
            (Route<dynamic> route) => false);
      }
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login gagal'),
        ),
      );
    } else {
      debugPrint(
          "StatusCode: [${response.statusCode}] Response: ${jsonResponse['message']}");
    }
  }

  static Future register(User? user, context) async {
    Uri endPoint = Uri.parse('$url/register.php');

    var response = await post(
      endPoint,
      body: {
        "nama": user!.nama,
        "username": user.username,
        "password": user.password,
        "tingkatSekolah": user.tingkatSekolah,
      },
    );

    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 201) {
      Navigator.pop(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonResponse['message'].toString())));
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonResponse['message'].toString())));
    } else {
      debugPrint(
          "StatusCode: [${response.statusCode}] Response: ${jsonResponse['message']}");
    }
  }
}
