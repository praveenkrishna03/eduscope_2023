
import 'package:firebase_storage/firebase_storage.dart';


 /* Future<String> uploadDocumentToStorage(String childName, FilePickerResult file) async {
  Uint8List fileData = file.files.first.bytes!;
  Reference ref = _storage.ref().child(childName);
  UploadTask uploadTask = ref.putData(fileData);
  TaskSnapshot snapshot = await uploadTask;
  String profile = await snapshot.ref.getDownloadURL();
  return profile;
  
}*/
