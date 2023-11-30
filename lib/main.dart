import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remnant2_calculator/domain/build_record_cubit.dart';
import 'package:remnant2_calculator/domain/select_build_cubit.dart';
import 'package:remnant2_calculator/repository/repository_pack.dart';
import 'package:remnant2_calculator/view/build_editor_view.dart';
import 'package:remnant2_calculator/view/build_list_view.dart';
import 'package:remnant2_calculator/view/item_collection_view.dart';
import 'package:remnant2_calculator/view/other_view.dart';
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
        RepositoryProvider(create: (_) => RepositoryPack(prefs)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BuildRecordCubit(
              context.read<RepositoryPack>().buildRecordRepository,
            ),
          ),
          BlocProvider(
            create: (context) => SelectBuildCubit(null),
          )
        ],
        child: MaterialApp(
          title: '遺蹟2傷害計算機',
          theme: ThemeData(
            typography: Typography.material2021(),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('遺跡2傷害計算機'),
                bottom: const TabBar(
                  tabs: [
                    Tab(text: '配裝'),
                    Tab(text: '儲存列表'),
                    Tab(text: '物品列表'),
                    Tab(text: '其他'),
                  ],
                ),
              ),
              body: const TabBarView(
                children: [
                  BuildEditorView(),
                  BuildListView(),
                  ItemCollectionView(),
                  OtherView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
