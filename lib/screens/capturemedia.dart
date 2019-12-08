import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:multi_media_picker/multi_media_picker.dart';
import 'package:video_player/video_player.dart';

class CaptureMedia extends StatefulWidget {
  final int index;
  final String appbartitle;
  CaptureMedia(this.index, this.appbartitle);
  @override
  _CaptureMediaState createState() => _CaptureMediaState(index, appbartitle);
}

class _CaptureMediaState extends State<CaptureMedia> {
  /*  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
  } */

  final int index;
  final String appBartitle;

  _CaptureMediaState(this.index, this.appBartitle);
  List<File> _images = [];
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  getVideo(ImageSource source) async {
    var video = await MultiMediaPicker.pickVideo(source: source);
    setState(() {
      if (video != null) {
        videoPlayerController = VideoPlayerController.file(video);
      }
    });
  }

  getImages(ImageSource source, bool singleImage) async {
    try {
      var images = await MultiMediaPicker.pickImages(
          maxHeight: 200.0,
          maxWidth: 200.0,
          source: source,
          singleImage: singleImage);
      setState(() {
        if (images != null) {
          _images = images;
        }
      });
    } on Exception catch (e) {
      print('exception: ' + e.toString());
    }
  }

  _buildImageList() {
    return _images == null
        ? Text('No images taken')
        : ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            itemCount: _images.length,
            itemBuilder: (context, int index) {
              return Image.file(_images[index]);
            },
          );
  }

  _buildVideoPlayer() {
    return FittedBox(
      fit: BoxFit.contain,
      child: videoPlayerController == null
          ? SizedBox(
              height: 5.0,
              width: 5.0,
            )
          : Chewie(
              controller: ChewieController(
                  looping: true,
                  aspectRatio: 3 / 2,
                  autoPlay: true,
                  allowFullScreen: true,
                  allowMuting: true,
                  videoPlayerController: videoPlayerController),
            ),
    );
  }

  _buildColumn(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.videocam),
          label: Text('Take Video from camera'),
          onPressed: () {
            getVideo(ImageSource.camera);
          },
        ),
        SizedBox(height: 5.0),
        FlatButton.icon(
          icon: Icon(Icons.videocam),
          label: Text('Take Video from gallery'),
          onPressed: () {
            getVideo(ImageSource.gallery);
          },
        ),
        SizedBox(height: 5.0),
        FlatButton.icon(
          icon: Icon(Icons.photo),
          label: Text('Import image from gallery'),
          onPressed: () {
            getImages(ImageSource.gallery, false);
          },
        ),
        SizedBox(height: 5.0),
        FlatButton.icon(
          icon: Icon(Icons.camera),
          label: Text('Take picture from camera'),
          onPressed: () {
            index == 2
                ? getImages(ImageSource.camera, true)
                : getImages(ImageSource.camera, false);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBartitle),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildColumn(index),
              Container(
                child: _buildVideoPlayer(),
                height: 200.0,
              ),
              Container(
                child: _buildImageList(),
                height: 400.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
