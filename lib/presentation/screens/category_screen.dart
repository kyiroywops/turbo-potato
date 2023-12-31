import 'dart:math';

import 'package:culturach/infrastructure/models/player_models.dart';
import 'package:culturach/infrastructure/models/question_models.dart';
import 'package:culturach/presentation/providers/gamemode_provider.dart';
import 'package:culturach/presentation/providers/player_provider.dart';
import 'package:culturach/presentation/providers/questions_provider.dart';
import 'package:culturach/presentation/providers/vidas_iniciales_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionsScreen extends ConsumerStatefulWidget {
  final String category;
  

  QuestionsScreen({Key? key, required this.category}) : super(key: key);

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends ConsumerState<QuestionsScreen> {
  List<Question> questions = [];
  late Color backgroundColor;
  String? selectedPlayerForLifeLoss; // Cambiado para almacenar solo un nombre
  int currentPlayerIndex = 0;



  @override
  void initState() {
    super.initState();
    backgroundColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
   
    
      WidgetsBinding.instance.addPostFrameCallback((_) {
        loadNewQuestions();
      });
    
  }

  void loadNewQuestions() {
    // Obtenemos todas las preguntas para la categoría y mezclamos
    List<Question> newQuestions = List.from(ref.read(questionsProvider(widget.category)));
    newQuestions.shuffle(Random());
    setState(() {
      questions = newQuestions;
    });
  }

 

  void changeBackgroundColor() {
    setState(() {
      backgroundColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    });
  }

  void changeQuestion() {
    final players = ref.read(playerProvider); // Asume que esto devuelve una lista de jugadores

    if (selectedPlayerForLifeLoss != null) {
    ref.read(playerProvider.notifier).removeLife(selectedPlayerForLifeLoss!);
    selectedPlayerForLifeLoss = null;
    checkForWinner(); // Verificar si hay un ganador

  }

    setState(() {
          currentPlayerIndex = (currentPlayerIndex + 1) % players.length; // Rotar al siguiente jugador

  });
   // Limpiar el conjunto para la siguiente ronda
  if (selectedPlayerForLifeLoss != null) {
    ref.read(playerProvider.notifier).removeLife(selectedPlayerForLifeLoss!);
    selectedPlayerForLifeLoss = null; // Limpiar para la siguiente ronda
  }
    if (questions.isNotEmpty) {
      questions.removeLast();
      changeBackgroundColor();
    } else {
      _showFinishedDialog();
    }
  }

  void restartGame() {
  // Este es el método que reiniciará el juego
  setState(() {
    // Reiniciamos las vidas de los jugadores
    int initialLives = ref.read(initialLivesProvider.state).state;
    ref.read(playerProvider.notifier).resetLives(initialLives);
    // Recargamos las preguntas
    loadNewQuestions();
  });
}



  Future<bool> _onWillPop() async {
    bool shouldPop = (await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
         
            title: Text('Salir', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w600)),
            content: Text('Si sales ahora, la partida se reiniciará. ¿Quieres salir?', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w500)),
            actions: <Widget>[
              TextButton(
                child: Text('No', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w800)),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: Text('Sí', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w600)),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        )) ??
        false;

     if (shouldPop) {
      int initialLives = ref.read(initialLivesProvider.state).state;
      ref.read(playerProvider.notifier).resetLives(initialLives);
      loadNewQuestions();
    }

    return shouldPop;
  }

  void _showFinishedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Fin de las preguntas'),
        content: Text('Has pasado por todas las preguntas de esta categoría.'),
        actions: <Widget>[
          TextButton(
            child: Text('Cerrar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    ).then((_) => loadNewQuestions()); // Reiniciar preguntas cuando se cierra el diálogo
  }

  void _showWinnerDialog(Player winner) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('¡Felicidades ${winner.name}!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(winner.avatar),
              radius: 30,
            ),
            SizedBox(height: 8),
            Text('¡Has ganado con ${winner.lives} vidas restantes!'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop();
              restartGame(); // Opcional: reiniciar el juego automáticamente
            },
          ),
        ],
      ),
    );
  }

  void checkForWinner() {
  final playersWithLives = ref.watch(playerProvider).where((player) => player.lives > 0).toList();

  if (playersWithLives.length == 1) {
    // Solo queda un jugador con vidas, es el ganador
    _showWinnerDialog(playersWithLives.first);
  }
}

  @override
  Widget build(BuildContext context) {
    final gameMode = ref.watch(gameModeProvider.state).state;
    final players = ref.watch(playerProvider);
    final currentPlayer = players[currentPlayerIndex];


     return WillPopScope(
    onWillPop: _onWillPop,
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 23),
            onPressed: () async {
              if (await _onWillPop()) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Cultura Chupistica',
              style: TextStyle(fontSize: 32, color: Colors.white, fontFamily: 'Lexend', fontWeight: FontWeight.w900),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 3, 30, 3),
              child: Text(
                widget.category,
                style: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Lexend', fontWeight: FontWeight.w700),
              ),
            ),
          ),
          // Aquí continuarás con el resto del contenido...
           Expanded(
            child: questions.isEmpty
                ? Center(child: Text('No me quedan más preguntas. 🥲', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w600, fontSize: 15, color: Colors.white),))
                : GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity! > 0) {
                        changeQuestion();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 40, 40),
                            child: Text(
                              questions.last.content,
                              style: TextStyle(fontSize: 24, color: Colors.white, fontFamily: 'Lexend', fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          if (gameMode == GameMode.custom) ...[
                            
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(currentPlayer.avatar),
                                      radius: 25,
                                    ),
                                    SizedBox(width: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(currentPlayer.name, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Lexend', fontWeight: FontWeight.w700)),
                                    ),
                                  ],
                                ),
                              ),
                             Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Text(
                                  'Comienza ${currentPlayer.name} y después el jugador a su derecha.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.9), fontFamily: 'Lexend', fontWeight: FontWeight.w500),
                                ),
                             ),

                             

                            SizedBox(height: 20),
                            Text(
                              'Jugadores',
                              style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Lexend', fontWeight: FontWeight.w800),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: ListView.builder(
                                  itemCount: players.length,
                                
                                  itemBuilder: (context, index) {
                                    final player = players[index];
                                
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: AssetImage(player.avatar),
                                      ),
                                      title: Text(player.name, style: TextStyle(color: Colors.white, fontFamily: 'Lexend', fontWeight: FontWeight.w700)),
                                      subtitle: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: List.generate(
                                          player.lives,
                                          (_) => Text('❤️', style: TextStyle(color: Colors.white)),
                                          
                                        ),
                                        
                                      ),
                                      trailing: player.lives > 0 // Solo mostramos la "X" si el jugador tiene vidas
                                        ? IconButton(
                                            icon: Icon(player.name == selectedPlayerForLifeLoss ? Icons.close : Icons.check, color: Colors.white),
                                            onPressed: () {
                                              setState(() {
                                                if (selectedPlayerForLifeLoss == player.name) {
                                                  selectedPlayerForLifeLoss = null; // Deseleccionar
                                                } else {
                                                  selectedPlayerForLifeLoss = player.name; // Seleccionar para pérdida de vida
                                                }
                                              });
                                            },
                                          )
                                        : null, // Si no tiene vidas, no mostramos ningún botón
                                    );
                                  },
                                ),
                              ),
                            ),
                            
                          ],
                        ],
                      ),
                    ),
                  ),
          ),
          Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 30),
        child: ElevatedButton.icon(
          onPressed: () {
            if (questions.isEmpty) {
              // No hay más preguntas, reiniciar el juego
              loadNewQuestions();
            } else {
              // Pasar a la siguiente pregunta
              changeQuestion();
            }
          },
          icon: Icon(Icons.arrow_forward, color: Colors.black),
          label: Text(
             questions.isEmpty ? 'Reiniciar Juego' : 'siguiente pregunta',
            style: TextStyle(color: Colors.black, fontFamily: 'Lexend', fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.white, // Color de fondo del botón
            onPrimary: Colors.black, // Color del texto e icono cuando el botón es presionado
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Bordes redondeados
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Ajuste del padding
            elevation: 5, // Sombra del botón
          ),
        ),
      ),
          


        ],
        
      ),
       // Ubicación del botón
    
    ),
  ); 
  }
  
}
