import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const calculadoraApp());
}

class calculadoraApp extends StatelessWidget {
  const calculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
        ),
      ),
      home: const CalculadoraPage(title: 'Calculadora'),
    );
  }
}

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key, required this.title});

  final String title;

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  // ── Estado da calculadora ──
  String _display = '0';
  double _valorAnterior = 0;
  String? _operacao;
  bool _aguardandoOperando = false;
  bool _temDecimal = false;

  void _pressionarDigito(String digito) {
    setState(() {
      if (_aguardandoOperando) {
        _display = digito;
        _aguardandoOperando = false;
        _temDecimal = false;
      } else {
        if (_display.replaceAll('-', '').replaceAll('.', '').length >= 9) return;
        _display = _display == '0' ? digito : _display + digito;
      }
    });
  }

  void _pressionarDecimal() {
    setState(() {
      if (_aguardandoOperando) {
        _display = '0.';
        _aguardandoOperando = false;
        _temDecimal = true;
        return;
      }
      if (!_temDecimal) {
        _display += '.';
        _temDecimal = true;
      }
    });
  }

  void _pressionarOperacao(String op) {
    setState(() {
      if (_operacao != null && !_aguardandoOperando) {
        _calcular();
      }
      _valorAnterior = double.parse(_display);
      _operacao = op;
      _aguardandoOperando = true;
    });
  }

  void _calcular() {
    if (_operacao == null) return;
    final double b = double.parse(_display);
    double resultado;

    switch (_operacao) {
      case '+':
        resultado = _valorAnterior + b;
        break;
      case '-':
        resultado = _valorAnterior - b;
        break;
      case '×':
        resultado = _valorAnterior * b;
        break;
      case '÷':
        if (b == 0) {
          _display = 'Erro';
          _operacao = null;
          _aguardandoOperando = true;
          return;
        }
        resultado = _valorAnterior / b;
        break;
      default:
        return;
    }

    _display = _formatarResultado(resultado);
    _temDecimal = _display.contains('.');
    _operacao = null;
    _aguardandoOperando = true;
  }

  void _pressionarIgual() {
    setState(() {
      _calcular();
    });
  }

  void _limparTudo() {
    setState(() {
      _display = '0';
      _valorAnterior = 0;
      _operacao = null;
      _aguardandoOperando = false;
      _temDecimal = false;
    });
  }

  void _inverterSinal() {
    setState(() {
      if (_display == '0' || _display == 'Erro') return;
      _display = _display.startsWith('-')
          ? _display.substring(1)
          : '-$_display';
    });
  }

  void _porcentagem() {
    setState(() {
      final v = double.tryParse(_display);
      if (v == null) return;
      _display = _formatarResultado(v / 100);
      _temDecimal = _display.contains('.');
    });
  }

  String _formatarResultado(double valor) {
    if (valor == valor.truncateToDouble() && valor.abs() < 1e9) {
      return valor.toInt().toString();
    }
    String s = valor.toStringAsPrecision(9);
    if (s.contains('.')) {
      s = s.replaceAll(RegExp(r'0+$'), '');
      s = s.replaceAll(RegExp(r'\.$'), '');
    }
    return s;
  }

  bool _operacaoAtiva(String op) => _operacao == op && _aguardandoOperando;

  double get _tamanhoFonte {
    if (_display.length <= 6) return 64;
    if (_display.length <= 9) return 48;
    if (_display.length <= 12) return 36;
    return 28;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
        centerTitle: true,
        foregroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DisplayCard(
              valor: _display,
              tamanhoFonte: _tamanhoFonte,
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                BotaoCalculadora(
                  label: 'AC',
                  tipo: TipoBotao.funcao,
                  onPressed: _limparTudo,
                ),
                const SizedBox(width: 10),
                BotaoCalculadora(
                  label: '+/-',
                  tipo: TipoBotao.funcao,
                  onPressed: _inverterSinal,
                ),
                const SizedBox(width: 10),
                BotaoCalculadora(
                  label: '%',
                  tipo: TipoBotao.funcao,
                  onPressed: _porcentagem,
                ),
                const SizedBox(width: 10),
                BotaoCalculadora(
                  label: '÷',
                  tipo: TipoBotao.operador,
                  ativo: _operacaoAtiva('÷'),
                  onPressed: () => _pressionarOperacao('÷'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                BotaoCalculadora(
                  label: '7',
                  tipo: TipoBotao.numero,
                  onPressed: () => _pressionarDigito('7'),
                ),
                const SizedBox(width: 10),
                BotaoCalculadora(
                  label: '8',
                  tipo: TipoBotao.numero,
                  onPressed: () => _pressionarDigito('8'),
                ),
                const SizedBox(width: 10),
                BotaoCalculadora(
                  label: '9',
                  tipo: TipoBotao.numero,
                  onPressed: () => _pressionarDigito('9'),
                ),
                const SizedBox(width: 10),
                BotaoCalculadora(
                  label: '×',
                  tipo: TipoBotao.operador,
                  ativo: _operacaoAtiva('×'),
                  onPressed: () => _pressionarOperacao('×'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                BotaoCalculadora(
                  label: '4',
                  tipo: TipoBotao.numero,
                  onPressed: () => _pressionarDigito('4'),
                ),
                const SizedBox(width: 10),
                BotaoCalculadora(
                  label: '5',
                  tipo: TipoBotao.numero,
                  onPressed: () => _pressionarDigito('5'),
                ),
                const SizedBox(width: 10),
                BotaoCalculadora(
                  label: '6',
                  tipo: TipoBotao.numero,
                  onPressed: () => _pressionarDigito('6'),
                ),
                const SizedBox(width: 10),
                BotaoCalculadora(
                  label: '-',
                  tipo: TipoBotao.operador,
                  ativo: _operacaoAtiva('-'),
                  onPressed: () => _pressionarOperacao('-'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                BotaoCalculadora(
                  label: '1',
                  tipo: TipoBotao.numero,
                  onPressed: () => _pressionarDigito('1'),
                ),
                const SizedBox(width: 10),
                BotaoCalculadora(
                  label: '2',
                  tipo: TipoBotao.numero,
                  onPressed: () => _pressionarDigito('2'),
                ),
                const SizedBox(width: 10),
                BotaoCalculadora(
                  label: '3',
                  tipo: TipoBotao.numero,
                  onPressed: () => _pressionarDigito('3'),
                ),
                const SizedBox(width: 10),
                BotaoCalculadora(
                  label: '+',
                  tipo: TipoBotao.operador,
                  ativo: _operacaoAtiva('+'),
                  onPressed: () => _pressionarOperacao('+'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: BotaoCalculadora(
                    label: '0',
                    tipo: TipoBotao.numero,
                    alinhamentoTexto: Alignment.centerLeft,
                    paddingTexto: const EdgeInsets.only(left: 26),
                    onPressed: () => _pressionarDigito('0'),
                  ),
                ),
                const SizedBox(width: 10),
                BotaoCalculadora(
                  label: '.',
                  tipo: TipoBotao.numero,
                  onPressed: _pressionarDecimal,
                ),
                const SizedBox(width: 10),
                BotaoCalculadora(
                  label: '=',
                  tipo: TipoBotao.operador,
                  onPressed: _pressionarIgual,
                ),
              ],
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class DisplayCard extends StatelessWidget {
  final String valor;
  final double tamanhoFonte;

  const DisplayCard({
    super.key,
    required this.valor,
    required this.tamanhoFonte,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDDDDDD)),
      ),
      child: Text(
        valor,
        textAlign: TextAlign.right,
        style: TextStyle(
          color: const Color(0xFF1A1A1A),
          fontSize: tamanhoFonte,
          fontWeight: FontWeight.w300,
          letterSpacing: -1,
        ),
      ),
    );
  }
}

enum TipoBotao { numero, funcao, operador }

class BotaoCalculadora extends StatelessWidget {
  final String label;
  final TipoBotao tipo;
  final VoidCallback onPressed;
  final bool ativo;
  final Alignment alinhamentoTexto;
  final EdgeInsets paddingTexto;

  const BotaoCalculadora({
    super.key,
    required this.label,
    required this.tipo,
    required this.onPressed,
    this.ativo = false,
    this.alinhamentoTexto = Alignment.center,
    this.paddingTexto = EdgeInsets.zero,
  });

  Color get _corFundo {
    if (ativo) return const Color(0xFF1A1A1A);
    switch (tipo) {
      case TipoBotao.numero:
        return Colors.white;
      case TipoBotao.funcao:
        return const Color(0xFFDDDDDD);
      case TipoBotao.operador:
        return const Color(0xFF555555);
    }
  }

  Color get _corTexto {
    if (ativo) return Colors.white;
    switch (tipo) {
      case TipoBotao.numero:
        return const Color(0xFF1A1A1A);
      case TipoBotao.funcao:
        return const Color(0xFF444444);
      case TipoBotao.operador:
        return Colors.white;
    }
  }

  double get _tamanhoTexto {
    switch (tipo) {
      case TipoBotao.funcao:
        return 20;
      case TipoBotao.operador:
        return 28;
      default:
        return 26;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          height: 72,
          decoration: BoxDecoration(
            color: _corFundo,
            borderRadius: BorderRadius.circular(36),
          ),
          alignment: alinhamentoTexto,
          padding: paddingTexto,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: _corTexto,
                fontSize: _tamanhoTexto,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
