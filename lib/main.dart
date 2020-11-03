import 'package:afternoon_app/all_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/*
Ch.16

Publish Code to GitHub
- What is github?
- Installation of git
- Creating github account
- Create first github repository
- Push first app on github
- Grab project from github
* */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      routes: {
        '/': (context) => HomePage(),
        '/all_data': (context) => AllDataPage(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore dbRef = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase App"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text("Insert Data"),
              color: Colors.deepOrange,
              textColor: Colors.white,
              onPressed: insertData,
            ),
            RaisedButton(
              child: Text("Update Data"),
              color: Colors.deepOrange,
              textColor: Colors.white,
              onPressed: updateData,
            ),
            RaisedButton(
              child: Text("Delete Data"),
              color: Colors.deepOrange,
              textColor: Colors.white,
              onPressed: deleteData,
            ),
            RaisedButton(
              child: Text("Retrieve Data"),
              color: Colors.deepOrange,
              textColor: Colors.white,
              onPressed: retrieveData,
            ),
            RaisedButton(
              child: Text("Display All Data"),
              color: Colors.deepOrange,
              textColor: Colors.white,
              onPressed: (){
                Navigator.of(context).pushNamed('/all_data');
              },
            ),
          ],
        ),
      ),
    );
  }

  insertData() async {
    var data = {
      'name': 'XYZ',
      'age': 22,
      'city': 'Surat',
    };

    // DocumentReference res = await dbRef.collection('users').add(data);

    await dbRef.collection('users').doc('temp_data').set(data);
  }

  updateData() async {
    var data = {
      'city': 'Mumbai',
    };

    await dbRef.collection('users').doc('my_custom_doc').update(data);
  }

  deleteData() async {
    await dbRef.collection('users').doc('temp_data').delete();
  }

  retrieveData() async {

    List documents = [];

    QuerySnapshot res = await dbRef.collection('users').get();
    res.docs.forEach((QueryDocumentSnapshot doc) {
      print(doc.id);
      documents.add(doc.id);
    });

    documents.forEach((id) {

      dbRef.collection('users').doc(id).get().then((ss) {
        print("${ss.id} => ${ss.data()}");
      });

    });

  }
}
