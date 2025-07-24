import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YouTubePlayerPage extends StatefulWidget {
  final String youtubeUrl;

  const YouTubePlayerPage({Key? key, required this.youtubeUrl}) : super(key: key);

  @override
  State<YouTubePlayerPage> createState() => _YouTubePlayerPageState();
}

class _YouTubePlayerPageState extends State<YouTubePlayerPage> {
  late YoutubePlayerController _controller;
  late String? _videoId;

  @override
  void initState() {
    super.initState();
    _videoId = YoutubePlayerController.convertUrlToId(widget.youtubeUrl);

    if (_videoId != null) {
      _controller = YoutubePlayerController.fromVideoId(
        videoId: _videoId!,
        autoPlay: true,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_videoId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("YouTube Video")),
        body: const Center(child: Text("Invalid YouTube URL")),
      );
    }

    return YoutubePlayerScaffold(
      controller: _controller,
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(title: const Text("YouTube Video")),
          body: Center(child: player),
        );
      },
    );
  }
}
