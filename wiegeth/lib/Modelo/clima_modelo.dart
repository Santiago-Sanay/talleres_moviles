class ClimaModelo {
  final String ciudad;
  final double temperatura;
  final String descripcion;

  ClimaModelo({
    required this.ciudad,
    required this.temperatura,
    required this.descripcion,
  });

  factory ClimaModelo.fromJson(Map<String, dynamic> json) {
    return ClimaModelo(
      ciudad: json['name'] ?? 'Desconocida',
      temperatura: (json['main']['temp'] as num?)?.toDouble() ?? 0.0,
      descripcion: json['weather'] != null && (json['weather'] as List).isNotEmpty
          ? json['weather'][0]['description'] ?? 'Sin descripción'
          : 'Sin descripción',
    );
  }
}