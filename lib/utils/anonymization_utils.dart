import 'package:smart_plug_data/data/database/database.dart';

class AnonymizationUtils {
  static List<SmartPlugEntry> anonymizeHomeAssistantEntityIds(
      List<SmartPlugEntry> smartPlugEntries) {
    List<SmartPlugEntry> anonymizedSmartPlugEntries = [];
    Map<String, int> homeAssistantEntityIdToNumber = {};
    int currentNumber = 1;

    for (SmartPlugEntry entry in smartPlugEntries) {
      if (!homeAssistantEntityIdToNumber
          .containsKey(entry.homeAssistantEntityId)) {
        homeAssistantEntityIdToNumber[entry.homeAssistantEntityId] =
            currentNumber;
        currentNumber++;
      }

      anonymizedSmartPlugEntries.add(entry.copyWith(
          homeAssistantEntityId:
              homeAssistantEntityIdToNumber[entry.homeAssistantEntityId]
                  .toString()));
    }

    return anonymizedSmartPlugEntries;
  }
}
