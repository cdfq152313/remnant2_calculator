import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remnant2_calculator/repository/amulet_repository.dart';
import 'package:remnant2_calculator/repository/archetype_repository.dart';
import 'package:remnant2_calculator/repository/hand_gun_repository.dart';
import 'package:remnant2_calculator/repository/long_gun_repository.dart';
import 'package:remnant2_calculator/repository/melee_mutator_repository.dart';
import 'package:remnant2_calculator/repository/melee_repository.dart';
import 'package:remnant2_calculator/repository/modifier_repository.dart';
import 'package:remnant2_calculator/repository/range_mutator_repository.dart';
import 'package:remnant2_calculator/repository/relic_fragment_repository.dart';
import 'package:remnant2_calculator/repository/ring_repository.dart';
import 'package:remnant2_calculator/view/build_editor_view.dart';
import 'package:remnant2_calculator/view/item_collection_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  const MyApp(this.prefs, {super.key});

  final SharedPreferences prefs;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AmuletRepository(prefs)),
        RepositoryProvider(create: (_) => ArchetypeRepository(prefs)),
        RepositoryProvider(create: (_) => HandGunRepository(prefs)),
        RepositoryProvider(create: (_) => LongGunRepository(prefs)),
        RepositoryProvider(create: (_) => MeleeMutatorRepository(prefs)),
        RepositoryProvider(create: (_) => MeleeRepository(prefs)),
        RepositoryProvider(create: (_) => ModifierRepository(prefs)),
        RepositoryProvider(create: (_) => RangeMutatorRepository(prefs)),
        RepositoryProvider(create: (_) => RelicFragmentRepository(prefs)),
        RepositoryProvider(create: (_) => RingRepository(prefs)),
      ],
      child: MaterialApp(
        title: '遺蹟2傷害計算機',
        theme: ThemeData(
          typography: Typography.material2021(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text('遺跡2傷害計算機'),
              bottom: const TabBar(
                tabs: [
                  Tab(text: '配裝'),
                  Tab(
                    text: '物品列表',
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                BuildEditorView(),
                ItemCollectionView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
