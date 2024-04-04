import 'package:flutter/material.dart';

//b1- tao 1 lop ke thua tu InheritWigdet
class MyInheritWidget1 extends InheritedWidget {
  final int data;
  //ham khoi tao 
  MyInheritWidget1({required this.data, required Widget child}) : super(child: child);
  //ham cap nhat khi du lieu thay doi 
  @override
  bool updateShouldNotify(MyInheritWidget1 oldWidget) {
    return oldWidget.data != data;
    }

//b2- tao 1 phuong thuc lay du lieu tu MyInheritWidget1 
static MyInheritWidget1? of(BuildContext context) {
  return context.dependOnInheritedWidgetOfExactType<MyInheritWidget1>();
  }
}

//b3- su dung inherit widget o cap do cao nhat
void main() => runApp(
  MyInheritWidget1(
    data: 50,
    child: MyApp(),
  ),
);

//dinh nghia MyWidget
class MyWidget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  //b5- su dung MyInheritWidget1 de lay du lieu 
    final data = MyInheritWidget1.of(context)!.data;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Du lieu truyen tu cha: $data'),
        SizedBox(
          height: 30,
        ),
        MyChildWidget1(),
      ],
    );
  }
}

//Dinh nghia MyChildWidget1
class MyChildWidget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  //b6- lay du lieu 
    final data = MyInheritWidget1.of(context)!.data;
    return Text('Du lieu tu lop cao nhat: $data');
  }
}

//b7- chay dung dung
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Vi du ve truyen du lieu'),
        ),
        body: MyWidget1(),
      ),
    );
  }
}