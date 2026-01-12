import 'package:flutter/material.dart';
import '../services/calculator_service.dart';
import '../widgets/operation_button.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  CalculatorPageState createState() => CalculatorPageState();
}

class CalculatorPageState extends State<CalculatorPage> {
  final CalculatorService _service = CalculatorService();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String _result = '';

  void _calculate(String operation) async {
    double a = double.tryParse(_controller1.text) ?? 0;
    double b = double.tryParse(_controller2.text) ?? 0;

    if (operation == '/') {
      bool? confirm = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmar división'),
            content: Text('¿Estás seguro de que quieres dividir $a entre $b?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Confirmar'),
              ),
            ],
          );
        },
      );
      if (confirm != true) return;
    }

    try {
      double res;
      switch (operation) {
        case '+':
          res = _service.add(a, b);
          break;
        case '-':
          res = _service.subtract(a, b);
          break;
        case '*':
          res = _service.multiply(a, b);
          break;
        case '/':
          res = _service.divide(a, b);
          break;
        default:
          res = 0;
      }
      setState(() {
        _result = res.toString();
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Operación ejecutada correctamente')),
        );
      }
    } catch (e) {
      setState(() {
        _result = 'Error: ${e.toString()}';
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error en la operación: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                image: DecorationImage(
                  image: NetworkImage('https://miro.medium.com/v2/resize:fit:1200/1*3ARszX_aGy01siMzSotOeg.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.3), BlendMode.dstATop),
                ),
              ),
              child: Center(
                child: Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('Calculadora'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller1,
              decoration: InputDecoration(labelText: 'Primer número'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _controller2,
              decoration: InputDecoration(labelText: 'Segundo número'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OperationButton(operation: 'Suma', onPressed: () => _calculate('+'), backgroundColor: Colors.red),
                OperationButton(operation: 'Resta', onPressed: () => _calculate('-'), backgroundColor: Colors.green),
                OperationButton(operation: 'Multiplicación', onPressed: () => _calculate('*'), backgroundColor: Colors.blue),
                OperationButton(operation: 'División', onPressed: () => _calculate('/'), backgroundColor: Colors.orange),
              ],
            ),
            SizedBox(height: 20),
            Text('Resultado: $_result', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}