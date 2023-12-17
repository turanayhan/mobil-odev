import 'package:flutter/material.dart';
import 'package:kutuphane_otomasyonu/MyTabBar.dart';
import 'FirebaseManager.dart';
import 'KitapModel.dart';

class KitapEklePage extends StatefulWidget {
  final KitapModel model;

  KitapEklePage({Key? key, required this.model}) : super(key: key);

  @override
  _KitapEklePageState createState() => _KitapEklePageState();
}

class _KitapEklePageState extends State<KitapEklePage> {
  final FirebaseManager firebaseManager = FirebaseManager();
  final TextEditingController kitapAdiController = TextEditingController();
  final TextEditingController yazarController = TextEditingController();
  final TextEditingController sayfaSayisiController = TextEditingController();
  final TextEditingController yayineviController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();
  final TextEditingController basimYiliController = TextEditingController();
  bool yayinlandi = false;
  String selectedKategori = '';

  @override
  void initState() {
    super.initState();
    kitapAdiController.text = widget.model.kitapAdi;
    yazarController.text = widget.model.yazar;
    sayfaSayisiController.text = widget.model.sayfaSayisi;
    yayineviController.text = widget.model.yayinevi;
    kategoriController.text = widget.model.kategori;
    basimYiliController.text = widget.model.basimYili.toString();
    yayinlandi = widget.model.yayinlandi;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kitap Ekle'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: kitapAdiController,
              decoration: InputDecoration(labelText: 'Kitap Adı'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: yazarController,
              decoration: InputDecoration(labelText: 'Yazar'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: sayfaSayisiController,
              decoration: InputDecoration(labelText: 'Sayfa Sayısı'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: yayineviController,
              decoration: InputDecoration(labelText: 'Yayınevi'),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [

                Expanded(
                  child: TextField(
                    controller: kategoriController,
                    decoration: InputDecoration(labelText: 'Kategori'),
                    enabled: false,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: selectedKategori.isNotEmpty ? Colors.black : Colors.grey, // Soluk renk
                    ),

                  ),
                ),
                SizedBox(width: 16.0),
                DropdownButton<String>(

                  items: <String>['Roman', 'Edebiyat', 'Şiir', 'Tarih','Ansiklopedi'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedKategori = value!;
                      kategoriController.text = selectedKategori;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: basimYiliController,
              decoration: InputDecoration(labelText: 'Basım Yılı'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            CheckboxListTile(
              title: Text('Listede Yayınlanacak mı?'),
              value: yayinlandi,
              onChanged: (value) {
                setState(() {
                  yayinlandi = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                KitapModel yeniKitap = KitapModel(
                  id: widget.model.id,
                  kitapAdi: kitapAdiController.text,
                  yazar: yazarController.text,
                  sayfaSayisi: sayfaSayisiController.text,
                  yayinevi: yayineviController.text,
                  kategori: kategoriController.text,
                  basimYili: int.tryParse(basimYiliController.text)!,
                  yayinlandi: yayinlandi,
                );

                await firebaseManager.updateData(yeniKitap);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyTabBar(),
                  ),
                );
              },
              child: Text('Kaydet'),
            ),

          ],
        ),
      ),
    );
  }
}
