import 'package:flutter/material.dart';
import 'package:pendidikan_milenial/model/course.dart';
import 'package:video_player/video_player.dart';

class CourseVideoPage extends StatefulWidget {
  final Course course;
  const CourseVideoPage({required this.course, super.key});

  @override
  State<CourseVideoPage> createState() => _CourseVideoPageState();
}

class _CourseVideoPageState extends State<CourseVideoPage> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    if (widget.course.tingkatan == 'SD') {
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.course.videoPathSD))
            ..initialize().then((_) {
              setState(() {
                videoPlayerController.play();
              });
            });
    } else if (widget.course.tingkatan == 'SMP') {
      videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(widget.course.videoPathSMP))
        ..initialize().then((_) {
          setState(() {
            videoPlayerController.play();
          });
        });
    } else {
      videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(widget.course.videoPathSMA))
        ..initialize().then((_) {
          setState(() {
            videoPlayerController.play();
          });
        });
    }
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            videoPlayerController.value.isPlaying
                ? videoPlayerController.pause()
                : videoPlayerController.play();
          });
        },
        child: Icon(
          videoPlayerController.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '${widget.course.title} Tingkat ${widget.course.tingkatan}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: kWidth / 20,
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Center(
                child: videoPlayerController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(videoPlayerController),
                      )
                    : const CircularProgressIndicator(),
              ),
              SizedBox(
                height: kWidth / 20,
              ),
              Text(
                'Video Rangkuman Materi ${widget.course.title}',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: kWidth / 23),
              )
            ],
          )
        ],
      ),
    );
  }
}
