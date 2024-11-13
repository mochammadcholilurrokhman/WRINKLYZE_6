import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DisplayPictureScreen extends StatefulWidget {
  final File imageFile;
  final bool isFrontCamera;

  const DisplayPictureScreen({
    Key? key,
    required this.imageFile,
    required this.isFrontCamera,
  }) : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  bool _isUploading = false;

  Future<String?> _uploadToFirebaseStorage() async {
    setState(() {
      _isUploading = true;
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final ref = FirebaseStorage.instance.ref().child(
            'images/${user.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg');

        final uploadTask = await ref.putFile(widget.imageFile);
        final downloadUrl = await uploadTask.ref.getDownloadURL();

        setState(() {
          _isUploading = false;
        });

        return downloadUrl;
      } catch (e) {
        setState(() {
          _isUploading = false;
        });

        print("Failed to upload image: $e");
        return null;
      }
    } else {
      setState(() {
        _isUploading = false;
      });
      print("User is not authenticated.");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff052135),
        title: Text('Captured Image', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: widget.isFrontCamera
                        ? Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(3.14159),
                            child: Image.file(
                              widget.imageFile,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.file(
                            widget.imageFile,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            color: Color(0xff052135),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _isUploading
                      ? null
                      : () async {
                          final downloadUrl = await _uploadToFirebaseStorage();
                          if (downloadUrl != null) {
                            print("Image uploaded successfully: $downloadUrl");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Image uploaded successfully!"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Failed to upload image."),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: _isUploading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF7995A4)),
                          )
                        : Icon(
                            Icons.check,
                            color: Color(0xFF7995A4),
                            size: 40,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
