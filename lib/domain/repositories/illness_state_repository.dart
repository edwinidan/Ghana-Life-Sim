import '../../models/character.dart';
import '../models/illness_state.dart';

class IllnessStateRepository {
  const IllnessStateRepository();

  List<ActiveIllnessState> read(Character character) {
    final illnesses = <ActiveIllnessState>[];
    for (final record in character.illnessStateRecords) {
      try {
        illnesses.add(ActiveIllnessState.decode(record));
      } catch (_) {
        // Migration/recovery owns malformed-record handling.
      }
    }
    return illnesses;
  }

  void write(Character character, List<ActiveIllnessState> illnesses) {
    character.illnessStateRecords = illnesses
        .map((illness) => illness.encode())
        .toList();
  }
}
