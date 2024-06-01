import 'package:flutter/material.dart';
import 'package:pendidikan_milenial/ui/home_page.dart';
import 'package:pendidikan_milenial/ui/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, prefs) {
            var dataPrefs = prefs.data;
            if (prefs.hasData) {
              if (dataPrefs!.getString('nama') != null) {
                return HomePage(
                  tingkatSekolah: dataPrefs.getString('tingkatSekolah')!,
                );
              } else {
                return const LoginPage();
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
