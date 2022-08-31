import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlogPosts extends StatefulWidget {
  const BlogPosts({super.key});

  @override
  State<BlogPosts> createState() => _BlogPostsState();
}

class _BlogPostsState extends State<BlogPosts> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('blogs').snapshots();

  readmore(context, String img, String title, String description) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          img,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Text(description,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 18),
                      textAlign: TextAlign.justify),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 20,
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.facebook,
                            color: Colors.white,
                            size: 20,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                )),
          ),
        ],
        backgroundColor: Colors.teal,
        title: Text("Blog Posts"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                '${data['img']}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${data['title']}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${data['description']}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.justify,
                                maxLines: 4,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    readmore(
                                        context,
                                        '${data['img']}',
                                        '${data['title']}',
                                        '${data['description']}');
                                  },
                                  child: Text("Read..."))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
              // ListTile(
              //   leading: CircleAvatar(
              //     radius: 30,
              //     child: Image.network('${data['image']}'),
              //   ),
              //   title: Text('${data['title']}'),
              //   subtitle: Text('${data['description']}'),
              // );
            }).toList(),
          );
        },
      ),
    );
  }
}
