


import 'package:allincluded/EnterDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:allincluded/AddImage.dart';
import 'package:flutter/material.dart';
import 'package:dcdg/dcdg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}
class _ReportsState extends State<Reports> {

  //Map document;
  String uid=FirebaseAuth.instance.currentUser.uid.toString();
  CollectionReference users = FirebaseFirestore.instance.collection('profileInfo');



  @override
  Widget build(BuildContext context) {
    navigateToImage(DocumentSnapshot post){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>DisplayImage(post:post,)));
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Click + button to add reports...",style: TextStyle(color: Colors.grey,fontSize: 13) ,),
        ),
        body:new StreamBuilder(

          stream: FirebaseFirestore.instance.collection('profileInfo').doc(uid).collection("ImageURLs").snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : Container(

                        padding: EdgeInsets.all(4),

                        child: GridView.builder(
                            itemCount: snapshot.data.docs.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                            itemBuilder: (context, index) {

                              return InkWell(

                                child: Container(

                                  margin: EdgeInsets.all(3),


                                    child: FadeInImage.memoryNetwork(
                                        fit: BoxFit.cover,
                                        placeholder: kTransparentImage,
                                        image: snapshot.data.docs[index].get('url')),


                                ),
                                onTap: ()=>navigateToImage(snapshot.data.docs[index]),
                              );

                            }),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF006400),
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddImage()));
          },
        ),
      ),
    );

  }



}
class DisplayImage extends StatefulWidget {
  final DocumentSnapshot post;
  DisplayImage({this.post});
  @override
  _DisplayImageState createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: AppBar(

          title: Text("View Reports"),
          backgroundColor: Colors.green,
          leading:

          GestureDetector(
            child: Icon(
              Icons.arrow_back,  // add custom icons also
            ),
            onTap: (){ Navigator.pop(context);},
          ),

        ),

        body:
        ListView(
          children: [
            Column(
              children: [
                Container(
                            child: Card(
                              margin: EdgeInsets.fromLTRB(0, 40, 0, 50),
                              child: FadeInImage.memoryNetwork(
                                  fit: BoxFit.cover,
                                  placeholder: kTransparentImage,
                                  image: widget.post.data()['url'],
                              ),

                            ),
                          ),

                      Text("Report Name with Date ="+widget.post.data()['reportname'].toString(),),

                      ],
                      ),
          ],
        ),

      ),
    );
  }

}
