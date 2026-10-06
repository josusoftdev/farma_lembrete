import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'medicamento_provider.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _doseCtrl = TextEditingController();
  TimeOfDay _horario = const TimeOfDay(hour: 8, minute: 0);

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _doseCtrl.dispose();
    super.dispose();
  }

  Future<void> _escolherHorario() async {
    final h = await showTimePicker(context: context, initialTime: _horario);
    if (h != null) setState(() => _horario = h);
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;
    context.read<MedicamentoProvider>().adicionar(
          _nomeCtrl.text.trim(),
          _doseCtrl.text.trim(),
          _horario,
        );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Medicamento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeCtrl,
                decoration: const InputDecoration(
                    labelText: 'Nome do medicamento', border: OutlineInputBorder()),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _doseCtrl,
                decoration: const InputDecoration(
                    labelText: 'Dose (ex: 1 comprimido)',
                    border: OutlineInputBorder()),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Informe a dose' : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                leading: const Icon(Icons.access_time),
                title: Text('Horário: ${_horario.format(context)}'),
                onTap: _escolherHorario,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _salvar,
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
