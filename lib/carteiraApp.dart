import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Carteira Warren',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: OcultarValores(),
    );
  }
}

class OcultarValores extends StatefulWidget {
  OcultarValores({Key? key}) : super(key: key);

  @override
  State<OcultarValores> createState() => MyHomePage();
}

class MyHomePage extends State<OcultarValores> {
  Widget listagemCrypto(
      String title, subtitle, trailing, double variacao, icon) {
    corVariacao() {
      if (variacao > 0)
        return true;
      else {
        return false;
      }
    }

    return ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Column(children: [
          Text(trailing),
          Text(
            variacao.toString() + '%',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: corVariacao() ? Colors.green : Colors.red,
              backgroundColor:
                  corVariacao() ? Colors.green[50] : Colors.red[50],
            ),
          ),
        ]));
  }

  String carteiras = 'Carteiras';
  String valor = 'R\$ 1.000,00';
  String rendimento = '+R\$ 100,00';
  String cdi = '(100% do CDI)';
  String valEth = 'R\$0,00';
  String valBtc = 'R\$1.000,00';
  String valLtc = 'R\$0,00';
  double variacao1 = 75;
  double variacao2 = 75;
  double variacao3 = -0.7;
  String esconderValores = '         ';
  bool alterarValor = true;

  String funcaoEsconderValor() {
    if (alterarValor == true) {
      return valor;
    } else {
      return esconderValores;
    }
  }

  String funcaoEsconderRendimento() {
    if (alterarValor == true) {
      return rendimento;
    } else {
      return esconderValores;
    }
  }

  String funcaoEsconderCdi() {
    if (alterarValor == true) {
      return cdi;
    } else {
      return esconderValores;
    }
  }

  String funcaoEsconderEthLtc() {
    if (alterarValor == true) {
      return valEth;
    } else {
      return esconderValores;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.wallet_travel), label: "Carteiras"),
            BottomNavigationBarItem(
                icon: Icon(Icons.tune), label: "Movimentações"),
          ],
        ),
        body: Column(children: <Widget>[
          const SizedBox(height: 0),
          ListTile(trailing: SizedBox(width: 10)),
          Row(children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 140, 1),
                child: Text(
                  carteiras,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  alterarValor = !alterarValor;
                  setState(() {
                    funcaoEsconderValor();
                  });
                },
                icon: const Icon(Icons.remove_red_eye)),
          ]),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(50, 0.5, 0, 2),
              child: Text(
                funcaoEsconderValor(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 50,
              ),
              Text(
                funcaoEsconderRendimento(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                funcaoEsconderCdi(),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Column(children: <Widget>[
            const SizedBox(
              height: 15,
            ),
            listagemCrypto('ETH', 'Ethereum', funcaoEsconderEthLtc(), variacao1,
                Icons.attach_money),
            listagemCrypto('BTC', 'Bitcoin', funcaoEsconderValor(), variacao2,
                Icons.money),
            listagemCrypto('LTC', 'Litecoin', funcaoEsconderEthLtc(), variacao3,
                Icons.analytics),
          ])
        ]));
  }
}
