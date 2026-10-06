import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cadastro_page.dart';
import 'medicamento_provider.dart';
import 'resumo_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Medicamentos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: 'Resumo do dia',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ResumoPage()),
            ),
          ),
        ],
      ),
      body: Consumer<MedicamentoProvider>(
        builder: (context, provider, _) {
          if (provider.medicamentos.isEmpty) {
            return const Center(
              child: Text('Nenhum medicamento cadastrado.\nToque no + para adicionar.',
                  textAlign: TextAlign.center),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: provider.medicamentos.length,
            itemBuilder: (context, i) {
              final m = provider.medicamentos[i];
              return Dismissible(
                key: ValueKey(m.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) => context.read<MedicamentoProvider>().remover(m.id),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.medication,
                        color: m.tomado ? Colors.green : Colors.teal),
                    title: Text(
                      m.nome,
                      style: TextStyle(
                        decoration: m.tomado ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text('${m.dose} • ${m.horario.format(context)}'),
                    trailing: Checkbox(
                      value: m.tomado,
                      onChanged: (_) =>
                          context.read<MedicamentoProvider>().alternarTomado(m.id),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CadastroPage()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
