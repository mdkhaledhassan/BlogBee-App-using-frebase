import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateBlog extends StatefulWidget {
  UpdateBlog({this.b_des, this.b_id, this.b_img, this.b_name});
  String? b_id;
  String? b_name;
  String? b_des;
  String? b_img;

  @override
  State<UpdateBlog> createState() => _UpdateBlogState();
}

class _UpdateBlogState extends State<UpdateBlog> {
  TextEditingController blogtitle = TextEditingController();
  TextEditingController blogdes = TextEditingController();
  XFile? blogimage;
  String? imageUrl;
  selectimage() async {
    ImagePicker picker = ImagePicker();
    blogimage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  update_writeData() async {
    if (blogimage == null) {
      CollectionReference blogData =
          FirebaseFirestore.instance.collection('blogs');

      blogData.doc(widget.b_id).update({
        'title': blogtitle.text,
        'description': blogdes.text,
        'img': widget.b_img
      });
    } else {
      File imageFile = File(blogimage!.path);

      FirebaseStorage storage = FirebaseStorage.instance;
      UploadTask uploadblog =
          storage.ref('images').child(blogimage!.name).putFile(imageFile);

      TaskSnapshot snapshot = await uploadblog;
      imageUrl = await snapshot.ref.getDownloadURL();

      CollectionReference blogData =
          FirebaseFirestore.instance.collection('blogs');

      blogData.doc(widget.b_id).update({
        'title': blogtitle.text,
        'description': blogdes.text,
        'img': imageUrl
      });
    }
  }

  void initState() {
    super.initState();
    blogtitle.text = widget.b_name!;
    blogdes.text = widget.b_des!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: blogtitle,
              decoration: InputDecoration(
                  hintText: 'Enter Blog Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: blogdes,
              decoration: InputDecoration(
                  hintText: 'Enter Blog Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: blogimage == null
                    ? Stack(
                        children: [
                          Image.network('${widget.b_img}'),
                          Positioned(
                              left: 20,
                              right: 20,
                              bottom: 0,
                              child: Center(
                                child: CircleAvatar(
                                  child: IconButton(
                                    icon: Icon(Icons.photo),
                                    onPressed: () {
                                      selectimage();
                                    },
                                  ),
                                ),
                              ))
                        ],
                      )
                    : Image.file(File(blogimage!.path))),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  update_writeData();
                  Navigator.of(context).pop();
                },
                child: Text("Update Blog"))
          ],
        ),
      ),
    );
  }
}
