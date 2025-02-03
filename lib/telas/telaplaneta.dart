import 'package:flutter/material.dart';
import '../controles/controleplaneta.dart';
import '../modulos/planeta.dart';

class TelaPlaneta extends StatefulWidget {
  final Function() onFinalizado;
  const TelaPlaneta({
    super.key,
    required this.onFinalizado,
  });

  @override
  State<TelaPlaneta> createState() => _TelaPlanetaState();
}

class _TelaPlanetaState extends State<TelaPlaneta> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nameController2 = TextEditingController();

  final ControlePlaneta _controlePlaneta = ControlePlaneta();
  final Planeta _planeta = Planeta.vazio();

  @override
  void initState() {
    _nameController.text = '1';
    _nameController2.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameController2.dispose();
    super.dispose();
  }

  Future<void> _inserirPlaneta() async {
    await _controlePlaneta.inserirPlaneta(_planeta);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _inserirPlaneta();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Planeta cadastrado com sucesso!'),
        ),
      );
      Navigator.of(context).pop();
      widget.onFinalizado();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cadastrar Planeta'),
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 20,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    labelText: 'Nome',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo Nome deve ser preenchido.';
                    }
                    if (value.length < 3) {
                      return 'É necessário pelo menos 3 caracteres.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _planeta.nome = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    labelText: 'Tamanho(Km)',
                  ),
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo Tamanho deve ser preenchido.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Tamanho inválido. Insira um valor válido.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _planeta.tamanho = double.parse(value!);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    labelText: 'Distância(Km)',
                  ),
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo Distância deve ser preenchido.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Distância inválida. Insira um valor válido.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _planeta.distancia = double.parse(value!);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    labelText: 'Apelido(opcional)',
                  ),
                  onSaved: (value) {
                    _planeta.apelido = value;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Salvar'),
                      SizedBox(width: 8),
                      Icon(Icons.check_circle),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
