import 'package:flutter/material.dart';
import 'package:product/screens/home_screen.dart';

import '../services/product_services.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _codecontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: _codecontroller,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan Kode Product',
                        ),
                      ),
                  ),
                ],
              ),
          ),
          Padding(
              padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                    controller: _namecontroller,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Nama Product',
                    ),
                  ),
              ),
            ],
          ),
          ),
          const SizedBox(height: 1),
          Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: FloatingActionButton(
                onPressed: (){
                  _productService.addProductItem(
                    _codecontroller.text,_namecontroller.text,context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> HomeScreen()),
                  );
                },
                child: const Icon(Icons.add),
                backgroundColor: Colors.blueGrey,
                elevation: 5,
                splashColor: Colors.purple,
              ),
          ),
        ],
      ),
    );
  }
}
