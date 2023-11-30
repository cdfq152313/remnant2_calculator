import 'dart:convert';
import 'dart:typed_data';

import 'package:remnant2_calculator/repository/amulet_repository.dart';
import 'package:remnant2_calculator/repository/archetype_repository.dart';
import 'package:remnant2_calculator/repository/build_record_repository.dart';
import 'package:remnant2_calculator/repository/effect_skill_repository.dart';
import 'package:remnant2_calculator/repository/hand_gun_repository.dart';
import 'package:remnant2_calculator/repository/long_gun_repository.dart';
import 'package:remnant2_calculator/repository/melee_mutator_repository.dart';
import 'package:remnant2_calculator/repository/melee_repository.dart';
import 'package:remnant2_calculator/repository/mod_repository.dart';
import 'package:remnant2_calculator/repository/modifier_repository.dart';
import 'package:remnant2_calculator/repository/range_mutator_repository.dart';
import 'package:remnant2_calculator/repository/relic_fragment_repository.dart';
import 'package:remnant2_calculator/repository/repository.dart';
import 'package:remnant2_calculator/repository/ring_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepositoryPack {
  RepositoryPack(SharedPreferences prefs, Map<String, dynamic> defaultJson)
      : amuletRepository = AmuletRepository(prefs, defaultJson),
        archetypeRepository = ArchetypeRepository(prefs, defaultJson),
        buildRecordRepository = BuildRecordRepository(prefs),
        effectSkillRepository = EffectSkillRepository(prefs, defaultJson),
        handGunRepository = HandGunRepository(prefs, defaultJson),
        longGunRepository = LongGunRepository(prefs, defaultJson),
        meleeMutatorRepository = MeleeMutatorRepository(prefs, defaultJson),
        meleeRepository = MeleeRepository(prefs, defaultJson),
        modRepository = ModRepository(prefs, defaultJson),
        modifierRepository = ModifierRepository(prefs, defaultJson),
        rangeMutatorRepository = RangeMutatorRepository(prefs, defaultJson),
        relicFragmentRepository = RelicFragmentRepository(prefs, defaultJson),
        ringRepository = RingRepository(prefs, defaultJson) {
    _map = {
      amuletRepository.key: amuletRepository,
      archetypeRepository.key: archetypeRepository,
      buildRecordRepository.key: buildRecordRepository,
      effectSkillRepository.key: effectSkillRepository,
      handGunRepository.key: handGunRepository,
      longGunRepository.key: longGunRepository,
      meleeMutatorRepository.key: meleeMutatorRepository,
      meleeRepository.key: meleeRepository,
      modRepository.key: modRepository,
      modifierRepository.key: modifierRepository,
      rangeMutatorRepository.key: rangeMutatorRepository,
      relicFragmentRepository.key: relicFragmentRepository,
      ringRepository.key: ringRepository,
    };
  }

  final AmuletRepository amuletRepository;
  final ArchetypeRepository archetypeRepository;
  final BuildRecordRepository buildRecordRepository;
  final EffectSkillRepository effectSkillRepository;
  final HandGunRepository handGunRepository;
  final LongGunRepository longGunRepository;
  final MeleeMutatorRepository meleeMutatorRepository;
  final MeleeRepository meleeRepository;
  final ModRepository modRepository;
  final ModifierRepository modifierRepository;
  final RangeMutatorRepository rangeMutatorRepository;
  final RelicFragmentRepository relicFragmentRepository;
  final RingRepository ringRepository;

  late final Map<String, Repository> _map;

  List<Repository> get repositories => _map.values.toList();

  Uint8List export() {
    final data = _map.map((key, value) => MapEntry(key, value.export()));
    final jsonStr = jsonEncode(data);
    return utf8.encode(jsonStr);
  }

  void import(Uint8List data) {
    final jsonStr = utf8.decode(data);
    final Map<String, dynamic> json = jsonDecode(jsonStr);
    for (final pair in json.entries) {
      _map[pair.key]?.import(pair.value);
    }
  }
}
