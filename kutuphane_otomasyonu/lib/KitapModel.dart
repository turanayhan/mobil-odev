import 'package:uuid/uuid.dart';

class KitapModel {
  final String id;
  final String kitapAdi;
  final String yazar;
  final String sayfaSayisi;
  final String yayinevi;
  final String kategori;
  final int basimYili;
  final bool yayinlandi;

  KitapModel({
    required String? id, // UUID olarak kullanılacak alan
    required this.kitapAdi,
    required this.yazar,
    required this.sayfaSayisi,
    required this.yayinevi,
    required this.kategori,
    required this.basimYili,
    required this.yayinlandi,
  }) : id = id ?? Uuid().v4(); // id null ise yeni bir UUID oluştur, değilse verilen id'yi kullan
}
