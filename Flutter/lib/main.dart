import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController volumeController = TextEditingController();

  Future<void> submitData() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/penjualan'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "harga": int.parse(hargaController.text),
        "volume": int.parse(volumeController.text),
        "tanggal": DateTime.now().toIso8601String(),
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data berhasil disimpan!')));
    }
  }

  Future<void> predictData() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/predict'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "harga": int.parse(hargaController.text),
        "volume": int.parse(volumeController.text),
      }),
    );

    final result = jsonDecode(response.body);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Hasil Prediksi"),
          content: Text("Harga: ${result['predicted_harga']}\nVolume: ${result['predicted_volume']}"),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Input Penjualan")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: hargaController, decoration: InputDecoration(labelText: "Harga")),
            TextField(controller: volumeController, decoration: InputDecoration(labelText: "Volume")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: submitData, child: Text("Simpan")),
            ElevatedButton(onPressed: predictData, child: Text("Prediksi")),
          ],
        ),
      ),
    );
  }
}
