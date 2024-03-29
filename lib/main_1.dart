import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyCalculator(),
    );
  }
}
class MyCalculator extends StatefulWidget{
  @override
  _MyCalculatorState createState() {
    return _MyCalculatorState();
  }
}
//lop quan ly trang thai cua man hinh chinh
class _MyCalculatorState extends State<MyCalculator>{
  TextEditingController num1Control=TextEditingController();//text1
  TextEditingController num2Control=TextEditingController();//text2
  //bien luu ket qua tinh toan
  String kq='';
  //ham tinh tong va cap nhat trang thai
  void calculatorSum(){
    //lay gia tri tu 2 o nhap lieu
    double num1=double.tryParse(num1Control.text) ?? 0.0;
    double num2=double.tryParse(num2Control.text) ?? 0.0;
    double num=num1+num2;
    //cap nhat trang thai
    setState(() {
      kq= 'Tong: $num';
    });
  }
  //giao dien cua activity
  @override
  Widget build(BuildContext context) {
    return Scaffold(//tra ve 1 man hinh
      appBar: AppBar(
        title: Text('Ung dung tinh tong'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //thanh phan chinh - text1
            TextField(
              controller: num1Control,//gan voi so1
              keyboardType: TextInputType.number,//chi cho nhap so
              decoration: InputDecoration(labelText: 'Nhap so 1'),//hint
            ),
            SizedBox(height: 10.0),//khoang cach
            //thanh phan chinh - text2
            TextField(
              controller: num2Control,//gan voi so1
              keyboardType: TextInputType.number,//chi cho nhap so
              decoration: InputDecoration(labelText: 'Nhap so 2'),//hint
            ),
            SizedBox(height: 20.0),//khoang cach
            //thanh phan chinh - Button click
            ElevatedButton(onPressed: calculatorSum, child: Text('Tinh tong')),
            SizedBox(height: 20.0),//khoang cach
            //thanh phan chinh - Hien thi ket qua
            Text(
              kq,
              style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

}

