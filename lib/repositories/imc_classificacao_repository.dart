class ImcClassificacaoRepository {
  List<List<String>> informeClassificacao() {
    return [
      ["Menos de 16,99", "Muito abaixo do peso"],
      ["entre 17 e 18,44", "Magreza leve"],
      ["Entre 18,5 e 24,99", "Peso normal"],
      ["Entre 25 e 29,99", "Acima do peso"],
      ["Entre 30 e 34,99", "Obesidade I"],
      ["Entre 35 e 39,99", "Obesidade II (severa)"],
      ["Acima de 40", "Obesidade III (mórbida)"]
    ];
  }
}
