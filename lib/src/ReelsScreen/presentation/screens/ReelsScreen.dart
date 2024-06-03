import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:instagram_clone/components/cards/reel_card_section.dart';
import 'package:instagram_clone/src/Authantication/data/model/HiveUserModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/src/ReelsScreen/presentation/bloc/ReelBloc.dart';
import 'package:instagram_clone/src/ReelsScreen/presentation/bloc/ReelEvent.dart';
import 'package:instagram_clone/src/ReelsScreen/presentation/bloc/ReelState.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../AddPostScreen/data/model/LikeModel.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> with ScreenUtils {
  final pageController = PageController();

  UserEntity userData = UserModel();
  LikeModel likePost = LikeModel();

  initialise(BuildContext context, bool refresh) async {
    context
        .read<ReelBloc>()
        .add(GetAllVideoPostEvent(isRefresh: refresh, context: context));
    Box<HiveUserModel> userDataBase = Hive.box<HiveUserModel>('UserDataBase');
    userData = HiveUserModel.toEntity(userDataBase.get("User"));
    likePost = likePost.copyWith(
        uniqueName: userData!.uniqueName,
        profileImage: userData!.profileImage,
        uuid: userData!.uuid);
  }

  @override
  void initState() {
    super.initState();
    initialise(context, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: super.screenWidthPercentage(context, 100),
      height: super.screenHeightPercentage(context, 100),
      alignment: Alignment.center,
      child: LiquidPullToRefresh(
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 200,
        color: primaryShade200,
        backgroundColor: primaryShade50,
        onRefresh: () async {
          await initialise(context, true);
        },
        child: BlocBuilder<ReelBloc, ReelState>(
          builder: (context, state) {
            if (state.currentState == CurrentAppState.ERROR) {
              return Text(
                "Some Error Occured",
                style: CoustomTextStyle.paragraph4,
              );
            }

            if (state.currentState == CurrentAppState.SUCCESS) {

                 if (state.videoPostList!.isEmpty) {
                      return Text(
                        "No Reels Yet",
                        style: CoustomTextStyle.paragraph4,
                      );
                    }
              return PageView.builder(
                  controller: pageController,
                  itemCount: state.videoPostList?.length ?? 0,
                  scrollDirection: Axis.vertical,
                  onPageChanged: (value) {},
                  // physics: const NeverScrollableScrollPhysics(),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final videoPost = state.videoPostList?[index];
                    return ReelCardSection(
                      videoPost: videoPost!,
                      likedPostUser: likePost,
                    );
                  }
                );
            }

            return CircularProgressIndicator(
              color: primaryShade500,
            );
          },
        ),
      ),
    );
  }
}
