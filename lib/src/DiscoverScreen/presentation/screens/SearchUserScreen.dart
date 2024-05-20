import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/components/search_bar.dart';
import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';
import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthBloc.dart';
import 'package:instagram_clone/src/DiscoverScreen/presentation/bloc/DiscoverBloc.dart';
import 'package:instagram_clone/src/DiscoverScreen/presentation/bloc/DiscoverEvent.dart';
import 'package:instagram_clone/src/DiscoverScreen/presentation/widgets/search_user_card.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';
import '../../../Authantication/domain/entity/UserEntity.dart';

class SearchUserScreen extends StatefulWidget {
  SearchUserScreen({super.key});

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> with ScreenUtils {
  String searchbar = "";
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }


  FollowModel currentUser = FollowModel();

 



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: primaryShade50,
      body: SizedBox(
        width: super.screenWidthPercentage(context, 100),
        height: super.screenHeightPercentage(context, 100),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              /// app bar section'
              BackButtonNavbar(
                  onPress: () {
                    Navigator.pop(context);
                  },
                  center: null),

              // search bars section
              Container(
                width: super.screenWidthPercentage(context, 100),
                height: super.screenHeightPercentage(context, 10),
                padding: EdgeInsets.symmetric(
                    horizontal: super.screenWidthPercentage(context, 5)),
                child: CoustomSearchBar(
                  onPress: () {},
                  touchDetecter: false,
                  height: super.screenHeightPercentage(context, 10),
                  width: super.screenWidthPercentage(context, 100),
                  validateTextField: (value) {},
                  getTextFieldValue: (value) {
                    if (_debounce?.isActive ?? false) _debounce?.cancel();

                    _debounce = Timer(const Duration(seconds: 2), () {
                      setState(() {
                        searchbar = value;
                      });
                    });
                  },
                ),
              ),

              Expanded(
                child: StreamBuilder(
                  stream: context
                      .read<AuthBloc>()
                      .getStreamOfUserList(searchbar.toString() ?? "", context),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<UserEntity>?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: primaryShade500,
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Container(
                          height: 500,
                          alignment: Alignment.center,
                          child: Text("Some Error Occured",
                              style: CoustomTextStyle.paragraph4));
                    }

                    if (snapshot.data?.length == 0) {
                      return Container(
                        height: 500,
                        alignment: Alignment.center,
                        child: Text(
                          "No User",
                          style: CoustomTextStyle.paragraph4,  
                        ),
                      );
                    }

                    final value = snapshot.data;
                    // print(value?.length);
                    return ListView.builder(
                      itemCount: value?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return SearchUserCard(
                          data: value?[index],
                          onPressTrailing: (uuid, UserEntity userToFollow) {
                            context.read<DiscoverBloc>().add(FollowUserEvent(
                                  context: context,
                                  following: FollowModel(
                                      uniqueName: userToFollow.uniqueName,
                                      uuid: userToFollow.uuid,
                                      profileImage: userToFollow.profileImage),
                                ));
                          },
                          index: index,
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
