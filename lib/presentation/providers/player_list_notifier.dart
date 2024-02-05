// Definición de PlayerListNotifier
import 'dart:math';

import 'package:culturach/infrastructure/models/player_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerListNotifier extends StateNotifier<List<Player>> {
  PlayerListNotifier() : super([]);

  void addPlayer(Player player) {
    state = [...state, player];
  }

  void removePlayer(int index) {
    state = [...state]..removeAt(index);
  }

  void setLivesForAll(int lives) {
    state = state.map((player) => player.copyWith(lives: lives)).toList();
  }

 void removeLife(String playerName) {
  // Primero, actualiza las vidas de los jugadores.
  List<Player> updatedPlayers = [
    for (final player in state)
      if (player.name == playerName)
        player.copyWith(lives: max(0, player.lives - 1)) // Usa max para evitar vidas negativas
      else
        player,
  ];

  // Luego, elimina los jugadores con 0 vidas.
  state = updatedPlayers.where((player) => player.lives > 0).toList();
}


  void resetLives(int initialLives) {
    state =
        state.map((player) => player.copyWith(lives: initialLives)).toList();
  }

 
  
}
