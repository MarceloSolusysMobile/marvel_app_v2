// Importa a biblioteca para trabalhar com codificação e decodificação de JSON
import 'dart:convert';
// Importa a biblioteca http para fazer requisições HTTP
import 'package:http/http.dart' as http;
// Importa a classe Personagem do arquivo personagem.dart
import '../model/personagem.dart';

// Classe que lida com as chamadas à API dos personagens
class PersonagemApi {
  // Chaves de autenticação fornecidas pela Marvel API
  final String publicKey = '0ea28726a5bc45579f222022fccbc6dc';
  final String hash = '3b038adcc3be49ab173cc9c47713cad1';
  final String ts = '1';
  // URL base da API dos personagens da Marvel
  final String url = 'https://gateway.marvel.com/v1/public/characters?';

  // Método para obter a lista de personagens offline
  Future<List<Personagem>> getPersonagensOffline() async {
    // JSON simulando a resposta da API (offline)
    String jsonString = '''
    [
      {
          "id": 1,
          "name": "Homem de Ferro",
          "thumbnail": {
              "path": "http://i.annihil.us/u/prod/marvel/i/mg/6/70/4ce5a7383561c",
              "extension": "jpg"
          }
      },
      {
          "id": 2,
          "name": "Capitão América",
          "thumbnail": {
              "path": "http://i.annihil.us/u/prod/marvel/i/mg/6/70/4ce5a7383561c",
              "extension": "jpg"
          }
      },
      {
          "id": 3,
          "name": "Viúva Negra",
          "thumbnail": {
              "path": "http://i.annihil.us/u/prod/marvel/i/mg/6/70/4ce5a7383561c",
              "extension": "jpg"
          }
      }
    ]
    ''';
    // Decodifica o JSON simulado e converte em uma lista de Mapas
    //final mapsPersonagens = jsonDecode(jsonString);
    final mapsPersonagens = [
      {
        'id': 1,
        'name': 'Homem de Ferro',
        'thumbnail': {
          'path': 'http://i.annihil.us/u/prod/marvel/i/mg/6/70/4ce5a7383561c',
          'extension': 'jpg'
        }
      },
      {
        'id': 2,
        'name': 'Capitão América',
        'thumbnail': {
          'path': 'http://i.annihil.us/u/prod/marvel/i/mg/6/70/4ce5a7383561c',
          'extension': 'jpg'
        }
      },
      {
        'id': 3,
        'name': 'Viúva Negra',
        'thumbnail': {
          'path': 'http://i.annihil.us/u/prod/marvel/i/mg/6/70/4ce5a7383561c',
          'extension': 'jpg'
        }
      },
    ];

    // Lista para armazenar os objetos Personagem
    List<Personagem> listPersonagens = [];

    // Converte cada mapa de personagem em um objeto Personagem
    for (var map in mapsPersonagens) {
      // Cria um objeto Personagem usando o método fromJson
      Personagem personagem = Personagem.fromJson(map);

      // Atualiza o URL do avatar com parâmetros de autenticação
      personagem.avatar =
          '${personagem.avatar}?apikey=$publicKey&hash=$hash&ts=$ts';

      // Adiciona o personagem à lista
      listPersonagens.add(personagem);
    }

    // Simula um atraso de 1 segundo (apenas para fins didáticos)
    await Future.delayed(const Duration(seconds: 1));

    // Retorna a lista de personagens obtida (offline)
    return listPersonagens;
  }

  // Método para obter a lista de personagens da API online
  Future<List<Personagem>> getPersonagens() async {
    // Faz uma requisição HTTP GET à API
    final response =
        await http.get(Uri.parse('${url}apikey=$publicKey&hash=$hash&ts=$ts'));

    // Verifica se a requisição foi bem-sucedida (código de status 200)
    if (response.statusCode == 200) {
      // Decodifica o JSON da resposta e extrai a lista de personagens
      final json = jsonDecode(response.body)['data']['results'];
      final mapsPersonagens = json.cast<Map<String, dynamic>>();

      // Lista para armazenar os objetos Personagem
      List<Personagem> listPersonagens = [];

      // Converte cada mapa de personagem em um objeto Personagem
      for (var map in mapsPersonagens) {
        // Cria um objeto Personagem usando o método fromJson
        Personagem personagem = Personagem.fromJson(map);

        // Atualiza o URL do avatar com parâmetros de autenticação
        personagem.avatar =
            '${personagem.avatar}?apikey=$publicKey&hash=$hash&ts=$ts';

        // Adiciona o personagem à lista
        listPersonagens.add(personagem);
      }

      // Retorna a lista de personagens obtida da API
      return listPersonagens;
    } else {
      // Caso a requisição não seja bem-sucedida, lança uma exceção
      throw Exception('Falha ao obter informações da API');
    }
  }
}
