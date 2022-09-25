import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comapny_task/src/create_blog/model/blog_data_model.dart';

class DataBase {
  static Stream<List<BlogDataModel>> get blogData {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore.collection("blogs").snapshots().map(
        (QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((QueryDocumentSnapshot snapshot) =>
                BlogDataModel(title: snapshot.get("title"),
                    description: snapshot.get("description"),
                    category: snapshot.get("category"),
                emailId: snapshot.get("email_id"),
                image:snapshot.get("image") ,
                userName:snapshot.get("userName") ))
            .toList());
  }
}
