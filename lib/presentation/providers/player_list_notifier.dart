// Definición de PlayerListNotifier
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
      state = [
        for (final player in state)
          if (player.name == playerName && player.lives > 0)
            player.copyWith(lives: player.lives - 1)
          else
            player,
      ];
    }
   void resetLives(int initialLives) {
    state = state.map((player) => player.copyWith(lives: initialLives)).toList();
  }

}
