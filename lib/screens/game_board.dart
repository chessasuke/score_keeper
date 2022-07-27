import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/appbar/widgets/custom_appbar.dart';
import 'package:score_keeper/appbar/widgets/drawer.dart';
import 'package:score_keeper/board/providers/game_providers.dart';
import 'package:score_keeper/board/widgets/player_board.dart';
import 'package:score_keeper/common/constants/app_colors.dart';
import 'package:score_keeper/common/constants/display_properties.dart';
import 'package:flutter/material.dart';
import 'package:score_keeper/common/widgets/separator.dart';

import '../board/widgets/target_points.dart';

final addPointsTextFieldProvider = StateProvider((ref) => '');

class GameBoard extends ConsumerStatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  ConsumerState<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends ConsumerState<GameBoard> {
  late Size screenSize;
  late final int numPlayers;

  @override
  void initState() {
    numPlayers = ref.read(numPlayersProvider);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    screenSize = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white100,
        appBar: const CustomAppBar(),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const TargetPoints(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Separator(
                      thickness: 0.5,
                      length: screenSize.width * 0.8,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height -
                        100 -
                        DisplayProperties.appbarHeight,
                    child: _ListBoardPlayers(
                      screenSize: screenSize,
                      numPlayers: numPlayers,
                    ),
                  ),
                ],
              ),
            ),
            const AppBarDrawer()
          ],
        ),
      ),
    );
  }
}

class _ListBoardPlayers extends StatelessWidget {
  const _ListBoardPlayers({
    required this.numPlayers,
    required this.screenSize,
    Key? key,
  }) : super(key: key);

  final int numPlayers;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.horizontal,
      slivers: [
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Row(
                children: [
                  PlayerBoard(
                    screenSize: screenSize,
                    key: ValueKey(index),
                    playerIndex: index,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: DisplayProperties.mainTopPadding),
                    child: Separator(
                      length: screenSize.height * 0.5,
                      isHorizontal: false,
                      thickness: 0.5,
                    ),
                  )
                ],
              );
            },
            childCount: numPlayers,
          ),
          itemExtent: screenSize.width / 2 - 0.5,
        ),
      ],
    );
  }
}
