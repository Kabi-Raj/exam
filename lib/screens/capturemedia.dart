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
  List<File> _images = List<File>();
  File _video;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  _buildVideoPicker() {
    return _video == null
        ? Container(
            width: MediaQuery.of(context).size.width,
            // margin: EdgeInsets.only(bottom: 10.0),
            child: GestureDetector(
              child: Icon(
                Icons.video_call,
                size: 100.0,
              ),
              onTap: () => _showDialog('video'),
            ),
          )
        : Chewie(
            controller: ChewieController(
                looping: true,
                aspectRatio: 3 / 2,
                autoPlay: true,
                allowFullScreen: true,
                allowMuting: true,
                videoPlayerController: videoPlayerController),
          );
  }

  _buildImageGridView() {
    return GridView.builder(
      itemCount: _images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
          childAspectRatio: 2 / 4),
      itemBuilder: (context, int index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.file(
            _images[index],
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        );
      },
    );
  }

  getVideo(ImageSource source) async {
    var video = await MultiMediaPicker.pickVideo(source: source);

    setState(() {
      if (video != null) {
        _video = video;
        videoPlayerController = VideoPlayerController.file(_video);
      }
    });
  }

  getImages(ImageSource source, bool singleImage) async {
    try {
      var images = await MultiMediaPicker.pickImages(
          maxHeight: 100.0,
          maxWidth: 100.0,
          source: source,
          singleImage: singleImage);
      /*  var dir = await getExternalStorageDirectory();
      var path = File('$dir/${DateTime.now()}.jpg');
      print('image path: $path'); */
      print('image path: $images');
      setState(() {
        if (images != null) {
          _images.addAll(images);
        }
      });
    } on Exception catch (e) {
      print('exception: ' + e.toString());
    }
  }

  _showDialog(String media) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              elevation: 10.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              title: Text('choose an option'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Gallery'),
                  onPressed: () {
                    media == 'video'
                        ? getVideo(ImageSource.gallery)
                        : index == 2
                            ? getImages(ImageSource.gallery, true)
                            : getImages(ImageSource.gallery, false);
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Camera'),
                  onPressed: () {
                    media == 'video'
                        ? getVideo(ImageSource.camera)
                        : index == 2
                            ? getImages(ImageSource.camera, true)
                            : getImages(ImageSource.camera, false);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  _buildAddImage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        child: Icon(
          Icons.add_a_photo,
          size: 100.0,
        ),
        onTap: () => _showDialog('image'),
      ),
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
        body: Column(
          children: <Widget>[
            Flexible(
              child: _buildVideoPicker(),
              flex: 2,
            ),
            Flexible(
              child: _buildAddImage(),
              flex: 2,
            ),
            //SizedBox(height: 10.0),
            _images.length == 0
                ? DecoratedBox(
                    decoration: BoxDecoration(shape: BoxShape.rectangle),
                    child: Text(
                      'No Images taken',
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Flexible(
                    child: _buildImageGridView(),
                    flex: 8,
                  ),
          ],
        ),
      ),
    );
  }
}
