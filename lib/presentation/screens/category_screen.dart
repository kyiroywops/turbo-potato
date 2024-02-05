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
  late Color backgroundColor;
  String? selectedPlayerForLifeLoss; // Cambiado para almacenar solo un nombre
  int currentPlayerIndex = 0;
  int currentQuestionIndex = 0; // Nuevo índice para la pregunta actual

  @override
  void initState() {
    super.initState();
    backgroundColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];
    Future.microtask(
      () => ref
          .read(questionsProvider(widget.category).notifier)
          .loadQuestions(widget.category),
    );
  }

  void loadNewQuestions() {
    // Solicita al provider que cargue nuevamente las preguntas.
    // Esto asume que el provider maneja adecuadamente la lógica para recargar y mezclar las preguntas.
    ref
        .read(questionsProvider(widget.category).notifier)
        .loadQuestions(widget.category);
  }

  void changeBackgroundColor() {
    setState(() {
      backgroundColor =
          Colors.primaries[Random().nextInt(Colors.primaries.length)];
    });
  }

void changeQuestion() {
  // Imprime el índice actual antes de intentar cambiar la pregunta.
  print("Índice actual de la pregunta antes de cambiar: $currentQuestionIndex");

  final questionsState = ref.watch(questionsProvider(widget.category));
  questionsState.whenData((questions) {
    print("Total de preguntas: ${questions.length}"); // Imprime el total de preguntas.

    if (currentQuestionIndex < questions.length - 1) {
      print("Cambiando a la siguiente pregunta...");
      setState(() {
        currentQuestionIndex++;
      });
      // Imprime el índice después de cambiarlo.
      print("Índice actual de la pregunta después de cambiar: $currentQuestionIndex");
    } else {
      print("No hay más preguntas. Mostrando diálogo de fin...");
      _showFinishedDialog();
    }
  });
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
            backgroundColor: Colors.grey.shade300, // Fondo del AlertDialog
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            titlePadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 10.0),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            title: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Icon(
                Icons.autorenew,
                color: Colors.black,
                size: 68.0,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text('¿Deseas salir?',
                        style: TextStyle(
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w800,
                            fontSize: 20))),
                SizedBox(height: 8),
                Text(
                    'Si presionas "Salir", irás a la pantalla asignar cartas y se reiniciará la partida.',
                    style: TextStyle(
                        fontFamily: 'Lexend', fontWeight: FontWeight.w400)),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No',
                    style: TextStyle(
                        fontFamily: 'Lexend', fontWeight: FontWeight.w800)),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Salir',
                    style: TextStyle(
                        fontFamily: 'Lexend', fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        )) ??
        false;

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
    ).then((_) =>
        loadNewQuestions()); // Reiniciar preguntas cuando se cierra el diálogo
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
    final playersWithLives =
        ref.watch(playerProvider).where((player) => player.lives > 0).toList();

    if (playersWithLives.length == 1) {
      // Solo queda un jugador con vidas, es el ganador
      _showWinnerDialog(playersWithLives.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = ref.watch(questionsProvider(widget
        .category)); // Esto asegura que la UI se actualice con los cambios

    final gameMode = ref.watch(gameModeProvider.state).state;
    final players = ref.watch(playerProvider);
    Player? currentPlayer = gameMode == GameMode.custom && players.isNotEmpty
        ? players[currentPlayerIndex]
        : null;
    // Esta comprobación asegura que solo se acceda a currentPlayer si estamos en un modo de juego que utiliza jugadores.

    final questionsAsyncValue = ref.watch(questionsProvider(widget.category));

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
        body: questionsAsyncValue.when(
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
            data: (questions) {
            // Verifica que hay preguntas disponibles y que el índice es válido.
            if (questions.isNotEmpty && currentQuestionIndex < questions.length) {
              // Obtiene la pregunta actual basada en el índice.
              final currentQuestion = questions[currentQuestionIndex];
              
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Cultura Chupistica',
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w900),
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
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  // Aquí continuarás con el resto del contenido...
                  Expanded(
                    child: questions.isEmpty
                        ? Center(
                            child: Text(
                            'No me quedan más preguntas. 🥲',
                            style: TextStyle(
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white),
                          ))
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
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 40),
                                    child: Text(
                                      currentQuestion.content,
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontFamily: 'Lexend',
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  if (gameMode == GameMode.custom) ...[
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: AssetImage(
                                                currentPlayer?.avatar ??
                                                    'assets/images/avatars/avatar1.png'),
                                            radius: 25,
                                          ),
                                          SizedBox(width: 10),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Text(
                                                currentPlayer?.name ??
                                                    'Sin jugadores',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontFamily: 'Lexend',
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        'Comienza ${currentPlayer?.name} y después el jugador a su derecha.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            fontFamily: 'Lexend',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Jugadores',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontFamily: 'Lexend',
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 0),
                                        child: ListView.builder(
                                          itemCount: players.length,
                                          itemBuilder: (context, index) {
                                            final player = players[index];

                                            return ListTile(
                                              leading: CircleAvatar(
                                                backgroundImage:
                                                    AssetImage(player.avatar),
                                              ),
                                              title: Text(player.name,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Lexend',
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              subtitle: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: List.generate(
                                                  player.lives,
                                                  (_) => Text('❤️',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ),
                                              trailing: player.lives >
                                                      0 // Solo mostramos la "X" si el jugador tiene vidas
                                                  ? IconButton(
                                                      icon: Icon(
                                                          player.name ==
                                                                  selectedPlayerForLifeLoss
                                                              ? Icons.close
                                                              : Icons.check,
                                                          color: Colors.white),
                                                      onPressed: () {
                                                        setState(() {
                                                          if (selectedPlayerForLifeLoss ==
                                                              player.name) {
                                                            selectedPlayerForLifeLoss =
                                                                null; // Deseleccionar
                                                          } else {
                                                            selectedPlayerForLifeLoss =
                                                                player
                                                                    .name; // Seleccionar para pérdida de vida
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
                       onPressed: changeQuestion, // Asegúrate de que llame a changeQuestion

                      icon: Icon(Icons.arrow_forward, color: Colors.black),
                      label: Text(
                        questions.isEmpty
                            ? 'Reiniciar Juego'
                            : 'siguiente pregunta',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Lexend',
                            fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // Color de fondo del botón
                        onPrimary: Colors
                            .black, // Color del texto e icono cuando el botón es presionado
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Bordes redondeados
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10), // Ajuste del padding
                        elevation: 5, // Sombra del botón
                      ),
                    ),
                  ),
                ],

              );
            
  }
            }

        // Ubicación del botón
      ),
      )
    );
  }
}
