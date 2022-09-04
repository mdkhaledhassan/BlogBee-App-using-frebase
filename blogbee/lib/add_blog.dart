import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  TextEditingController blogtitle = TextEditingController();
  TextEditingController blogdes = TextEditingController();
  XFile? blogimage;
  String? imageUrl;
  selectimage() async {
    ImagePicker picker = ImagePicker();
    blogimage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  writeData() async {
    File imageFile = File(blogimage!.path);

    FirebaseStorage storage = FirebaseStorage.instance;
    UploadTask uploadblog =
        storage.ref('images').child(blogimage!.name).putFile(imageFile);

    TaskSnapshot snapshot = await uploadblog;
    imageUrl = await snapshot.ref.getDownloadURL();

    CollectionReference blogData =
        FirebaseFirestore.instance.collection('blogs');

    blogData.add({
      'title': blogtitle.text,
      'description': blogdes.text,
      'img': imageUrl
    });
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
                    ? IconButton(
                        onPressed: () {
                          selectimage();
                        },
                        icon: Icon(Icons.photo))
                    : Image.file(File(blogimage!.path))),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  writeData();
                  Navigator.of(context).pop();
                },
                child: Text("Add Blog"))
          ],
        ),
      ),
    );
  }
}
