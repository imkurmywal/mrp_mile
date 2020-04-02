import 'package:flutter/material.dart';
import 'package:mrpmile/utils/Utils.dart';
import 'package:video_player/video_player.dart';

import 'ActivityVideoComments.dart';

class ActivityVideoDetails extends StatefulWidget {
  String _videoUrl;

  ActivityVideoDetails(this._videoUrl);

  @override
  _ActivityVideoDetailsState createState() =>
      _ActivityVideoDetailsState(_videoUrl);
}

class _ActivityVideoDetailsState extends State<ActivityVideoDetails> {
  String _videoUrl;
  VideoPlayerController _controller;

  _ActivityVideoDetailsState(this._videoUrl);

  @override
  void initState() {
    _controller = VideoPlayerController.network(_videoUrl)
      ..initialize().then((res) {
        setState(() {
          _controller.play();
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Video Message'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.comment),
            onPressed: () {
              if (_controller.value.isPlaying) {
                _controller.pause();
              }
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ActivityVideoComments()));
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: _controller != null
            ? _controller.value.initialized
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: VideoPlayer(_controller),
                  )
                : Utils.loadingContainer()
            : Utils.loadingContainer(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
