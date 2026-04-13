import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ListaTarefas(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,

    );
  }
}

class ListaTarefas extends StatefulWidget {
  const ListaTarefas({super.key, required this.title});
  final String title;

  @override
  State<ListaTarefas> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ListaTarefas> {
  final List<String> _tarefas = [];
  final TextEditingController _controller = TextEditingController();

  void _adicionarTarefas(){
    if(_controller.text.isNotEmpty){
      setState((){
        _tarefas.add(_controller.text);
        _controller.clear();
      });
    }
  }

  void _removerTarefa(int index){
    setState((){
      _tarefas.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Minha Lista de Tarefas'), backgroundColor: Colors.blueAccent),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Digite uma nova tarefa...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.blueAccent),
                  onPressed: _adicionarTarefas,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tarefas[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => _removerTarefa(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}