class Carta:
    def __init__(self, nome, descricao, imagemUrl, tipo, naipe, numero, simbolismo, inversao):
        self.nome = nome
        self.descricao = descricao
        self.imagemUrl = imagemUrl
        self.tipo = tipo
        self.naipe = naipe
        self.numero = numero
        self.simbolismo = simbolismo
        self.inversao = inversao

    def to_dict(self):
        return {
            'nome': self.nome,
            'descricao': self.descricao,
            'imagemUrl': self.imagemUrl,
            'tipo': self.tipo,
            'naipe': self.naipe,
            'numero': self.numero,
            'simbolismo': self.simbolismo,
            'inversao': self.inversao
        }
