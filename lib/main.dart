import 'package:flutter/material.dart';
import 'package:myapp/telas/telaplaneta.dart';
import 'controles/controleplaneta.dart';
import 'modulos/planeta.dart';
import 'telas/detalhes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Planetas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'App Alerta Evasão'),
    );
  }
}

// Criação da classe da Tela Principal
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Criação de estado da classe da Tela Principal
class _MyHomePageState extends State<MyHomePage> {
  final ControlePlaneta _controlePlaneta = ControlePlaneta();
  List<Planeta> _planetas = [];

  @override
  void initState() {
    super.initState();
    _atualizarPlanetas();
  }

// Função para atualizar a lista de planetas
  Future<void> _atualizarPlanetas() async {
    final resultado = await _controlePlaneta.lerPlanetas();
    setState(() {
      _planetas = resultado;
    });
  }

// Função para inclusão de um novo planeta
  void _incluirPlaneta(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaPlaneta(
          isIncluir: true,
          planeta: Planeta.vazio(),
          onFinalizado: () {
            _atualizarPlanetas();
          },
        ),
      ),
    );
  }

// Função para alteração de um planeta
  void _alterarPlaneta(BuildContext context, Planeta planeta) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaPlaneta(
          isIncluir: false,
          planeta: planeta,
          onFinalizado: () {
            _atualizarPlanetas();
          },
        ),
      ),
    );
  }

// Função para excluir um planeta (com mini tela de confirmação)
  void _excluirPlaneta(int id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir Planeta'),
          content: const Text('Tem certeza que deseja excluir este planeta?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: ()  {
                Navigator.of(context).pop();
                _controlePlaneta.excluirPlaneta(id);
                _atualizarPlanetas();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Planeta excluído com sucesso!'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

// Função para abrir a tela de detalhes do planeta
  void _detalhes(id) {
    final planeta = _planetas.firstWhere((planeta) => planeta.id == id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaDeDetalhes(planeta: planeta),
      ),
    );
  }

// Construtor da Tela Principal
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Cadastro de Planetas'),
      ),
      body: ListView.builder(
        itemCount: _planetas.length,
        itemBuilder: (context, index) {
          final planeta = _planetas[index];
          return ListTile(
            title: Text(planeta.nome),
            subtitle: Text(planeta.apelido!),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.info),
                  onPressed: () => _detalhes(planeta.id as int),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _excluirPlaneta(planeta.id!),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _alterarPlaneta(context, planeta),
                ),
              ],
            ),
          );
        },
      ),
// Botão Flutuante de Inclusão
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incluirPlaneta(context);
        },
        tooltip: 'Increment',
        child: const Row(
            mainAxisSize: MainAxisSize.max,
            children: [(Icon(Icons.add)), (Icon(Icons.public))]),
      ),
    );
  }
}
