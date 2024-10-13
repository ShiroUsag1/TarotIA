class CartaTarot {
  final String nome;
  final String descricao;
  final String imagemUrl;
  final String tipo;
  final String naipe;
  final String inversao;
  final int numero;
  final List<String> simbolismo;

  CartaTarot(
      {required this.nome,
      required this.descricao,
      required this.imagemUrl,
      required this.tipo,
      required this.naipe,
      required this.numero,
      required this.simbolismo,
      required this.inversao});

  factory CartaTarot.fromJson(Map<String, dynamic> json) {
    var simbolismoFromJson = json['simbolismo'] as List;
    List<String> simbolismoList =
        simbolismoFromJson.map((s) => s.toString()).toList();
    return CartaTarot(
        nome: json['nome'],
        descricao: json['descricao'],
        imagemUrl: json['imagem_url'],
        tipo: json['tipo'],
        naipe: json['naipe'],
        numero: json['numero'] ?? 0,
        simbolismo: simbolismoList,
        inversao: json['inversao']);
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'imagem_url': imagemUrl,
      'tipo': tipo,
      'naipe': naipe,
      'numero': numero,
      'simbolismo': simbolismo,
      'inversao': inversao
    };
  }
}
