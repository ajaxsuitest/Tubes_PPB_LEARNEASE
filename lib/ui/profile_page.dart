import 'package:flutter/material.dart';
import 'package:pendidikan_milenial/model/user.dart';
import 'package:pendidikan_milenial/ui/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({required this.user, super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var kWidth = MediaQuery.of(context).size.width;

    Future logout(BuildContext context) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false);
    }

    void confirmLogOut() {
      var kWidth = MediaQuery.of(context).size.width;

      showModalBottomSheet(
          isDismissible: true,
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kWidth / 20),
                topRight: Radius.circular(kWidth / 20)),
          ),
          builder: (context) {
            return IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.all(kWidth / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Apakah anda yakin ingin logout?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: kWidth / 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: kWidth / 3,
                          padding: EdgeInsets.only(
                              top: kWidth / 20, bottom: kWidth / 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(kWidth / 40),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: kWidth / 30),
                              child: Text(
                                "BATAL",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: kWidth / 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: kWidth / 3,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius:
                                    BorderRadius.circular(kWidth / 40),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              logout(context);
                            },
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: kWidth / 30),
                              child: Text(
                                "LOGOUT",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: kWidth / 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Profil',
          style: TextStyle(
            color: Colors.black,
            fontSize: kWidth / 20,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(kWidth / 20),
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(kWidth / 20),
                  child: Icon(
                    Icons.person,
                    size: kWidth / 9,
                  ),
                ),
                SizedBox(
                  height: kWidth / 40,
                ),
                Text(
                  widget.user.nama,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kWidth / 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Tingkat ${widget.user.tingkatSekolah}',
                  style: TextStyle(
                    fontSize: kWidth / 23,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kWidth / 20),
            child: InkWell(
              onTap: () {
                confirmLogOut();
              },
              child: Padding(
                padding: EdgeInsets.only(top: kWidth / 25, bottom: kWidth / 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Theme.of(context).primaryColor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: kWidth / 20),
                          child: Text(
                            "Logout",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: kWidth / 23),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).primaryColor,
                      size: kWidth / 15,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
