import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key, required this.videoUrl, required this.local});

  final dynamic videoUrl;
  final bool? local;

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  final ValueNotifier<bool> _initialized = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = widget.local!
        ? VideoPlayerController.file(widget.videoUrl)
        : VideoPlayerController.networkUrl(
            widget.videoUrl,
          );
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      looping: true,
    );

    _initialized.value = true;
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    _initialized.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _initialized,
      builder: (context, isReady, _) {
        if (!isReady) {
          return const Center(child: CircularProgressIndicator());
        }
        return AspectRatio(
          aspectRatio: _videoPlayerController.value.aspectRatio,
          child: Chewie(controller: _chewieController!),
        );
      },
    );
  }
}
