import 'package:flutter/material.dart';

class MyInheritWidget extends InheritedWidget {
  final int data;
//ham khoi tao 
  MyInheritWidget({required this.data, required Widget child}) : super(child: child);
//ham update (kiem tra xem co can update khong) 
  @override
  bool updateShouldNotify(MyInheritWidget oldWidget) {
    return oldWidget.data != data;
    }

//dinh nghia phuong thuc lay du lieu tu context 
static MyInheritWidget? of(BuildContext context) {
  return context.dependOnInheritedWidgetOfExactType<MyInheritWidget>();
  }
}

//dinh nghia widget con su dung MyInheritWidget
class  MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  //su dung inheritwidget 
  final data = MyInheritWidget.of(context)!.data;
  return Text('Du lieu tu Cha truyen xuong: $data');
  }
}

//Dinh nghia widget chua MyInheritWidget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyInheritWidget(
      data: 40, 
      child: MyWidget(),
      ),
    );
  }
}

//chay chuong trinh
void main() => runApp(MyApp());