import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ChapterPlayer extends StatefulWidget {
  String ytUri;
  Function onEnded;
  ChapterPlayer({required this.onEnded, required this.ytUri, super.key});

  @override
  State<ChapterPlayer> createState() => _ChapterPlayerState();
}

class _ChapterPlayerState extends State<ChapterPlayer> {
  late String ytUri;
  late YoutubePlayerController _controller;
  late Function onEnded;
  bool isSetState = false;
  @override
  void initState() {
    ytUri = widget.ytUri;
    onEnded = widget.onEnded;
    _controller = YoutubePlayerController(
        params: const YoutubePlayerParams(
            showControls: true, showFullscreenButton: true))
      ..onInit = (() {
        _controller.cueVideoById(
            videoId: YoutubePlayerController.convertUrlToId(ytUri) ?? "",
            startSeconds: 0);
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
        controller: _controller,
        builder: ((context, player) => _controller == null
            ? CircularProgressIndicator()
            : Column(
                children: [
                  Container(
                      constraints:
                          BoxConstraints(maxHeight: 750, maxWidth: 750),
                      child: player),
                  Align(
                    child: YoutubeValueBuilder(
                      controller: _controller,
                      buildWhen: (p0, p1) {
                        if (p1.playerState == PlayerState.playing) {
                          return true;
                        } else if (p1.playerState == PlayerState.ended) {
                          onEnded();
                          return false;
                        } else {
                          return false;
                        }
                      },
                      builder: (BuildContext, YoutubePlayerValue) =>
                          SizedBox.shrink(),
                    ),
                  ),
                ],
              )));
  }
}
