import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/pessoa.dart';

class ImcCalculator extends StatefulWidget {
  const ImcCalculator({super.key});

  @override
  State<ImcCalculator> createState() => _ImcCalculatorState();
}

class _ImcCalculatorState extends State<ImcCalculator> {
  final _decimalRegExp =
      RegExp(r'^\d+(\.\d{0,2})?$'); // Permite até 2 casas decimais
  TextEditingController idController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  List<Pessoa> pessoas = [];

  void calcularIMC() {
    String id = UniqueKey().toString();
    String nome = nomeController.text;
    double peso = double.tryParse(pesoController.text) ?? 0;
    double altura = double.tryParse(alturaController.text) ?? 0;

    if (nome.isNotEmpty && peso > 0 && altura > 0) {
      Pessoa pessoa = Pessoa(id: id, nome: nome, peso: peso, altura: altura);
      pessoas.add(pessoa);
      idController.clear();
      nomeController.clear();
      pesoController.clear();
      alturaController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                    isDense: true,
                    labelText: "Nome",
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    hintText: "Digite seu nome"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: pesoController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(_decimalRegExp)
                ],
                decoration: const InputDecoration(
                    isDense: true,
                    labelText: "Peso",
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    hintText: "Digite seu peso em Kg (Ex.: 82.5):"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: alturaController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(_decimalRegExp)
                ],
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: "Altura",
                  hintText: "Digite sua altura em metros (Ex.: 1.80):",
                  labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: calcularIMC,
              child: const Text('Calcular IMC'),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Histórico de IMC:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: pessoas.length,
                itemBuilder: (context, index) {
                  Pessoa pessoa = pessoas[index];
                  double imc = pessoa.calcularIMC();
                  // classificação imc
                  var classificacao = Pessoa.classificacao(imc);
                  return Card(
                    elevation: 10,
                    child: ListTile(
                      title: Text(
                        'Nome: ${pessoa.nome}\nPeso: ${pessoa.peso}\nAltura: ${pessoa.altura}\nIMC: ${imc.toStringAsFixed(2)}\nClassificação: $classificacao',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
