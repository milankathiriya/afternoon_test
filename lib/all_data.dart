import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AllDataPage extends StatefulWidget {
  @override
  _AllDataPageState createState() => _AllDataPageState();
}

class _AllDataPageState extends State<AllDataPage> {
  FirebaseFirestore dbRef = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Data"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: dbRef.collection('users').snapshots(),
        builder: (context, ss) {
          if (ss.hasData) {
            if (ss.data != null) {
              var data = ss.data.documents;
              print(data);
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, i){
                    return ListTile(
                      leading: Text(i.toString()),
                      title: Text(data[i]['name']),
                      subtitle: Text(data[i]['city']),
                      trailing: Text(data[i]['age'].toString()),
                    );
                  });
            } else {
              return Text("No Data");
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
