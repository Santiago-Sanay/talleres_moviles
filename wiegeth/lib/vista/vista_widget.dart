import 'package:flutter/material.dart';
import 'package:wiegeth/vista/vista_inicio.dart';
import '../controlador/clima_controlador.dart';
import '../modelo/clima_modelo.dart';
import 'vista_widget.dart';

class VistaInicio extends StatefulWidget {
  @override
  _VistaInicioState createState() => _VistaInicioState();
}

class _VistaInicioState extends State<VistaInicio> {
  final TextEditingController _ciudadController = TextEditingController();
  final ClimaControlador _controlador = ClimaControlador();
  ClimaModelo? _clima;

  void _buscarClima() async {
    final ciudad = _ciudadController.text.trim();
    if (ciudad.isNotEmpty) {
      final clima = await _controlador.obtenerClima(ciudad);
      setState(() {
        _clima = clima;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, ingrese un nombre de ciudad.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Consulta de Clima',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _ciudadController,
              decoration: InputDecoration(
                labelText: 'Ingrese el nombre de la ciudad',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_city),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _buscarClima,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Ver Clima',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(height: 30),
            if (_clima != null)
              ClimaWidget(
                _clima!.ciudad,
                _clima!.temperatura,
                _clima!.descripcion,
              )
            else if (_clima == null && _ciudadController.text.isNotEmpty)
              Text(
                'No se encontraron datos para la ciudad ingresada.',
                //style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ciudadController.dispose();
    super.dispose();
  }
}