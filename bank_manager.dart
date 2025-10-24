import 'package:flutter/material.dart';
import 'dart:math';

class BankManager {
  double initialBank = 100.0;
  double stakePercent = 2.0;
  double currentBalance = 100.0;
  List<String> projection = [];
  List<String> history = [];

  void registerResult(bool won) {
    final stake = currentBalance * (stakePercent / 100.0);
    if (won) {
      currentBalance += stake * (1.9 - 1.0);
      history.add('GREEN: +R\$ \${(stake * (1.9 - 1.0)).toStringAsFixed(2)} -> saldo R\$ \${currentBalance.toStringAsFixed(2)}');
    } else {
      currentBalance -= stake;
      history.add('RED: -R\$ \${stake.toStringAsFixed(2)} -> saldo R\$ \${currentBalance.toStringAsFixed(2)}');
    }
  }

  void generateAutomaticProjection(int days) {
    projection.clear();
    double balance = initialBank;
    Random rnd = Random();
    for (int d = 1; d <= days; d++) {
      int picks = 7;
      for (int i = 0; i < picks; i++) {
        double stake = balance * (stakePercent / 100.0);
        bool win = rnd.nextBool();
        double odd = 1.9;
        balance += win ? stake * (odd - 1) : -stake;
      }
      projection.add('Dia \$d: R\$ ' + balance.toStringAsFixed(2));
    }
    currentBalance = balance;
    history.add('Projeção automática para \$days dias -> saldo R\$ ' + balance.toStringAsFixed(2));
  }
}

class BankTab extends StatefulWidget {
  final BankManager bank;
  BankTab({required this.bank});
  @override _BankTabState createState() => _BankTabState();
}

class _BankTabState extends State<BankTab> {
  @override
  void initState() {
    super.initState();
    widget.bank.generateAutomaticProjection(7);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          ElevatedButton(onPressed: () {
            setState(() {
              widget.bank.generateAutomaticProjection(7);
            });
          }, child: Text('Atualizar projeção automática')),
          SizedBox(height: 12),
          Expanded(child: ListView(children: widget.bank.projection.map((p) => Text(p)).toList())),
          SizedBox(height: 8),
          Text('Saldo atual: R\$ ' + widget.bank.currentBalance.toStringAsFixed(2)),
          SizedBox(height: 8),
          Text('Histórico: '),
          Expanded(child: ListView(children: widget.bank.history.map((h) => Text(h)).toList())),
          Row(children: [
            ElevatedButton(onPressed: () { setState(() { widget.bank.registerResult(true); }); }, child: Text('Registrar GREEN')),
            SizedBox(width: 8),
            ElevatedButton(onPressed: () { setState(() { widget.bank.registerResult(false); }); }, child: Text('Registrar RED')),
          ])
        ],
      ),
    );
  }
}
