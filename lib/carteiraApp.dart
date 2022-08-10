import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: TelaInicialWidget(),
    );
  }
}

class TelaInicialWidget extends StatefulWidget {
  TelaInicialWidget({Key? key}) : super(key: key);

  @override
  State<TelaInicialWidget> createState() => TelaInicialState();
}

class TelaInicialState extends State<TelaInicialWidget> {
  String carteira = 'Carteira';
  String valorCarteira = 'R\$ 1.000,00';
  String rendimento = '+R\$ 100,00';
  String cdi = '(100% do CDI)';
  String valEthLtc = 'R\$0,00';
  String valBtc = 'R\$1.000,00';
  double variacao1 = 75;
  double variacao2 = 75;
  double variacao3 = -0.7;
  String valorOculto = '         ';
  bool alterarValorCarteira = true;

  Widget listagemCrypto(
      String title, subtitle, trailing, double variacao, icon) {
    mudarCorVariacao() {
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
              color: mudarCorVariacao() ? Colors.green : Colors.red,
              backgroundColor:
                  mudarCorVariacao() ? Colors.green[50] : Colors.red[50],
            ),
          ),
        ]));
  }

  String esconderValor() {
    if (alterarValorCarteira == true) {
      return valorCarteira;
    } else {
      return valorOculto;
    }
  }

  String esconderRendimento() {
    if (alterarValorCarteira == true) {
      return rendimento;
    } else {
      return valorOculto;
    }
  }

  String esconderCDI() {
    if (alterarValorCarteira == true) {
      return cdi;
    } else {
      return valorOculto;
    }
  }

  String esconderEthLtc() {
    if (alterarValorCarteira == true) {
      return valEthLtc;
    } else {
      return valorOculto;
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
                  carteira,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  alterarValorCarteira = !alterarValorCarteira;
                  setState(() {
                    esconderValor();
                  });
                },
                icon: const Icon(Icons.remove_red_eye)),
          ]),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(50, 0.5, 0, 2),
              child: Text(
                esconderValor(),
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
                esconderRendimento(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                esconderCDI(),
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
            listagemCrypto('ETH', 'Ethereum', esconderEthLtc(), variacao1,
                Icons.attach_money),
            listagemCrypto('BTC', 'Bitcoin', esconderValor(), variacao2,
                Icons.money),
            listagemCrypto('LTC', 'Litecoin', esconderEthLtc(), variacao3,
                Icons.analytics),
          ])
        ]));
  }
}
