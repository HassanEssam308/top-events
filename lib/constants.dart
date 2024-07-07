import 'package:cloud_firestore/cloud_firestore.dart';

Stream usersStream = FirebaseFirestore.instance.collection('users').snapshots();
FirebaseFirestore dbFireStore = FirebaseFirestore.instance;