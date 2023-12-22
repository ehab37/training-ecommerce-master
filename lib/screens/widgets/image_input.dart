import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({
    Key? key,
    required this.onSelectedImage,
    this.imageFile,
  }) : super(key: key);
  final Function(File image) onSelectedImage;
  final File? imageFile;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  _pickImage(ImageSource imageSoure,imageFile) {
    final ImagePicker imagePicker = ImagePicker();
    imagePicker
        .pickImage(
      source: imageSoure,
    )
        .then((value) {
      setState(() {
        imageFile = File(value!.path);
      });
      widget.onSelectedImage(imageFile!);
      return imageFile;
    });
  }
  void _removeImage(imageFile) {
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            color: Colors.black,
            size: 28,
          ),
          Text(
            ' Pick Image',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
    if (widget.imageFile != null) {
      setState(() {
        content = Image.file(
          widget.imageFile!,
          height: 280,
          width: double.infinity,
          fit: BoxFit.fill,
        );
      });
    }

    return GestureDetector(
      onTap: () {
        SnackBar snackBar = SnackBar(
          backgroundColor: Colors.white,
          shape: const Border(
            top: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
          content: widget.imageFile == null
              ? Column(
            children: [
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  _pickImage(ImageSource.gallery,widget.imageFile);
                },
                child: const SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'From Gallery',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  _pickImage(ImageSource.camera,widget.imageFile);
                },
                child: const SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'From Camera',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
              : Column(
            children: [
              GestureDetector(
                onTap: () {
                  SnackBar snackBar = SnackBar(
                    backgroundColor: Colors.white,
                    shape: const Border(
                      top: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    content: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context)
                                .clearSnackBars();
                            _pickImage(ImageSource.gallery,widget.imageFile);
                          },
                          child: const SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'From Gallery',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context)
                                .clearSnackBars();
                            _pickImage(ImageSource.camera,widget.imageFile);
                          },
                          child: const SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'From Camera',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Pick New Image',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  _removeImage(widget.imageFile);
                },
                child: const SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_circle_outline,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Remove Image',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Container(
        alignment: Alignment.center,
        height: 250,
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: content,
      ),
    );
  }
}

class ImageInputProfile extends StatefulWidget {
  const ImageInputProfile({
    Key? key,
    required this.onSelectedImage, this.imageFile,
  }) : super(key: key);
  final Function(File image) onSelectedImage;
  final  File? imageFile;
  @override
  State<ImageInputProfile> createState() => _ImageInputProfileState();
}

class _ImageInputProfileState extends State<ImageInputProfile> {


  _pickImage(ImageSource imageSoure, imageFile) {
    final ImagePicker imagePicker = ImagePicker();
    imagePicker
        .pickImage(
      source: imageSoure,
    )
        .then((value) {
      setState(() {
        imageFile = File(value!.path);
      });
      widget.onSelectedImage(imageFile!);
      return imageFile;
    });
  }

  void _removeImage(imageFile) {
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Icon(
        FontAwesomeIcons.circleUser,
        size: 115,
      ),
    );
    if (widget.imageFile != null) {
      setState(() {
        content = Image.file(
          widget.imageFile!,
          height: 120,
          fit: BoxFit.fill,
        );
      });
    }

    return GestureDetector(
      onTap: () {
        SnackBar snackBar = SnackBar(
          backgroundColor: Colors.white,
          shape: const Border(
            top: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
          content: widget.imageFile == null
              ? Column(
            children: [
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  _pickImage(ImageSource.gallery,widget.imageFile);
                },
                child: const SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'From Gallery',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  _pickImage(ImageSource.camera,widget.imageFile);
                },
                child: const SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'From Camera',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
              : Column(
            children: [
              GestureDetector(
                onTap: () {
                  SnackBar snackBar = SnackBar(
                    backgroundColor: Colors.white,
                    shape: const Border(
                      top: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    content: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context)
                                .clearSnackBars();
                            _pickImage(ImageSource.gallery,widget.imageFile);
                          },
                          child: const SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'From Gallery',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context)
                                .clearSnackBars();
                            _pickImage(ImageSource.camera,widget.imageFile);
                          },
                          child: const SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'From Camera',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Pick New Image',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  _removeImage(widget.imageFile);
                },
                child: const SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_circle_outline,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Remove Image',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        clipBehavior: Clip.hardEdge,
        child: CircleAvatar(
          radius: 60,
          backgroundColor: Colors.white,
          child: content,
        ),
      ),
    );
  }
}