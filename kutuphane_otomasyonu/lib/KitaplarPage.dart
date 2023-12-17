import 'package:flutter/material.dart';
import 'package:kutuphane_otomasyonu/KitapModel.dart';
import 'FirebaseManager.dart';
import 'KitapEklePage.dart';

class KitaplarPage extends StatefulWidget {
  @override
  _KitaplarPageState createState() => _KitaplarPageState();
}

class _KitaplarPageState extends State<KitaplarPage> {
  final FirebaseManager firebaseManager = FirebaseManager();
  List<Map<String, dynamic>> kitapListesi = [];


  @override
  void initState() {
    super.initState();
    _verileriGetir();
  }

  Future<void> _verileriGetir() async {
    List<Map<String, dynamic>> veriler = await firebaseManager.getKitaplar();

    setState(() {
      kitapListesi = veriler;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false
      ),
      body: ListView.builder(
        itemCount: kitapListesi.length,
        itemBuilder: (context, index) {


          var model = KitapModel(
              id: kitapListesi[index]['id'] as String,
              kitapAdi: kitapListesi[index]['kitapAdi'] as String,
              yazar: kitapListesi[index]['yazar'] as String,
              sayfaSayisi: kitapListesi[index]['sayfaSayisi'] as String,
              yayinevi: kitapListesi[index]['yayinevi'] as String,
              kategori: kitapListesi[index]['kategori'] as String,
              basimYili: kitapListesi[index]['basimYili'] as int,
              yayinlandi: kitapListesi[index]['yayinlandi'] as bool);

          if (model.yayinlandi) {
            return Card(
              margin: EdgeInsets.all(5.0),
              child: ListTile(
                title: Text(model.kitapAdi),
                subtitle: Text('Yazar:${model.yazar}\nsayfa sayısı:${model.sayfaSayisi}'),

                leading: Icon(Icons.book),
                onTap: () {

                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KitapEklePage(
                              model: model,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _showAlertDialog(context,index,model);
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {

            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => KitapEklePage(
              model:  KitapModel(kitapAdi: "", yazar: "", sayfaSayisi: "", yayinevi: "", kategori: "", basimYili: 0, yayinlandi:true, id:null)
            )),
          );
        },
        child: Icon(Icons.add),
      ),
    );






  }

  void _showAlertDialog(BuildContext context,int index,KitapModel model ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Silme işlemi'),
          content: Text('Kitabı Silmek istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Alert dialogu kapat
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                firebaseManager.deleteData(model);
                kitapListesi.removeAt(index);

                setState(() {

                });
                Navigator.of(context).pop(); // Alert dialogu kapat
              },
              child: Text('Sil'),
            ),
          ],
        );
      },
    );
  }





}