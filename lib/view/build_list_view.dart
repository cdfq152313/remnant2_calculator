import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remnant2_calculator/domain/build_record_cubit.dart';
import 'package:remnant2_calculator/domain/select_build_cubit.dart';

class BuildListView extends StatelessWidget {
  const BuildListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildRecordCubit, List<BuildRecordState>>(
      builder: (context, state) {
        return Wrap(
          children: [
            for (var i = 0; i < state.length; ++i)
              _BuildItem(
                i: i,
                state: state[i],
              ),
          ],
        );
      },
    );
  }
}

class _BuildItem extends StatelessWidget {
  const _BuildItem({required this.i, required this.state});

  final int i;
  final BuildRecordState state;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 200,
        child: Column(
          children: [
            _Button(
              icon: Icons.edit,
              text: state.name.isEmpty ? '未命名' : state.name,
              onPressed: () => _onEditNamePressed(context),
            ),
            _Button(
              icon: Icons.delete,
              text: '刪除',
              onPressed: () {
                context.read<BuildRecordCubit>().removeAt(i);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('已刪除')),
                );
              },
            ),
            _Button(
              icon: Icons.download,
              text: '載入到配裝頁',
              onPressed: () {
                context.read<SelectBuildCubit>().select(state.build);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('已載入')),
                );
              },
            ),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('長槍 ${state.build.longGun?.name ?? '--'}'),
                Text('手槍 ${state.build.handGun?.name ?? '--'}'),
                Text('近戰 ${state.build.melee?.name ?? '--'}'),
                Text('長槍改裝 ${state.build.longGunMod?.name ?? '--'}'),
                Text('手槍改裝 ${state.build.handGunMod?.name ?? '--'}'),
                Text('長槍突變因子 ${state.build.longGunMutator?.name ?? '--'}'),
                Text('手槍突變因子 ${state.build.handGunMutator?.name ?? '--'}'),
                Text('近戰突變因子 ${state.build.meleeMutator?.name ?? '--'}'),
                Text('主職業 ${state.build.primaryArchetype?.name ?? '--'}'),
                Text('副職業 ${state.build.secondaryArchetype?.name ?? '--'}'),
                Text('項鍊 ${state.build.amulet?.name ?? '--'}'),
                Text('戒指1 ${state.build.rings[0]?.name ?? '--'}'),
                Text('戒指2 ${state.build.rings[1]?.name ?? '--'}'),
                Text('戒指3 ${state.build.rings[2]?.name ?? '--'}'),
                Text('戒指4 ${state.build.rings[3]?.name ?? '--'}'),
                Text('聖物碎片1 ${state.build.relicFragments[0]?.name ?? '--'}'),
                Text('聖物碎片2 ${state.build.relicFragments[1]?.name ?? '--'}'),
                Text('聖物碎片3 ${state.build.relicFragments[2]?.name ?? '--'}'),
              ],
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  void _onEditNamePressed(BuildContext context) {
    final controller = TextEditingController(text: state.name);
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          children: [
            TextFormField(
              controller: controller,
              onChanged: (v) => v,
            ),
            Row(
              children: [
                TextButton(
                  child: const Text('取消'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text('確定'),
                  onPressed: () {
                    context
                        .read<BuildRecordCubit>()
                        .editName(i, controller.text);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.icon,
    required this.onPressed,
    required this.text,
  });

  final IconData icon;
  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(icon),
          Text(text),
        ],
      ),
    );
  }
}
