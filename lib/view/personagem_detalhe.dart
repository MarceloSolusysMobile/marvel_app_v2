import 'package:flutter/material.dart';
import '../model/personagem.dart';

class DetalhesPersonagem extends StatefulWidget {
  final Personagem personagem;

  // Construtor que recebe o objeto Personagem como argumento
  const DetalhesPersonagem({super.key, required this.personagem});

  @override
  State<DetalhesPersonagem> createState() => _DetalhesPersonagemState();
}

class _DetalhesPersonagemState extends State<DetalhesPersonagem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Personagem ${widget.personagem.name}'),
      ),
      body: Column(
        children: [
          Card(
            child: Column(
              children: [
                Image.network(
                  widget.personagem.avatar,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.personagem.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
