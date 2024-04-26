import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductService{
  final DatabaseReference _database =
  FirebaseDatabase.instance.ref().child('product_list');

  Stream<Map<String, String>> getProductList(){
    return _database.onValue.map((event) {
      final Map<String, String> items = {};
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null){
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          items[key]=
              'Kode\t\t:${value['kode']} \nNama\t\t:${value['nama']}';
        });
      }
      return items;
    });
  }
  void addProductItem(String code, name, BuildContext context){
    if (code.isEmpty || name.isEmpty){
      const warning = SnackBar(content: Text('Data harus diisi'));
      ScaffoldMessenger.of(context).showSnackBar(warning);
    }else{
      _database.push().set({'kode':code,'nama':name});
    }
  }
  Future<void> removeProductItem(String key) async{
    await _database.child(key).remove();
  }
}