
import 'package:culturach/infrastructure/models/player_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPlayerIndexProvider = StateProvider<int>((ref) => 0);

final playerProvider = StateProvider<List<Player>>((ref) => []);
