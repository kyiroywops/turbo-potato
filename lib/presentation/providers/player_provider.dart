
import 'package:culturach/infrastructure/models/player_models.dart';
import 'package:culturach/presentation/providers/player_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPlayerIndexProvider = StateProvider<int>((ref) => 0);

final playerProvider = StateNotifierProvider<PlayerListNotifier, List<Player>>((ref) {
  return PlayerListNotifier();
});
