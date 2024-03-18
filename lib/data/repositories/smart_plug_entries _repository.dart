import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/data/database/database_manager.dart';
import 'package:smart_plug_data/data/database/database.dart';

class SmartPlugEntriesRepository {
  final _database = GetIt.instance<DatabaseManager>().database;

  Future<List<SmartPlugEntry>> getSmartPlugEntries() async {
    List<SmartPlugEntry> smartPlugEntriesEntries =
        await (_database.select(_database.smartPlugEntries)
              ..orderBy([
                (entry) => OrderingTerm(
                    expression: entry.timeStamp, mode: OrderingMode.desc)
              ]))
            .get();

    return smartPlugEntriesEntries;
  }

  Future<SmartPlugEntry?> getSmartPlugEntryByEntryId(int entryId) async {
    SmartPlugEntry? smartPlugEntry =
        await (_database.select(_database.smartPlugEntries)
              ..where((entry) => entry.entryId.equals(entryId)))
            .getSingleOrNull();

    return smartPlugEntry;
  }

  Future<int> createSmartPlugEntry(String homeAssistantEntityId,
      DateTime timeStamp, double state, String deviceClass) async {
    final newSmartPlugEntry = SmartPlugEntriesCompanion(
        homeAssistantEntityId: Value(homeAssistantEntityId),
        timeStamp: Value(timeStamp),
        state: Value(state),
        deviceClass: Value(deviceClass));

    return await _database
        .into(_database.smartPlugEntries)
        .insert(newSmartPlugEntry);
  }

  Future<void> updateSmartPlugEntry(
      SmartPlugEntry smartPlugEntry, String label) async {
    await (_database.update(_database.smartPlugEntries)
          ..where((entry) => entry.entryId.equals(smartPlugEntry.entryId)))
        .write(SmartPlugEntriesCompanion(label: Value(label)));
  }

  Future<void> deleteSmartPlugEntry(SmartPlugEntry smartPlugEntry) async {
    await (_database.delete(_database.smartPlugEntries)
          ..where((entry) => entry.entryId.equals(smartPlugEntry.entryId)))
        .go();
  }
}
