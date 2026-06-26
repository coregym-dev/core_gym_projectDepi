import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:video_player/video_player.dart';

class VideoPlayHeader extends StatefulWidget {
  final String videoUrl;

  const VideoPlayHeader({super.key, required this.videoUrl});

  @override
  State<VideoPlayHeader> createState() => _VideoPlayHeaderState();
}

class _VideoPlayHeaderState extends State<VideoPlayHeader> {
  VideoPlayerController? controller;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    playVideoGym(widget.videoUrl);
  }

  Future<void> playVideoGym(String url) async {
    controller = VideoPlayerController.networkUrl(Uri.parse(url));

    await controller!.initialize();

    controller!.addListener(() {
      if (controller!.value.position >= controller!.value.duration &&
          controller!.value.duration != Duration.zero) {
        controller!.pause();
        if (mounted) setState(() {});
      }
    });

    isInitialized = true;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void togglePlay() {
    if (controller == null) return;

    setState(() {
      if (controller!.value.isPlaying) {
        controller!.pause();
      } else {
        controller!.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 220,
              width: double.infinity,
              color: Colors.black,
              child: (controller != null && isInitialized)
                  ? FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: controller!.value.size.width,
                        height: controller!.value.size.height,
                        child: VideoPlayer(controller!),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.accentColor,
                      ),
                    ),
            ),
          ),
        ),

        if (controller != null && isInitialized)
          Positioned(
            top: 90,
            left: 0,
            right: 0,
            child: Center(
              child: IconButton.filledTonal(
                iconSize: 20,
                onPressed: togglePlay,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  padding: const EdgeInsets.all(10),
                ),
                icon: Icon(
                  controller!.value.isPlaying
                      ? CupertinoIcons.pause_solid
                      : CupertinoIcons.play_arrow_solid,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
