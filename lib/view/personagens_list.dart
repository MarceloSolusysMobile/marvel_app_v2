import 'package:flutter/material.dart';
import 'package:marvel_app_v2/view/personagem_detalhe.dart';
import '../http/personagem_api.dart';
import '../model/personagem.dart';

class PersonagensList extends StatefulWidget {
  const PersonagensList({super.key});
  @override
  State<PersonagensList> createState() => _PersonagensListState();
}

class _PersonagensListState extends State<PersonagensList> {
  List<Personagem> personagensList = [];

  // Método para obter a lista de personagens da API
  getPersonagens() async {
    PersonagemApi api = PersonagemApi();
    final personagens = await api.getPersonagens();
    setState(() {
      personagensList = personagens;
    });
  }

  // Função para navegar para a tela de detalhes do personagem
  navegarDetalhesPersonagem(Personagem personagem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalhesPersonagem(
          personagem: personagem,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Chama o método para obter a lista de personagens
    getPersonagens();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Listagem de Personagens'),
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: personagensList.length,
          itemBuilder: (context, index) {
            Personagem personagem = personagensList[index];
            return Card(
              child: Column(
                children: [
                  Image.network(
                    personagem.avatar,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () {
                          // Chama a função para navegar para a tela de detalhes
                          navegarDetalhesPersonagem(personagem);
                        },
                        child: Text(
                          personagem.name,
                          style: const TextStyle(fontSize: 16),
                        )),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
