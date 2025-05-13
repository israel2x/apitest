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
  double temp2 = 0;

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

  double convertirKaC(double dato) {
    return dato - 273.15;
  }

  Future<void> getDataClima() async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=-2.3348&lon=-79.395221&appid=1af6229b9e9cae6b78bca3cd9006f199");
    final response = await http.get(url);

    print(response);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));

      var data = jsonDecode(response.body);

      setState(() {
        ciudad = data['name'];
        temp2 = convertirKaC(data['main']['temp']);
      });

      print(ciudad);
      print(temp2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Datos:"),
        Text("Ciudad:${ciudad}"),
        Text("Temperatura:${temp2}"),
        Text("Clima:${clima}"),
        TextButton(
            onPressed: () {
              //getClima();
              //getDataAPI();
              getDataClima();
            },
            child: Text("Mostrar Clima"))
      ],
    );
  }
}
