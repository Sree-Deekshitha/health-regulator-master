import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class DatabaseManager {
  final CollectionReference profileList =
  FirebaseFirestore.instance.collection('profileInfo');

   String uid=FirebaseAuth.instance.currentUser.uid.toString();
    //here user uid

  Future<void>createUserDetails(String Email,String Name,String Fname, String Mname,int Gender,DateTime _dob,
      String PhNumber,String Address,String Weight,String Height,
      String uid) async{
        return await profileList.doc(uid).set({"Email":Email,"Name":Name,"Fname":Fname,"Mname":Mname,"Date Of Birth":_dob,
              "Gender":Gender,"PhNumber":PhNumber,"Address":Address,"Weight":Weight,"Height":Height,"uid":uid});
  }
  Future<bool> checkIfDocExists(String uid) async {
    try{
      var collectionRef = FirebaseFirestore.instance.collection('profileInfo');

      var doc = await collectionRef.doc(uid).get();
      return doc.exists;
    }
    catch(e){
      throw e;
    }
  }

 Future<void>createHealthRecords(String Datetime,String Systolic,String Diastolic,String Temperature,String Bbefore,String Bafter,String LBefore,String Lafter
     ,String Dbefore,String Dafter,String food,String insulinone,String minsulinone,String ainsulinone,String einsulinone
     ,String insulintwo,String minsulintwo,String ainsulintwo,String einsulintwo) async {
    return await profileList.doc(uid).collection("Health").add({
      "CreatedOn":Datetime,
      "Systolic":Systolic,"Diastolic":Diastolic,
      "Temperature":Temperature,
      "Breakfast before":Bbefore,
      "Breakfast after":Bafter,
      "Lunch before":LBefore,
      "Lunch after":Lafter,
      "Dinner before":Dbefore,
      "Dinner after":Dafter,
      "Food":food,
      "Insulinone":insulinone,
      "Mone":minsulinone,
      "Aone":ainsulinone,
      "Eone":einsulinone,
      "Insulintwo":insulintwo,
      "Mtwo":minsulintwo,
      "Atwo":ainsulintwo,
      "Etwo":einsulintwo,

    });

 }
}