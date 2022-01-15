import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dcdg/dcdg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
class AddImage extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  TextEditingController _nameController = TextEditingController();
  bool uploading = false;
  double val = 0;
  List<String> listOfStr = List();
  CollectionReference imgRef;
  firebase_storage.Reference ref;
  List<File> _image=[];
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
                      child: Icon(
                      Icons.arrow_back,  // add custom icons also
                ),
          ),
          actions: [
            FlatButton(
              onPressed: (){
                setState(() {
                  uploading=true;
                });
                uploadFile().whenComplete(() => Navigator.of(context).pop());
              },
              child : Text("Upload",style: TextStyle(color: Colors.white,),),
            ),
          ],



        ),
        body: ListView(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,

              child: Stack(children: [

                   GridView.builder(
                      itemCount: _image.length+1,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      itemBuilder: (context,index){
                        return index ==0?
                        Center(
                          child: IconButton(
                            icon: Icon(Icons.add),
                              onPressed: () =>
                              !uploading ? chooseImage() : null),

                          )

                            :Container(margin: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            image:DecorationImage(
                                image: FileImage(_image[index-1]),
                                fit: BoxFit.cover
                            ),
                          ),
                        );
                      }
                      ),



                      Container(
                        margin: EdgeInsets.fromLTRB(0, 450, 0, 0),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Container(
                              width: MediaQuery.of(context).size.width/4,
                              child :Text("Reports Name & Date:",style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(width: 5,),
                            Container(
                              width: MediaQuery.of(context).size.width/2,
                              child: TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: 'Report name',
                                  alignLabelWithHint:true,
                                  counterText: "",
                                  contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                                  labelStyle: TextStyle(color: Colors.grey.shade600,),
                                ),

                                style: TextStyle(
                                    fontSize: 12.0,
                                    //height: 2.0,
                                    color: Colors.black
                                ),

                              ),
                            ),


                          ],
                        ),
                      ),

                uploading?Center(
                 child: Column(
                   mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(

                      child: Text(
                        'uploading...',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CircularProgressIndicator(
                      value: val,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    )
                  ],
                 )
                )
                    : Container(),


              ],
              ),

            ),
          ],
        ),

      ),


    );
  }
  chooseImage() async{

    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }
  Future uploadFile() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
     
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgRef.add({'url': value,'reportname':_nameController.text});
          i++;
        });
      });
    }
  }
  @override
  void initState() {
    super.initState();
    String uid=FirebaseAuth.instance.currentUser.uid.toString();
    
    imgRef = FirebaseFirestore.instance.collection('profileInfo').doc(uid).collection("ImageURLs");
  }
}
