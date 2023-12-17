import 'package:firebase_database/firebase_database.dart';
import 'package:kutuphane_otomasyonu/KitapModel.dart';


class FirebaseManager {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();



  Future<void> updateData(
       KitapModel data) async {

    Map<String, dynamic> yeniVeri = {
      'id' :data.id,
      'kitapAdi': data.kitapAdi,
      'yazar': data.yazar,
      'sayfaSayisi': data.sayfaSayisi,
      'yayinevi': data.yayinevi,
      'kategori': data.kategori,
      'basimYili': data.basimYili,
      'yayinlandi': data.yayinlandi,
    };

    await _database.child("Kitaplar").child(data.id).update(yeniVeri);
  }

  Future<void> deleteData(KitapModel data) async {
    await _database.child("Kitaplar").child(data.id).remove();
  }

  Future<List<Map<String, dynamic>>> getKitaplar() async {
    List<Map<String, dynamic>> kitapListesi = [];

    DataSnapshot snapshot = await _database.child("Kitaplar").get();

    if (snapshot.value != null) {
      if (snapshot.value is Map) {
        Map<dynamic, dynamic> values = snapshot.value as Map;
        values.forEach((key, value) {
          if (value is Map) {
            kitapListesi.add(Map<String, dynamic>.from(value));
          }
        });
      }
    }

    return kitapListesi;
  }

  Future<dynamic> fetchItem(String path, String key) async {
    DataSnapshot snapshot =
        (await _database.child(path).child(key).get()) as DataSnapshot;
    return snapshot.value;
  }
}
