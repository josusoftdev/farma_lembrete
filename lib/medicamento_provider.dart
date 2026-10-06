import 'package:flutter/material.dart';
import 'medicamento.dart';

class MedicamentoProvider extends ChangeNotifier {
  final List<Medicamento> _medicamentos = [];

  List<Medicamento> get medicamentos => List.unmodifiable(_medicamentos);
  int get total => _medicamentos.length;
  int get tomados => _medicamentos.where((m) => m.tomado).length;
  int get pendentes => total - tomados;
  double get progresso => total == 0 ? 0 : tomados / total;

  void adicionar(String nome, String dose, TimeOfDay horario) {
    _medicamentos.add(Medicamento(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      nome: nome,
      dose: dose,
      horario: horario,
    ));
    _medicamentos.sort((a, b) => (a.horario.hour * 60 + a.horario.minute)
        .compareTo(b.horario.hour * 60 + b.horario.minute));
    notifyListeners();
  }

  void alternarTomado(String id) {
    final m = _medicamentos.firstWhere((m) => m.id == id);
    m.tomado = !m.tomado;
    notifyListeners();
  }

  void remover(String id) {
    _medicamentos.removeWhere((m) => m.id == id);
    notifyListeners();
  }

  void reiniciarDia() {
    for (final m in _medicamentos) {
      m.tomado = false;
    }
    notifyListeners();
  }
}
