import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'medicamento_provider.dart';

class ResumoPage extends StatelessWidget {
  const ResumoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<MedicamentoProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Resumo do Dia')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('${(p.progresso * 100).toStringAsFixed(0)}% concluído',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: 16),
            LinearProgressIndicator(value: p.progresso, minHeight: 12),
            const SizedBox(height: 32),
            _info(Icons.list, 'Total', p.total, Colors.blueGrey),
            _info(Icons.check_circle, 'Tomados', p.tomados, Colors.green),
            _info(Icons.schedule, 'Pendentes', p.pendentes, Colors.orange),
            const Spacer(),
            OutlinedButton.icon(
              onPressed: p.total == 0
                  ? null
                  : () => context.read<MedicamentoProvider>().reiniciarDia(),
              icon: const Icon(Icons.refresh),
              label: const Text('Reiniciar o dia'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(IconData icon, String label, int valor, Color cor) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: cor),
        title: Text(label),
        trailing: Text('$valor',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
