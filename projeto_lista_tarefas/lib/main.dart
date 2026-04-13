import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Tarefa {
  final String id;
  final String descricao;
  final bool concluida;

  Tarefa({required this.id, required this.descricao, this.concluida = false});

  Tarefa copyWith({bool? concluida}) {
    return Tarefa(
      id: id,
      descricao: descricao,
      concluida: concluida ?? this.concluida,
    );
  }
}


class ListaTarefasNotifier extends StateNotifier<List<Tarefa>> {
  ListaTarefasNotifier() : super([]);

  void adicionar(String desc) {
    if (desc.trim().isNotEmpty) {
      state = [...state, Tarefa(id: DateTime.now().toString(), descricao: desc)];
    }
  }

  void alternarStatus(String id) {
    state = [
      for (final t in state)
        if (t.id == id) t.copyWith(concluida: !t.concluida) else t,
    ];
  }

  void remover(String id) {
    state = state.where((t) => t.id != id).toList();
  }
}


final listaProvider = StateNotifierProvider<ListaTarefasNotifier, List<Tarefa>>((ref) {
  return ListaTarefasNotifier();
});


void main() => runApp(const ProviderScope(child: MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false)));

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todasTarefas = ref.watch(listaProvider);
    
    final pendentes = todasTarefas.where((t) => !t.concluida).toList();
    final finalizadas = todasTarefas.where((t) => t.concluida).toList();

    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Gestão de Tarefas'), backgroundColor: Colors.indigo, foregroundColor: Colors.white),
      body: Column(
        children: [
          _campoEntrada(ref, controller),
          Expanded(
            child: ListView(
              children: [
                _seccaoTitulo("Pendentes (${pendentes.length})", Colors.orange),
                _buildList(ref, pendentes),
                const Divider(),
                _seccaoTitulo("Finalizadas (${finalizadas.length})", Colors.green),
                _buildList(ref, finalizadas),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _campoEntrada(WidgetRef ref, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(child: TextField(controller: controller, decoration: const InputDecoration(hintText: "Nova tarefa..."))),
          IconButton(
            icon: const Icon(Icons.add_circle, color: Colors.indigo, size: 40),
            onPressed: () {
              ref.read(listaProvider.notifier).adicionar(controller.text);
              controller.clear();
            },
          ),
        ],
      ),
    );
  }

  Widget _seccaoTitulo(String titulo, Color cor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(titulo, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: cor)),
    );
  }

  Widget _buildList(WidgetRef ref, List<Tarefa> tarefas) {
    return ListView.builder(
      shrinkWrap: true, // Importante para ListView dentro de ListView
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tarefas.length,
      itemBuilder: (context, index) {
        final t = tarefas[index];
        return ListTile(
          leading: Checkbox(
            value: t.concluida,
            onChanged: (_) => ref.read(listaProvider.notifier).alternarStatus(t.id),
          ),
          title: Text(t.descricao, style: TextStyle(decoration: t.concluida ? TextDecoration.lineThrough : null)),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () => ref.read(listaProvider.notifier).remover(t.id),
          ),
        );
      },
    );
  }
}