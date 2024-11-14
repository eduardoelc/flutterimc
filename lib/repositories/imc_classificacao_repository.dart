class ImcClassificacaoRepository {
  List<List<String>> informeClassificacao() {
    return [
      ["Menos de 16,99", "Muito abaixo do peso"],
      ["Entre 17 e 18,44", "Magreza leve"],
      ["Entre 18,5 e 24,99", "Peso normal"],
      ["Entre 25 e 29,99", "Acima do peso"],
      ["Entre 30 e 34,99", "Obesidade I"],
      ["Entre 35 e 39,99", "Obesidade II (severa)"],
      ["Acima de 40", "Obesidade III (mórbida)"]
    ];
  }

  String obterClassificacao(double imc) {
    var classificacoes = informeClassificacao();

    // Verifica em qual faixa o IMC se encaixa
    for (var faixa in classificacoes) {
      var intervalo = faixa[0];
      var descricao = faixa[1];

      // Verificar se o intervalo contém a palavra "Menos" ou "Acima"
      if (intervalo.contains("Menos")) {
        double limite =
            double.parse(intervalo.split(' ')[2].replaceAll(",", "."));
        if (imc < limite) return descricao;
      } else if (intervalo.contains("Acima")) {
        double limite =
            double.parse(intervalo.split(' ')[2].replaceAll(",", "."));
        if (imc >= limite) return descricao;
      } else {
        // Caso o intervalo esteja no formato "de x até y"
        var limites = intervalo
            .replaceAll("Entre", "")
            .replaceAll("e", "-")
            .split("-")
            .map((limite) => double.parse(limite.replaceAll(",", ".")))
            .toList();
        if (imc >= limites[0] && imc <= limites[1]) return descricao;
      }
    }

    // Caso nenhum intervalo seja encontrado, retornamos uma classificação padrão
    return "Classificação não encontrada";
  }
}
