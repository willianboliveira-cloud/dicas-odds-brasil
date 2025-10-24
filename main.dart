import 'package:flutter/material.dart';
import 'api.dart';
import 'bank_manager.dart';

void main() {
  runApp(DicasOddsApp());
}

class DicasOddsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dicas Odds Brasil',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  final BankManager bank = BankManager();

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      Center(child: Text('Modo Grátis: 5 dicas simples + 1 dupla + 1 tripla')),
      Center(child: Text('Modo VIP: 15 dicas simples + 5 duplas + 3 triplas')),
      Center(child: Text('Resultados de Ontem - GREEN / RED')),
      BankTab(bank: bank),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Dicas Odds Brasil')),
      body: tabs[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dicas'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'VIP'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Resultados'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Gestão'),
        ],
      ),
    );
  }
}
