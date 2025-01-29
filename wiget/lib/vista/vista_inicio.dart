import 'package:flutter/material.dart';

class ClimaWidget extends StatelessWidget {
  final String ciudad;
  final double temperatura;
  final String descripcion;

  ClimaWidget(this.ciudad, this.temperatura, this.descripcion);

  IconData _obtenerIconoClima(String descripcion) {
    if (descripcion.contains("cloud")) {
      return Icons.cloud;
    } else if (descripcion.contains("rain")) {
      return Icons.umbrella;
    } else if (descripcion.contains("sun") || descripcion.contains("clear")) {
      return Icons.wb_sunny;  // Sol
    } else {
      return Icons.help_outline;  // Icono de ayuda en caso de error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 320,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade400, Colors.orange.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ciudad,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 15),
            Icon(
              _obtenerIconoClima(descripcion.toLowerCase()),
              size: 60,
              color: Colors.yellow.shade700,  // Color amarillo para el sol
            ),
            SizedBox(height: 20),
            Text(
              '${temperatura.toStringAsFixed(1)}°C',  // Mostrar con un decimal
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 15),
            Text(
              descripcion,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}