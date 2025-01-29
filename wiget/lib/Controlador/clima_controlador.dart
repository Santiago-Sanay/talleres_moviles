import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modelo/clima_modelo.dart';

class ClimaControlador {
  final String apikey = '29b1f10e981dbdc64b85587b0b7617a8';
  final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<ClimaModelo?> obtenerClima(String ciudad) async {
    final url = Uri.parse('$apiUrl?q=$ciudad&units=metric&appid=$apikey&lang=es');
    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        final json = jsonDecode(respuesta.body);
        return ClimaModelo.fromJson(json);
      } else {
        print('Error: ${respuesta.statusCode} - ${respuesta.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Error de conexión: $e');
      return null;
    }
  }
}