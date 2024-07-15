import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';

Stream usersStream = FirebaseFirestore.instance.collection('users').snapshots();
FirebaseFirestore fireStoreInstance = FirebaseFirestore.instance;
FirebaseStorage storageInstance = FirebaseStorage.instance;
GetStorage box = GetStorage();
