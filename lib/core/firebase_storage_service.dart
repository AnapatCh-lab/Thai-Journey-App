import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> getImageUrl(String path) async {
    try {
      final Reference ref = _storage.ref().child(path);
      final String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      (e);
      return '';
    }
  }

  Future<List<String>> getImageUrls(List<String> paths) async {
    try {
      List<String> urls = [];
      for (String path in paths) {
        final Reference ref = _storage.ref().child(path);
        final String url = await ref.getDownloadURL();
        urls.add(url);
      }
      return urls;
    } catch (e) {
      (e);
      return [];
    }
  }
}
