class Personagem {
  int id;          // ID do personagem
  String name;     // Nome do personagem
  String avatar;   // URL do avatar do personagem
  
  // Construtor da classe Personagem
  Personagem({
    this.id = 0,
    this.name = '',
    this.avatar = '',
  });

  // Fábrica para criar um objeto Personagem a partir de um mapa JSON
  factory Personagem.fromJson(Map<String, dynamic> json) {
    return Personagem(
      id: json['id'],   // Define o ID a partir do campo 'id' no JSON
      name: json['name'],   // Define o nome a partir do campo 'name' no JSON
      avatar: '${json['thumbnail']['path']}.${json['thumbnail']['extension']}',
      // Combina 'path' e 'extension' para criar a URL completa do avatar a partir dos campos 'thumbnail' no JSON
    );
  }
}
