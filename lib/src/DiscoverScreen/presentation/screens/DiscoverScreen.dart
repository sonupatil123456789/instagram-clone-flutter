import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/components/search_bar.dart';
import 'package:instagram_clone/src/HomeScreen/presentation/bloc/HomeBloc.dart';
import 'package:instagram_clone/src/HomeScreen/presentation/bloc/HomeEvent.dart';
import 'package:instagram_clone/src/HomeScreen/presentation/bloc/HomeState.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../utils/resources/enums.dart';
import '../../../../components/cards/discover_grid_card.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> with ScreenUtils {
  @override
  void initState() {
    super.initState();
    context
        .read<HomeBloc>()
        .add(GetAllPostEvent(context: context, isRefresh: false));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: super.screenWidthPercentage(context, 100),
      height: super.screenHeightPercentage(context, 100),
      child: SafeArea(
        child: Column(
          children: [
            // search bars section
            Container(
                width: super.screenWidthPercentage(context, 100),
                height: super.screenHeightPercentage(context, 10),
                padding: EdgeInsets.symmetric(
                    horizontal: super.screenWidthPercentage(context, 2)),
                child: CoustomSearchBar(
                  onPress: () {
                    Navigator.pushNamed(context, RoutesName.searcnUserScreen);
                  },
                  touchDetecter: true,
                  height: super.screenHeightPercentage(context, 10),
                  width: super.screenWidthPercentage(context, 100),
                  validateTextField: (value) {},
                  getTextFieldValue: (value) {},
                )),

            LiquidPullToRefresh(
              showChildOpacityTransition: false,
              springAnimationDurationInMilliseconds: 200,
              color: primaryShade200,
              backgroundColor: primaryShade50,
              onRefresh: () async {
                context
                    .read<HomeBloc>()
                    .add(GetAllPostEvent(context: context, isRefresh: true));
              },
              child: Container(
                width: super.screenWidthPercentage(context, 100),
                height: super.screenHeightPercentage(context, 80),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    horizontal: super.screenWidthPercentage(context, 4)),
                child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, HomeState state) {
                  if (state.currentState == CurrentAppState.ERROR) {
                    return Text(
                      "Some Error Occured ",
                      style: CoustomTextStyle.paragraph4,
                    );
                  }

                  if (state.currentState == CurrentAppState.SUCCESS) {
                    if (state.postList!.isEmpty) {
                      return Text(
                        "No Post Yet",
                        style: CoustomTextStyle.paragraph4,
                      );
                    }

                    return GridView.custom(
                      gridDelegate: SliverQuiltedGridDelegate(
                        crossAxisCount: 4,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        repeatPattern: QuiltedGridRepeatPattern.inverted,
                        pattern: const [
                          QuiltedGridTile(2, 3),
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(1, 2),
                        ],
                      ),
                      childrenDelegate: SliverChildBuilderDelegate(
                          childCount: state.postList!.length, (context, index) {
                        final postData = state.postList![index];

                        return DiscoverGridCard(
                          postData: postData,
                        );
                      }),
                    );
                  }

                  return CircularProgressIndicator(
                    color: primaryShade500,
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
