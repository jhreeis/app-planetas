import 'package:flutter/material.dart';
import 'package:myapp/modulos/planeta.dart';

class TelaDeDetalhes extends StatelessWidget {
  final Planeta planeta;

  const TelaDeDetalhes({super.key, required this.planeta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes de ${planeta.nome}:'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDetailRow('Nome', planeta.nome),
            _buildDetailRow('Tamanho', '${planeta.tamanho} km'),
            _buildDetailRow('Distância', '${planeta.distancia} km'),
            _buildDetailRow('Apelido', '${planeta.apelido}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Voltar'),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_back),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
