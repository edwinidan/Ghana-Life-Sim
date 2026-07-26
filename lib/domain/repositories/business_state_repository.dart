import '../../models/character.dart';
import '../models/business_state.dart';

class BusinessStateRepository {
  const BusinessStateRepository();

  List<BusinessState> read(Character character) {
    final businesses = <BusinessState>[];
    for (final record in character.businessStateRecords) {
      try {
        businesses.add(BusinessState.decode(record));
      } catch (_) {
        // Migration/recovery owns malformed-record handling.
      }
    }
    return businesses;
  }

  void write(Character character, List<BusinessState> businesses) {
    character.businessStateRecords = businesses
        .map((business) => business.encode())
        .toList();
  }
}
