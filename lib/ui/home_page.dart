import 'package:flutter/material.dart';
import 'package:pendidikan_milenial/model/course.dart';
import 'package:pendidikan_milenial/model/user.dart';
import 'package:pendidikan_milenial/ui/course_video_page.dart';
import 'package:pendidikan_milenial/ui/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String tingkatSekolah;
  const HomePage({required this.tingkatSekolah, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Beranda',
          style: TextStyle(
            fontSize: kWidth / 20,
            color: Colors.black,
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              // ignore: use_build_context_synchronously
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProfilePage(
                  user: User(
                      username: prefs.getString('username')!,
                      nama: prefs.getString('nama')!,
                      tingkatSekolah: prefs.getString('tingkatSekolah')!),
                );
              }));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kWidth / 25),
              child: Icon(
                Icons.person,
                color: Colors.black,
                size: kWidth / 17,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          homeWidgets(kWidth),
        ],
      ),
    );
  }

  Widget homeWidgets(double kWidth) {
    return Padding(
      padding: EdgeInsets.all(kWidth / 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pilih pelajaran untuk tingkat ${widget.tingkatSekolah}',
            style: TextStyle(
              fontSize: kWidth / 25,
            ),
          ),
          SizedBox(
            height: kWidth / 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CourseVideoPage(
                  course: Course(
                    title: 'Matematika',
                    videoPathSMA:
                        'https://sukucadang.encepmotor.com/pendidikan/api/vid/sma_mtk.mp4',
                    videoPathSMP:
                        'https://sukucadang.encepmotor.com/pendidikan/api/vid/smp_mtk.mp4',
                    videoPathSD:
                        'https://sukucadang.encepmotor.com/pendidikan/api/vid/sd_mtk.mp4',
                    tingkatan: widget.tingkatSekolah,
                  ),
                );
              }));
            },
            child: Container(
              padding: EdgeInsets.all(kWidth / 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    left: BorderSide(
                      width: kWidth / 40,
                      color: Colors.blue,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      blurRadius: kWidth / 80,
                      offset: const Offset(0, 5),
                    )
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(kWidth / 40),
                  )),
              child: Row(
                children: [
                  SizedBox(
                    width: kWidth / 4,
                    height: kWidth / 4,
                    child: Image.asset(
                      'assets/mtk.png',
                      scale: 2.2,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(
                    width: kWidth / 20,
                  ),
                  Text(
                    'Matematika',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: kWidth / 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: kWidth / 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CourseVideoPage(
                  course: Course(
                    title: 'Bahasa Indonesia',
                    videoPathSMA:
                        'https://sukucadang.encepmotor.com/pendidikan/api/vid/sma_bindo.mp4',
                    videoPathSMP:
                        'https://sukucadang.encepmotor.com/pendidikan/api/vid/smp_bindo.mp4',
                    videoPathSD:
                        'https://sukucadang.encepmotor.com/pendidikan/api/vid/sd_bindo.mp4',
                    tingkatan: widget.tingkatSekolah,
                  ),
                );
              }));
            },
            child: Container(
              padding: EdgeInsets.all(kWidth / 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    left: BorderSide(
                      width: kWidth / 40,
                      color: Colors.amber,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      blurRadius: kWidth / 80,
                      offset: const Offset(0, 5),
                    )
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(kWidth / 40),
                  )),
              child: Row(
                children: [
                  SizedBox(
                    width: kWidth / 4,
                    height: kWidth / 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(kWidth / 40),
                      ),
                      child: Image.asset(
                        'assets/bahasa.png',
                        scale: 5,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: kWidth / 20,
                  ),
                  Text(
                    'Bahasa Indonesia',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: kWidth / 20,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
