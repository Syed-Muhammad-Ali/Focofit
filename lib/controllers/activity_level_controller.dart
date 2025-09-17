import 'package:get/get.dart';

import '../models/activity_level_model.dart';

class LevelController extends GetxController {
  final List<LevelsModel> levellsit = [
    LevelsModel(level: 'Beginner', desc: 'Office, remote or sedentary work'),
    LevelsModel(
      level: 'Mildly active',
      desc: 'Standing work (e.g. waiter, delivery person)',
    ),
    LevelsModel(
      level: 'Moderately active',
      desc: 'Physically demanding work (e.g. bricklayer)',
    ),
    LevelsModel(level: 'Maximum', desc: 'Heavy physical work (e.g. gym)'),
  ];
}
