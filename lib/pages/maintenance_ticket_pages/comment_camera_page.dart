import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../../services/FirebaseConfig.dart';

class CommentCameraPage extends StatefulWidget {
  final MaintenanceTicket maintenanceTicket;
  final Landlord landlord;
  const CommentCameraPage({Key? key, required this.maintenanceTicket, required this.landlord})
      : super(key: key);

  @override
  State<CommentCameraPage> createState() => _CommentCameraPageState();
}

class _CommentCameraPageState extends State<CommentCameraPage> {
  XFile? imageFile;

  void setImage(XFile? value) {
    imageFile = value;
  }

  void caputure(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    picker
        .pickImage(
      source: ImageSource.camera,
      maxWidth: MediaQuery.of(context).size.width,
      maxHeight: MediaQuery.of(context).size.height,
      imageQuality: 100,
    )
        .then((pickedFile) {
      try {
        pickedFile!.readAsBytes().then((value) {
          ImageComment comment = ImageComment.fromLandlord(widget.landlord);
          comment.setComment(base64Encode(value));
          FirebaseConfiguration()
              .setComment(widget.maintenanceTicket.firebaseId, comment);
          Navigator.pop(context);
      Navigator.pop(context);
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => caputure(context));
  }

  dynamic _pickImageError;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (imageFile != null) {
      return Semantics(
          label: 'image_picker_example_picked_images',
          child: Semantics(
            label: 'image_picker_example_picked_image',
            child: kIsWeb
                ? Image.network(imageFile!.path)
                : Image.file(File(imageFile!.path)),
          ));
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
          setImage(response.file);
        } else {
          imageFile = response.files![0];
        }
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
            ? FutureBuilder<void>(
                future: retrieveLostData(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Text(
                        'You have not yet picked an image.',
                        textAlign: TextAlign.center,
                      );
                    case ConnectionState.done:
                      return _previewImages();
                    default:
                      if (snapshot.hasError) {
                        return Text(
                          'Pick image error: ${snapshot.error}}',
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return const Text(
                          'You have not yet picked an image.',
                          textAlign: TextAlign.center,
                        );
                      }
                  }
                },
              )
            : _previewImages(),
      ),
     

    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
