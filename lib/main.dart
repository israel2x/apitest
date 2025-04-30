import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: DatosClima(),
        ),
      ),
    );
  }
}

class DatosClima extends StatefulWidget {
  const DatosClima({super.key});

  @override
  State<DatosClima> createState() => _DatosClimaState();
}

class _DatosClimaState extends State<DatosClima> {
  String ciudad = "";
  String temp = "";
  String clima = "";
  List posts = [];

  void getClima() {
    setState(() {
      ciudad = "La Troncal";
      temp = "36 C";
      clima = "Nublado";
    });
  }

  Future<void> getDataAPI() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      posts = jsonDecode(response.body);
      print(posts);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Datos:"),
        Text("Ciudad:${ciudad}"),
        Text("Temperatura:${temp}"),
        Text("Clima:${clima}"),
        TextButton(
            onPressed: () {
              getClima();
              getDataAPI();
            },
            child: Text("Mostrar Clima"))
      ],
    );
  }
}
