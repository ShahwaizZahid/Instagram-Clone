import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String name, File file) async {
    var uuid = Uuid().v4();

    Reference ref = _storage
        .ref()
        .child(name)
        .child(_auth.currentUser!.uid)
        .child(uuid);

    try {
      // Upload the file
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      // Handle errors
      print('Error uploading image: $e');
      throw e;
    }
  }
}
