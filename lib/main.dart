
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  String search_image;
  String styleid;
  String brands_filter_facet;
  String price;
  String product_additional;
  Product({
    required this.search_image,
    required this.styleid,
    required this.brands_filter_facet,
    required this.price,
    required this.product_additional,
  } );
}

//Khai bao screen
class ProductListScreen extends StatefulWidget{
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}
//dinh nghia
class _ProductListScreenState extends State<ProductListScreen>{
  
  late List<Product> products;
  //khoi tao trang thai
  @override
  void initState(){
    super.initState();
    products = [];
    fetchProducts(); //ham lay toan bo san pham tu server
  }

  //doc du lieu tu server
  List<Product> convertMapToList(Map<String, dynamic> data){
    List<Product> productList = [];
    data.forEach((key, value){
      for (int i = 0; i < value.length; i++){
        Product product = Product(
          search_image: value[i]['search_image'] ?? '', 
          styleid: value[i]['styleid'] ?? 0, 
          brands_filter_facet: value[i]["brands_filter_facet"] ?? '', 
          price: value[i]['price'] ?? 0, 
          product_additional: value[i]['product_additional'] ?? '');
        productList.add(product);
      }
    });
    return productList;
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse("http://192.168.1.44/aflutter/api.php"));
    if(response.statusCode == 200){
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        products = convertMapToList(data);

      });
    }
    else {
      throw Exception("khong co du lieu");
    }
  }

  //layout hien thi du lieu


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("danh sach san pham"),
      ),
      // ignore: unnecessary_null_comparison
      body: products != null ? 
      ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(products[index].brands_filter_facet),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Price: ${products[index].price}"),

              ],
            ),
            leading: Image.network(
              products[index].search_image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            // them su kien
            onTap:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => 
                ProductDetailScreen(products[index])),
              );
            },
          );
        }
      ) : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget{
  final Product product;
  ProductDetailScreen(this.product);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Product Detail'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: 
            EdgeInsets.all(0.0)),
            Image.network(product.search_image),
            Padding(
              padding: EdgeInsets.all(0.0),
              child: Text('Styleid:  ${product.styleid}'),
              ),
            Padding(
              padding: EdgeInsets.all(0.0),
              child: Text('brands filter dacet:  ${product.brands_filter_facet}'),
              ),  
          ],
        ),
      );
  }}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Danh sach san pham",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(), 
      // ProductListScreen(), 
    );
  }
}

//dinh nghia homeScreen
class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("home screen"),
      ),
      body: Center(
        //dinh nghia button de khi click thi goi listScreen
        child: ElevatedButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductListScreen())
              );
          },
          child: Text("Go to list screen"),
        ),
      ),
    );
  }
}

void main (){
  runApp(const MyApp());
}