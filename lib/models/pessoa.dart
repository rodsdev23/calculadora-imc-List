import 'package:flutter/material.dart';

class Pessoa {
  late String id = UniqueKey().toString();
  final String nome;
  final double peso;
  final double altura;

  Pessoa(
      {required this.id,
      required this.nome,
      required this.peso,
      required this.altura});

  double calcularIMC() {
    return peso / (altura * altura);
  }

  static classificacao(double imc) {
    String classificacao = "";
    if (imc < 16) {
      classificacao = 'Magreza grave';
    } else if (imc < 17) {
      classificacao = 'Magreza moderada';
    } else if (imc < 18.5) {
      classificacao = 'Magreza leve';
    } else if (imc < 25) {
      classificacao = 'Saudável';
    } else if (imc < 30) {
      classificacao = 'Sobrepeso';
    } else if (imc < 35) {
      classificacao = 'Obesidade – GRAU I';
    } else if (imc < 40) {
      classificacao = 'Obesidade – GRAU II | Severa';
    } else if (imc > 40) {
      classificacao = 'Obesidade – GRAU III | Mórbida';
    } else {
      return "Não classificado.";
    }
    return classificacao;
  }
}
