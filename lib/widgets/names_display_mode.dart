import 'package:flutter/material.dart';
import 'package:omnilore_scheduler/theme.dart';

/// Creates the name display mode set of buttons. This includes show splits,
/// show BU & CA, Implement splits, Show Coord(s), Set C and CC, Set CC1 and CC2
class NamesDisplayMode extends StatelessWidget {
  const NamesDisplayMode(
      {Key? key,
      required this.onShowSplits,
      required this.onImplSplit,
      required this.onShowCoords,
      required this.onSetC,
      required this.onSetCC,
      this.coordinatorMode = 'none'})
      : super(key: key);

  final void Function()? onShowSplits;
  final void Function()? onImplSplit;
  final void Function()? onShowCoords;
  final void Function()? onSetC;
  final void Function()? onSetCC;
  final String coordinatorMode; // 'none', 'main', or 'equal'

  @override
  Widget build(BuildContext context) {
    String setcLabel = coordinatorMode == 'main' ? 'Confirm' : 'Set C and CC';
    String setccLabel = coordinatorMode == 'equal' ? 'Confirm' : 'Set CC1 and CC2';
    
    return Container(
        color: themeColors['KindaBlue'],
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            alignment: Alignment.center,
            child: const Text('NAMES DISPLAY MODE',
                style: TextStyle(fontStyle: FontStyle.normal, fontSize: 25)),
          ),
          ElevatedButton(
              onPressed: onShowSplits, child: const Text('Show Splits')),
          ElevatedButton(
              onPressed: onImplSplit, child: const Text('Imp. Splits')),
          ElevatedButton(
              onPressed: coordinatorMode == 'none' ? onShowCoords : null,
              child: const Text('Show Coord(s)')),
          ElevatedButton(onPressed: onSetC, child: Text(setcLabel)),
          ElevatedButton(
              onPressed: onSetCC, child: Text(setccLabel)),
        ]));
  }
}
