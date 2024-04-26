import 'package:flutter/material.dart';
import 'package:product/screens/add_product_screen.dart';
import 'package:product/services/product_services.dart';

class HomeScreen extends StatelessWidget {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          const SizedBox(height: 1),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                right: 15.0
              ),
              child: FloatingActionButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>const ProductListScreen()),
                  );
                },
                child: const Icon(Icons.add),
                backgroundColor: Colors.blueGrey,
                elevation: 5,
                splashColor: Colors.purple,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<Map<String, String>>(
                stream: _productService.getProductList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData){
                    Map<String, String> items = snapshot.data!;
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        final key = items.keys.elementAt(index);
                        final item = items[key];
                        return ListTile(
                          title: Text(item!),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: (){
                              _productService.removeProductItem(key);
                            },
                          ),
                        );
                      },
                    );
                  }else if (snapshot.hasError){
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }else{
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
          ),
        ],
      ),
    );
  }
}
