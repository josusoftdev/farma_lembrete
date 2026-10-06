import 'package:flutter/material.dart';

class Medicamento {
  final String id;
  final String nome;
  final String dose;
  final TimeOfDay horario;
  bool tomado;

  Medicamento({
    required this.id,
    required this.nome,
    required this.dose,
    required this.horario,
    this.tomado = false,
  });
}
